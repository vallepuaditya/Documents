# reservations_new Table Schema

**Table:** `reservations_new`

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
| `reservation_id` | `bigint(64)` | NO |  | PRIMARY KEY | [FILL] |
| `primary_resource_id` | `integer(32)` | NO |  | [FK - FILL] | [FILL] |
| `user_id` | `integer(32)` | NO |  | [FK - FILL] | [FILL] |
| `status_sk` | `integer(32)` | NO |  |  | [FILL] |
| `booking_mode` | `character varying(20)` | NO |  |  | [FILL] |
| `reservation_date` | `date` | NO |  |  | [FILL] |
| `start_at` | `timestamp with time zone` | NO |  |  | [FILL] |
| `end_at` | `timestamp with time zone` | NO |  |  | [FILL] |
| `duration_minutes` | `integer(32)` | NO |  |  | [FILL] |
| `location_id` | `integer(32)` | NO |  | [FK - FILL] | [FILL] |
| `area_id` | `integer(32)` | NO |  | [FK - FILL] | [FILL] |
| `notes` | `character varying(500)` | YES |  |  | [FILL] |
| `created_by` | `integer(32)` | NO | `'-1'::integer` |  | [FILL] |
| `created_at` | `timestamp with time zone` | NO | `now()` |  | [FILL] |
| `updated_by` | `integer(32)` | YES |  |  | [FILL] |
| `updated_at` | `timestamp with time zone` | YES |  |  | [FILL] |
| `cancelled_by` | `integer(32)` | YES |  |  | [FILL] |
| `cancelled_at` | `timestamp with time zone` | YES |  |  | [FILL] |

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
| `trg_reservations_new_updated_at` | BEFORE UPDATE | `update_updated_at_column()` | Auto-update updated_at |

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
-- Use: \d reservations_new in psql or pg_dump
```

---

## Notes for Developer

- [FILL: Important notes about this table]
