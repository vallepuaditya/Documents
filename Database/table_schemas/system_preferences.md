# system_preferences Table Schema

**Table:** `system_preferences`

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
| `system_preference_id` | `integer(32)` | NO |  | PRIMARY KEY | [FILL] |
| `default_language` | `character varying(50)` | YES | `'English'::character varying` |  | [FILL] |
| `timezone` | `character varying(100)` | YES | `'UTC'::character varying` |  | [FILL] |
| `date_format` | `character varying(20)` | YES | `'MM/DD/YYYY'::character varying` |  | [FILL] |
| `time_format` | `character varying(20)` | YES | `'12_HOUR'::character varying` |  | [FILL] |
| `email_notifications_enabled` | `boolean` | YES | `true` |  | [FILL] |
| `sms_notifications_enabled` | `boolean` | YES | `false` |  | [FILL] |
| `notification_level` | `character varying(30)` | YES | `'INFO_AND_ABOVE'::character varying` |  | [FILL] |
| `logging_level` | `character varying(30)` | YES | `'INFO_AND_ABOVE'::character varying` |  | [FILL] |
| `data_retention_days` | `integer(32)` | YES | `365` |  | [FILL] |
| `auto_archival_enabled` | `boolean` | YES | `false` |  | [FILL] |
| `auto_archival_after_days` | `integer(32)` | YES | `90` |  | [FILL] |
| `is_active` | `boolean` | YES | `true` |  | [FILL] |
| `created_by` | `integer(32)` | YES |  |  | [FILL] |
| `created_at` | `timestamp with time zone` | YES | `CURRENT_TIMESTAMP` |  | [FILL] |
| `updated_by` | `integer(32)` | YES |  |  | [FILL] |
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
| `trg_system_preferences_updated_at` | BEFORE UPDATE | `update_updated_at_column()` | Auto-update updated_at |

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
-- Use: \d system_preferences in psql or pg_dump
```

---

## Notes for Developer

- [FILL: Important notes about this table]
