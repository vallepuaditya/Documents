# resource_categories Table Schema

**Table:** `resource_categories`

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
| `category_id` | `integer(32)` | NO | `nextval('resource_categories_category_id_seq'::regclass)` | PRIMARY KEY | [FILL] |
| `category_sk` | `integer(32)` | YES |  |  | [FILL] |
| `category_code` | `character varying(10)` | NO |  |  | [FILL] |
| `icon_key` | `character varying(50)` | YES |  |  | [FILL] |
| `display_order` | `integer(32)` | NO | `0` |  | [FILL] |
| `status` | `character varying(20)` | NO | `'active'::character varying` |  | [FILL] |
| `created_by` | `integer(32)` | NO | `'-1'::integer` |  | [FILL] |
| `created_at` | `timestamp with time zone` | NO | `now()` |  | [FILL] |
| `updated_by` | `integer(32)` | NO | `'-1'::integer` |  | [FILL] |
| `updated_at` | `timestamp with time zone` | NO | `now()` |  | [FILL] |
| `category_name` | `character varying(100)` | NO |  |  | [FILL] |
| `category_description` | `character varying(255)` | YES |  |  | [FILL] |
| `display_name` | `character varying(100)` | YES |  |  | [FILL] |

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
| `trg_resource_categories_updated_at` | BEFORE UPDATE | `update_updated_at_column()` | Auto-update updated_at |

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
-- Use: \d resource_categories in psql or pg_dump
```

---

## Notes for Developer

- [FILL: Important notes about this table]
