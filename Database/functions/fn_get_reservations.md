# fn_get_reservations

## Function Name

**Function:** `public.fn_get_reservations(p_data jsonb)`

**Purpose:** Retrieves reservation records with flexible filtering by reservation ID, user, or resource

**Called By:** API endpoints for reservation queries

---

## Signature

```sql
CREATE OR REPLACE FUNCTION public.fn_get_reservations(p_data jsonb)
RETURNS JSONB
LANGUAGE plpgsql
STABLE SECURITY DEFINER
AS $$
```

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `p_data` | `JSONB` | YES | JSON object containing filter parameters |

**p_data structure:**
- `p_reservation_id`: Reservation ID for single record lookup (optional)
- `p_user_id_sk`: Filter by user ID (optional, 0 = all users)
- `p_resource_id_sk`: Filter by resource ID (optional, 0 = all resources)

**Return Type:** `JSONB` - Single reservation object or array of reservations

---

## Transaction Behavior

| Aspect | Value |
|--------|-------|
| Runs inside transaction | YES |
| Rollback scope | Read-only operation |
| Savepoint usage | None |

---

## Preconditions / Validation

- Function always returns valid JSONB (never raises exceptions to caller)
- Filters out deleted/removed reservations automatically

---

## Main Logic Steps

### Single Record Mode (reservation_id > 0):
1. Extract reservation_id from p_data
2. Query reservation by ID
3. Filter by user_id_sk (for access control)
4. Exclude deleted status (LST='Removed')
5. Return single JSONB object
6. Return error object if not found

### List Mode (reservation_id = 0 or not provided):
1. Extract filter parameters from p_data
2. Query reservations table
3. Apply user_id_sk filter (0 = all users)
4. Apply resource_id_sk filter (0 = all resources)
5. Exclude deleted status
6. Aggregate results as JSONB array
7. Return array or error object if empty

---

## Waitlist Behavior

- `[ ]` This function does not interact with waitlists
- Read-only query function
- Returns confirmed reservations only

---

## Audit Logging

| Audit Action | Logged To | Fields Captured |
|--------------|-----------|-----------------|
| N/A | N/A | Read-only operation - no audit logging |

---

## Error Handling

| Error Code / Condition | Returned / Raised | Message |
|------------------------|-------------------|---------|
| No record found (single) | JSONB | `{status: false, message: 'No record found'}` |
| No records found (list) | JSONB | `{status: false, message: 'No records found'}` |
| Any exception | JSONB | `{status: false, message: SQLERRM}` |

**Note:** Function never raises exceptions - always returns JSONB with error details.

---

## SQL Implementation

```sql
CREATE OR REPLACE FUNCTION public.fn_get_reservations(p_data jsonb)
RETURNS jsonb
LANGUAGE plpgsql
STABLE SECURITY DEFINER
AS $function$
DECLARE
    v_reservation_id   BIGINT;
    v_user_id_sk       INTEGER;
    v_resource_id_sk   INTEGER;
    v_delete_status_sk INTEGER;
    v_result jsonb;
BEGIN
    -- Get delete status SK
    SELECT sk INTO v_delete_status_sk
    FROM lookup
    WHERE code = 'LST' AND value = 'Removed'
    LIMIT 1;

    -- Extract parameters
    v_reservation_id := COALESCE((p_data->>'p_reservation_id')::BIGINT, 0);
    v_user_id_sk     := COALESCE((p_data->>'p_user_id_sk')::INTEGER, 0);
    v_resource_id_sk := COALESCE((p_data->>'p_resource_id_sk')::INTEGER, 0);

    -- Single record mode
    IF v_reservation_id > 0 THEN
        SELECT jsonb_build_object(
            'reservation_id', r.reservation_id,
            'resource_id_sk', r.resource_id_sk,
            'user_id_sk', r.user_id_sk,
            'status_sk', r.status_sk,
            'allocation_date', r.allocation_date,
            'allocation_time', r.allocation_time,
            'allocation_duration', r.allocation_duration,
            'created_by', r.created_by,
            'created_at', r.created_at,
            'updated_by', r.updated_by,
            'updated_at', r.updated_at
        )
        INTO v_result
        FROM reservations r
        WHERE r.reservation_id = v_reservation_id
          AND r.user_id_sk = v_user_id_sk
          AND r.status_sk IS NOT NULL
          AND status_sk <> v_delete_status_sk
        LIMIT 1;

        RETURN COALESCE(v_result,
            jsonb_build_object('status', false, 'message', 'No record found')
        );
    END IF;

    -- List mode
    SELECT jsonb_agg(
        jsonb_build_object(
            'reservation_id', r.reservation_id,
            'resource_id_sk', r.resource_id_sk,
            'user_id_sk', r.user_id_sk,
            'status_sk', r.status_sk,
            'allocation_date', r.allocation_date,
            'allocation_time', r.allocation_time,
            'allocation_duration', r.allocation_duration,
            'created_at', r.created_at
        )
    )
    INTO v_result
    FROM reservations r
    WHERE (v_user_id_sk = 0 OR r.user_id_sk = v_user_id_sk)
      AND (v_resource_id_sk = 0 OR r.resource_id_sk = v_resource_id_sk)
      AND status_sk <> v_delete_status_sk
      AND r.status_sk IS NOT NULL;

    RETURN COALESCE(v_result,
        jsonb_build_object('status', false, 'message', 'No records found')
    );

EXCEPTION
    WHEN OTHERS THEN
        RETURN jsonb_build_object('status', false, 'message', SQLERRM);
END;
$function$
```

---

## Example Call

```sql
-- Get single reservation by ID
SELECT fn_get_reservations(jsonb_build_object(
    'p_reservation_id', 123,
    'p_user_id_sk', 456
));

-- Get all reservations for a user
SELECT fn_get_reservations(jsonb_build_object(
    'p_user_id_sk', 456,
    'p_resource_id_sk', 0
));

-- Get all reservations for a resource
SELECT fn_get_reservations(jsonb_build_object(
    'p_user_id_sk', 0,
    'p_resource_id_sk', 789
));

-- Get all active reservations
SELECT fn_get_reservations(jsonb_build_object(
    'p_user_id_sk', 0,
    'p_resource_id_sk', 0
));
```

---

## Related Functions / Triggers

| Related Object | Relationship |
|----------------|--------------|
| `reservations` table | Queries reservation data |
| `lookup` table | Gets delete status SK |
| `fn_kiosk_create_reservation` | Creates reservations that this function retrieves |

---

## Notes for Developer

- **SECURITY DEFINER:** Runs with function owner's privileges (use carefully)
- **Delete filter:** Automatically excludes reservations with 'Removed' status
- **Zero convention:** Value of 0 means "no filter" for user_id_sk and resource_id_sk
- **Access control:** Single record mode requires matching user_id_sk
- **NULL status check:** Filters out records where status_sk IS NULL
- **COALESCE pattern:** Returns error object instead of NULL when no results
- **Exception handling:** Catches all errors and returns as JSONB error object
- **JSONB output:** All results as JSONB for easy API consumption
- **Stable function:** Safe for optimization since it doesn't modify data
- **Legacy table:** Uses older `reservations` table (not `reservations_new`)
