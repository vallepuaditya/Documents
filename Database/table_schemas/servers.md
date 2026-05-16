# Table Schema: servers

## Table Name

**Table:** `servers`

**Purpose:** Stores physical and virtual server configurations that host the application, Endpoint APIs, and handle workstation connections and authentication routing.

**Setup / Defaults:** At least one server created during installation for the primary application server.

---

## Dependencies

| Depends On | Relationship | Notes |
|------------|-------------|-------|
| `lookup` | FK (server_type_sk, status_sk, last_health_check_status_sk) | Server type, status, and health check status enumerations |
| `users` | FK (created_by, updated_by) | Audit trail |

---

## Columns

| Column Name | Data Type | Nullable | Default | Constraints | Description |
|-------------|-----------|----------|---------|-------------|-------------|
| `server_id` | `BIGSERIAL` | NO | Auto | `PRIMARY KEY` | Surrogate primary key |
| `server_name` | `VARCHAR(150)` | NO | | `UNIQUE` | Unique server name |
| `hostname` | `VARCHAR(255)` | NO | | | Server hostname or IP |
| `port` | `INTEGER` | NO | `443` | | Server port |
| `server_uri` | `VARCHAR(255)` | NO | | | Full server URI |
| `use_ssl` | `BOOLEAN` | NO | `true` | | Use SSL/TLS |
| `server_type_sk` | `INTEGER` | NO | | `FK -> lookup(sk)` | Server type/role (lookup type: server_type_sk) |
| `has_endpoint_api` | `BOOLEAN` | NO | `true` | | Hosts Endpoint API |
| `can_authenticate` | `BOOLEAN` | NO | `true` | | Can handle authentication requests |
| `location_id` | `INTEGER` | YES | | `FK -> locations(location_id)` | Physical server location (optional) |
| `is_primary` | `BOOLEAN` | NO | `false` | | Primary/master server flag |
| `health_check_url` | `VARCHAR(255)` | YES | | | Health check endpoint |
| `last_health_check_at` | `TIMESTAMP WITH TIME ZONE` | YES | | | Last health check timestamp |
| `last_health_check_status_sk` | `INTEGER` | YES | | `FK -> lookup(sk)` | Last health status (lookup type: health_check_status_sk) |
| `latency_ms` | `INTEGER` | YES | | | Last measured latency (ms) |
| `status_sk` | `INTEGER` | NO | | `FK -> lookup(sk)` | Server status (lookup type: server_status_sk) |
| `server_metadata` | `JSONB` | YES | `'{}'` | | Additional server configuration |
| `created_at` | `TIMESTAMP WITH TIME ZONE` | NO | `NOW()` | | Record creation timestamp |
| `updated_at` | `TIMESTAMP WITH TIME ZONE` | NO | `NOW()` | | Last update timestamp |
| `created_by` | `INTEGER` | YES | | `FK -> users(id)` | User who created this record |
| `updated_by` | `INTEGER` | YES | | `FK -> users(id)` | User who last updated this record |

---

## Indexes

| Index Name | Columns | Type | Purpose |
|------------|---------|------|---------|
| `idx_servers_name` | `server_name` | B-tree | Fast lookup by name |
| `idx_servers_hostname` | `hostname` | B-tree | Lookup by hostname |
| `idx_servers_type` | `server_type_sk` | B-tree | Filter by server type |
| `idx_servers_status` | `status_sk` | B-tree | Filter by status |
| `idx_servers_endpoint_api` | `has_endpoint_api` | B-tree | Find API servers |
| `idx_servers_can_auth` | `can_authenticate` | B-tree | Find auth servers |
| `idx_servers_location` | `location_id` | B-tree | Servers by location |
| `idx_servers_health` | `last_health_check_status_sk` | B-tree | Filter by health |

---

## Foreign Keys

| Column | References | On Delete | On Update | Notes |
|--------|------------|-----------|-----------|-------|
| `server_type_sk` | `lookup(sk)` | `RESTRICT` | `CASCADE` | Server type lookup |
| `status_sk` | `lookup(sk)` | `RESTRICT` | `CASCADE` | Server status lookup |
| `last_health_check_status_sk` | `lookup(sk)` | `RESTRICT` | `CASCADE` | Health check status lookup |
| `location_id` | `locations(location_id)` | `SET NULL` | `CASCADE` | Physical location of server |
| `created_by` | `users(id)` | `SET NULL` | `CASCADE` | Audit trail |
| `updated_by` | `users(id)` | `SET NULL` | `CASCADE` | Audit trail |

---

## Triggers

| Trigger Name | Event | Function | Purpose |
|--------------|-------|----------|---------|
| `trg_servers_updated_at` | `BEFORE UPDATE` | `fn_update_timestamp()` | Auto-update `updated_at` |
| `trg_servers_update_any_server_segments` | `AFTER INSERT OR UPDATE OR DELETE` | `fn_update_any_server_segments()` | Update "Any Server" segments |

---

## Constraints

| Constraint Name | Type | Columns / Expression | Notes |
|-----------------|------|----------------------|-------|
| `chk_servers_port` | `CHECK` | `port > 0 AND port <= 65535` | Valid port range |
| `chk_servers_latency` | `CHECK` | `latency_ms IS NULL OR latency_ms >= 0` | Latency non-negative |

---

## Waitlist Support

- [ ] This table directly represents a reservable resource
- [ ] This table has a related waitlist table
- [x] Not applicable - infrastructure table

---

## Audit Requirements

- [x] Changes are logged to `staff_audit_log`
- [x] Status changes trigger alerts
- [x] Audit function name: `fn_audit_server_changes()`

---

## SQL DDL

```sql
-- Drop if exists (for dev/re-run safety)
-- DROP TABLE IF EXISTS servers CASCADE;

CREATE TABLE servers (
    server_id                   BIGSERIAL PRIMARY KEY,
    server_name                 VARCHAR(150) NOT NULL UNIQUE,
    hostname                    VARCHAR(255) NOT NULL,
    port                        INTEGER NOT NULL DEFAULT 443 CHECK (port > 0 AND port <= 65535),
    server_uri                  VARCHAR(255) NOT NULL,
    use_ssl                     BOOLEAN NOT NULL DEFAULT true,
    server_type_sk              INTEGER NOT NULL REFERENCES lookup(sk) ON DELETE RESTRICT,
    has_endpoint_api            BOOLEAN NOT NULL DEFAULT true,
    can_authenticate            BOOLEAN NOT NULL DEFAULT true,
    location_id                 INTEGER REFERENCES locations(location_id) ON DELETE SET NULL,
    is_primary                  BOOLEAN NOT NULL DEFAULT false,
    health_check_url            VARCHAR(255),
    last_health_check_at        TIMESTAMP WITH TIME ZONE,
    last_health_check_status_sk INTEGER REFERENCES lookup(sk) ON DELETE RESTRICT,
    latency_ms                  INTEGER CHECK (latency_ms IS NULL OR latency_ms >= 0),
    status_sk                   INTEGER NOT NULL REFERENCES lookup(sk) ON DELETE RESTRICT,
    -- Defaults: server_type_sk='Application', status_sk='Active'
    server_metadata             JSONB DEFAULT '{}',
    
    created_at                  TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    updated_at                  TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    created_by                  INTEGER,
    updated_by                  INTEGER
);

-- Indexes
CREATE INDEX idx_servers_name ON servers(server_name);
CREATE INDEX idx_servers_hostname ON servers(hostname);
CREATE INDEX idx_servers_type ON servers(server_type_sk);
CREATE INDEX idx_servers_status ON servers(status_sk);
CREATE INDEX idx_servers_location ON servers(location_id);


```

---

## Notes for Developer

- When server added/removed, update "Any Server" system segments automatically
- Health check should update latency_ms, last_health_check_at, last_health_check_status
- Failback validation uses Endpoint API connection (not ping)
- Latency threshold configurable per segment (default 1000ms = offline)
- Server metadata can store custom configuration (e.g., max connections, priority weights)
- Physical location_id is optional and for documentation - network topology matters more
