# staff_role_assignments Table Schema

**Table:** `staff_role_assignments`

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
| `id` | `uuid` | NO | `gen_random_uuid()` | PRIMARY KEY | [FILL] |
| `staff_member_id` | `uuid` | NO |  | [FK - FILL] | [FILL] |
| `role_id` | `uuid` | NO |  | [FK - FILL] | [FILL] |
| `is_active` | `boolean` | NO | `true` |  | [FILL] |
| `assigned_by` | `uuid` | NO |  |  | [FILL] |
| `assigned_at` | `timestamp with time zone` | NO | `now()` |  | [FILL] |
| `revoked_by` | `uuid` | YES |  |  | [FILL] |
| `revoked_at` | `timestamp with time zone` | YES |  |  | [FILL] |
| `location_id` | `integer(32)` | YES |  | [FK - FILL] | [FILL] |

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
| `trg_staff_role_assignments_updated_at` | BEFORE UPDATE | `update_updated_at_column()` | Auto-update updated_at |

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
-- Use: \d staff_role_assignments in psql or pg_dump
```

---

## Notes for Developer

- [FILL: Important notes about this table]
