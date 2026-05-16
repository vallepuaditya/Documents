# resource_areas Table Schema

**Table:** `resource_areas`

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
| `area_id` | `integer(32)` | NO |  | PRIMARY KEY | [FILL] |
| `location_id` | `integer(32)` | NO |  | [FK - FILL] | [FILL] |
| `area_name` | `character varying(150)` | NO |  |  | [FILL] |
| `area_type_sk` | `integer(32)` | NO |  |  | [FILL] |
| `description` | `text` | YES |  |  | [FILL] |
| `opening_time` | `time without time zone` | YES |  |  | [FILL] |
| `closing_time` | `time without time zone` | YES |  |  | [FILL] |
| `status` | `character varying(50)` | NO | `'active'::character varying` |  | [FILL] |
| `created_at` | `timestamp with time zone` | YES | `CURRENT_TIMESTAMP` |  | [FILL] |
| `updated_at` | `timestamp with time zone` | YES | `CURRENT_TIMESTAMP` |  | [FILL] |
| `created_by` | `integer(32)` | YES |  |  | [FILL] |
| `updated_by` | `integer(32)` | YES |  |  | [FILL] |

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
| `trg_resource_areas_updated_at` | BEFORE UPDATE | `update_updated_at_column()` | Auto-update updated_at |

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
-- Use: \d resource_areas in psql or pg_dump
```

---

## Notes for Developer

- [FILL: Important notes about this table]
