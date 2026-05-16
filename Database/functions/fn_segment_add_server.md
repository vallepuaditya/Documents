# PostgreSQL Function: fn_segment_add_server

## Function Name

**Function:** `fn_segment_add_server(p_segment_id, p_server_id, p_server_role, p_priority_order, p_created_by)`

**Purpose:** Adds a server to a segment with specified role (main/secondary) and priority order for failover sequencing.

**Called By:** API Controller: `/api/constructs/segments/{id}/servers` (POST)

---

## Signature

```sql
CREATE OR REPLACE FUNCTION fn_segment_add_server(
    p_segment_id BIGINT,
    p_server_id BIGINT,
    p_server_role_sk INTEGER,
    p_priority_order INTEGER,
    p_created_by INTEGER
)
RETURNS TABLE(
    segment_server_id BIGINT,
    status VARCHAR(20),
    message TEXT
)
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
```

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `p_segment_id` | `BIGINT` | YES | Target segment ID |
| `p_server_id` | `BIGINT` | YES | Server to add |
| `p_server_role_sk` | `INTEGER` | YES | Server role SK from lookup (type: server_role_sk) |
| `p_priority_order` | `INTEGER` | NO | Priority order (lower = higher priority, default 0) |
| `p_created_by` | `INTEGER` | YES | User ID adding the server |

**Return Type:** `TABLE(segment_server_id BIGINT, status VARCHAR(20), message TEXT)`

---

## Transaction Behavior

| Aspect | Value |
|--------|-------|
| Runs inside transaction | YES |
| Rollback scope | Full operation |
| Savepoint usage | None |

---

## Preconditions / Validation

- Segment must exist
- Server must exist
- Server role SK must exist in lookup table (Main or Secondary)
- Server not already in segment (uniqueness check)
- Created_by user must exist and have permissions
- Priority order must be non-negative

---

## Main Logic Steps

1. Validate segment exists
2. Validate server exists
3. Check server not already in segment
4. Validate server role SK exists in lookup
5. Set default priority if not provided
6. Insert segment_servers record
7. Update "Any Server" system segments if applicable
8. Log audit entry
9. Return success

---

## Waitlist Behavior

- [x] Not applicable - configuration function

---

## Audit Logging

| Audit Action | Logged To | Fields Captured |
|--------------|-----------|-----------------|
| `INSERT` | `staff_audit_log` | segment_id, server_id, server_role, priority_order, created_by, action='ADD_SERVER' |

**Audit helper used:** `fn_log_audit('segment_servers', 'ADD_SERVER', segment_server_id, ...)`

---

## Error Handling

| Error Code / Condition | Returned / Raised | Message |
|------------------------|-------------------|---------|
| Segment not found | EXCEPTION | 'Segment ID {id} not found' |
| Server not found | EXCEPTION | 'Server ID {id} not found' |
| Duplicate server in segment | EXCEPTION | 'Server already exists in this segment' |
| Invalid server role SK | EXCEPTION | 'Invalid server role SK: {sk}' |
| System segment modification | EXCEPTION | 'Cannot manually add servers to system segments' |

---

## SQL Implementation

```sql
CREATE OR REPLACE FUNCTION fn_segment_add_server(
    p_segment_id BIGINT,
    p_server_id BIGINT,
    p_server_role_sk INTEGER DEFAULT NULL,
    p_priority_order INTEGER DEFAULT 0,
    p_created_by INTEGER
)
RETURNS TABLE(
    segment_server_id BIGINT,
    status VARCHAR(20),
    message TEXT
)
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
    v_new_segment_server_id BIGINT;
    v_is_system_segment BOOLEAN;
    v_audit_data JSONB;
BEGIN
    -- Validation: Check segment exists
    SELECT is_system_segment INTO v_is_system_segment
    FROM segments WHERE segments.segment_id = p_segment_id;
    
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Segment ID % not found', p_segment_id;
    END IF;

    -- Validation: Prevent manual modification of system segments
    IF v_is_system_segment THEN
        RAISE EXCEPTION 'Cannot manually add servers to system segments';
    END IF;

    -- Validation: Check server exists
    IF NOT EXISTS (SELECT 1 FROM servers WHERE servers.server_id = p_server_id) THEN
        RAISE EXCEPTION 'Server ID % not found', p_server_id;
    END IF;

    -- Validation: Check server not already in segment
    IF EXISTS (
        SELECT 1 FROM segment_servers 
        WHERE segment_servers.segment_id = p_segment_id 
        AND segment_servers.server_id = p_server_id
    ) THEN
        RAISE EXCEPTION 'Server already exists in this segment';
    END IF;

    -- Validation: Check server role SK exists in lookup
    IF p_server_role_sk IS NOT NULL AND NOT EXISTS (
        SELECT 1 FROM lookup WHERE sk = p_server_role_sk AND type = 'server_role_sk'
    ) THEN
        RAISE EXCEPTION 'Invalid server role SK: %', p_server_role_sk;
    END IF;

    -- Insert segment_servers record
    INSERT INTO segment_servers (
        segment_id,
        server_id,
        server_role_sk,
        priority_order,
        created_by,
        updated_by
    ) VALUES (
        p_segment_id,
        p_server_id,
        COALESCE(p_server_role_sk, (SELECT sk FROM lookup WHERE type = 'server_role_sk' AND value = 'Main')),
        COALESCE(p_priority_order, 0),
        p_created_by,
        p_created_by
    )
    RETURNING segment_servers.segment_server_id INTO v_new_segment_server_id;

    -- Build audit data
    v_audit_data := jsonb_build_object(
        'segment_server_id', v_new_segment_server_id,
        'segment_id', p_segment_id,
        'server_id', p_server_id,
        'server_role_sk', p_server_role_sk,
        'priority_order', COALESCE(p_priority_order, 0)
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
        'ADD_SERVER',
        'segment_servers',
        'Server added to segment',
        v_audit_data
    );

    -- Return result
    RETURN QUERY
    SELECT 
        v_new_segment_server_id,
        'success'::VARCHAR(20),
        'Server added to segment successfully'::TEXT;

EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Error adding server to segment: %', SQLERRM;
END;
$$;
```

---

## Example Call

```sql
SELECT * FROM fn_segment_add_server(
    1::BIGINT,        -- segment_id
    5::BIGINT,        -- server_id
    (SELECT sk FROM lookup WHERE type = 'server_role_sk' AND value = 'Main'),  -- server_role_sk
    1::INTEGER,       -- priority_order
    1::INTEGER        -- created_by
);
```

---

## Related Functions / Triggers

| Related Object | Relationship |
|----------------|--------------|
| `fn_segment_create` | Creates parent segment |
| `fn_segment_remove_server` | Removes server from segment |
| `fn_update_any_server_segments` | Updates system segments |

---

## Notes for Developer

- Same server can be both main and secondary (common in single-server setups)
- Priority order determines failover sequence within role
- System segments automatically updated by triggers when servers added/removed
- When server added, validate it's appropriate for segment type (e.g., has_endpoint_api for communication)
