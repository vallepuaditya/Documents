# security_policies Table Schema

**Table:** `security_policies`

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
| `security_policy_id` | `integer(32)` | NO |  | PRIMARY KEY | [FILL] |
| `password_min_length` | `integer(32)` | NO | `8` |  | [FILL] |
| `password_complexity` | `character varying(20)` | NO | `'MEDIUM'::character varying` |  | [FILL] |
| `password_expiry_days` | `integer(32)` | NO | `90` |  | [FILL] |
| `staff_session_timeout_minutes` | `integer(32)` | NO | `480` |  | [FILL] |
| `patron_session_timeout_minutes` | `integer(32)` | NO | `60` |  | [FILL] |
| `max_failed_login_attempts` | `integer(32)` | NO | `5` |  | [FILL] |
| `lockout_duration_minutes` | `integer(32)` | NO | `30` |  | [FILL] |
| `require_mfa_all_users` | `boolean` | YES | `false` |  | [FILL] |
| `require_mfa_staff_only` | `boolean` | YES | `true` |  | [FILL] |
| `enable_ip_whitelist` | `boolean` | YES | `false` |  | [FILL] |
| `enable_ip_blacklist` | `boolean` | YES | `false` |  | [FILL] |
| `is_active` | `boolean` | YES | `true` |  | [FILL] |
| `created_at` | `timestamp with time zone` | YES | `CURRENT_TIMESTAMP` |  | [FILL] |
| `updated_at` | `timestamp with time zone` | YES | `CURRENT_TIMESTAMP` |  | [FILL] |

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
| `trg_security_policies_updated_at` | BEFORE UPDATE | `update_updated_at_column()` | Auto-update updated_at |

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
-- Use: \d security_policies in psql or pg_dump
```

---

## Notes for Developer

- [FILL: Important notes about this table]
