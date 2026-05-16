# PostgreSQL Function: fn_segment_create

## Function Name

**Function:** `fn_segment_create(p_segment_name, p_segment_type, p_description, p_server_preference_mode, p_failover_mode, p_created_by)`

**Purpose:** Creates a new segment with specified configuration for communication and/or authentication routing.

**Called By:** API Controller: `/api/constructs/segments` (POST)

---

## Signature

```sql
CREATE OR REPLACE FUNCTION fn_segment_create(
    p_segment_name VARCHAR(150),
    p_segment_type VARCHAR(30),
    p_description TEXT,
    p_server_preference_mode VARCHAR(30),
    p_failover_mode VARCHAR(30),
    p_latency_threshold_ms INTEGER,
    p_failback_interval_minutes INTEGER,
    p_created_by INTEGER
)
RETURNS TABLE(
    segment_id BIGINT,
    segment_name VARCHAR(150),
    status VARCHAR(20),
    message TEXT
)
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
```

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `p_segment_name` | `VARCHAR(150)` | YES | Unique segment name |
| `p_segment_type` | `VARCHAR(30)` | YES | Type: 'communication', 'authentication', or 'both' |
| `p_description` | `TEXT` | NO | Optional description |
| `p_server_preference_mode` | `VARCHAR(30)` | NO | Server preference: 'prefer_main', 'combination', 'any', 'load_balance' |
| `p_failover_mode` | `VARCHAR(30)` | NO | Failover strategy: 'latency', 'round_robin', 'random' |
| `p_latency_threshold_ms` | `INTEGER` | NO | Latency threshold for offline determination (default 1000ms) |
| `p_failback_interval_minutes` | `INTEGER` | NO | Minutes between preferred server checks (default 5) |
| `p_created_by` | `INTEGER` | YES | User ID creating the segment |

**Return Type:** `TABLE(segment_id BIGINT, segment_name VARCHAR(150), status VARCHAR(20), message TEXT)`

---

## Transaction Behavior

| Aspect | Value |
|--------|-------|
| Runs inside transaction | YES |
| Rollback scope | Full operation |
| Savepoint usage | None |

---

## Preconditions / Validation

- Segment name must be unique (not already exist)
- Segment type must be one of: 'communication', 'authentication', 'both'
- Server preference mode must be valid enum value
- Failover mode must be valid enum value
- Created_by user must exist and have permissions
- Latency threshold must be positive if provided
- Failback interval must be positive if provided

---

## Main Logic Steps

1. Validate input parameters
2. Check segment name uniqueness
3. Validate created_by user exists
4. Set default values for optional parameters
5. Insert new segment record
6. Log audit entry for segment creation
7. Return newly created segment details

---

## Waitlist Behavior

- [ ] This function creates a reservation that may trigger waitlist promotion
- [ ] This function cancels a reservation and must promote from waitlist
- [ ] Waitlist promotion is handled by: N/A
- [ ] This function directly manages waitlist entries
- [x] Not applicable - configuration function

**Waitlist promotion rules:** N/A

---

## Audit Logging

| Audit Action | Logged To | Fields Captured |
|--------------|-----------|-----------------|
| `INSERT` | `staff_audit_log` | segment_id, segment_name, segment_type, created_by, created_at, action='CREATE' |

**Audit helper used:** `fn_log_audit('segments', 'CREATE', new_segment_id, NULL, segment_data_jsonb, p_created_by)`

---

## Error Handling

| Error Code / Condition | Returned / Raised | Message |
|------------------------|-------------------|---------|
| Duplicate segment name | EXCEPTION | 'Segment name already exists: {name}' |
| Invalid segment type | EXCEPTION | 'Invalid segment type. Must be: communication, authentication, or both' |
| Invalid preference mode | EXCEPTION | 'Invalid server preference mode' |
| Invalid failover mode | EXCEPTION | 'Invalid failover mode' |
| User not found | EXCEPTION | 'User ID {id} not found' |
| Negative threshold | EXCEPTION | 'Latency threshold must be positive' |

---

## SQL Implementation

```sql
CREATE OR REPLACE FUNCTION fn_segment_create(
    p_segment_name VARCHAR(150),
    p_segment_type VARCHAR(30),
    p_description TEXT DEFAULT NULL,
    p_server_preference_mode VARCHAR(30) DEFAULT 'any',
    p_failover_mode VARCHAR(30) DEFAULT 'latency',
    p_latency_threshold_ms INTEGER DEFAULT 1000,
    p_failback_interval_minutes INTEGER DEFAULT 5,
    p_created_by INTEGER
)
RETURNS TABLE(
    segment_id BIGINT,
    segment_name VARCHAR(150),
    status VARCHAR(20),
    message TEXT
)
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
    v_new_segment_id BIGINT;
    v_segment_data JSONB;
BEGIN
    -- Validation: Check segment name uniqueness
    IF EXISTS (SELECT 1 FROM segments WHERE segments.segment_name = p_segment_name) THEN
        RAISE EXCEPTION 'Segment name already exists: %', p_segment_name;
    END IF;

    -- Validation: Check segment type
    IF p_segment_type NOT IN ('communication', 'authentication', 'both') THEN
        RAISE EXCEPTION 'Invalid segment type. Must be: communication, authentication, or both';
    END IF;

    -- Validation: Check user exists
    IF NOT EXISTS (SELECT 1 FROM users WHERE users.id = p_created_by) THEN
        RAISE EXCEPTION 'User ID % not found', p_created_by;
    END IF;

    -- Validation: Check latency threshold
    IF p_latency_threshold_ms IS NOT NULL AND p_latency_threshold_ms <= 0 THEN
        RAISE EXCEPTION 'Latency threshold must be positive';
    END IF;

    -- Insert new segment
    INSERT INTO segments (
        segment_name,
        segment_type,
        description,
        server_preference_mode,
        failover_mode,
        latency_threshold_ms,
        failback_interval_minutes,
        status,
        created_by,
        updated_by
    ) VALUES (
        p_segment_name,
        p_segment_type,
        p_description,
        COALESCE(p_server_preference_mode, 'any'),
        COALESCE(p_failover_mode, 'latency'),
        COALESCE(p_latency_threshold_ms, 1000),
        COALESCE(p_failback_interval_minutes, 5),
        'active',
        p_created_by,
        p_created_by
    )
    RETURNING segments.segment_id INTO v_new_segment_id;

    -- Build audit data
    v_segment_data := jsonb_build_object(
        'segment_id', v_new_segment_id,
        'segment_name', p_segment_name,
        'segment_type', p_segment_type,
        'server_preference_mode', COALESCE(p_server_preference_mode, 'any'),
        'failover_mode', COALESCE(p_failover_mode, 'latency')
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
        'segments',
        'Segment created: ' || p_segment_name,
        v_segment_data
    );

    -- Return result
    RETURN QUERY
    SELECT 
        v_new_segment_id,
        p_segment_name,
        'active'::VARCHAR(20),
        'Segment created successfully'::TEXT;

EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Error creating segment: %', SQLERRM;
END;
$$;
```

---

## Example Call

```sql
SELECT * FROM fn_segment_create(
    'Downtown Communication'::VARCHAR(150),
    'communication'::VARCHAR(30),
    'Communication segment for downtown locations'::TEXT,
    'prefer_main'::VARCHAR(30),
    'latency'::VARCHAR(30),
    1000::INTEGER,
    5::INTEGER,
    1::INTEGER
);
```

---

## Related Functions / Triggers

| Related Object | Relationship |
|----------------|--------------|
| `fn_segment_update` | Update existing segment |
| `fn_segment_delete` | Delete segment |
| `fn_segment_add_server` | Add server to segment |
| `trg_segments_updated_at` | Trigger target |

---

## Notes for Developer

- System segments ("Any Server - Communication" and "Any Server - Authentication") created during installation
- Segment cannot be deleted if assigned to any locations (enforced by FK RESTRICT)
- Empty segment (no servers) is allowed initially - servers added separately
- Preference mode and failover mode work together to determine server selection
- Latency threshold used to determine when server is considered offline
