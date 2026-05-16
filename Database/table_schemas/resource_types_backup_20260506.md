# Table Schema Template

> **Instructions:** Copy this file, rename it to match your table (e.g., `reservations.md`), and fill in all sections marked with `[FILL]`. Remove this instructions block when done.
> All table and field names must use `lowercase_snake_case`.

---

## Table Name

**Table:** `resource_types_backup_20260506`

**Purpose:** `[FILL: One-line description of what this table stores]`

**Setup / Defaults:** `[FILL: Any default rows, auto-generated entries, or setup flags]`

---

## Dependencies

| Depends On | Relationship | Notes |
|------------|-------------|-------|
| `resource_types_backup_20260506` | `[FILL: FK / trigger / etc]` | `[FILL: description]` |

---

## Columns

| Column Name | Data Type | Nullable | Default | Constraints | Description |
|-------------|-----------|----------|---------|-------------|-------------|
| `id` | `BIGSERIAL` | NO | Auto | `PRIMARY KEY` | Surrogate primary key |
| `[FILL: column]` | `[FILL: type]` | `[YES/NO]` | `[FILL]` | `[FILL]` | `[FILL: description]` |
| `created_at` | `TIMESTAMP WITH TIME ZONE` | NO | `NOW()` | | Record creation timestamp |
| `updated_at` | `TIMESTAMP WITH TIME ZONE` | NO | `NOW()` | | Last update timestamp (trigger-maintained) |
| `created_by` | `BIGINT` | YES | | `FK -> users(id)` | User who created this record |
| `updated_by` | `BIGINT` | YES | | `FK -> users(id)` | User who last updated this record |

---

## Indexes

| Index Name | Columns | Type | Purpose |
|------------|---------|------|---------|
| `[FILL: idx_name]` | `[FILL: column(s)]` | `[B-tree / GIN / etc]` | `[FILL: why]` |

---

## Foreign Keys

| Column | References | On Delete | On Update | Notes |
|--------|------------|-----------|-----------|-------|
| `[FILL: column]` | `[FILL: table(column)]` | `[CASCADE / SET NULL / RESTRICT]` | `[CASCADE / NO ACTION]` | `[FILL]` |

---

## Triggers

| Trigger Name | Event | Function | Purpose |
|--------------|-------|----------|---------|
| `trg_resource_types_backup_20260506_updated_at` | `BEFORE UPDATE` | `fn_update_timestamp()` | Auto-update `updated_at` |
| `[FILL]` | `[FILL]` | `[FILL]` | `[FILL]` |

---

## Constraints

| Constraint Name | Type | Columns / Expression | Notes |
|-----------------|------|----------------------|-------|
| `[FILL: chk_name]` | `CHECK` | `[FILL: expression]` | `[FILL: purpose]` |

---

## Waitlist Support

> All tables representing reservable resources or their related state must support waitlist behavior.

- `[ ]` This table directly represents a reservable resource
- `[ ]` This table has a related waitlist table (name: `[FILL: table_name_waitlist]`)
- `[ ]` Waitlist promotion is handled by: `[FILL: function name]`

---

## Audit Requirements

> Every reservation action must be auditable. If this table captures reservation-related data, ensure:

- `[ ]` Changes are logged to `[FILL: audit table]`
- `[ ]` Trigger or function captures: old value, new value, changed by, changed at, action type
- `[ ]` Audit function name: `[FILL]`

---

## SQL DDL

```sql
-- Drop if exists (for dev/re-run safety)
-- DROP TABLE IF EXISTS [table_name] CASCADE;

CREATE TABLE [table_name] (
    id                  BIGSERIAL PRIMARY KEY,
    -- [FILL: columns]

    created_at          TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    updated_at          TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    created_by          BIGINT REFERENCES users(id) ON DELETE SET NULL,
    updated_by          BIGINT REFERENCES users(id) ON DELETE SET NULL
);

-- Indexes
-- CREATE INDEX idx_resource_types_backup_20260506_[column] ON [table_name]([column]);

-- Triggers
-- CREATE TRIGGER trg_resource_types_backup_20260506_updated_at
--     BEFORE UPDATE ON [table_name]
--     FOR EACH ROW
--     EXECUTE FUNCTION fn_update_timestamp();
```

---

## Notes for Developer

- `[FILL: Any special migration notes, data seeding requirements, or business-rule reminders]`

