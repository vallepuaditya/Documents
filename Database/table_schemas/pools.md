# Table Schema: pools

## Table Name

**Table:** `pools`

**Purpose:** Stores collections of Areas across multiple locations that can be treated as a single reservable scope for portals and cross-location resource access.

**Setup / Defaults:** No default pools. Created by administrators to group related Areas.

---

## Dependencies

| Depends On | Relationship | Notes |
|------------|-------------|-------|
| `lookup` | FK (status_sk) | Pool status enumeration |
| `users` | FK (created_by, updated_by) | Audit trail |

---

## Columns

| Column Name | Data Type | Nullable | Default | Constraints | Description |
|-------------|-----------|----------|---------|-------------|-------------|
| `pool_id` | `SERIAL` | NO | Auto | `PRIMARY KEY` | Surrogate primary key |
| `pool_name` | `VARCHAR(150)` | NO | | `UNIQUE` | Unique pool name |
| `description` | `TEXT` | YES | | | Pool description |
| `pool_type` | `VARCHAR(50)` | YES | | | Optional type categorization |
| `status_sk` | `INTEGER` | NO | | `FK -> lookup(sk)` | Pool status (lookup type: pool_status_sk) |
| `created_at` | `TIMESTAMP WITH TIME ZONE` | NO | `NOW()` | | Record creation timestamp |
| `updated_at` | `TIMESTAMP WITH TIME ZONE` | NO | `NOW()` | | Last update timestamp |
| `created_by` | `INTEGER` | YES | | `FK -> users(id)` | User who created this record |
| `updated_by` | `INTEGER` | YES | | `FK -> users(id)` | User who last updated this record |

---

## Indexes

| Index Name | Columns | Type | Purpose |
|------------|---------|------|---------|
| `idx_pools_name` | `pool_name` | B-tree | Fast lookup by name |
| `idx_pools_status` | `status_sk` | B-tree | Filter by status |

---

## Foreign Keys

| Column | References | On Delete | On Update | Notes |
|--------|------------|-----------|-----------|-------|
| `status_sk` | `lookup(sk)` | `RESTRICT` | `CASCADE` | Pool status lookup |
| `created_by` | `users(id)` | `SET NULL` | `CASCADE` | Audit trail |
| `updated_by` | `users(id)` | `SET NULL` | `CASCADE` | Audit trail |

---

## Triggers

| Trigger Name | Event | Function | Purpose |
|--------------|-------|----------|---------|
| `trg_pools_updated_at` | `BEFORE UPDATE` | `fn_update_timestamp()` | Auto-update `updated_at` |

---

## Constraints

| Constraint Name | Type | Columns / Expression | Notes |
|-----------------|------|----------------------|-------|
| None | | | |

---

## Waitlist Support

- [ ] This table directly represents a reservable resource
- [ ] This table has a related waitlist table
- [x] Not applicable - grouping/organizational table

---

## Audit Requirements

- [x] Changes are logged to `staff_audit_log`
- [x] Audit function name: `fn_audit_pool_changes()`

---

## SQL DDL

```sql
-- Drop if exists (for dev/re-run safety)
-- DROP TABLE IF EXISTS pools CASCADE;

CREATE TABLE pools (
    pool_id         SERIAL PRIMARY KEY,
    pool_name       VARCHAR(150) NOT NULL UNIQUE,
    description     TEXT,
    pool_type       VARCHAR(50),
    status_sk       INTEGER NOT NULL REFERENCES lookup(sk) ON DELETE RESTRICT,
    -- Default status_sk should reference 'Active' from lookup table (pool_status_sk)
    
    created_at      TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    created_by      INTEGER REFERENCES users(id) ON DELETE SET NULL,
    updated_by      INTEGER REFERENCES users(id) ON DELETE SET NULL
);

-- Indexes
CREATE INDEX idx_pools_name ON pools(pool_name);
CREATE INDEX idx_pools_status ON pools(status_sk);

-- Triggers

```

---

## Notes for Developer

- Pools group Areas across locations (e.g., "All Maker Spaces", "Mobile Pools")
- Areas added to pools via pool_areas junction table
- Portals can assign to pools for multi-location access
- Example: Pool "Maker Spaces" contains Areas at 3 branches - portal assigned to pool allows reservation at any
- When Area added to pool, users with access to pool automatically get access to new Area
