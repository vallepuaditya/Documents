# staff_audit_log Table Schema

**Table:** `staff_audit_log`

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
| `changed_by` | `uuid` | NO |  |  | [FILL] |
| `changed_at` | `timestamp with time zone` | NO | `now()` |  | [FILL] |
| `action` | `character varying(20)` | NO |  |  | [FILL] |
| `field_name` | `character varying(100)` | YES |  |  | [FILL] |
| `old_value` | `text` | YES |  |  | [FILL] |
| `new_value` | `text` | YES |  |  | [FILL] |
| `old_values` | `jsonb` | YES |  |  | [FILL] |
| `new_values` | `jsonb` | YES |  |  | [FILL] |
| `ip_address` | `character varying(45)` | YES |  |  | [FILL] |
| `notes` | `text` | YES |  |  | [FILL] |

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
| `trg_staff_audit_log_updated_at` | BEFORE UPDATE | `update_updated_at_column()` | Auto-update updated_at |

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
-- Use: \d staff_audit_log in psql or pg_dump
```

---

## Notes for Developer

- [FILL: Important notes about this table]
