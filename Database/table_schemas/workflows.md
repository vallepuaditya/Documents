# Table Schema: workflows

## Table Name

**Table:** `workflows`

**Purpose:** Stores global authentication workflow definitions that route user types to identity providers with pattern matching, field mapping, and account creation rules.

**Setup / Defaults:** One default workflow for Local Database authentication created on installation.

---

## Dependencies

| Depends On | Relationship | Notes |
|------------|-------------|-------|
| `lookup` | FK (detection_method_sk, account_creation_mode_sk, status_sk) | Detection method, account creation mode, and status enumerations |
| `identity_providers` | FK (identity_provider_id) | Target authentication provider |
| `user_types` | FK (user_type_id) | Optional user type constraint |
| `users` | FK (created_by, updated_by) | Audit trail |

---

## Columns

| Column Name | Data Type | Nullable | Default | Constraints | Description |
|-------------|-----------|----------|---------|-------------|-------------|
| `workflow_id` | `BIGSERIAL` | NO | Auto | `PRIMARY KEY` | Surrogate primary key |
| `workflow_name` | `VARCHAR(150)` | NO | | `UNIQUE` | Unique workflow name |
| `description` | `TEXT` | YES | | | Workflow description |
| `identity_provider_id` | `BIGINT` | NO | | `FK -> identity_providers(identity_provider_id)` | Target identity provider |
| `user_type_id` | `INTEGER` | YES | | `FK -> user_types(user_type_id)` | Optional user type constraint |
| `detection_pattern` | `VARCHAR(255)` | YES | | | Regex pattern for user type detection |
| `pattern_priority` | `INTEGER` | NO | `100` | | Pattern matching priority (lower = higher) |
| `detection_method_sk` | `INTEGER` | NO | | `FK -> lookup(sk)` | Detection method type (lookup type: detection_method_sk) |
| `account_creation_mode_sk` | `INTEGER` | NO | | `FK -> lookup(sk)` | Account creation behavior (lookup type: account_creation_mode_sk) |
| `permitted_reverse_lookup_fields` | `JSONB` | YES | `'[]'` | | Array of fields permitted for reverse lookup |
| `field_import_config` | `JSONB` | YES | `'{}'` | | Field import mapping configuration |
| `alias_generation_pattern` | `VARCHAR(255)` | YES | | | Pattern for generating user aliases |
| `error_message_override` | `TEXT` | YES | | | Custom error message template |
| `is_global` | `BOOLEAN` | NO | `true` | | Global workflow (vs location-specific) |
| `is_enabled` | `BOOLEAN` | NO | `true` | | Workflow enabled status |
| `status_sk` | `INTEGER` | NO | | `FK -> lookup(sk)` | Workflow status (lookup type: workflow_status_sk) |
| `last_test_at` | `TIMESTAMP WITH TIME ZONE` | YES | | | Last test timestamp |
| `last_test_result` | `TEXT` | YES | | | Last test result |
| `created_at` | `TIMESTAMP WITH TIME ZONE` | NO | `NOW()` | | Record creation timestamp |
| `updated_at` | `TIMESTAMP WITH TIME ZONE` | NO | `NOW()` | | Last update timestamp |
| `created_by` | `INTEGER` | YES | | `FK -> users(id)` | User who created this record |
| `updated_by` | `INTEGER` | YES | | `FK -> users(id)` | User who last updated this record |

---

## Indexes

| Index Name | Columns | Type | Purpose |
|------------|---------|------|---------|
| `idx_workflows_name` | `workflow_name` | B-tree | Fast lookup by name |
| `idx_workflows_provider` | `identity_provider_id` | B-tree | Workflows by provider |
| `idx_workflows_user_type` | `user_type_id` | B-tree | Workflows by user type |
| `idx_workflows_priority` | `pattern_priority` | B-tree | Pattern matching order |
| `idx_workflows_enabled` | `is_enabled` | B-tree | Filter enabled workflows |
| `idx_workflows_global` | `is_global` | B-tree | Filter global workflows |
| `idx_workflows_status` | `status_sk` | B-tree | Filter by status |

---

## Foreign Keys

| Column | References | On Delete | On Update | Notes |
|--------|------------|-----------|-----------|-------|
| `identity_provider_id` | `identity_providers(identity_provider_id)` | `RESTRICT` | `CASCADE` | Block provider deletion if used |
| `user_type_id` | `user_types(user_type_id)` | `SET NULL` | `CASCADE` | Optional constraint |
| `detection_method_sk` | `lookup(sk)` | `RESTRICT` | `CASCADE` | Detection method lookup |
| `account_creation_mode_sk` | `lookup(sk)` | `RESTRICT` | `CASCADE` | Account creation mode lookup |
| `status_sk` | `lookup(sk)` | `RESTRICT` | `CASCADE` | Workflow status lookup |
| `created_by` | `users(id)` | `SET NULL` | `CASCADE` | Audit trail |
| `updated_by` | `users(id)` | `SET NULL` | `CASCADE` | Audit trail |

---

## Triggers

| Trigger Name | Event | Function | Purpose |
|--------------|-------|----------|---------|
| `trg_workflows_updated_at` | `BEFORE UPDATE` | `fn_update_timestamp()` | Auto-update `updated_at` |
| `trg_workflows_validate_pattern` | `BEFORE INSERT OR UPDATE` | `fn_validate_workflow_pattern()` | Validate regex pattern syntax |

---

## Constraints

| Constraint Name | Type | Columns / Expression | Notes |
|-----------------|------|----------------------|-------|
| `chk_workflows_priority_positive` | `CHECK` | `pattern_priority > 0` | Priority must be positive |

---

## Waitlist Support

- [ ] This table directly represents a reservable resource
- [ ] This table has a related waitlist table
- [x] Not applicable - configuration table

---

## Audit Requirements

- [x] Changes are logged to `staff_audit_log`
- [x] Audit function name: `fn_audit_workflow_changes()`

---

## SQL DDL

```sql
-- Drop if exists (for dev/re-run safety)
-- DROP TABLE IF EXISTS workflows CASCADE;

CREATE TABLE workflows (
    workflow_id                         BIGSERIAL PRIMARY KEY,
    workflow_name                       VARCHAR(150) NOT NULL UNIQUE,
    description                         TEXT,
    identity_provider_id                BIGINT NOT NULL REFERENCES identity_providers(identity_provider_id) ON DELETE RESTRICT,
    user_type_id                        INTEGER REFERENCES user_types(user_type_id) ON DELETE SET NULL,
    detection_pattern                   VARCHAR(255),
    pattern_priority                    INTEGER NOT NULL DEFAULT 100 CHECK (pattern_priority > 0),
    detection_method_sk                 INTEGER NOT NULL REFERENCES lookup(sk) ON DELETE RESTRICT,
    account_creation_mode_sk            INTEGER NOT NULL REFERENCES lookup(sk) ON DELETE RESTRICT,
    permitted_reverse_lookup_fields     JSONB DEFAULT '[]',
    field_import_config                 JSONB DEFAULT '{}',
    alias_generation_pattern            VARCHAR(255),
    error_message_override              TEXT,
    is_global                           BOOLEAN NOT NULL DEFAULT true,
    is_enabled                          BOOLEAN NOT NULL DEFAULT true,
    status_sk                           INTEGER NOT NULL REFERENCES lookup(sk) ON DELETE RESTRICT,
    last_test_at                        TIMESTAMP WITH TIME ZONE,
    -- Defaults: detection_method_sk='Regex', account_creation_mode_sk='Auto Create', status_sk='Active'
    last_test_result                    TEXT,
    
    created_at                          TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    updated_at                          TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    created_by                          INTEGER  NULL,
    updated_by                          INTEGER NULL
);

-- Indexes
CREATE INDEX idx_workflows_name ON workflows(workflow_name);
CREATE INDEX idx_workflows_provider ON workflows(identity_provider_id);
CREATE INDEX idx_workflows_user_type ON workflows(user_type_id);
CREATE INDEX idx_workflows_priority ON workflows(pattern_priority);
CREATE INDEX idx_workflows_enabled ON workflows(is_enabled);
CREATE INDEX idx_workflows_global ON workflows(is_global);
CREATE INDEX idx_workflows_status ON workflows(status_sk);

-- Triggers
```

---

## Notes for Developer

- Patterns evaluated in priority order (lower pattern_priority = higher priority)
- First matching workflow wins unless multi-workflow processing enabled
- field_import_config maps external provider fields to system user fields
- permitted_reverse_lookup_fields is array of field names allowing reverse lookup
- alias_generation_pattern uses template syntax (e.g., "{first_name:2}{last_name:1}-{id:3}")
- Workflows NOT tied to Segments - routing determined at Location + Identity Provider level
