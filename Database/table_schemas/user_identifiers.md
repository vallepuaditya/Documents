# user_identifiers Table Schema

**Table:** `user_identifiers`

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
| `identifier_id` | `integer(32)` | NO |  | PRIMARY KEY | [FILL] |
| `user_id` | `integer(32)` | NO |  | [FK - FILL] | [FILL] |
| `id_type` | `character varying(100)` | NO |  |  | [FILL] |
| `id_value` | `character varying(255)` | NO |  |  | [FILL] |
| `gov_id_type` | `character varying(100)` | YES |  |  | [FILL] |
| `is_primary` | `boolean` | YES | `false` |  | [FILL] |
| `is_active` | `boolean` | YES | `true` |  | [FILL] |
| `valid_from` | `timestamp with time zone` | YES |  |  | [FILL] |
| `valid_until` | `timestamp with time zone` | YES |  |  | [FILL] |
| `created_at` | `timestamp with time zone` | YES | `CURRENT_TIMESTAMP` |  | [FILL] |
| `created_by` | `integer(32)` | YES |  |  | [FILL] |

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
| `trg_user_identifiers_updated_at` | BEFORE UPDATE | `update_updated_at_column()` | Auto-update updated_at |

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
-- Use: \d user_identifiers in psql or pg_dump
```

---

## Notes for Developer

- [FILL: Important notes about this table]
