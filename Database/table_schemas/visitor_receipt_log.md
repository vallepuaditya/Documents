# visitor_receipt_log Table Schema

**Table:** `visitor_receipt_log`

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
| `receipt_id` | `integer(32)` | NO |  | PRIMARY KEY | [FILL] |
| `user_id` | `integer(32)` | YES |  | [FK - FILL] | [FILL] |
| `batch_id` | `integer(32)` | YES |  | [FK - FILL] | [FILL] |
| `printed_by` | `integer(32)` | NO | `'-1'::integer` |  | [FILL] |
| `printed_at` | `timestamp with time zone` | NO | `CURRENT_TIMESTAMP` |  | [FILL] |
| `receipt_type` | `character varying(10)` | NO | `'SINGLE'::character varying` |  | [FILL] |
| `branch_sk` | `integer(32)` | NO |  |  | [FILL] |
| `printed_count` | `integer(32)` | YES | `1` |  | [FILL] |

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
| `trg_visitor_receipt_log_updated_at` | BEFORE UPDATE | `update_updated_at_column()` | Auto-update updated_at |

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
-- Use: \d visitor_receipt_log in psql or pg_dump
```

---

## Notes for Developer

- [FILL: Important notes about this table]
