# user_auth_logs Table Schema

**Table:** `user_auth_logs`

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
| `auth_log_id` | `integer(32)` | NO |  | PRIMARY KEY | [FILL] |
| `user_id` | `integer(32)` | YES |  | [FK - FILL] | [FILL] |
| `logon_id_used` | `character varying(150)` | YES |  |  | [FILL] |
| `location_id` | `integer(32)` | YES |  | [FK - FILL] | [FILL] |
| `auth_method` | `character varying(100)` | YES |  |  | [FILL] |
| `auth_result` | `character varying(50)` | NO |  |  | [FILL] |
| `failure_reason` | `text` | YES |  |  | [FILL] |
| `ip_address` | `character varying(50)` | YES |  |  | [FILL] |
| `portal_type` | `character varying(50)` | YES |  |  | [FILL] |
| `created_at` | `timestamp with time zone` | YES | `CURRENT_TIMESTAMP` |  | [FILL] |

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
| `trg_user_auth_logs_updated_at` | BEFORE UPDATE | `update_updated_at_column()` | Auto-update updated_at |

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
-- Use: \d user_auth_logs in psql or pg_dump
```

---

## Notes for Developer

- [FILL: Important notes about this table]
