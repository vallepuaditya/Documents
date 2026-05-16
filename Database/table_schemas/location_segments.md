# Table Schema: location_segments

## Table Name

**Table:** `location_segments`

**Purpose:** Junction table mapping segments to locations for both communication and authentication routing. Locations can have separate communication and authentication segments.

**Setup / Defaults:** No default rows. Populated when segments are assigned to locations.

---

## Dependencies

| Depends On | Relationship | Notes |
|------------|-------------|-------|
| `lookup` | FK (connection_mode_sk) | Connection mode enumeration |
| `locations` | FK (location_id) | Parent location |
| `segments` | FK (communication_segment_id, auth_segment_id) | Assigned segments |
| `servers` | FK (preferred_server_id) | Home/preferred server |

---

## Columns

| Column Name | Data Type | Nullable | Default | Constraints | Description |
|-------------|-----------|----------|---------|-------------|-------------|
| `location_segment_id` | `BIGSERIAL` | NO | Auto | `PRIMARY KEY` | Surrogate primary key |
| `location_id` | `INTEGER` | NO | | `FK -> locations(location_id)` | Parent location |
| `communication_segment_id` | `BIGINT` | YES | | `FK -> segments(segment_id)` | Communication segment for this location |
| `auth_segment_id` | `BIGINT` | YES | | `FK -> segments(segment_id)` | Authentication segment for this location |
| `preferred_server_id` | `BIGINT` | YES | | `FK -> servers(server_id)` | Home/preferred server for failback |
| `connection_mode_sk` | `INTEGER` | NO | | `FK -> lookup(sk)` | Connection preference mode (lookup type: connection_mode_sk) |
| `is_active` | `BOOLEAN` | NO | `true` | | Active status |
| `created_at` | `TIMESTAMP WITH TIME ZONE` | NO | `NOW()` | | Record creation timestamp |
| `updated_at` | `TIMESTAMP WITH TIME ZONE` | NO | `NOW()` | | Last update timestamp |
| `created_by` | `INTEGER` | YES | | | User who created this record |
| `updated_by` | `INTEGER` | YES | | | User who last updated this record |

---

## Indexes

| Index Name | Columns | Type | Purpose |
|------------|---------|------|---------|
| `idx_location_segments_location` | `location_id` | B-tree | Lookup by location |
| `idx_location_segments_comm` | `communication_segment_id` | B-tree | Find locations using segment |
| `idx_location_segments_auth` | `auth_segment_id` | B-tree | Find locations using segment |
| `idx_location_segments_server` | `preferred_server_id` | B-tree | Locations by preferred server |

---

## Foreign Keys

| Column | References | On Delete | On Update | Notes |
|--------|------------|-----------|-----------|-------|
| `location_id` | `locations(location_id)` | `CASCADE` | `CASCADE` | Delete when location deleted |
| `connection_mode_sk` | `lookup(sk)` | `RESTRICT` | `CASCADE` | Connection mode lookup |
| `communication_segment_id` | `segments(segment_id)` | `RESTRICT` | `CASCADE` | Block segment deletion if assigned |
| `auth_segment_id` | `segments(segment_id)` | `RESTRICT` | `CASCADE` | Block segment deletion if assigned |
| `preferred_server_id` | `servers(server_id)` | `SET NULL` | `CASCADE` | Clear preferred server if deleted |

---

## Triggers

| Trigger Name | Event | Function | Purpose |
|--------------|-------|----------|---------|
| `trg_location_segments_updated_at` | `BEFORE UPDATE` | `fn_update_timestamp()` | Auto-update `updated_at` |
| `trg_location_segments_validate_server` | `BEFORE INSERT OR UPDATE` | `fn_validate_preferred_server_in_segment()` | Ensure preferred server in assigned segment |

---

## Constraints

| Constraint Name | Type | Columns / Expression | Notes |
|-----------------|------|----------------------|-------|
| `chk_location_segments_has_segment` | `CHECK` | `communication_segment_id IS NOT NULL OR auth_segment_id IS NOT NULL` | At least one segment required |

---

## Waitlist Support

- [ ] This table directly represents a reservable resource
- [ ] This table has a related waitlist table
- [x] Not applicable - configuration table

---

## Audit Requirements

- [x] Changes are logged to `staff_audit_log`
- [x] Audit function name: `fn_audit_location_segment_changes()`

---

## SQL DDL

```sql
-- Drop if exists (for dev/re-run safety)
-- DROP TABLE IF EXISTS location_segments CASCADE;

CREATE TABLE location_segments (
    location_segment_id         BIGSERIAL PRIMARY KEY,
    location_id                 INTEGER NOT NULL REFERENCES locations(location_id) ON DELETE CASCADE,
    communication_segment_id    BIGINT REFERENCES segments(segment_id) ON DELETE RESTRICT,
    auth_segment_id             BIGINT REFERENCES segments(segment_id) ON DELETE RESTRICT,
    preferred_server_id         BIGINT REFERENCES servers(server_id) ON DELETE SET NULL,
    connection_mode_sk          INTEGER NOT NULL REFERENCES lookup(sk) ON DELETE RESTRICT,
    is_active                   BOOLEAN NOT NULL DEFAULT true,
    -- Default connection_mode_sk should reference 'local_then_any' from lookup table (connection_mode_sk)
    
    created_at                  TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    updated_at                  TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    created_by                  INTEGER,
    updated_by                  INTEGER,
    
    CONSTRAINT chk_location_segments_has_segment 
        CHECK (communication_segment_id IS NOT NULL OR auth_segment_id IS NOT NULL)
);

-- Indexes
CREATE INDEX idx_location_segments_location ON location_segments(location_id);
CREATE INDEX idx_location_segments_comm ON location_segments(communication_segment_id);
CREATE INDEX idx_location_segments_auth ON location_segments(auth_segment_id);
CREATE INDEX idx_location_segments_server ON location_segments(preferred_server_id);

-- Triggers

```

---

## Notes for Developer

- Preferred server must exist in assigned communication segment (validated by trigger)
- RESTRICT on segment FK prevents deletion while assigned to locations
- Communication and auth segments can be different or same
- Areas and kiosks inherit segment from location
