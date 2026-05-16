# Table Schema: location_workflows

## Table Name

**Table:** `location_workflows`

**Purpose:** Junction table managing which global workflows are enabled/disabled at specific locations with location-specific overrides for error messages and behavior.

**Setup / Defaults:** No default rows. Populated when locations enable specific workflows.

---

## Dependencies

| Depends On | Relationship | Notes |
|------------|-------------|-------|
| `locations` | FK (location_id) | Parent location |
| `workflows` | FK (workflow_id) | Global workflow being enabled |
| `users` | FK (created_by, updated_by) | Audit trail |

---

## Columns

| Column Name | Data Type | Nullable | Default | Constraints | Description |
|-------------|-----------|----------|---------|-------------|-------------|
| `location_workflow_id` | `BIGSERIAL` | NO | Auto | `PRIMARY KEY` | Surrogate primary key |
| `location_id` | `INTEGER` | NO | | `FK -> locations(location_id)` | Parent location |
| `workflow_id` | `BIGINT` | NO | | `FK -> workflows(workflow_id)` | Global workflow |
| `is_enabled` | `BOOLEAN` | NO | `true` | | Workflow enabled at this location |
| `priority_override` | `INTEGER` | YES | | | Location-specific priority override |
| `error_message_override` | `TEXT` | YES | | | Location-specific error message |
| `field_mapping_override` | `JSONB` | YES | | | Location-specific field mapping overrides |
| `created_at` | `TIMESTAMP WITH TIME ZONE` | NO | `NOW()` | | Record creation timestamp |
| `updated_at` | `TIMESTAMP WITH TIME ZONE` | NO | `NOW()` | | Last update timestamp |
| `created_by` | `INTEGER` | YES | | `FK -> users(id)` | User who created this record |
| `updated_by` | `INTEGER` | YES | | `FK -> users(id)` | User who last updated this record |

---

## Indexes

| Index Name | Columns | Type | Purpose |
|------------|---------|------|---------|
| `idx_location_workflows_location` | `location_id` | B-tree | Workflows by location |
| `idx_location_workflows_workflow` | `workflow_id` | B-tree | Locations using workflow |
| `idx_location_workflows_enabled` | `location_id, is_enabled` | B-tree | Filter enabled workflows |

---

## Foreign Keys

| Column | References | On Delete | On Update | Notes |
|--------|------------|-----------|-----------|-------|
| `location_id` | `locations(location_id)` | `CASCADE` | `CASCADE` | Delete when location deleted |
| `workflow_id` | `workflows(workflow_id)` | `CASCADE` | `CASCADE` | Delete when workflow deleted |
| `created_by` | `users(id)` | `SET NULL` | `CASCADE` | Audit trail |
| `updated_by` | `users(id)` | `SET NULL` | `CASCADE` | Audit trail |

---

## Triggers

| Trigger Name | Event | Function | Purpose |
|--------------|-------|----------|---------|
| `trg_location_workflows_updated_at` | `BEFORE UPDATE` | `fn_update_timestamp()` | Auto-update `updated_at` |

---

## Constraints

| Constraint Name | Type | Columns / Expression | Notes |
|-----------------|------|----------------------|-------|
| `unq_location_workflow` | `UNIQUE` | `(location_id, workflow_id)` | Prevent duplicate workflow at location |

---

## Waitlist Support

- [ ] This table directly represents a reservable resource
- [ ] This table has a related waitlist table
- [x] Not applicable - configuration table

---

## Audit Requirements

- [x] Changes are logged to `staff_audit_log`
- [x] Audit function name: `fn_audit_location_workflow_changes()`

---

## SQL DDL

```sql
-- Drop if exists (for dev/re-run safety)
-- DROP TABLE IF EXISTS location_workflows CASCADE;

CREATE TABLE location_workflows (
    location_workflow_id    BIGSERIAL PRIMARY KEY,
    location_id             INTEGER NOT NULL REFERENCES locations(location_id) ON DELETE CASCADE,
    workflow_id             BIGINT NOT NULL REFERENCES workflows(workflow_id) ON DELETE CASCADE,
    is_enabled              BOOLEAN NOT NULL DEFAULT true,
    priority_override       INTEGER,
    error_message_override  TEXT,
    field_mapping_override  JSONB,
    
    created_at              TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    updated_at              TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    created_by                   INTEGER NULL,
    updated_by                   INTEGER NULL,
    
    CONSTRAINT unq_location_workflow UNIQUE (location_id, workflow_id)
);

-- Indexes
CREATE INDEX idx_location_workflows_location ON location_workflows(location_id);
CREATE INDEX idx_location_workflows_workflow ON location_workflows(workflow_id);
CREATE INDEX idx_location_workflows_enabled ON location_workflows(location_id, is_enabled);

-- Triggers
```

---

## Notes for Developer

- Locations cannot create new workflows, only enable/disable global workflows
- priority_override allows location to change pattern matching order
- error_message_override provides location-specific user-facing messages
- field_mapping_override allows location-specific field mapping adjustments
