# update_updated_at_column

## Function Name

**Function:** `public.update_updated_at_column()`

**Purpose:** Trigger function that automatically updates the `updated_at` timestamp column on row modifications

**Called By:** Database triggers on tables requiring automatic timestamp updates

---

## Signature

```sql
CREATE OR REPLACE FUNCTION public.update_updated_at_column()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
```

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| None | N/A | N/A | Trigger functions receive context automatically |

**Return Type:** `TRIGGER` - Returns NEW record with updated timestamp

---

## Transaction Behavior

| Aspect | Value |
|--------|-------|
| Runs inside transaction | YES (within trigger context) |
| Rollback scope | Part of triggering statement's transaction |
| Savepoint usage | None |

---

## Preconditions / Validation

- Table must have an `updated_at` column (typically `TIMESTAMP` or `TIMESTAMP WITH TIME ZONE`)
- Called as a BEFORE UPDATE trigger

---

## Main Logic Steps

1. Set `NEW.updated_at` to `CURRENT_TIMESTAMP`
2. Return the modified NEW record

---

## Waitlist Behavior

- `[ ]` This function does not interact with waitlists
- This is a generic utility trigger function

---

## Audit Logging

| Audit Action | Logged To | Fields Captured |
|--------------|-----------|-----------------|
| N/A | N/A | No audit logging - only updates timestamp |

---

## Error Handling

| Error Code / Condition | Returned / Raised | Message |
|------------------------|-------------------|---------|
| None | N/A | Function does not raise exceptions |

**Note:** If the `updated_at` column doesn't exist, PostgreSQL will raise a column not found error at the database level.

---

## SQL Implementation

```sql
CREATE OR REPLACE FUNCTION public.update_updated_at_column()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$function$
```

---

## Example Call

```sql
-- Create trigger on a table
CREATE TRIGGER trg_update_timestamp
BEFORE UPDATE ON public.staff_members
FOR EACH ROW
EXECUTE FUNCTION public.update_updated_at_column();

-- Trigger fires automatically on UPDATE
UPDATE public.staff_members 
SET first_name = 'John' 
WHERE id = '...';
-- updated_at is automatically set to current timestamp
```

---

## Related Functions / Triggers

| Related Object | Relationship |
|----------------|--------------|
| Any table with `updated_at` column | Attached as BEFORE UPDATE trigger |
| `staff_members` | Uses this trigger |
| `reservations` | Uses this trigger |
| `resources` | Uses this trigger |

---

## Notes for Developer

- This is a standard pattern for automatic timestamp management
- Must be created as a BEFORE UPDATE trigger (not AFTER)
- Ensures consistent timestamp updates across all tables
- Uses `CURRENT_TIMESTAMP` which respects the session timezone
- Do not modify this function without considering impact on all tables using it
