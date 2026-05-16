# fn_location_schedule_overrides

## Function Name

**Function:** `public.fn_location_schedule_overrides(...)`

**Purpose:** Manages special operating hours for specific dates at a location

**Called By:** Admin Portal API schedule management endpoints

---

## Signature

```sql
CREATE OR REPLACE FUNCTION public.fn_location_schedule_overrides(
    p_mode INTEGER,
    p_location_id INTEGER DEFAULT NULL,
    p_override_id BIGINT DEFAULT NULL,
    p_override_date DATE DEFAULT NULL,
    p_open_time TIME DEFAULT NULL,
    p_close_time TIME DEFAULT NULL,
    p_is_closed BOOLEAN DEFAULT FALSE,
    p_start_date DATE DEFAULT NULL,
    p_end_date DATE DEFAULT NULL,
    p_updated_by INTEGER DEFAULT NULL
)
RETURNS TABLE(
    result_override_id BIGINT,
    result_location_id INTEGER,
    result_override_date DATE,
    result_open_time TIME,
    result_close_time TIME,
    result_is_closed BOOLEAN,
    result_created_at TIMESTAMPTZ,
    result_updated_at TIMESTAMPTZ
)
LANGUAGE plpgsql
AS $$
```

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `p_mode` | `INTEGER` | YES | Operation mode (1-5) |
| `p_location_id` | `INTEGER` | Conditional | Location ID |
| `p_override_id` | `BIGINT` | Conditional | Override record ID |
| `p_override_date` | `DATE` | Conditional | Specific date for override |
| `p_open_time` | `TIME` | Conditional | Custom opening time |
| `p_close_time` | `TIME` | Conditional | Custom closing time |
| `p_is_closed` | `BOOLEAN` | NO | True if location closed (default: false) |
| `p_start_date` | `DATE` | Conditional | Range start (mode 1) |
| `p_end_date` | `DATE` | Conditional | Range end (mode 1) |
| `p_updated_by` | `INTEGER` | NO | User performing update |

**Return Type:** `TABLE` - Override records

**Modes:**
- `1` - List overrides for location within date range
- `2` - Get single override by override_id
- `3` - Upsert (create or update) single override
- `4` - Update existing override
- `5` - Delete override

**Constants:**
- `v_max_range` = 366 days (maximum date range for mode 1)

---

## Transaction Behavior

| Aspect | Value |
|--------|-------|
| Runs inside transaction | YES |
| Rollback scope | Full operation |
| Savepoint usage | None |

---

## Preconditions / Validation

**Mode 1 (List):**
- start_date and end_date must be provided
- start_date <= end_date
- Date range must not exceed 366 days
- Location must exist

**Mode 2 (Get):**
- override_id must be provided

**Mode 3 (Upsert):**
- location_id and override_date must be provided
- Location must exist
- If is_closed=TRUE, open_time and close_time must be NULL
- If is_closed=FALSE, both open_time and close_time must be provided

**Mode 4 (Update):**
- override_id must be provided
- Same time validation as mode 3 if times are updated

**Mode 5 (Delete):**
- override_id must be provided

---

## Main Logic Steps

### Mode 1: List Overrides
1. Validate start_date and end_date provided
2. Validate start_date <= end_date
3. Validate range <= 366 days
4. Validate location exists
5. Query overrides within date range
6. Order by override_date
7. Return records

### Mode 2: Get Single Override
1. Validate override_id provided
2. Query single record
3. Return record

### Mode 3: Upsert Override
1. Validate location_id and override_date provided
2. Validate location exists
3. If is_closed=TRUE, ensure times are NULL
4. If is_closed=FALSE, ensure both times provided
5. INSERT with ON CONFLICT DO UPDATE
6. Return upserted record

### Mode 4: Update Override
1. Validate override_id provided
2. Validate time consistency if provided
3. Update record (only provided fields)
4. Return updated record

### Mode 5: Delete Override
1. Validate override_id provided
2. Delete record
3. Return deleted record

---

## Waitlist Behavior

- `[ ]` This function does not interact with waitlists
- Schedule configuration only

---

## Audit Logging

| Audit Action | Logged To | Fields Captured |
|--------------|-----------|-----------------|
| Created/Updated | `location_schedule_overrides` | `created_at`, `updated_at` |

---

## Error Handling

| Error Code / Condition | Returned / Raised | Message |
|------------------------|-------------------|---------|
| `23502` (mode 1) | EXCEPTION | `p_start_date and p_end_date are required for mode 1` |
| `P0001` (date order) | EXCEPTION | `start_date must be <= end_date` |
| `P0001` (range limit) | EXCEPTION | `Date range must not exceed 366 days` |
| `P0001` (location) | EXCEPTION | `Location not found: {location_id}` |
| `23502` (mode 2) | EXCEPTION | `p_override_id is required for mode 2` |
| `23502` (mode 3) | EXCEPTION | `p_location_id is required for mode 3` |
| `23502` (mode 3) | EXCEPTION | `p_override_date is required for mode 3` |
| `P0001` (closed times) | EXCEPTION | `open_time and close_time must be NULL when is_closed=TRUE` |
| `P0001` (open times) | EXCEPTION | `Both open_time and close_time are required when is_closed=FALSE` |
| `23502` (mode 4) | EXCEPTION | `p_override_id is required for mode 4` |
| `23502` (mode 5) | EXCEPTION | `p_override_id is required for mode 5` |
| `P0001` (invalid mode) | EXCEPTION | `Invalid mode: {mode}. Valid modes: 1=list, 2=get, 3=upsert, 4=update, 5=delete` |

---

## SQL Implementation

```sql
CREATE OR REPLACE FUNCTION public.fn_location_schedule_overrides(...)
RETURNS TABLE(...)
LANGUAGE plpgsql
AS $function$
DECLARE
    v_max_range CONSTANT INTEGER := 366;
BEGIN
    IF p_mode = 1 THEN
        -- Validate and list
        IF (p_end_date - p_start_date + 1) > v_max_range THEN
            RAISE EXCEPTION 'Date range must not exceed % days', v_max_range USING ERRCODE = 'P0001';
        END IF;
        PERFORM _schedule_assert_location_exists(p_location_id);
        RETURN QUERY SELECT ... ORDER BY o.override_date;
        
    ELSIF p_mode = 3 THEN
        -- Upsert
        IF p_is_closed THEN
            IF p_open_time IS NOT NULL OR p_close_time IS NOT NULL THEN
                RAISE EXCEPTION ...;
            END IF;
        ELSE
            IF p_open_time IS NULL OR p_close_time IS NULL THEN
                RAISE EXCEPTION ...;
            END IF;
        END IF;
        RETURN QUERY
        INSERT INTO location_schedule_overrides (...)
        VALUES (...)
        ON CONFLICT (location_id, override_date)
        DO UPDATE SET ...
        RETURNING *;
    END IF;
END;
$function$
```

---

## Example Call

```sql
-- List overrides for May 2026
SELECT * FROM fn_location_schedule_overrides(
    p_mode := 1,
    p_location_id := 1,
    p_start_date := '2026-05-01',
    p_end_date := '2026-05-31'
);

-- Create override for special hours
SELECT * FROM fn_location_schedule_overrides(
    p_mode := 3,
    p_location_id := 1,
    p_override_date := '2026-07-04',
    p_open_time := '10:00',
    p_close_time := '14:00',
    p_is_closed := FALSE
);

-- Create override for closure
SELECT * FROM fn_location_schedule_overrides(
    p_mode := 3,
    p_location_id := 1,
    p_override_date := '2026-12-25',
    p_is_closed := TRUE
);

-- Delete override
SELECT * FROM fn_location_schedule_overrides(
    p_mode := 5,
    p_override_id := 123
);
```

---

## Related Functions / Triggers

| Related Object | Relationship |
|----------------|--------------|
| `location_schedule_overrides` table | Primary CRUD operations |
| `_schedule_assert_location_exists` | Validates location |
| `fn_location_holidays` | Related schedule management function |

---

## Notes for Developer

- **Date range limit:** 366 days maximum prevents performance issues
- **Upsert pattern:** Mode 3 uses ON CONFLICT for idempotent operations
- **Closure logic:** When closed, times must be NULL; when open, both times required
- **No soft delete:** Mode 5 performs hard DELETE
- **Unique constraint:** (location_id, override_date) ensures one override per date
- **Time consistency:** Validates open/close time combinations
- **Use case:** Special holiday hours, early closures, extended hours
- **Priority:** Overrides take precedence over regular schedule
