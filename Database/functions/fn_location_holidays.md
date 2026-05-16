# fn_location_holidays

## Function Name

**Function:** `public.fn_location_holidays(...)`

**Purpose:** CRUD operations for location-specific holidays and closure dates

**Called By:** Admin Portal API location management endpoints

---

## Signature

```sql
CREATE OR REPLACE FUNCTION public.fn_location_holidays(
    p_mode INTEGER,
    p_location_holiday_id INTEGER DEFAULT NULL,
    p_location_id INTEGER DEFAULT NULL,
    p_holiday_name VARCHAR DEFAULT NULL,
    p_start_date DATE DEFAULT NULL,
    p_end_date DATE DEFAULT NULL,
    p_closure_type VARCHAR DEFAULT NULL,
    p_is_active BOOLEAN DEFAULT NULL,
    p_created_by INTEGER DEFAULT NULL,
    p_updated_by INTEGER DEFAULT NULL
)
RETURNS TABLE(
    location_holiday_id INTEGER,
    location_id INTEGER,
    holiday_name VARCHAR,
    start_date DATE,
    end_date DATE,
    closure_type VARCHAR,
    is_active BOOLEAN,
    created_at TIMESTAMP,
    created_by INTEGER,
    updated_at TIMESTAMP,
    updated_by INTEGER
)
LANGUAGE plpgsql
AS $$
```

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `p_mode` | `INTEGER` | YES | Operation mode (1-5) |
| `p_location_holiday_id` | `INTEGER` | Conditional | Holiday ID (modes 2, 4, 5) |
| `p_location_id` | `INTEGER` | Conditional | Location ID (modes 1, 3) |
| `p_holiday_name` | `VARCHAR` | Conditional | Holiday name (mode 3) |
| `p_start_date` | `DATE` | Conditional | Start date (mode 3) |
| `p_end_date` | `DATE` | Conditional | End date (mode 3) |
| `p_closure_type` | `VARCHAR` | NO | Type of closure |
| `p_is_active` | `BOOLEAN` | NO | Active status (default: true) |
| `p_created_by` | `INTEGER` | NO | Creating user |
| `p_updated_by` | `INTEGER` | NO | Updating user |

**Return Type:** `TABLE` - Holiday records matching the operation

**Modes:**
- `1` - List all holidays (optionally filtered by location_id)
- `2` - Get single holiday by location_holiday_id
- `3` - Create new holiday
- `4` - Update existing holiday
- `5` - Delete holiday

---

## Transaction Behavior

| Aspect | Value |
|--------|-------|
| Runs inside transaction | YES |
| Rollback scope | Full operation |
| Savepoint usage | None |

---

## Preconditions / Validation

**Mode 2 (Get):**
- location_holiday_id must be provided

**Mode 3 (Create):**
- location_id must be provided and exist
- Location must exist (validated via _schedule_assert_location_exists)

**Mode 4 (Update):**
- location_holiday_id must be provided

**Mode 5 (Delete):**
- location_holiday_id must be provided

---

## Main Logic Steps

### Mode 1: List Holidays
1. Query location_holidays table
2. Filter by location_id if provided
3. Order by location_id and start_date
4. Return all matching records

### Mode 2: Get Single Holiday
1. Validate location_holiday_id is provided
2. Query single record by ID
3. Return record

### Mode 3: Create Holiday
1. Validate location_id is provided
2. Call _schedule_assert_location_exists to validate location
3. Trim and NULLIF holiday_name and closure_type
4. Insert record with defaults
5. Return created record

### Mode 4: Update Holiday
1. Validate location_holiday_id is provided
2. Update provided fields (using COALESCE for optional updates)
3. Set updated_at to NOW()
4. Return updated record

### Mode 5: Delete Holiday
1. Validate location_holiday_id is provided
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
| Created/Updated | `location_holidays` | `created_by`, `updated_by`, `created_at`, `updated_at` |

---

## Error Handling

| Error Code / Condition | Returned / Raised | Message |
|------------------------|-------------------|---------|
| `23502` (mode 2) | EXCEPTION | `p_location_holiday_id is required for mode 2` |
| `23502` (mode 3) | EXCEPTION | `p_location_id is required for mode 3` |
| `P0001` (mode 3) | EXCEPTION | `Location not found: {location_id}` (from helper) |
| `23502` (mode 4) | EXCEPTION | `p_location_holiday_id is required for mode 4` |
| `23502` (mode 5) | EXCEPTION | `p_location_holiday_id is required for mode 5` |
| `P0001` (invalid mode) | EXCEPTION | `Invalid mode: {mode}. Valid modes: 1=list, 2=get, 3=create, 4=update, 5=delete` |

---

## SQL Implementation

```sql
CREATE OR REPLACE FUNCTION public.fn_location_holidays(...)
RETURNS TABLE(...)
LANGUAGE plpgsql
AS $function$
BEGIN
    IF p_mode = 1 THEN
        -- List all or filtered by location
        RETURN QUERY
        SELECT lh.* FROM location_holidays lh
        WHERE (p_location_id IS NULL OR lh.location_id = p_location_id)
        ORDER BY lh.location_id, lh.start_date;
        
    ELSIF p_mode = 2 THEN
        -- Get single by ID
        IF p_location_holiday_id IS NULL THEN
            RAISE EXCEPTION 'p_location_holiday_id is required for mode 2' USING ERRCODE = '23502';
        END IF;
        RETURN QUERY SELECT lh.* FROM location_holidays lh WHERE lh.location_holiday_id = p_location_holiday_id;
        
    ELSIF p_mode = 3 THEN
        -- Create
        PERFORM _schedule_assert_location_exists(p_location_id);
        RETURN QUERY
        INSERT INTO location_holidays (...) VALUES (...) RETURNING *;
        
    ELSIF p_mode = 4 THEN
        -- Update
        RETURN QUERY
        UPDATE location_holidays lh SET ... WHERE ... RETURNING *;
        
    ELSIF p_mode = 5 THEN
        -- Delete
        RETURN QUERY DELETE FROM location_holidays WHERE ... RETURNING *;
    END IF;
END;
$function$
```

---

## Example Call

```sql
-- List all holidays for location 1
SELECT * FROM fn_location_holidays(
    p_mode := 1,
    p_location_id := 1
);

-- Create new holiday
SELECT * FROM fn_location_holidays(
    p_mode := 3,
    p_location_id := 1,
    p_holiday_name := 'Christmas Day',
    p_start_date := '2026-12-25',
    p_end_date := '2026-12-25',
    p_closure_type := 'full_day',
    p_is_active := true,
    p_created_by := 1
);

-- Update holiday
SELECT * FROM fn_location_holidays(
    p_mode := 4,
    p_location_holiday_id := 1,
    p_holiday_name := 'Christmas Holiday',
    p_updated_by := 1
);

-- Delete holiday
SELECT * FROM fn_location_holidays(
    p_mode := 5,
    p_location_holiday_id := 1
);
```

---

## Related Functions / Triggers

| Related Object | Relationship |
|----------------|--------------|
| `location_holidays` table | Primary CRUD operations |
| `_schedule_assert_location_exists` | Called to validate location |
| `locations` table | Referenced for location validation |

---

## Notes for Developer

- **Location validation:** Always validates location exists before creating
- **NULLIF pattern:** Trims and converts empty strings to NULL
- **Date ranges:** Supports single-day (start_date = end_date) or multi-day closures
- **Closure types:** Expected values like 'full_day', 'partial', etc.
- **is_active flag:** Allows soft-disabling holidays without deletion
- **COALESCE updates:** Mode 4 only updates provided fields
- **Hard delete:** Mode 5 performs actual DELETE (not soft delete)
- **Order by:** Mode 1 orders by location then start_date for logical grouping
