# Table Schema: pool_areas

## Table Name

**Table:** `pool_areas`

**Purpose:** Junction table mapping Areas to Pools. Enables cross-location grouping of Areas for portal access and resource management.

**Setup / Defaults:** No default rows. Populated when Areas are added to Pools.

---

## Dependencies

| Depends On | Relationship | Notes |
|------------|-------------|-------|
| `pools` | FK (pool_id) | Parent pool |
| `resource_areas` | FK (area_id) | Area being added to pool |
| `users` | FK (created_by) | Audit trail |

---

## Columns

| Column Name | Data Type | Nullable | Default | Constraints | Description |
|-------------|-----------|----------|---------|-------------|-------------|
| `pool_area_id` | `SERIAL` | NO | Auto | `PRIMARY KEY` | Surrogate primary key |
| `pool_id` | `INTEGER` | NO | | `FK -> pools(pool_id)` | Parent pool |
| `area_id` | `INTEGER` | NO | | `FK -> resource_areas(area_id)` | Area in this pool |
| `is_active` | `BOOLEAN` | NO | `true` | | Active status |
| `added_at` | `TIMESTAMP WITH TIME ZONE` | NO | `NOW()` | | When area added to pool |
| `created_by` | `INTEGER` | YES | | `FK -> users(id)` | User who added area to pool |

---

## Indexes

| Index Name | Columns | Type | Purpose |
|------------|---------|------|---------|
| `idx_pool_areas_pool` | `pool_id` | B-tree | Areas by pool |
| `idx_pool_areas_area` | `area_id` | B-tree | Pools containing area |
| `idx_pool_areas_active` | `pool_id, is_active` | B-tree | Filter active areas |

---

## Foreign Keys

| Column | References | On Delete | On Update | Notes |
|--------|------------|-----------|-----------|-------|
| `pool_id` | `pools(pool_id)` | `CASCADE` | `CASCADE` | Delete when pool deleted |
| `area_id` | `resource_areas(area_id)` | `CASCADE` | `CASCADE` | Delete when area deleted |
| `created_by` | `users(id)` | `SET NULL` | `CASCADE` | Audit trail |

---

## Triggers

| Trigger Name | Event | Function | Purpose |
|--------------|-------|----------|---------|
| `trg_pool_areas_notify_zones` | `AFTER INSERT OR DELETE` | `fn_notify_zone_pool_change()` | Notify zones of pool membership changes |

---

## Constraints

| Constraint Name | Type | Columns / Expression | Notes |
|-----------------|------|----------------------|-------|
| `unq_pool_area` | `UNIQUE` | `(pool_id, area_id)` | Prevent duplicate area in same pool |

---

## Waitlist Support

- [ ] This table directly represents a reservable resource
- [ ] This table has a related waitlist table
- [x] Not applicable - junction table

---

## Audit Requirements

- [x] Changes are logged to `staff_audit_log`
- [x] Audit function name: `fn_audit_pool_area_changes()`

---

## SQL DDL

```sql
-- Drop if exists (for dev/re-run safety)
-- DROP TABLE IF EXISTS pool_areas CASCADE;

CREATE TABLE pool_areas (
    pool_area_id    SERIAL PRIMARY KEY,
    pool_id         INTEGER NOT NULL REFERENCES pools(pool_id) ON DELETE CASCADE,
    area_id         INTEGER NOT NULL REFERENCES resource_areas(area_id) ON DELETE CASCADE,
    is_active       BOOLEAN NOT NULL DEFAULT true,
    added_at        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    created_by      INTEGER REFERENCES users(id) ON DELETE SET NULL,
    
    CONSTRAINT unq_pool_area UNIQUE (pool_id, area_id)
);

-- Indexes
CREATE INDEX idx_pool_areas_pool ON pool_areas(pool_id);
CREATE INDEX idx_pool_areas_area ON pool_areas(area_id);
CREATE INDEX idx_pool_areas_active ON pool_areas(pool_id, is_active);

-- Triggers
-- Trigger to notify zones when pool membership changes (for future zone implementation)
-- CREATE TRIGGER trg_pool_areas_notify_zones
--     AFTER INSERT OR DELETE ON pool_areas
--     FOR EACH ROW
--     EXECUTE FUNCTION fn_notify_zone_pool_change();
```

---

## Notes for Developer

- When Area added to Pool, portals assigned to that Pool automatically gain access to new Area
- Zones (MVP2) will auto-update when Areas added/removed from Pools
- Dynamic membership - no manual reconfiguration needed
