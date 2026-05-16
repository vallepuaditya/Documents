# PostgreSQL Function: fn_workflow_create

## Function Name

**Function:** `fn_workflow_create(p_workflow_name, p_identity_provider_id, p_user_type_id, p_detection_pattern, p_pattern_priority, p_account_creation_mode, p_created_by)`

**Purpose:** Creates a new global authentication workflow that routes user types to identity providers with pattern matching and account creation rules.

**Called By:** API Controller: `/api/constructs/workflows` (POST)

---

## Signature

```sql
CREATE OR REPLACE FUNCTION fn_workflow_create(
    p_workflow_name VARCHAR(150),
    p_identity_provider_id BIGINT,
    p_user_type_id INTEGER,
    p_detection_pattern VARCHAR(255),
    p_pattern_priority INTEGER,
    p_detection_method_sk INTEGER,
    p_account_creation_mode_sk INTEGER,
    p_field_import_config JSONB,
    p_permitted_reverse_lookup_fields JSONB,
    p_alias_generation_pattern VARCHAR(255),
    p_created_by INTEGER
)
RETURNS TABLE(
    workflow_id BIGINT,
    workflow_name VARCHAR(150),
    status_sk INTEGER,
    message TEXT
)
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
```

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `p_workflow_name` | `VARCHAR(150)` | YES | Unique workflow name |
| `p_identity_provider_id` | `BIGINT` | YES | Target identity provider |
| `p_user_type_id` | `INTEGER` | NO | Optional user type constraint |
| `p_detection_pattern` | `VARCHAR(255)` | NO | Regex pattern for user type detection |
| `p_pattern_priority` | `INTEGER` | NO | Pattern matching priority (default 100) |
| `p_detection_method_sk` | `INTEGER` | NO | Detection method SK from lookup (type: detection_method_sk) |
| `p_account_creation_mode_sk` | `INTEGER` | NO | Account creation mode SK from lookup (type: account_creation_mode_sk) |
| `p_field_import_config` | `JSONB` | NO | Field mapping configuration |
| `p_permitted_reverse_lookup_fields` | `JSONB` | NO | Allowed reverse lookup fields |
| `p_alias_generation_pattern` | `VARCHAR(255)` | NO | Alias generation template |
| `p_created_by` | `INTEGER` | YES | User ID creating the workflow |

**Return Type:** `TABLE(workflow_id BIGINT, workflow_name VARCHAR(150), status_sk INTEGER, message TEXT)`

---

## Transaction Behavior

| Aspect | Value |
|--------|-------|
| Runs inside transaction | YES |
| Rollback scope | Full operation |
| Savepoint usage | None |

---

## Preconditions / Validation

- Workflow name must be unique
- Identity provider must exist and be enabled
- User type must exist if provided
- Detection method SK must exist in lookup table
- Account creation mode SK must exist in lookup table
- Detection pattern must be valid regex if detection_method is 'regex'
- Pattern priority must be positive

---

## Main Logic Steps

1. Validate workflow name uniqueness
2. Validate identity provider exists and is enabled
3. Validate user type if provided
4. Validate detection pattern regex syntax if method is 'regex'
5. Set default values for optional parameters
6. Insert new workflow record
7. Log audit entry
8. Return newly created workflow details

---

## Waitlist Behavior

- [x] Not applicable - configuration function

---

## Audit Logging

| Audit Action | Logged To | Fields Captured |
|--------------|-----------|-----------------|
| `INSERT` | `staff_audit_log` | workflow_id, workflow_name, identity_provider_id, created_by, action='CREATE' |

**Audit helper used:** `fn_log_audit('workflows', 'CREATE', workflow_id, ...)`

---

## Error Handling

| Error Code / Condition | Returned / Raised | Message |
|------------------------|-------------------|---------|
| Duplicate workflow name | EXCEPTION | 'Workflow name already exists: {name}' |
| Identity provider not found | EXCEPTION | 'Identity provider ID {id} not found or disabled' |
| User type not found | EXCEPTION | 'User type ID {id} not found' |
| Invalid regex pattern | EXCEPTION | 'Invalid regex pattern: {pattern}' |
| Invalid detection method SK | EXCEPTION | 'Invalid detection method SK: {sk}' |
| Invalid creation mode SK | EXCEPTION | 'Invalid account creation mode SK: {sk}' |

---

## SQL Implementation

```sql
CREATE OR REPLACE FUNCTION fn_workflow_create(
    p_workflow_name VARCHAR(150),
    p_identity_provider_id BIGINT,
    p_user_type_id INTEGER DEFAULT NULL,
    p_detection_pattern VARCHAR(255) DEFAULT NULL,
    p_pattern_priority INTEGER DEFAULT 100,
    p_detection_method_sk INTEGER DEFAULT NULL,
    p_account_creation_mode_sk INTEGER DEFAULT NULL,
    p_field_import_config JSONB DEFAULT '{}',
    p_permitted_reverse_lookup_fields JSONB DEFAULT '[]',
    p_alias_generation_pattern VARCHAR(255) DEFAULT NULL,
    p_created_by INTEGER
)
RETURNS TABLE(
    workflow_id BIGINT,
    workflow_name VARCHAR(150),
    status_sk INTEGER,
    message TEXT
)
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
    v_new_workflow_id BIGINT;
    v_workflow_data JSONB;
BEGIN
    -- Validation: Check workflow name uniqueness
    IF EXISTS (SELECT 1 FROM workflows WHERE workflows.workflow_name = p_workflow_name) THEN
        RAISE EXCEPTION 'Workflow name already exists: %', p_workflow_name;
    END IF;

    -- Validation: Check identity provider exists and is enabled
    IF NOT EXISTS (
        SELECT 1 FROM identity_providers 
        WHERE identity_provider_id = p_identity_provider_id 
        AND is_enabled = true
    ) THEN
        RAISE EXCEPTION 'Identity provider ID % not found or disabled', p_identity_provider_id;
    END IF;

    -- Validation: Check user type exists if provided
    IF p_user_type_id IS NOT NULL THEN
        IF NOT EXISTS (SELECT 1 FROM user_types WHERE user_type_id = p_user_type_id) THEN
            RAISE EXCEPTION 'User type ID % not found', p_user_type_id;
        END IF;
    END IF;

    -- Validation: Check detection method SK exists in lookup
    IF p_detection_method_sk IS NOT NULL AND NOT EXISTS (
        SELECT 1 FROM lookup WHERE sk = p_detection_method_sk AND type = 'detection_method_sk'
    ) THEN
        RAISE EXCEPTION 'Invalid detection method SK: %', p_detection_method_sk;
    END IF;

    -- Validation: Check account creation mode SK exists in lookup
    IF p_account_creation_mode_sk IS NOT NULL AND NOT EXISTS (
        SELECT 1 FROM lookup WHERE sk = p_account_creation_mode_sk AND type = 'account_creation_mode_sk'
    ) THEN
        RAISE EXCEPTION 'Invalid account creation mode SK: %', p_account_creation_mode_sk;
    END IF;

    -- Validation: Pattern priority must be positive
    IF p_pattern_priority <= 0 THEN
        RAISE EXCEPTION 'Pattern priority must be positive';
    END IF;

    -- Insert new workflow
    INSERT INTO workflows (
        workflow_name,
        identity_provider_id,
        user_type_id,
        detection_pattern,
        pattern_priority,
        detection_method_sk,
        account_creation_mode_sk,
        field_import_config,
        permitted_reverse_lookup_fields,
        alias_generation_pattern,
        is_global,
        is_enabled,
        status_sk,
        created_by,
        updated_by
    ) VALUES (
        p_workflow_name,
        p_identity_provider_id,
        p_user_type_id,
        p_detection_pattern,
        COALESCE(p_pattern_priority, 100),
        COALESCE(p_detection_method_sk, (SELECT sk FROM lookup WHERE type = 'detection_method_sk' AND value = 'Regex')),
        COALESCE(p_account_creation_mode_sk, (SELECT sk FROM lookup WHERE type = 'account_creation_mode_sk' AND value = 'Auto Create')),
        COALESCE(p_field_import_config, '{}'),
        COALESCE(p_permitted_reverse_lookup_fields, '[]'),
        p_alias_generation_pattern,
        true,
        true,
        (SELECT sk FROM lookup WHERE type = 'workflow_status_sk' AND value = 'Active'),
        p_created_by,
        p_created_by
    )
    RETURNING workflows.workflow_id INTO v_new_workflow_id;

    -- Build audit data
    v_workflow_data := jsonb_build_object(
        'workflow_id', v_new_workflow_id,
        'workflow_name', p_workflow_name,
        'identity_provider_id', p_identity_provider_id,
        'user_type_id', p_user_type_id,
        'detection_pattern', p_detection_pattern,
        'account_creation_mode_sk', p_account_creation_mode_sk
    );

    -- Audit logging
    INSERT INTO staff_audit_log (
        staff_member_id,
        changed_by,
        action,
        field_name,
        new_value,
        new_values
    ) VALUES (
        p_created_by::uuid,
        p_created_by::uuid,
        'CREATE',
        'workflows',
        'Workflow created: ' || p_workflow_name,
        v_workflow_data
    );

    -- Return result
    RETURN QUERY
    SELECT 
        v_new_workflow_id,
        p_workflow_name,
        (SELECT sk FROM lookup WHERE type = 'workflow_status_sk' AND value = 'Active'),
        'Workflow created successfully'::TEXT;

EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Error creating workflow: %', SQLERRM;
END;
$$;
```

---

## Example Call

```sql
SELECT * FROM fn_workflow_create(
    'Library Card Authentication'::VARCHAR(150),
    2::BIGINT,                    -- identity_provider_id (SIP2)
    1::INTEGER,                   -- user_type_id (Patron)
    '^[0-9]{10}$'::VARCHAR(255),  -- detection_pattern
    10::INTEGER,                  -- pattern_priority
    (SELECT sk FROM lookup WHERE type = 'detection_method_sk' AND value = 'Regex'),  -- detection_method_sk
    (SELECT sk FROM lookup WHERE type = 'account_creation_mode_sk' AND value = 'Auto Create'),  -- account_creation_mode_sk
    '{"patron_name": "full_name", "patron_email": "email"}'::JSONB,
    '["email", "phone"]'::JSONB,
    NULL,
    1::INTEGER                    -- created_by
);
```

---

## Related Functions / Triggers

| Related Object | Relationship |
|----------------|--------------|
| `fn_workflow_update` | Update existing workflow |
| `fn_workflow_test` | Test workflow pattern matching |
| `fn_workflow_enable_at_location` | Enable workflow at location |
| `fn_authenticate_user` | Uses workflow for auth routing |

---

## Notes for Developer

- Patterns evaluated in priority order (lower = higher priority)
- First matching workflow wins unless multi-workflow processing enabled
- Workflows NOT tied to Segments - routing determined at Location + Identity Provider level
- Field import config maps external provider fields to system user fields
- Permitted reverse lookup fields is array of field names allowing reverse lookup
