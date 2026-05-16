# Table Schema: access_portals

## Table Name

**Table:** `access_portals`

**Purpose:** Stores web-accessible portal configurations that provide browser-based reservation interfaces. Portals act as pseudo-virtual kiosks with path-based routing.

**Setup / Defaults:** No default portals. Created by administrators as needed.

---

## Dependencies

| Depends On | Relationship | Notes |
|------------|-------------|-------|
| `lookup` | FK (status_sk) | Portal status enumeration |
| `locations` | FK (location_id) | Associated location |
| `pools` | FK (pool_id) | Optional pool assignment (preferred) |
| `segments` | FK (communication_segment_id) | Inherited from location |
| `servers` | FK (server_id) | Server hosting portal |
| `users` | FK (created_by, updated_by) | Audit trail |

---

## Columns

| Column Name | Data Type | Nullable | Default | Constraints | Description |
|-------------|-----------|----------|---------|-------------|-------------|
| `portal_id` | `BIGSERIAL` | NO | Auto | `PRIMARY KEY` | Surrogate primary key |
| `portal_name` | `VARCHAR(150)` | NO | | | Descriptive portal name |
| `portal_path` | `VARCHAR(100)` | NO | | `UNIQUE` | URL path (e.g., /branchA, /downtown) |
| `location_id` | `INTEGER` | YES | | `FK -> locations(location_id)` | Associated location |
| `pool_id` | `INTEGER` | YES | | `FK -> pools(pool_id)` | Optional pool assignment |
| `server_id` | `BIGINT` | YES | | `FK -> servers(server_id)` | Server hosting portal |
| `server_uri` | `VARCHAR(255)` | YES | | | Full server URI |
| `communication_segment_id` | `BIGINT` | YES | | `FK -> segments(segment_id)` | Communication segment (inherited) |
| `use_https` | `BOOLEAN` | NO | `true` | | Enable HTTPS/SSL |
| `allowed_user_types` | `JSONB` | YES | `'[]'` | | Array of allowed user type IDs |
| `allowed_user_tiers` | `JSONB` | YES | `'[]'` | | Array of allowed user tier IDs |
| `allowed_user_groups` | `JSONB` | YES | `'[]'` | | Array of allowed user group IDs |
| `allowed_reservation_types` | `JSONB` | YES | | | Allowed reservation types |
| `require_location_selection` | `BOOLEAN` | NO | `false` | | Require users to select location |
| `is_active` | `BOOLEAN` | NO | `true` | | Portal active status |
| `status_sk` | `INTEGER` | NO | | `FK -> lookup(sk)` | Portal status (lookup type: portal_status_sk) |
| `portal_metadata` | `JSONB` | YES | `'{}'` | | Additional portal configuration |
| `created_at` | `TIMESTAMP WITH TIME ZONE` | NO | `NOW()` | | Record creation timestamp |
| `updated_at` | `TIMESTAMP WITH TIME ZONE` | NO | `NOW()` | | Last update timestamp |
| `created_by` | `INTEGER` | YES | | `FK -> users(id)` | User who created this record |
| `updated_by` | `INTEGER` | YES | | `FK -> users(id)` | User who last updated this record |

---

## Indexes

| Index Name | Columns | Type | Purpose |
|------------|---------|------|---------|
| `idx_access_portals_path` | `portal_path` | B-tree | Fast path lookup |
| `idx_access_portals_location` | `location_id` | B-tree | Portals by location |
| `idx_access_portals_pool` | `pool_id` | B-tree | Portals by pool |
| `idx_access_portals_server` | `server_id` | B-tree | Portals by server |
| `idx_access_portals_active` | `is_active` | B-tree | Filter active portals |
| `idx_access_portals_status` | `status_sk` | B-tree | Filter by status |

---

## Foreign Keys

| Column | References | On Delete | On Update | Notes |
|--------|------------|-----------|-----------|-------|
| `location_id` | `locations(location_id)` | `RESTRICT` | `CASCADE` | Block location deletion if portal assigned |
| `pool_id` | `pools(pool_id)` | `SET NULL` | `CASCADE` | Clear pool if deleted |
| `server_id` | `servers(server_id)` | `SET NULL` | `CASCADE` | Clear server if deleted |
| `communication_segment_id` | `segments(segment_id)` | `SET NULL` | `CASCADE` | Inherited from location |
| `status_sk` | `lookup(sk)` | `RESTRICT` | `CASCADE` | Portal status lookup |
| `created_by` | `users(id)` | `SET NULL` | `CASCADE` | Audit trail |
| `updated_by` | `users(id)` | `SET NULL` | `CASCADE` | Audit trail |

---

## Triggers

| Trigger Name | Event | Function | Purpose |
|--------------|-------|----------|---------|
| `trg_access_portals_updated_at` | `BEFORE UPDATE` | `fn_update_timestamp()` | Auto-update `updated_at` |
| `trg_access_portals_validate_path` | `BEFORE INSERT OR UPDATE` | `fn_validate_portal_path()` | Validate path format |
| `trg_access_portals_inherit_segment` | `BEFORE INSERT OR UPDATE` | `fn_inherit_portal_segment()` | Inherit segment from location |

---

## Constraints

| Constraint Name | Type | Columns / Expression | Notes |
|-----------------|------|----------------------|-------|
| `chk_access_portals_assignment` | `CHECK` | `location_id IS NOT NULL OR pool_id IS NOT NULL` | Must assign to location or pool |
| `chk_access_portals_path_format` | `CHECK` | `portal_path ~ '^/[a-z0-9\-_]+$'` | Path must start with / and be lowercase |

---

## Waitlist Support

- [ ] This table directly represents a reservable resource
- [ ] This table has a related waitlist table
- [x] Not applicable - configuration table (but enables reservations via web)

---

## Audit Requirements

- [x] Changes are logged to `staff_audit_log`
- [x] URI and location changes trigger portal sync notifications
- [x] Audit function name: `fn_audit_portal_changes()`

---

## SQL DDL

```sql
-- Drop if exists (for dev/re-run safety)
-- DROP TABLE IF EXISTS access_portals CASCADE;

CREATE TABLE access_portals (
    portal_id                   BIGSERIAL PRIMARY KEY,
    portal_name                 VARCHAR(150) NOT NULL,
    portal_path                 VARCHAR(100) NOT NULL UNIQUE 
                                CHECK (portal_path ~ '^/[a-z0-9\-_]+$'),
    location_id                 INTEGER REFERENCES locations(location_id) ON DELETE RESTRICT,
    pool_id                     INTEGER REFERENCES pools(pool_id) ON DELETE SET NULL,
    server_id                   BIGINT REFERENCES servers(server_id) ON DELETE SET NULL,
    server_uri                  VARCHAR(255),
    communication_segment_id    BIGINT REFERENCES segments(segment_id) ON DELETE SET NULL,
    use_https                   BOOLEAN NOT NULL DEFAULT true,
    allowed_user_types          JSONB DEFAULT '[]',
    allowed_user_tiers          JSONB DEFAULT '[]',
    allowed_user_groups         JSONB DEFAULT '[]',
    allowed_reservation_types   JSONB,
    require_location_selection  BOOLEAN NOT NULL DEFAULT false,
    is_active                   BOOLEAN NOT NULL DEFAULT true,
    status_sk                   INTEGER NOT NULL REFERENCES lookup(sk) ON DELETE RESTRICT,
    portal_metadata             JSONB DEFAULT '{}',
    -- Default status_sk should reference 'active' from lookup table (portal_status_sk)
    
    created_at                  TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    updated_at                  TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    created_by                  INTEGER  NULL,
    updated_by                  INTEGER  NULL,
    
    CONSTRAINT chk_access_portals_assignment 
        CHECK (location_id IS NOT NULL OR pool_id IS NOT NULL)
);

-- Indexes
CREATE INDEX idx_access_portals_path ON access_portals(portal_path);
CREATE INDEX idx_access_portals_location ON access_portals(location_id);
CREATE INDEX idx_access_portals_pool ON access_portals(pool_id);
CREATE INDEX idx_access_portals_server ON access_portals(server_id);
CREATE INDEX idx_access_portals_active ON access_portals(is_active);
CREATE INDEX idx_access_portals_status ON access_portals(status_sk);

-- Triggers

```

---

## Notes for Developer

- Path must be unique and follow format: /[lowercase-alphanumeric-hyphen-underscore]
- Reserved paths: /admin, /api, /system, /staff (validated in trigger)
- Single portal per location enforced via path uniqueness
- Portals act as pseudo-virtual kiosks (share kiosk configuration model)
- When URI or location changes, trigger portal sync to connected workstations
- Existing reservations survive portal decommission
- Pool assignment preferred for multi-location portal access
- Empty arrays for allowed_* fields means "all allowed"
