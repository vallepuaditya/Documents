# Table Schema: segment_servers

## Table Name

**Table:** `segment_servers`

**Purpose:** Junction table mapping servers to segments, defining main vs secondary server roles and server priority order within segments.

**Setup / Defaults:** No default rows. Populated when servers are added to segments.

---

## Dependencies

| Depends On | Relationship | Notes |
|------------|-------------|-------|
| `lookup` | FK (server_role_sk) | Server role enumeration |
| `segments` | FK (segment_id) | Parent segment |
| `servers` | FK (server_id) | Server being added to segment |
| `users` | FK (created_by, updated_by) | Audit trail |

---

## Columns

| Column Name | Data Type | Nullable | Default | Constraints | Description |
|-------------|-----------|----------|---------|-------------|-------------|
| `segment_server_id` | `BIGSERIAL` | NO | Auto | `PRIMARY KEY` | Surrogate primary key |
| `segment_id` | `BIGINT` | NO | | `FK -> segments(segment_id)` | Parent segment |
| `server_id` | `BIGINT` | NO | | `FK -> servers(server_id)` | Server in this segment |
| `server_role_sk` | `INTEGER` | NO | | `FK -> lookup(sk)` | Main or secondary server (lookup type: server_role_sk) |
| `priority_order` | `INTEGER` | NO | `0` | | Order preference (lower = higher priority) |
| `is_active` | `BOOLEAN` | NO | `true` | | Active status |
| `created_at` | `TIMESTAMP WITH TIME ZONE` | NO | `NOW()` | | Record creation timestamp |
| `updated_at` | `TIMESTAMP WITH TIME ZONE` | NO | `NOW()` | | Last update timestamp |
| `created_by` | `INTEGER` | YES | | `FK -> users(id)` | User who created this record |
| `updated_by` | `INTEGER` | YES | | `FK -> users(id)` | User who last updated this record |

---

## Indexes

| Index Name | Columns | Type | Purpose |
|------------|---------|------|---------|
| `idx_segment_servers_segment` | `segment_id` | B-tree | Lookup servers by segment |
| `idx_segment_servers_server` | `server_id` | B-tree | Lookup segments by server |
| `idx_segment_servers_role` | `segment_id, server_role_sk` | B-tree | Filter main/secondary servers |
| `idx_segment_servers_priority` | `segment_id, priority_order` | B-tree | Server ordering |

---

## Foreign Keys

| Column | References | On Delete | On Update | Notes |
|--------|------------|-----------|-----------|-------|
| `segment_id` | `segments(segment_id)` | `CASCADE` | `CASCADE` | Delete when segment deleted |
| `server_id` | `servers(server_id)` | `CASCADE` | `CASCADE` | Delete when server deleted |
| `server_role_sk` | `lookup(sk)` | `RESTRICT` | `CASCADE` | Server role lookup |
| `created_by` | `users(id)` | `SET NULL` | `CASCADE` | Audit trail |
| `updated_by` | `users(id)` | `SET NULL` | `CASCADE` | Audit trail |

---

## Triggers

| Trigger Name | Event | Function | Purpose |
|--------------|-------|----------|---------|
| `trg_segment_servers_updated_at` | `BEFORE UPDATE` | `fn_update_timestamp()` | Auto-update `updated_at` |

---

## Constraints

| Constraint Name | Type | Columns / Expression | Notes |
|-----------------|------|----------------------|-------|
| `unq_segment_server` | `UNIQUE` | `(segment_id, server_id)` | Prevent duplicate server in same segment |

---

## Waitlist Support

- [ ] This table directly represents a reservable resource
- [ ] This table has a related waitlist table
- [x] Not applicable - configuration table

---

## Audit Requirements

- [x] Changes are logged to `staff_audit_log`
- [x] Audit function name: `fn_audit_segment_server_changes()`

---

## SQL DDL

```sql
-- Drop if exists (for dev/re-run safety)
-- DROP TABLE IF EXISTS segment_servers CASCADE;

CREATE TABLE segment_servers (
    segment_server_id   BIGSERIAL PRIMARY KEY,
    segment_id          BIGINT NOT NULL REFERENCES segments(segment_id) ON DELETE CASCADE,
    server_id           BIGINT NOT NULL REFERENCES servers(server_id) ON DELETE CASCADE,
    server_role_sk      INTEGER NOT NULL REFERENCES lookup(sk) ON DELETE RESTRICT,
    priority_order      INTEGER NOT NULL DEFAULT 0,
    -- Default server_role_sk should reference 'Main' from lookup table (server_role_sk)
    is_active           BOOLEAN NOT NULL DEFAULT true,
    
    created_at          TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    updated_at          TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    created_by                  INTEGER,
    updated_by                  INTEGER,
    
    CONSTRAINT unq_segment_server UNIQUE (segment_id, server_id)
);

-- Indexes
CREATE INDEX idx_segment_servers_segment ON segment_servers(segment_id);
CREATE INDEX idx_segment_servers_server ON segment_servers(server_id);
CREATE INDEX idx_segment_servers_role ON segment_servers(segment_id, server_role_sk);
CREATE INDEX idx_segment_servers_priority ON segment_servers(segment_id, priority_order);

-- Triggers
```

---

## Notes for Developer

- Same server can appear as both main and secondary (common in single-server installations)
- Priority order determines failover sequence within role
- Main servers preferred over secondary unless configuration specifies otherwise
