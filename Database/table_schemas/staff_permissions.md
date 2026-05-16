# staff_permissions Table Schema

**Table:** `staff_permissions`

**Purpose:** [FILL: Description of this table's purpose]

**Setup / Defaults:** [FILL: Any default rows or setup requirements]

---

## Dependencies

| Depends On | Relationship | Notes |
|------------|-------------|-------|
| [FILL] | [FILL] | [FILL] |

---

## Columns

| Column Name | Data Type | Nullable | Default | Constraints | Description |
|-------------|-----------|----------|---------|-------------|-------------|
| `id` | `uuid` | NO | `gen_random_uuid()` | PRIMARY KEY | [FILL] |
| `permission_key` | `character varying(50)` | NO |  |  | [FILL] |
| `display_name` | `character varying(100)` | NO |  |  | [FILL] |
| `description` | `text` | YES |  |  | [FILL] |
| `is_active` | `boolean` | NO | `true` |  | [FILL] |
| `created_by` | `uuid` | YES |  |  | [FILL] |
| `created_at` | `timestamp with time zone` | NO | `now()` |  | [FILL] |
| `updated_by` | `uuid` | YES |  |  | [FILL] |
| `updated_at` | `timestamp with time zone` | YES |  |  | [FILL] |

---

## Indexes

| Index Name | Columns | Type | Purpose |
|------------|---------|------|---------|
| [FILL] | [FILL] | B-tree | [FILL] |

---

## Foreign Keys

| Column | References | On Delete | On Update | Notes |
|--------|------------|-----------|-----------|-------|
| [FILL] | [FILL] | [FILL] | [FILL] | [FILL] |

---

## Triggers

| Trigger Name | Event | Function | Purpose |
|--------------|-------|----------|---------|
| `trg_staff_permissions_updated_at` | BEFORE UPDATE | `update_updated_at_column()` | Auto-update updated_at |

---

## Constraints

| Constraint Name | Type | Columns / Expression | Notes |
|-----------------|------|----------------------|-------|
| [FILL] | CHECK/UNIQUE | [FILL] | [FILL] |

---

## Waitlist Support

- [ ] This table directly represents a reservable resource
- [ ] This table has a related waitlist table
- [ ] Waitlist promotion handled by: [FILL]

---

## Audit Requirements

- [ ] Changes logged to: [FILL]
- [ ] Audit function: [FILL]

---

## SQL DDL

```sql
-- See actual database schema
-- Use: \d staff_permissions in psql or pg_dump
```

---

## Notes for Developer

- [FILL: Important notes about this table]
