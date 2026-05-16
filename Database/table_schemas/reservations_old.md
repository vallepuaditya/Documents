# reservations_old Table Schema

**Table:** `reservations_old`

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
| `reservation_id` | `integer(32)` | NO |  | PRIMARY KEY | [FILL] |
| `system_id` | `integer(32)` | YES |  | [FK - FILL] | [FILL] |
| `branch_id` | `integer(32)` | NO |  | [FK - FILL] | [FILL] |
| `resource_group_id` | `integer(32)` | NO |  | [FK - FILL] | [FILL] |
| `system_type_sk` | `integer(32)` | NO |  |  | [FILL] |
| `user_id` | `integer(32)` | YES |  | [FK - FILL] | [FILL] |
| `status` | `integer(32)` | YES |  |  | [FILL] |
| `start_time` | `timestamp with time zone` | NO |  |  | [FILL] |
| `end_time` | `timestamp with time zone` | NO |  |  | [FILL] |
| `requested_at` | `timestamp with time zone` | YES | `CURRENT_TIMESTAMP` |  | [FILL] |
| `allocated_at` | `timestamp with time zone` | YES |  |  | [FILL] |
| `released_at` | `timestamp with time zone` | YES |  |  | [FILL] |
| `priority` | `integer(32)` | YES | `0` |  | [FILL] |
| `created_at` | `timestamp with time zone` | YES | `CURRENT_TIMESTAMP` |  | [FILL] |
| `updated_at` | `timestamp with time zone` | YES | `CURRENT_TIMESTAMP` |  | [FILL] |
| `created_by` | `integer(32)` | YES |  |  | [FILL] |
| `updated_by` | `integer(32)` | YES |  |  | [FILL] |

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
| `trg_reservations_old_updated_at` | BEFORE UPDATE | `update_updated_at_column()` | Auto-update updated_at |

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
-- Use: \d reservations_old in psql or pg_dump
```

---

## Notes for Developer

- [FILL: Important notes about this table]
