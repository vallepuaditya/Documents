# user_groups Table Schema

**Table:** `user_groups`

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
| `user_group_id` | `integer(32)` | NO |  | PRIMARY KEY | [FILL] |
| `group_name` | `character varying(150)` | NO |  |  | [FILL] |
| `description` | `text` | YES |  |  | [FILL] |
| `default_minutes_per_day` | `integer(32)` | YES |  |  | [FILL] |
| `default_sessions_per_day` | `integer(32)` | YES |  |  | [FILL] |
| `is_visitor_group` | `boolean` | YES | `false` |  | [FILL] |
| `is_default_group` | `boolean` | YES | `false` |  | [FILL] |
| `status` | `character varying(50)` | NO | `'active'::character varying` |  | [FILL] |
| `created_at` | `timestamp with time zone` | YES | `CURRENT_TIMESTAMP` |  | [FILL] |
| `updated_at` | `timestamp with time zone` | YES | `CURRENT_TIMESTAMP` |  | [FILL] |
| `created_by` | `integer(32)` | YES |  |  | [FILL] |
| `updated_by` | `integer(32)` | YES |  |  | [FILL] |
| `location_id` | `integer(32)` | YES |  | [FK - FILL] | [FILL] |

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
| `trg_user_groups_updated_at` | BEFORE UPDATE | `update_updated_at_column()` | Auto-update updated_at |

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
-- Use: \d user_groups in psql or pg_dump
```

---

## Notes for Developer

- [FILL: Important notes about this table]
