# global_settings Table Schema

**Table:** `global_settings`

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
| `sk` | `integer(32)` | NO |  |  | [FILL] |
| `lan_login_mode_sk` | `integer(32)` | NO |  |  | [FILL] |
| `advance_reservation_days` | `integer(32)` | YES | `7` |  | [FILL] |
| `min_minutes_before_first_slot` | `integer(32)` | YES | `2` |  | [FILL] |
| `max_pending_reservations_per_patron` | `integer(32)` | YES | `2` |  | [FILL] |
| `auto_delete_signup_username` | `boolean` | YES | `false` |  | [FILL] |
| `auto_delete_after_hours` | `integer(32)` | YES | `24` |  | [FILL] |
| `unclaimed_scheduled_session_timeout_minutes` | `integer(32)` | YES | `15` |  | [FILL] |
| `unclaimed_queued_session_timeout_minutes` | `integer(32)` | YES | `7` |  | [FILL] |
| `inactivity_timeout_minutes` | `integer(32)` | YES | `90` |  | [FILL] |
| `lock_computer_timeout_minutes` | `integer(32)` | YES | `5` |  | [FILL] |
| `logon_timeout_seconds` | `integer(32)` | YES | `120` |  | [FILL] |
| `warning_time_low_minutes` | `integer(32)` | YES | `10` |  | [FILL] |
| `warning_time_critical_minutes` | `integer(32)` | YES | `5` |  | [FILL] |
| `visitor_account_active_days` | `integer(32)` | YES |  |  | [FILL] |
| `visitor_default_user_group_sk` | `integer(32)` | YES |  |  | [FILL] |
| `created_at` | `timestamp with time zone` | YES | `CURRENT_TIMESTAMP` |  | [FILL] |
| `updated_at` | `timestamp with time zone` | YES | `CURRENT_TIMESTAMP` |  | [FILL] |
| `created_by` | `integer(32)` | YES | `'-1'::integer` |  | [FILL] |
| `updated_by` | `integer(32)` | YES | `'-1'::integer` |  | [FILL] |

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
| `trg_global_settings_updated_at` | BEFORE UPDATE | `update_updated_at_column()` | Auto-update updated_at |

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
-- Use: \d global_settings in psql or pg_dump
```

---

## Notes for Developer

- [FILL: Important notes about this table]
