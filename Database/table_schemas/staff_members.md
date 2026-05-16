# staff_members Table Schema

**Table:** `staff_members`

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
| `first_name` | `character varying(100)` | NO |  |  | [FILL] |
| `last_name` | `character varying(100)` | NO |  |  | [FILL] |
| `email` | `character varying(255)` | NO |  |  | [FILL] |
| `phone` | `character varying(20)` | YES |  |  | [FILL] |
| `auth_method` | `character varying(10)` | NO | `'local'::character varying` |  | [FILL] |
| `password_hash` | `text` | YES |  |  | [FILL] |
| `last_login_at` | `timestamp with time zone` | YES |  |  | [FILL] |
| `failed_login_count` | `integer(32)` | NO | `0` |  | [FILL] |
| `locked_until` | `timestamp with time zone` | YES |  |  | [FILL] |
| `status` | `character varying(15)` | NO | `'active'::character varying` |  | [FILL] |
| `created_by` | `uuid` | YES |  |  | [FILL] |
| `created_at` | `timestamp with time zone` | NO | `now()` |  | [FILL] |
| `updated_by` | `uuid` | YES |  |  | [FILL] |
| `updated_at` | `timestamp with time zone` | YES |  |  | [FILL] |
| `username` | `character varying` | YES |  |  | [FILL] |

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
| `trg_staff_members_updated_at` | BEFORE UPDATE | `update_updated_at_column()` | Auto-update updated_at |

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
-- Use: \d staff_members in psql or pg_dump
```

---

## Notes for Developer

- [FILL: Important notes about this table]
