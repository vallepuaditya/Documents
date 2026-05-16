# resource_addons Table Schema

**Table:** `resource_addons`

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
| `addon_id` | `integer(32)` | NO | `nextval('resource_addons_addon_id_seq'::regclass)` | PRIMARY KEY | [FILL] |
| `primary_resource_id` | `integer(32)` | NO |  | [FK - FILL] | [FILL] |
| `addon_resource_id` | `integer(32)` | NO |  | [FK - FILL] | [FILL] |
| `is_active` | `boolean` | NO | `true` |  | [FILL] |
| `linked_by` | `integer(32)` | NO | `'-1'::integer` |  | [FILL] |
| `linked_at` | `timestamp with time zone` | NO | `now()` |  | [FILL] |
| `unlinked_by` | `integer(32)` | YES |  |  | [FILL] |
| `unlinked_at` | `timestamp with time zone` | YES |  |  | [FILL] |
| `addon_type` | `character varying(20)` | NO | `'standard'::character varying` |  | [FILL] |
| `display_order` | `integer(32)` | NO | `0` |  | [FILL] |

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
| `trg_resource_addons_updated_at` | BEFORE UPDATE | `update_updated_at_column()` | Auto-update updated_at |

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
-- Use: \d resource_addons in psql or pg_dump
```

---

## Notes for Developer

- [FILL: Important notes about this table]
