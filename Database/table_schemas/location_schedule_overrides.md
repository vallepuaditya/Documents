# location_schedule_overrides Table Schema

**Table:** `location_schedule_overrides`

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
| `override_id` | `bigint(64)` | NO | `nextval('branch_schedule_overrides_override_id_seq'::regclass)` | PRIMARY KEY | [FILL] |
| `location_id` | `integer(32)` | NO |  | [FK - FILL] | [FILL] |
| `override_date` | `date` | NO |  |  | [FILL] |
| `open_time` | `time without time zone` | YES |  |  | [FILL] |
| `close_time` | `time without time zone` | YES |  |  | [FILL] |
| `is_closed` | `boolean` | NO | `false` |  | [FILL] |
| `created_at` | `timestamp with time zone` | NO | `now()` |  | [FILL] |
| `updated_at` | `timestamp with time zone` | NO | `now()` |  | [FILL] |

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
| `trg_location_schedule_overrides_updated_at` | BEFORE UPDATE | `update_updated_at_column()` | Auto-update updated_at |

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
-- Use: \d location_schedule_overrides in psql or pg_dump
```

---

## Notes for Developer

- [FILL: Important notes about this table]
