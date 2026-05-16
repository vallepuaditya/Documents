# lookup Table Schema

**Table:** `lookup`

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
| `sk` | `integer(32)` | NO | `nextval('lookup_sk_seq'::regclass)` |  | [FILL] |
| `type` | `character varying(50)` | NO |  |  | [FILL] |
| `code` | `character varying(100)` | NO |  |  | [FILL] |
| `value` | `character varying(255)` | NO |  |  | [FILL] |
| `display_order` | `integer(32)` | YES |  |  | [FILL] |
| `is_active` | `boolean` | YES |  |  | [FILL] |
| `created_by` | `integer(32)` | YES | `'-1'::integer` |  | [FILL] |
| `created_at` | `timestamp with time zone` | YES | `now()` |  | [FILL] |
| `updated_by` | `integer(32)` | YES | `'-1'::integer` |  | [FILL] |
| `updated_at` | `timestamp with time zone` | YES | `now()` |  | [FILL] |

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
| `trg_lookup_updated_at` | BEFORE UPDATE | `update_updated_at_column()` | Auto-update updated_at |

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
-- Use: \d lookup in psql or pg_dump
```

---

## Notes for Developer

- [FILL: Important notes about this table]
