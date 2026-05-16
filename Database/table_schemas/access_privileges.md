# access_privileges Table Schema

**Table:** `access_privileges`

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
| `access_id` | `integer(32)` | NO |  | PRIMARY KEY | [FILL] |
| `user_privilege_sk` | `integer(32)` | YES |  |  | [FILL] |
| `allowed_minutes` | `integer(32)` | YES |  |  | [FILL] |
| `session_timeout` | `integer(32)` | YES |  |  | [FILL] |
| `notes` | `text` | YES |  |  | [FILL] |
| `created_at` | `timestamp without time zone` | YES | `CURRENT_TIMESTAMP` |  | [FILL] |
| `updated_at` | `timestamp without time zone` | YES | `CURRENT_TIMESTAMP` |  | [FILL] |
| `created_by` | `integer(32)` | YES |  |  | [FILL] |
| `updated_by` | `integer(32)` | YES |  |  | [FILL] |
| `privilege_name` | `character varying(100)` | YES | `NULL::character varying` |  | [FILL] |
| `user_group_sk` | `integer(32)` | YES |  |  | [FILL] |
| `sessions_allowed` | `integer(32)` | YES |  |  | [FILL] |
| `max_login_attempts` | `integer(32)` | YES | `5` |  | [FILL] |
| `can_extend_session` | `boolean` | YES | `false` |  | [FILL] |
| `is_active` | `boolean` | NO | `true` |  | [FILL] |

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
| `trg_access_privileges_updated_at` | BEFORE UPDATE | `update_updated_at_column()` | Auto-update updated_at |

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
-- Use: \d access_privileges in psql or pg_dump
```

---

## Notes for Developer

- [FILL: Important notes about this table]
