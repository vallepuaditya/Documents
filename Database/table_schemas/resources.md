# resources Table Schema

**Table:** `resources`

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
| `resource_id` | `integer(32)` | NO | `nextval('resources_resource_id_seq'::regclass)` | PRIMARY KEY | [FILL] |
| `resource_name` | `character varying(100)` | NO |  |  | [FILL] |
| `resource_type_id` | `integer(32)` | NO |  | [FK - FILL] | [FILL] |
| `area_id` | `integer(32)` | NO |  | [FK - FILL] | [FILL] |
| `description` | `character varying(255)` | YES |  |  | [FILL] |
| `serial_number` | `character varying(100)` | YES |  |  | [FILL] |
| `asset_tag` | `character varying(100)` | YES |  |  | [FILL] |
| `resource_status_sk` | `integer(32)` | NO |  |  | [FILL] |
| `created_by` | `integer(32)` | NO | `'-1'::integer` |  | [FILL] |
| `created_at` | `timestamp with time zone` | NO | `now()` |  | [FILL] |
| `updated_by` | `integer(32)` | NO | `'-1'::integer` |  | [FILL] |
| `updated_at` | `timestamp with time zone` | NO | `now()` |  | [FILL] |
| `pc_audience` | `character varying(10)` | YES |  |  | [FILL] |
| `compound_resource_id` | `integer(32)` | YES |  | [FK - FILL] | [FILL] |
| `compound_role` | `character varying(20)` | YES |  |  | [FILL] |
| `resource_metadata` | `jsonb` | YES | `'{}'::jsonb` |  | [FILL] |

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
| `trg_resources_updated_at` | BEFORE UPDATE | `update_updated_at_column()` | Auto-update updated_at |

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
-- Use: \d resources in psql or pg_dump
```

---

## Notes for Developer

- [FILL: Important notes about this table]
