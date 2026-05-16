# database_configuration_settings Table Schema

**Table:** `database_configuration_settings`

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
| `database_configuration_id` | `integer(32)` | NO |  | PRIMARY KEY | [FILL] |
| `server` | `character varying(255)` | NO |  |  | [FILL] |
| `port` | `integer(32)` | NO | `5432` |  | [FILL] |
| `database_name` | `character varying(150)` | NO |  |  | [FILL] |
| `username` | `character varying(150)` | NO |  |  | [FILL] |
| `password` | `text` | NO |  |  | [FILL] |
| `enable_automated_backups` | `boolean` | YES | `false` |  | [FILL] |
| `backup_frequency` | `character varying(20)` | YES |  |  | [FILL] |
| `backup_time` | `time without time zone` | YES |  |  | [FILL] |
| `retention_days` | `integer(32)` | YES | `30` |  | [FILL] |
| `enable_data_synchronization` | `boolean` | YES | `false` |  | [FILL] |
| `sync_interval_minutes` | `integer(32)` | YES | `15` |  | [FILL] |
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
| `trg_database_configuration_settings_updated_at` | BEFORE UPDATE | `update_updated_at_column()` | Auto-update updated_at |

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
-- Use: \d database_configuration_settings in psql or pg_dump
```

---

## Notes for Developer

- [FILL: Important notes about this table]
