# Table Schema: segments

## Table Name

**Table:** `segments`

**Purpose:** Stores segment definitions for Communication and Authentication routing. Segments group servers for workstation connectivity and authentication request routing with failover support.

**Setup / Defaults:** Two pre-defined system segments are created on installation: "Any Server - Communication" and "Any Server - Authentication" (is_system_segment = true, cannot be deleted).

---

## Dependencies

| Depends On | Relationship | Notes |
|------------|-------------|-------|
| `lookup` | FK (segment_type_sk, server_preference_mode_sk, failover_mode_sk, status_sk) | Segment configuration enumerations |
| `users` | FK (created_by, updated_by) | Audit trail for segment management |
| `locations` | Referenced by location_segments | Segments assigned to locations |
| `servers` | Referenced by segment_servers | Servers included in segment |

---

## Columns

| Column Name | Data Type | Nullable | Default | Constraints | Description |
|-------------|-----------|----------|---------|-------------|-------------|
| `segment_id` | `BIGSERIAL` | NO | Auto | `PRIMARY KEY` | Surrogate primary key |
| `segment_name` | `VARCHAR(150)` | NO | | `UNIQUE` | Unique name for the segment |
| `segment_type_sk` | `INTEGER` | NO | | `FK -> lookup(sk)` | Type: communication, authentication, or both (lookup type: segment_type_sk) |
| `is_system_segment` | `BOOLEAN` | NO | `false` | | True for "Any Server" pre-defined segments |
| `relay_all_auth_through_mains` | `BOOLEAN` | NO | `false` | | Flag to route all auth through main servers |
| `server_preference_mode_sk` | `INTEGER` | YES | | `FK -> lookup(sk)` | Server selection preference (lookup type: server_preference_mode_sk) |
| `failover_mode_sk` | `INTEGER` | YES | | `FK -> lookup(sk)` | Failover strategy (lookup type: failover_mode_sk) |
| `latency_threshold_ms` | `INTEGER` | YES | `1000` | | Latency threshold for offline determination (ms) |
| `round_robin_interval_minutes` | `INTEGER` | YES | | | Interval for round robin switching |
| `failback_interval_minutes` | `INTEGER` | YES | `5` | | Time between checks for preferred server availability |
| `description` | `TEXT` | YES | | | Optional description |
| `status_sk` | `INTEGER` | NO | | `FK -> lookup(sk)` | Segment status (lookup type: segment_status_sk) |
| `created_at` | `TIMESTAMP WITH TIME ZONE` | NO | `NOW()` | | Record creation timestamp |
| `updated_at` | `TIMESTAMP WITH TIME ZONE` | NO | `NOW()` | | Last update timestamp |
| `created_by` | `INTEGER` | YES | | `FK -> users(user_id)` | User who created this record |
| `updated_by` | `INTEGER` | YES | | `FK -> users(user_id)` | User who last updated this record |

---

## Indexes

| Index Name | Columns | Type | Purpose |
|------------|---------|------|---------|
| `idx_segments_name` | `segment_name` | B-tree | Fast lookup by name |
| `idx_segments_type` | `segment_type_sk` | B-tree | Filter by segment type |
| `idx_segments_status` | `status_sk` | B-tree | Filter by status |
| `idx_segments_system` | `is_system_segment` | B-tree | Identify system segments |

---

## Foreign Keys

| Column | References | On Delete | On Update | Notes |
|--------|------------|-----------|-----------|-------|
| `segment_type_sk` | `lookup(sk)` | `RESTRICT` | `CASCADE` | Segment type lookup |
| `server_preference_mode_sk` | `lookup(sk)` | `RESTRICT` | `CASCADE` | Server preference mode lookup |
| `failover_mode_sk` | `lookup(sk)` | `RESTRICT` | `CASCADE` | Failover mode lookup |
| `status_sk` | `lookup(sk)` | `RESTRICT` | `CASCADE` | Segment status lookup |
| `created_by` | `users(user_id)` | `SET NULL` | `CASCADE` | Audit trail |
| `updated_by` | `users(user_id)` | `SET NULL` | `CASCADE` | Audit trail |

---

## Triggers

| Trigger Name | Event | Function | Purpose |
|--------------|-------|----------|---------|
| `trg_segments_updated_at` | `BEFORE UPDATE` | `fn_update_timestamp()` | Auto-update `updated_at` |
| `trg_segments_prevent_system_delete` | `BEFORE DELETE` | `fn_prevent_system_segment_delete()` | Block deletion of system segments |

---

## Constraints

| Constraint Name | Type | Columns / Expression | Notes |
|-----------------|------|----------------------|-------|
| `chk_segments_latency_positive` | `CHECK` | `latency_threshold_ms IS NULL OR latency_threshold_ms > 0` | Latency must be positive |

---

## Waitlist Support

- [ ] This table directly represents a reservable resource
- [ ] This table has a related waitlist table
- [x] Not applicable - configuration table

---

## Audit Requirements

- [x] Changes are logged to `staff_audit_log`
- [x] Trigger captures: old value, new value, changed by, changed at, action type
- [x] Audit function name: `fn_audit_segment_changes()`

---

## SQL DDL

```sql
-- Drop if exists (for dev/re-run safety)
-- DROP TABLE IF EXISTS segments CASCADE;

CREATE TABLE segments (
    segment_id                      BIGSERIAL PRIMARY KEY,
    segment_name                    VARCHAR(150) NOT NULL UNIQUE,
    segment_type_sk                 INTEGER NOT NULL REFERENCES lookup(sk) ON DELETE RESTRICT,
    is_system_segment               BOOLEAN NOT NULL DEFAULT false,
    relay_all_auth_through_mains    BOOLEAN NOT NULL DEFAULT false,
    server_preference_mode_sk       INTEGER REFERENCES lookup(sk) ON DELETE RESTRICT,
    failover_mode_sk                INTEGER REFERENCES lookup(sk) ON DELETE RESTRICT,
    latency_threshold_ms            INTEGER CHECK (latency_threshold_ms IS NULL OR latency_threshold_ms > 0) DEFAULT 1000,
    round_robin_interval_minutes    INTEGER,
    failback_interval_minutes       INTEGER DEFAULT 5,
    description                     TEXT,
    status_sk                       INTEGER NOT NULL REFERENCES lookup(sk) ON DELETE RESTRICT,
    -- Defaults: segment_type_sk, server_preference_mode_sk='Any', failover_mode_sk='Latency', status_sk='Active'
    
    created_at                      TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    updated_at                      TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    created_by                      INTEGER REFERENCES users(user_id) ON DELETE SET NULL,
    updated_by                      INTEGER REFERENCES users(user_id) ON DELETE SET NULL
);

-- Indexes
CREATE INDEX idx_segments_name ON segments(segment_name);
CREATE INDEX idx_segments_type ON segments(segment_type_sk);
CREATE INDEX idx_segments_status ON segments(status_sk);
CREATE INDEX idx_segments_system ON segments(is_system_segment);

-- Triggers
CREATE TRIGGER trg_segments_updated_at
    BEFORE UPDATE ON segments
    FOR EACH ROW
    EXECUTE FUNCTION fn_update_timestamp();

-- Insert default system segments
-- Note: segment_type_sk and status_sk must reference lookup table values
-- INSERT INTO segments (segment_name, segment_type_sk, status_sk, is_system_segment, description, created_by, updated_by)
-- VALUES 
--     ('Any Server - Communication', 
--      (SELECT sk FROM lookup WHERE type='segment_type_sk' AND value='Communication'),
--      (SELECT sk FROM lookup WHERE type='segment_status_sk' AND value='Active'),
--      true, 'System-defined segment including all servers hosting Endpoint APIs', -1, -1),
--     ('Any Server - Authentication',
--      (SELECT sk FROM lookup WHERE type='segment_type_sk' AND value='Authentication'),
--      (SELECT sk FROM lookup WHERE type='segment_status_sk' AND value='Active'),
--      true, 'System-defined segment including all servers capable of authentication', -1, -1);
```

---

## Notes for Developer

- System segments ("Any Server - Communication" and "Any Server - Authentication") cannot be deleted
- Deletion blocked if segment assigned to any locations (check via segment_servers and location_segments)
- Failback validation uses Endpoint API connection, not ping
- When segment deleted, must be manually unassigned from all locations first
