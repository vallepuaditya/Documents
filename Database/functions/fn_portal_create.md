# PostgreSQL Function: fn_portal_create

## Function Name

**Function:** `fn_portal_create(p_portal_name, p_portal_path, p_location_id, p_pool_id, p_server_uri, p_created_by)`

**Purpose:** Creates a new access portal with path-based routing for web-accessible reservation interfaces.

**Called By:** API Controller: `/api/constructs/portals` (POST)

---

## Signature

```sql
CREATE OR REPLACE FUNCTION fn_portal_create(
    p_portal_name VARCHAR(150),
    p_portal_path VARCHAR(100),
    p_location_id INTEGER,
    p_pool_id INTEGER,
    p_server_id BIGINT,
    p_server_uri VARCHAR(255),
    p_use_https BOOLEAN,
    p_allowed_reservation_types JSONB,
    p_created_by INTEGER
)
RETURNS TABLE(
    portal_id BIGINT,
    portal_name VARCHAR(150),
    portal_path VARCHAR(100),
    status_sk INTEGER,
    message TEXT
)
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
```

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `p_portal_name` | `VARCHAR(150)` | YES | Descriptive portal name |
| `p_portal_path` | `VARCHAR(100)` | YES | Unique URL path (e.g., /branchA) |
| `p_location_id` | `INTEGER` | YES* | Associated location (*or pool required) |
| `p_pool_id` | `INTEGER` | YES* | Optional pool assignment (*or location required) |
| `p_server_id` | `BIGINT` | YES | Server ID hosting portal (FK to servers) |
| `p_server_uri` | `VARCHAR(255)` | YES | Server URI hosting portal |
| `p_use_https` | `BOOLEAN` | NO | Enable HTTPS (default true) |
| `p_allowed_reservation_types` | `JSONB` | NO | Allowed reservation types array |
| `p_created_by` | `INTEGER` | YES | User ID creating the portal |

**Return Type:** `TABLE(portal_id BIGINT, portal_name VARCHAR(150), portal_path VARCHAR(100), status_sk INTEGER, message TEXT)`

---

## Transaction Behavior

| Aspect | Value |
|--------|-------|
| Runs inside transaction | YES |
| Rollback scope | Full operation |
| Savepoint usage | None |

---

## Preconditions / Validation

- Portal path must be unique
- Portal path must follow format: /[lowercase-alphanumeric-hyphen-underscore]
- Portal path must not be reserved (/admin, /api, /system, /staff)
- Either location_id OR pool_id must be provided (not both null)
- Location must exist if provided
- Pool must exist if provided
- Created_by user must exist and have permissions

---

## Main Logic Steps

1. Validate portal path format and uniqueness
2. Check path not reserved
3. Validate location or pool assignment
4. Validate location/pool exists
5. Inherit communication segment from location if applicable
6. Insert new portal record
7. Set status based on configuration completeness
8. Log audit entry
9. Return newly created portal details

---

## Waitlist Behavior

- [x] Not applicable - configuration function (but enables reservation functionality)

---

## Audit Logging

| Audit Action | Logged To | Fields Captured |
|--------------|-----------|-----------------|
| `INSERT` | `staff_audit_log` | portal_id, portal_name, portal_path, location_id, created_by, action='CREATE' |

**Audit helper used:** `fn_log_audit('access_portals', 'CREATE', portal_id, ...)`

---

## Error Handling

| Error Code / Condition | Returned / Raised | Message |
|------------------------|-------------------|---------|
| Duplicate portal path | EXCEPTION | 'Portal path already exists: {path}' |
| Invalid path format | EXCEPTION | 'Invalid portal path format. Must be /[lowercase-alphanumeric-hyphen-underscore]' |
| Reserved path | EXCEPTION | 'Portal path is reserved: {path}' |
| No location or pool | EXCEPTION | 'Must assign portal to location or pool' |
| Location not found | EXCEPTION | 'Location ID {id} not found' |
| Pool not found | EXCEPTION | 'Pool ID {id} not found' |
| User not found | EXCEPTION | 'User ID {id} not found' |

---

## SQL Implementation

```sql
CREATE OR REPLACE FUNCTION fn_portal_create(
    p_portal_name VARCHAR(150),
    p_portal_path VARCHAR(100),
    p_location_id INTEGER DEFAULT NULL,
    p_pool_id INTEGER DEFAULT NULL,
    p_server_uri VARCHAR(255),
    p_use_https BOOLEAN DEFAULT true,
    p_allowed_reservation_types JSONB DEFAULT '["scheduled","walkup","waitlist"]',
    p_created_by INTEGER
)
RETURNS TABLE(
    portal_id BIGINT,
    portal_name VARCHAR(150),
    portal_path VARCHAR(100),
    status VARCHAR(20),
    message TEXT
)
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
    v_new_portal_id BIGINT;
    v_portal_data JSONB;
    v_comm_segment_id BIGINT;
    v_portal_status_sk INTEGER;
    v_reserved_paths TEXT[] := ARRAY['/admin', '/api', '/system', '/staff', '/health', '/login'];
BEGIN
    -- Validation: Check path format
    IF p_portal_path !~ '^/[a-z0-9\-_]+$' THEN
        RAISE EXCEPTION 'Invalid portal path format. Must be /[lowercase-alphanumeric-hyphen-underscore]';
    END IF;

    -- Validation: Check path not reserved
    IF p_portal_path = ANY(v_reserved_paths) THEN
        RAISE EXCEPTION 'Portal path is reserved: %', p_portal_path;
    END IF;

    -- Validation: Check path uniqueness
    IF EXISTS (SELECT 1 FROM access_portals WHERE portal_path = p_portal_path) THEN
        RAISE EXCEPTION 'Portal path already exists: %', p_portal_path;
    END IF;

    -- Validation: Must have location or pool
    IF p_location_id IS NULL AND p_pool_id IS NULL THEN
        RAISE EXCEPTION 'Must assign portal to location or pool';
    END IF;

    -- Validation: Check location exists if provided
    IF p_location_id IS NOT NULL THEN
        IF NOT EXISTS (SELECT 1 FROM locations WHERE location_id = p_location_id) THEN
            RAISE EXCEPTION 'Location ID % not found', p_location_id;
        END IF;
        
        -- Get communication segment from location
        SELECT communication_segment_id INTO v_comm_segment_id
        FROM location_segments
        WHERE location_id = p_location_id
        AND is_active = true
        LIMIT 1;
    END IF;

    -- Validation: Check pool exists if provided
    IF p_pool_id IS NOT NULL THEN
        IF NOT EXISTS (SELECT 1 FROM pools WHERE pool_id = p_pool_id) THEN
            RAISE EXCEPTION 'Pool ID % not found', p_pool_id;
        END IF;
    END IF;

    -- Validation: Check server exists if provided
    IF p_server_id IS NOT NULL THEN
        IF NOT EXISTS (SELECT 1 FROM servers WHERE server_id = p_server_id) THEN
            RAISE EXCEPTION 'Server ID % not found', p_server_id;
        END IF;
    END IF;

    -- Validation: Check user exists
    IF NOT EXISTS (SELECT 1 FROM users WHERE id = p_created_by) THEN
        RAISE EXCEPTION 'User ID % not found', p_created_by;
    END IF;

    -- Determine portal status based on configuration completeness
    IF p_location_id IS NOT NULL AND p_server_uri IS NOT NULL THEN
        v_portal_status_sk := (SELECT sk FROM lookup WHERE type = 'portal_status_sk' AND value = 'active');
    ELSE
        v_portal_status_sk := (SELECT sk FROM lookup WHERE type = 'portal_status_sk' AND value = 'config_incomplete');
    END IF;

    -- Insert new portal
    INSERT INTO access_portals (
        portal_name,
        portal_path,
        location_id,
        pool_id,
        server_id,
        server_uri,
        communication_segment_id,
        use_https,
        allowed_reservation_types,
        is_active,
        status_sk,
        created_by,
        updated_by
    ) VALUES (
        p_portal_name,
        p_portal_path,
        p_location_id,
        p_pool_id,
        p_server_id,
        p_server_uri,
        v_comm_segment_id,
        COALESCE(p_use_https, true),
        COALESCE(p_allowed_reservation_types, '["scheduled","walkup","waitlist"]'),
        CASE WHEN v_portal_status_sk = (SELECT sk FROM lookup WHERE type = 'portal_status_sk' AND value = 'active') THEN true ELSE false END,
        v_portal_status_sk,
        p_created_by,
        p_created_by
    )
    RETURNING access_portals.portal_id INTO v_new_portal_id;

    -- Build audit data
    v_portal_data := jsonb_build_object(
        'portal_id', v_new_portal_id,
        'portal_name', p_portal_name,
        'portal_path', p_portal_path,
        'location_id', p_location_id,
        'pool_id', p_pool_id,
        'server_id', p_server_id,
        'server_uri', p_server_uri,
        'use_https', COALESCE(p_use_https, true)
    );

    -- Audit logging
    INSERT INTO staff_audit_log (
        staff_member_id,
        changed_by,
        action,
        field_name,
        new_value,
        new_values
    ) VALUES (
        p_created_by::uuid,
        p_created_by::uuid,
        'CREATE',
        'access_portals',
        'Portal created: ' || p_portal_name,
        v_portal_data
    );

    -- Return result
    RETURN QUERY
    SELECT 
        v_new_portal_id,
        p_portal_name,
        p_portal_path,
        v_portal_status_sk,
        CASE 
            WHEN v_portal_status_sk = (SELECT sk FROM lookup WHERE type = 'portal_status_sk' AND value = 'active') THEN 'Portal created and activated successfully'
            ELSE 'Portal created but configuration incomplete'
        END::TEXT;

EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Error creating portal: %', SQLERRM;
END;
$$;
```

---

## Example Call

```sql
SELECT * FROM fn_portal_create(
    'Downtown Branch Portal'::VARCHAR(150),
    '/downtown'::VARCHAR(100),
    1::INTEGER,                           -- location_id
    NULL::INTEGER,                        -- pool_id
    1::BIGINT,                            -- server_id
    'https://portal.library.com'::VARCHAR(255),
    true::BOOLEAN,                        -- use_https
    '["scheduled","waitlist"]'::JSONB,    -- allowed_reservation_types
    1::INTEGER                            -- created_by
);
```

---

## Related Functions / Triggers

| Related Object | Relationship |
|----------------|--------------|
| `fn_portal_update` | Update existing portal |
| `fn_portal_validate_path` | Trigger - validates path format |
| `fn_inherit_portal_segment` | Trigger - inherits segment from location |
| `fn_portal_sync_workstations` | Syncs portal changes to workstations |

---

## Notes for Developer

- Path must be unique and lowercase with /, alphanumeric, hyphen, underscore only
- Reserved paths prevent conflicts with system routes
- Single portal per location enforced via path uniqueness
- Communication segment inherited from location automatically
- Portal acts as pseudo-virtual kiosk
- When URI or location changes, trigger portal sync to connected workstations
- Pool assignment preferred for multi-location portal access
- Empty arrays for allowed_* fields means "all allowed"
