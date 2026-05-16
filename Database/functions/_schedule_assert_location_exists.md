# _schedule_assert_location_exists

## Function Name

**Function:** `public._schedule_assert_location_exists(p_location_id integer)`

**Purpose:** Validates that a location exists before allowing schedule-related operations

**Called By:** Schedule management functions (fn_location_holidays, fn_location_schedule_overrides)

---

## Signature

```sql
CREATE OR REPLACE FUNCTION public._schedule_assert_location_exists(
    p_location_id INTEGER
)
RETURNS VOID
LANGUAGE plpgsql
STABLE
AS $$
```

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `p_location_id` | `INTEGER` | YES | The location ID to validate |

**Return Type:** `VOID` - Raises exception on validation failure

---

## Transaction Behavior

| Aspect | Value |
|--------|-------|
| Runs inside transaction | YES |
| Rollback scope | Full operation on exception |
| Savepoint usage | None |

---

## Preconditions / Validation

- `p_location_id` must not be NULL
- Location with given ID must exist in `public.locations` table

---

## Main Logic Steps

1. Check if `p_location_id` is NULL - raise exception if true
2. Query `public.locations` table for the given location_id
3. If location doesn't exist, raise exception with location ID in message

---

## Waitlist Behavior

- `[ ]` This function does not interact with waitlists
- This is a validation utility function

---

## Audit Logging

| Audit Action | Logged To | Fields Captured |
|--------------|-----------|-----------------|
| N/A | N/A | No audit logging - validation only |

---

## Error Handling

| Error Code / Condition | Returned / Raised | Message |
|------------------------|-------------------|---------|
| `23502` (NOT NULL VIOLATION) | EXCEPTION | `location_id cannot be null` |
| `P0001` (CUSTOM ERROR) | EXCEPTION | `Location not found: {p_location_id}` |

---

## SQL Implementation

```sql
CREATE OR REPLACE FUNCTION public._schedule_assert_location_exists(p_location_id integer)
 RETURNS void
 LANGUAGE plpgsql
 STABLE
AS $function$
BEGIN
    IF p_location_id IS NULL THEN
        RAISE EXCEPTION 'location_id cannot be null' USING ERRCODE = '23502';
    END IF;
    IF NOT EXISTS (SELECT 1 FROM public.locations WHERE location_id = p_location_id) THEN
        RAISE EXCEPTION 'Location not found: %', p_location_id USING ERRCODE = 'P0001';
    END IF;
END;
$function$
```

---

## Example Call

```sql
-- Validate location exists
SELECT public._schedule_assert_location_exists(1);

-- Will raise exception if location doesn't exist
SELECT public._schedule_assert_location_exists(9999);
```

---

## Related Functions / Triggers

| Related Object | Relationship |
|----------------|--------------|
| `fn_location_holidays` | Called by - validates location before creating holidays |
| `fn_location_schedule_overrides` | Called by - validates location before creating overrides |

---

## Notes for Developer

- This is a private utility function (prefix with `_`)
- Marked as STABLE since it reads from database but doesn't modify
- Always use this function before creating location-specific schedule records
- Provides consistent error messages across all schedule functions
