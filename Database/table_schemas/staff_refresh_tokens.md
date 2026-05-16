# staff_refresh_tokens Table Schema

**Table:** `staff_refresh_tokens`

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
| `staff_id` | `uuid` | NO |  | [FK - FILL] | [FILL] |
| `refresh_token` | `text` | NO |  |  | [FILL] |
| `is_revoked` | `boolean` | NO | `false` |  | [FILL] |
| `created_at` | `timestamp with time zone` | NO | `now()` |  | [FILL] |
| `expires_at` | `timestamp with time zone` | NO |  |  | [FILL] |

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
| `trg_staff_refresh_tokens_updated_at` | BEFORE UPDATE | `update_updated_at_column()` | Auto-update updated_at |

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
-- Use: \d staff_refresh_tokens in psql or pg_dump
```

---

## Notes for Developer

- [FILL: Important notes about this table]
