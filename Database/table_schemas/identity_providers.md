# Table Schema: identity_providers

## Table Name

**Table:** `identity_providers`

**Purpose:** Stores external and internal authentication provider configurations (LDAP, SIP2, Local Database, etc.) with connection credentials and settings.

**Setup / Defaults:** One default "Local Database" provider created on installation (is_system_provider = true).

---

## Dependencies

| Depends On | Relationship | Notes |
|------------|-------------|-------|
| `lookup` | FK (provider_type_sk, status_sk) | Provider type and status enumeration |
| `users` | FK (created_by, updated_by) | Audit trail |
| `segments` | Referenced by workflows | Auth segment for provider routing |

---

## Columns

| Column Name | Data Type | Nullable | Default | Constraints | Description |
|-------------|-----------|----------|---------|-------------|-------------|
| `identity_provider_id` | `BIGSERIAL` | NO | Auto | `PRIMARY KEY` | Surrogate primary key |
| `provider_name` | `VARCHAR(150)` | NO | | `UNIQUE` | Unique provider name |
| `provider_type_sk` | `INTEGER` | NO | | `FK -> lookup(sk)` | Provider type (lookup type: identity_provider_type_sk) |
| `is_system_provider` | `BOOLEAN` | NO | `false` | | True for system default (Local Database) |
| `host` | `VARCHAR(255)` | YES | | | Provider host/server address |
| `port` | `INTEGER` | YES | | | Provider port number |
| `use_ssl` | `BOOLEAN` | NO | `true` | | Use SSL/TLS connection |
| `base_dn` | `VARCHAR(255)` | YES | | | LDAP base DN |
| `bind_dn` | `VARCHAR(255)` | YES | | | LDAP bind DN |
| `bind_password` | `TEXT` | YES | | | Encrypted bind password |
| `search_filter` | `TEXT` | YES | | | LDAP search filter template |
| `field_mappings` | `JSONB` | YES | `'{}'` | | Field mapping configuration JSON |
| `connection_timeout_seconds` | `INTEGER` | YES | `30` | | Connection timeout |
| `is_enabled` | `BOOLEAN` | NO | `true` | | Provider enabled status |
| `status_sk` | `INTEGER` | NO | | `FK -> lookup(sk)` | Provider status (lookup type: identity_provider_status_sk) |
| `last_test_at` | `TIMESTAMP WITH TIME ZONE` | YES | | | Last connection test timestamp |
| `last_test_result` | `TEXT` | YES | | | Last test result message |
| `created_at` | `TIMESTAMP WITH TIME ZONE` | NO | `NOW()` | | Record creation timestamp |
| `updated_at` | `TIMESTAMP WITH TIME ZONE` | NO | `NOW()` | | Last update timestamp |
| `created_by` | `INTEGER` | YES | | `FK -> users(id)` | User who created this record |
| `updated_by` | `INTEGER` | YES | | `FK -> users(id)` | User who last updated this record |

---

## Indexes

| Index Name | Columns | Type | Purpose |
|------------|---------|------|---------|
| `idx_identity_providers_name` | `provider_name` | B-tree | Fast lookup by name |
| `idx_identity_providers_type` | `provider_type_sk` | B-tree | Filter by provider type |
| `idx_identity_providers_status` | `status_sk` | B-tree | Filter by status |
| `idx_identity_providers_enabled` | `is_enabled` | B-tree | Filter enabled providers |
| `idx_identity_providers_system` | `is_system_provider` | B-tree | Identify system provider |

---

## Foreign Keys

| Column | References | On Delete | On Update | Notes |
|--------|------------|-----------|-----------|-------|
| `provider_type_sk` | `lookup(sk)` | `RESTRICT` | `CASCADE` | Provider type lookup |
| `status_sk` | `lookup(sk)` | `RESTRICT` | `CASCADE` | Provider status lookup |
| `created_by` | `users(id)` | `SET NULL` | `CASCADE` | Audit trail |
| `updated_by` | `users(id)` | `SET NULL` | `CASCADE` | Audit trail |

---

## Triggers

| Trigger Name | Event | Function | Purpose |
|--------------|-------|----------|---------|
| `trg_identity_providers_updated_at` | `BEFORE UPDATE` | `fn_update_timestamp()` | Auto-update `updated_at` |
| `trg_identity_providers_encrypt_password` | `BEFORE INSERT OR UPDATE` | `fn_encrypt_bind_password()` | Encrypt bind_password field |

---

## Constraints

| Constraint Name | Type | Columns / Expression | Notes |
|-----------------|------|----------------------|-------|
| `chk_identity_providers_port` | `CHECK` | `port IS NULL OR (port > 0 AND port <= 65535)` | Valid port range |

---

## Waitlist Support

- [ ] This table directly represents a reservable resource
- [ ] This table has a related waitlist table
- [x] Not applicable - configuration table

---

## Audit Requirements

- [x] Changes are logged to `staff_audit_log`
- [x] Password changes logged but value masked
- [x] Audit function name: `fn_audit_identity_provider_changes()`

---

## SQL DDL

```sql
-- Drop if exists (for dev/re-run safety)
-- DROP TABLE IF EXISTS identity_providers CASCADE;

CREATE TABLE identity_providers (
    identity_provider_id        BIGSERIAL PRIMARY KEY,
    provider_name               VARCHAR(150) NOT NULL UNIQUE,
    provider_type_sk            INTEGER NOT NULL REFERENCES lookup(sk) ON DELETE RESTRICT,
    is_system_provider          BOOLEAN NOT NULL DEFAULT false,
    host                        VARCHAR(255),
    port                        INTEGER CHECK (port IS NULL OR (port > 0 AND port <= 65535)),
    use_ssl                     BOOLEAN NOT NULL DEFAULT true,
    base_dn                     VARCHAR(255),
    bind_dn                     VARCHAR(255),
    bind_password               TEXT,
    search_filter               TEXT,
    field_mappings              JSONB DEFAULT '{}',
    connection_timeout_seconds  INTEGER DEFAULT 30,
    is_enabled                  BOOLEAN NOT NULL DEFAULT true,
    status_sk                   INTEGER NOT NULL REFERENCES lookup(sk) ON DELETE RESTRICT,
    last_test_at                TIMESTAMP WITH TIME ZONE,
    last_test_result            TEXT,
    
    created_at                  TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    updated_at                  TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    created_by                  INTEGER REFERENCES users(user_id) ON DELETE SET NULL,
    updated_by                  INTEGER REFERENCES users(user_id) ON DELETE SET NULL
);

-- Indexes
CREATE INDEX idx_identity_providers_name ON identity_providers(provider_name);
CREATE INDEX idx_identity_providers_type ON identity_providers(provider_type_sk);
CREATE INDEX idx_identity_providers_status ON identity_providers(status_sk);
CREATE INDEX idx_identity_providers_enabled ON identity_providers(is_enabled);
CREATE INDEX idx_identity_providers_system ON identity_providers(is_system_provider);

-- Insert system provider
-- Note: provider_type_sk and status_sk must reference lookup table values
-- provider_type_sk should reference 'local' from identity_provider_type_sk
-- status_sk should reference 'active' from identity_provider_status_sk
-- INSERT INTO identity_providers (provider_name, provider_type_sk, status_sk, is_system_provider, created_by, updated_by)
-- VALUES ('Local Database', (SELECT sk FROM lookup WHERE type='identity_provider_type_sk' AND value='local'), 
--         (SELECT sk FROM lookup WHERE type='identity_provider_status_sk' AND value='active'), true, -1, -1);
```

---

## Notes for Developer

- Credentials (bind_password) must be encrypted before storage
- System provider "Local Database" cannot be deleted
- field_mappings stores JSON mapping external fields to system fields
- Test connection function should update last_test_at and last_test_result
- Access restricted to full administrators (Systems > Connections section)
