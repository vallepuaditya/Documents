# schedules Table Schema

**Table:** `schedules`

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
| `schedule_id` | `integer(32)` | NO |  | PRIMARY KEY | [FILL] |
| `branch_sk` | `integer(32)` | YES |  |  | [FILL] |
| `monday_is_closed` | `boolean` | YES | `false` |  | [FILL] |
| `monday_from_time` | `time without time zone` | YES |  |  | [FILL] |
| `monday_to_time` | `time without time zone` | YES |  |  | [FILL] |
| `tuesday_is_closed` | `boolean` | YES | `false` |  | [FILL] |
| `tuesday_from_time` | `time without time zone` | YES |  |  | [FILL] |
| `tuesday_to_time` | `time without time zone` | YES |  |  | [FILL] |
| `wednesday_is_closed` | `boolean` | YES | `false` |  | [FILL] |
| `wednesday_from_time` | `time without time zone` | YES |  |  | [FILL] |
| `wednesday_to_time` | `time without time zone` | YES |  |  | [FILL] |
| `thursday_is_closed` | `boolean` | YES | `false` |  | [FILL] |
| `thursday_from_time` | `time without time zone` | YES |  |  | [FILL] |
| `thursday_to_time` | `time without time zone` | YES |  |  | [FILL] |
| `friday_is_closed` | `boolean` | YES | `false` |  | [FILL] |
| `friday_from_time` | `time without time zone` | YES |  |  | [FILL] |
| `friday_to_time` | `time without time zone` | YES |  |  | [FILL] |
| `saturday_is_closed` | `boolean` | YES | `false` |  | [FILL] |
| `saturday_from_time` | `time without time zone` | YES |  |  | [FILL] |
| `saturday_to_time` | `time without time zone` | YES |  |  | [FILL] |
| `sunday_is_closed` | `boolean` | YES | `false` |  | [FILL] |
| `sunday_from_time` | `time without time zone` | YES |  |  | [FILL] |
| `sunday_to_time` | `time without time zone` | YES |  |  | [FILL] |
| `is_active` | `boolean` | YES | `true` |  | [FILL] |
| `created_by` | `integer(32)` | YES |  |  | [FILL] |
| `created_at` | `timestamp without time zone` | YES | `CURRENT_TIMESTAMP` |  | [FILL] |
| `updated_by` | `integer(32)` | YES |  |  | [FILL] |
| `updated_at` | `timestamp without time zone` | YES | `CURRENT_TIMESTAMP` |  | [FILL] |

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
| `trg_schedules_updated_at` | BEFORE UPDATE | `update_updated_at_column()` | Auto-update updated_at |

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
-- Use: \d schedules in psql or pg_dump
```

---

## Notes for Developer

- [FILL: Important notes about this table]
