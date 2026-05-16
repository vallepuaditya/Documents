# PostgreSQL Function: fn_workflow_match_pattern

## Function Name

**Function:** `fn_workflow_match_pattern(p_location_id, p_user_input)`

**Purpose:** Matches user input against enabled workflows at a location to determine the appropriate authentication workflow based on detection patterns and priority.

**Called By:** Authentication Controller during login process

---

## Signature

```sql
CREATE OR REPLACE FUNCTION fn_workflow_match_pattern(
    p_location_id INTEGER,
    p_user_input VARCHAR(255)
)
RETURNS TABLE(
    workflow_id BIGINT,
    workflow_name VARCHAR(150),
    identity_provider_id BIGINT,
    user_type_id INTEGER,
    account_creation_mode_sk INTEGER,
    field_import_config JSONB
)
LANGUAGE plpgsql
SECURITY INVOKER
AS $$
```

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `p_location_id` | `INTEGER` | YES | Location where authentication is attempted |
| `p_user_input` | `VARCHAR(255)` | YES | User credential input (barcode, username, etc.) |

**Return Type:** `TABLE(workflow_id, workflow_name, identity_provider_id, user_type_id, account_creation_mode_sk, field_import_config)`

---

## Transaction Behavior

| Aspect | Value |
|--------|-------|
| Runs inside transaction | NO |
| Rollback scope | N/A - Read-only |
| Savepoint usage | None |

---

## Preconditions / Validation

- Location must exist
- User input must not be empty
- At least one workflow must be enabled at location

---

## Main Logic Steps

1. Retrieve enabled workflows for the location (via location_workflows)
2. Order workflows by priority (lower = higher priority)
3. For each workflow in priority order:
   - Apply detection method (regex, prefix, exact)
   - If pattern matches, return this workflow
4. If no match found, return NULL/empty result
5. First match wins

---

## Waitlist Behavior

- [x] Not applicable - authentication helper function

---

## Audit Logging

| Audit Action | Logged To | Fields Captured |
|--------------|-----------|-----------------|
| N/A | N/A | Read-only function - no audit needed |

**Audit helper used:** None - read-only

---

## Error Handling

| Error Code / Condition | Returned / Raised | Message |
|------------------------|-------------------|---------|
| Location not found | EXCEPTION | 'Location ID {id} not found' |
| No enabled workflows | RETURN NULL | Empty result set |
| Invalid regex pattern | EXCEPTION | 'Invalid regex in workflow pattern' |

---

## SQL Implementation

```sql
CREATE OR REPLACE FUNCTION fn_workflow_match_pattern(
    p_location_id INTEGER,
    p_user_input VARCHAR(255)
)
RETURNS TABLE(
    workflow_id BIGINT,
    workflow_name VARCHAR(150),
    identity_provider_id BIGINT,
    user_type_id INTEGER,
    account_creation_mode_sk INTEGER,
    field_import_config JSONB,
    permitted_reverse_lookup_fields JSONB
)
LANGUAGE plpgsql
SECURITY INVOKER
AS $$
DECLARE
    v_workflow RECORD;
    v_pattern_match BOOLEAN;
    v_detection_method VARCHAR(50);
BEGIN
    -- Validation: Check location exists
    IF NOT EXISTS (SELECT 1 FROM locations WHERE location_id = p_location_id) THEN
        RAISE EXCEPTION 'Location ID % not found', p_location_id;
    END IF;

    -- Loop through enabled workflows for this location, ordered by priority
    FOR v_workflow IN
        SELECT 
            w.workflow_id,
            w.workflow_name,
            w.identity_provider_id,
            w.user_type_id,
            w.detection_pattern,
            w.detection_method_sk,
            w.account_creation_mode_sk,
            w.field_import_config,
            w.permitted_reverse_lookup_fields,
            COALESCE(lw.priority_override, w.pattern_priority) as effective_priority
        FROM workflows w
        LEFT JOIN location_workflows lw ON w.workflow_id = lw.workflow_id 
            AND lw.location_id = p_location_id
        WHERE w.is_enabled = true
        AND w.status_sk = (SELECT sk FROM lookup WHERE type = 'workflow_status_sk' AND value = 'Active')
        AND (
            -- Global workflows enabled at location
            (w.is_global = true AND lw.is_enabled = true)
            OR
            -- Location-specific workflows
            (w.is_global = false AND lw.location_id = p_location_id AND lw.is_enabled = true)
        )
        ORDER BY effective_priority ASC, w.workflow_id ASC
    LOOP
        -- Get detection method value from lookup
        SELECT value INTO v_detection_method
        FROM lookup
        WHERE sk = v_workflow.detection_method_sk;

        -- Apply detection method
        v_pattern_match := false;
        
        CASE v_detection_method
            WHEN 'Regex' THEN
                -- Regex pattern matching
                IF v_workflow.detection_pattern IS NOT NULL THEN
                    v_pattern_match := p_user_input ~ v_workflow.detection_pattern;
                ELSE
                    -- No pattern means match all
                    v_pattern_match := true;
                END IF;
            
            WHEN 'Prefix' THEN
                -- Prefix matching
                IF v_workflow.detection_pattern IS NOT NULL THEN
                    v_pattern_match := p_user_input LIKE v_workflow.detection_pattern || '%';
                ELSE
                    v_pattern_match := true;
                END IF;
            
            WHEN 'Exact' THEN
                -- Exact matching
                IF v_workflow.detection_pattern IS NOT NULL THEN
                    v_pattern_match := p_user_input = v_workflow.detection_pattern;
                ELSE
                    v_pattern_match := true;
                END IF;
            
            ELSE
                -- Default to no match for unknown methods
                v_pattern_match := false;
        END CASE;

        -- If pattern matched, return this workflow (first match wins)
        IF v_pattern_match THEN
            RETURN QUERY
            SELECT 
                v_workflow.workflow_id,
                v_workflow.workflow_name,
                v_workflow.identity_provider_id,
                v_workflow.user_type_id,
                v_workflow.account_creation_mode_sk,
                v_workflow.field_import_config,
                v_workflow.permitted_reverse_lookup_fields;
            RETURN; -- Exit function after first match
        END IF;
    END LOOP;

    -- No match found - return empty result
    RETURN;

EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Error matching workflow pattern: %', SQLERRM;
END;
$$;
```

---

## Example Call

```sql
-- Match library card barcode (10 digits)
SELECT * FROM fn_workflow_match_pattern(
    1::INTEGER,           -- location_id
    '1234567890'::VARCHAR(255)  -- user_input (library card)
);

-- Match student ID (prefix STU)
SELECT * FROM fn_workflow_match_pattern(
    1::INTEGER,
    'STU98765'::VARCHAR(255)
);
```

---

## Related Functions / Triggers

| Related Object | Relationship |
|----------------|--------------|
| `fn_authenticate_user` | Calls this to determine workflow |
| `fn_workflow_create` | Creates workflows |
| `fn_workflow_enable_at_location` | Enables workflows at locations |

---

## Notes for Developer

- First match wins - patterns evaluated in priority order
- Priority can be overridden at location level via location_workflows.priority_override
- Empty/null detection_pattern means "match all" for that workflow
- Regex errors caught and raised as exceptions
- Returns empty set if no workflows match
- Does not process multiple workflows - authentication controller handles multi-workflow logic if needed
