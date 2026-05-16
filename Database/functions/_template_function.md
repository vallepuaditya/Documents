# PostgreSQL Function Template

> **Instructions:** Copy this file, rename it to match your function (e.g., `fn_create_reservation.md`), and fill in all sections marked with `[FILL]`. Remove this instructions block when done.
> Business logic must stay in PostgreSQL functions; controllers only call DB procedures.

---

## Function Name

**Function:** `[FILL: function_name]([FILL: parameters])`

**Purpose:** `[FILL: One-line description of what this function does]`

**Called By:** `[FILL: Controller / trigger / other function]`

---

## Signature

```sql
CREATE OR REPLACE FUNCTION [schema.][function_name](
    [FILL: param1_name] [FILL: param1_type],
    [FILL: param2_name] [FILL: param2_type]
)
RETURNS [FILL: return_type]
LANGUAGE plpgsql
[SECURITY DEFINER / INVOKER]
AS $$
```

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `[FILL: param]` | `[FILL: type]` | `[YES/NO]` | `[FILL: description]` |

**Return Type:** `[FILL: TABLE(...) / VOID / BOOLEAN / JSONB / etc]`

---

## Transaction Behavior

| Aspect | Value |
|--------|-------|
| Runs inside transaction | `[YES / NO]` |
| Rollback scope | `[FILL: full operation / partial]` |
| Savepoint usage | `[FILL: if any]` |

---

## Preconditions / Validation

- `[FILL: e.g., "User must be active", "Resource must exist and be available", etc]`
- `[FILL]`

---

## Main Logic Steps

1. `[FILL: Step 1]`
2. `[FILL: Step 2]`
3. `[FILL: Step 3]`

---

## Waitlist Behavior

> All reservation-related functions must consider waitlist implications.

- `[ ]` This function creates a reservation that may trigger waitlist promotion
- `[ ]` This function cancels a reservation and must promote from waitlist
- `[ ]` Waitlist promotion is handled by: `[FILL: function name]`
- `[ ]` This function directly manages waitlist entries

**Waitlist promotion rules:** `[FILL: e.g., FIFO, priority-based, etc]`

---

## Audit Logging

> Every reservation action must be auditable.

| Audit Action | Logged To | Fields Captured |
|--------------|-----------|-----------------|
| `[FILL: INSERT / UPDATE / DELETE / etc]` | `[FILL: audit table]` | `[FILL: old_val, new_val, changed_by, changed_at, action_type]` |

**Audit helper used:** `[FILL: fn_log_audit(...)]`

---

## Error Handling

| Error Code / Condition | Returned / Raised | Message |
|------------------------|-------------------|---------|
| `[FILL: e.g., user_not_found]` | `[EXCEPTION / RETURN NULL / RETURN FALSE]` | `[FILL]` |
| `[FILL]` | `[FILL]` | `[FILL]` |

---

## SQL Implementation

```sql
CREATE OR REPLACE FUNCTION [schema.][function_name](
    p_[param1] [type],
    p_[param2] [type]
)
RETURNS [return_type]
LANGUAGE plpgsql
SECURITY [DEFINER / INVOKER]
AS $$
DECLARE
    v_[var1] [type];
    v_[var2] [type];
BEGIN
    -- [FILL: Validation]

    -- [FILL: Main logic]

    -- [FILL: Audit logging]

    -- [FILL: Return / COMMIT]

EXCEPTION
    WHEN [exception_type] THEN
        -- [FILL: Error handling]
        RAISE EXCEPTION '[message]', ...;
END;
$$;
```

---

## Example Call

```sql
SELECT * FROM [function_name](
    [FILL: example_arg1]::[type],
    [FILL: example_arg2]::[type]
);
```

---

## Related Functions / Triggers

| Related Object | Relationship |
|----------------|--------------|
| `[FILL: function_name]` | `[FILL: calls / called by / trigger target]` |

---

## Notes for Developer

- `[FILL: Any gotchas, performance notes, or business-rule reminders]`
