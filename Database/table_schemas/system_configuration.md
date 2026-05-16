# system_configuration Table Schema

**Table:** `system_configuration`

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
| `config_id` | `integer(32)` | NO |  | PRIMARY KEY | [FILL] |
| `db_server` | `character varying(100)` | NO |  |  | [FILL] |
| `db_port` | `integer(32)` | NO |  |  | [FILL] |
| `db_name` | `character varying(100)` | NO |  |  | [FILL] |
| `db_username` | `character varying(100)` | NO |  |  | [FILL] |
| `db_password` | `text` | NO |  |  | [FILL] |
| `backup_enabled` | `boolean` | YES | `false` |  | [FILL] |
| `backup_frequency` | `character varying(20)` | YES |  |  | [FILL] |
| `backup_time` | `time without time zone` | YES |  |  | [FILL] |
| `backup_retention_days` | `integer(32)` | YES |  |  | [FILL] |
| `sync_enabled` | `boolean` | YES | `false` |  | [FILL] |
| `sync_interval_minutes` | `integer(32)` | YES |  |  | [FILL] |
| `sync_branches` | `jsonb` | YES |  |  | [FILL] |
| `password_min_length` | `integer(32)` | YES | `8` |  | [FILL] |
| `password_complexity` | `character varying(50)` | YES |  |  | [FILL] |
| `password_expiry_days` | `integer(32)` | YES |  |  | [FILL] |
| `staff_session_timeout_minutes` | `integer(32)` | YES |  |  | [FILL] |
| `patron_session_timeout_minutes` | `integer(32)` | YES |  |  | [FILL] |
| `max_failed_login_attempts` | `integer(32)` | YES |  |  | [FILL] |
| `lockout_duration_minutes` | `integer(32)` | YES |  |  | [FILL] |
| `mfa_all_users` | `boolean` | YES | `false` |  | [FILL] |
| `mfa_staff_only` | `boolean` | YES | `false` |  | [FILL] |
| `default_language` | `character varying(50)` | YES |  |  | [FILL] |
| `timezone` | `character varying(50)` | YES |  |  | [FILL] |
| `date_format` | `character varying(20)` | YES |  |  | [FILL] |
| `time_format` | `character varying(20)` | YES |  |  | [FILL] |
| `email_notifications_enabled` | `boolean` | YES | `false` |  | [FILL] |
| `sms_notifications_enabled` | `boolean` | YES | `false` |  | [FILL] |
| `notification_level` | `character varying(50)` | YES |  |  | [FILL] |
| `logging_level` | `character varying(50)` | YES |  |  | [FILL] |
| `data_retention_days` | `integer(32)` | YES |  |  | [FILL] |
| `auto_archival_enabled` | `boolean` | YES | `false` |  | [FILL] |
| `auto_archival_after_days` | `integer(32)` | YES |  |  | [FILL] |
| `ils_integration_enabled` | `boolean` | YES | `false` |  | [FILL] |
| `third_party_api_endpoints` | `jsonb` | YES |  |  | [FILL] |
| `smtp_enabled` | `boolean` | YES | `false` |  | [FILL] |
| `smtp_server` | `character varying(150)` | YES |  |  | [FILL] |
| `smtp_port` | `integer(32)` | YES |  |  | [FILL] |
| `smtp_username` | `character varying(100)` | YES |  |  | [FILL] |
| `smtp_password` | `text` | YES |  |  | [FILL] |
| `smtp_use_tls` | `boolean` | YES | `true` |  | [FILL] |
| `sms_enabled` | `boolean` | YES | `false` |  | [FILL] |
| `sms_gateway_config` | `jsonb` | YES |  |  | [FILL] |
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
| `trg_system_configuration_updated_at` | BEFORE UPDATE | `update_updated_at_column()` | Auto-update updated_at |

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
-- Use: \d system_configuration in psql or pg_dump
```

---

## Notes for Developer

- [FILL: Important notes about this table]
