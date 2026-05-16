# Lookup Table Refactoring Analysis

## Overview
Analyze and document changes needed to refactor new tables to use lookup table with FK relationships instead of VARCHAR+CHECK constraints for enumerated values.

---

## Tables to Refactor

### 1. `access_portals`

**Fields to Change:**
- `status` VARCHAR(20) → `status_sk` INTEGER FK to lookup
  - Lookup type: `portal_status_sk` (Code: PSS)
  - Values: active, inactive, config_incomplete, decommissioned

**Changes:**
- Column: `status_sk INTEGER REFERENCES lookup(sk)`
- Remove CHECK constraint on status
- Add FK constraint to lookup table
- Update indexes: `idx_access_portals_status` on `status_sk`

---

### 2. `identity_providers`

**Fields to Change:**
1. `provider_type` VARCHAR(30) → `provider_type_sk` INTEGER FK to lookup
   - Lookup type: `identity_provider_type_sk` (Code: IPT)
   - Values: local, ldap, sip2, oauth, saml

2. `status` VARCHAR(20) → `status_sk` INTEGER FK to lookup
   - Lookup type: `identity_provider_status_sk` (Code: IPS)
   - Values: active, inactive, error

**Changes:**
- Columns: `provider_type_sk`, `status_sk` as INTEGER FK
- Remove CHECK constraints
- Add FK constraints to lookup table
- Update indexes

---

### 3. `location_segments`

**Fields to Change:**
- `connection_mode` VARCHAR(30) → `connection_mode_sk` INTEGER FK to lookup
  - Lookup type: `connection_mode_sk` (Code: CMO)
  - Values: local_only, local_then_any, any_available

**Changes:**
- Column: `connection_mode_sk INTEGER REFERENCES lookup(sk)`
- Remove CHECK constraint
- Add FK constraint
- Update indexes

---

### 4. `location_workflows`

**Fields to Change:**
- None (junction table, no enumerated fields)

---

### 5. `pool_areas`

**Fields to Change:**
- None (junction table)

---

### 6. `pools`

**Fields to Change:**
- `status` VARCHAR(20) → `status_sk` INTEGER FK to lookup
  - Lookup type: `pool_status_sk` (Code: PLS)
  - Values: Active, Inactive

**Changes:**
- Column: `status_sk INTEGER REFERENCES lookup(sk)`
- Remove CHECK constraint
- Add FK constraint
- Update indexes: `idx_pools_status` on `status_sk`

---

### 7. `segment_servers`

**Fields to Change:**
- `server_role` VARCHAR(20) → `server_role_sk` INTEGER FK to lookup
  - Lookup type: `server_role_sk` (Code: SRO)
  - Values: Main, Secondary

**Changes:**
- Column: `server_role_sk INTEGER REFERENCES lookup(sk)`
- Remove CHECK constraint
- Add FK constraint
- Update indexes: `idx_segment_servers_role` on `server_role_sk`

---

### 8. `segments`

**Fields to Change:**
1. `segment_type` VARCHAR(30) → `segment_type_sk` INTEGER FK to lookup
   - Lookup type: `segment_type_sk` (Code: SGT)
   - Values: Communication, Authentication, Both

2. `server_preference_mode` VARCHAR(30) → `server_preference_mode_sk` INTEGER FK to lookup
   - Lookup type: `server_preference_mode_sk` (Code: SPM)
   - Values: Prefer Main, Combination, Any, Load Balance

3. `failover_mode` VARCHAR(30) → `failover_mode_sk` INTEGER FK to lookup
   - Lookup type: `failover_mode_sk` (Code: FMO)
   - Values: Latency, Round Robin, Random

4. `status` VARCHAR(20) → `status_sk` INTEGER FK to lookup
   - Lookup type: `segment_status_sk` (Code: SST)
   - Values: Active, Inactive

**Changes:**
- Columns: `segment_type_sk`, `server_preference_mode_sk`, `failover_mode_sk`, `status_sk` as INTEGER FK
- Remove all CHECK constraints
- Add FK constraints to lookup table
- Update all related indexes

---

### 9. `servers`

**Fields to Change:**
1. `server_type` VARCHAR(30) → `server_type_sk` INTEGER FK to lookup
   - Lookup type: `server_type_sk` (Code: SVT)
   - Values: Application, Database, Authentication, Web

2. `status` VARCHAR(20) → `status_sk` INTEGER FK to lookup
   - Lookup type: `server_status_sk` (Code: SES)
   - Values: Active, Inactive, Maintenance, Offline

3. `last_health_check_status` VARCHAR(20) → `last_health_check_status_sk` INTEGER FK to lookup
   - Lookup type: `health_check_status_sk` (Code: HCS)
   - Values: Online, Offline, Degraded, Unknown

**Changes:**
- Columns: `server_type_sk`, `status_sk`, `last_health_check_status_sk` as INTEGER FK
- Remove all CHECK constraints
- Add FK constraints to lookup table
- Update all related indexes

---

### 10. `workflows`

**Fields to Change:**
1. `detection_method` VARCHAR(30) → `detection_method_sk` INTEGER FK to lookup
   - Lookup type: `detection_method_sk` (Code: DTM)
   - Values: Regex, Prefix, Exact

2. `account_creation_mode` VARCHAR(30) → `account_creation_mode_sk` INTEGER FK to lookup
   - Lookup type: `account_creation_mode_sk` (Code: ACM)
   - Values: Auto Create, Deny Access, Allow Without Account

3. `status` VARCHAR(20) → `status_sk` INTEGER FK to lookup
   - Lookup type: `workflow_status_sk` (Code: WFS)
   - Values: Active, Inactive, Testing

**Changes:**
- Columns: `detection_method_sk`, `account_creation_mode_sk`, `status_sk` as INTEGER FK
- Remove all CHECK constraints
- Add FK constraints to lookup table
- Update all related indexes

---

## Summary

**Total Tables Affected:** 8 out of 10
**Total Fields to Refactor:** 18 fields across 8 tables
**Lookup Types Used:** 16 different lookup types

**Benefits:**
1. Consistent data model using lookup table
2. Easier to add/modify enumerated values
3. Better referential integrity with FK constraints
4. Centralized management of all enumerated values
5. Easier for AI agents to understand valid values
