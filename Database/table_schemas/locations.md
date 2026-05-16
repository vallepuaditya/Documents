# locations Table Schema

**Table:** `locations`

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
| `location_id` | `integer(32)` | NO |  | PRIMARY KEY | [FILL] |
| `name` | `character varying(150)` | NO |  |  | [FILL] |
| `address` | `text` | NO |  |  | [FILL] |
| `phone` | `character varying(20)` | YES |  |  | [FILL] |
| `email` | `character varying(150)` | YES |  |  | [FILL] |
| `created_at` | `timestamp with time zone` | YES | `CURRENT_TIMESTAMP` |  | [FILL] |
| `created_by` | `integer(32)` | YES |  |  | [FILL] |
| `updated_at` | `timestamp with time zone` | YES | `CURRENT_TIMESTAMP` |  | [FILL] |
| `updated_by` | `integer(32)` | YES |  |  | [FILL] |
| `open_time` | `time without time zone` | YES |  |  | [FILL] |
| `close_time` | `time without time zone` | YES |  |  | [FILL] |
| `time_zone` | `character varying(50)` | YES | `'America/New_York'::character varying` |  | [FILL] |
| `status` | `character varying(30)` | NO | `'active'::character varying` |  | [FILL] |
| `location_code` | `character varying(10)` | YES |  |  | [FILL] |
| `website` | `character varying(255)` | YES |  |  | [FILL] |
| `status_changed_at` | `timestamp with time zone` | YES |  |  | [FILL] |

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
| `trg_locations_updated_at` | BEFORE UPDATE | `update_updated_at_column()` | Auto-update updated_at |

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
-- Use: \d locations in psql or pg_dump
```

---

## Notes for Developer

- [FILL: Important notes about this table]
