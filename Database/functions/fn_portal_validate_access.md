# PostgreSQL Function: fn_portal_validate_access

## Function Name

**Function:** `fn_portal_validate_access(p_portal_id, p_user_id)`

**Purpose:** Validates whether a user has permission to access a specific portal based on user type, tier, group, and portal configuration.

**Called By:** Portal authentication middleware

---

## Signature

```sql
CREATE OR REPLACE FUNCTION fn_portal_validate_access(
    p_portal_id BIGINT,
    p_user_id INTEGER
)
RETURNS TABLE(
    has_access BOOLEAN,
    reason TEXT,
    allowed_reservation_types JSONB
)
LANGUAGE plpgsql
SECURITY INVOKER
AS $$
```

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `p_portal_id` | `BIGINT` | YES | Portal to validate access for |
| `p_user_id` | `INTEGER` | YES | User attempting to access portal |

**Return Type:** `TABLE(has_access BOOLEAN, reason TEXT, allowed_reservation_types JSONB)`

---

## Transaction Behavior

| Aspect | Value |
|--------|-------|
| Runs inside transaction | NO |
| Rollback scope | N/A - Read-only |
| Savepoint usage | None |

---

## Preconditions / Validation

- Portal must exist and be active
- User must exist and be active

---

## Main Logic Steps

1. Retrieve portal configuration
2. Retrieve user details (user_type_id, user_tier_id, user_group_id)
3. Check portal is active
4. Check user type allowed (if portal has restrictions)
5. Check user tier allowed (if portal has restrictions)
6. Check user group allowed (if portal has restrictions)
7. Return access decision with reason
8. Return allowed reservation types for this user

---

## Waitlist Behavior

- [x] Not applicable - access validation function

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
| Portal not found | RETURN FALSE | 'Portal not found' |
| Portal inactive | RETURN FALSE | 'Portal is not active' |
| User not found | RETURN FALSE | 'User not found' |
| User type not allowed | RETURN FALSE | 'User type not permitted for this portal' |
| User tier not allowed | RETURN FALSE | 'User tier not permitted for this portal' |
| User group not allowed | RETURN FALSE | 'User group not permitted for this portal' |

---

## SQL Implementation

```sql
CREATE OR REPLACE FUNCTION fn_portal_validate_access(
    p_portal_id BIGINT,
    p_user_id INTEGER
)
RETURNS TABLE(
    has_access BOOLEAN,
    reason TEXT,
    allowed_reservation_types JSONB
)
LANGUAGE plpgsql
SECURITY INVOKER
AS $$
DECLARE
    v_portal RECORD;
    v_user RECORD;
    v_allowed_types JSONB;
BEGIN
    -- Get portal details
    SELECT 
        p.portal_id,
        p.is_active,
        p.status_sk,
        p.allowed_user_types,
        p.allowed_user_tiers,
        p.allowed_user_groups,
        p.allowed_reservation_types
    INTO v_portal
    FROM access_portals p
    WHERE p.portal_id = p_portal_id;

    -- Check portal exists
    IF NOT FOUND THEN
        RETURN QUERY SELECT false, 'Portal not found'::TEXT, NULL::JSONB;
        RETURN;
    END IF;

    -- Check portal is active
    IF NOT v_portal.is_active OR v_portal.status_sk != (SELECT sk FROM lookup WHERE type = 'portal_status_sk' AND value = 'active') THEN
        RETURN QUERY SELECT false, 'Portal is not active'::TEXT, NULL::JSONB;
        RETURN;
    END IF;

    -- Get user details
    SELECT 
        u.id,
        u.user_type_id,
        u.user_tier_id,
        u.user_group_id,
        u.status
    INTO v_user
    FROM users u
    WHERE u.id = p_user_id;

    -- Check user exists
    IF NOT FOUND THEN
        RETURN QUERY SELECT false, 'User not found'::TEXT, NULL::JSONB;
        RETURN;
    END IF;

    -- Check user is active
    IF v_user.status != 'active' THEN
        RETURN QUERY SELECT false, 'User account is not active'::TEXT, NULL::JSONB;
        RETURN;
    END IF;

    -- Check user type allowed (if portal has restrictions)
    IF v_portal.allowed_user_types IS NOT NULL 
       AND jsonb_array_length(v_portal.allowed_user_types) > 0 THEN
        IF NOT (v_portal.allowed_user_types @> to_jsonb(v_user.user_type_id)) THEN
            RETURN QUERY SELECT false, 'User type not permitted for this portal'::TEXT, NULL::JSONB;
            RETURN;
        END IF;
    END IF;

    -- Check user tier allowed (if portal has restrictions)
    IF v_portal.allowed_user_tiers IS NOT NULL 
       AND jsonb_array_length(v_portal.allowed_user_tiers) > 0 THEN
        IF NOT (v_portal.allowed_user_tiers @> to_jsonb(v_user.user_tier_id)) THEN
            RETURN QUERY SELECT false, 'User tier not permitted for this portal'::TEXT, NULL::JSONB;
            RETURN;
        END IF;
    END IF;

    -- Check user group allowed (if portal has restrictions)
    IF v_portal.allowed_user_groups IS NOT NULL 
       AND jsonb_array_length(v_portal.allowed_user_groups) > 0 THEN
        IF NOT (v_portal.allowed_user_groups @> to_jsonb(v_user.user_group_id)) THEN
            RETURN QUERY SELECT false, 'User group not permitted for this portal'::TEXT, NULL::JSONB;
            RETURN;
        END IF;
    END IF;

    -- All checks passed - grant access
    v_allowed_types := COALESCE(v_portal.allowed_reservation_types, '["scheduled","walkup","waitlist"]');

    RETURN QUERY SELECT true, 'Access granted'::TEXT, v_allowed_types;

EXCEPTION
    WHEN OTHERS THEN
        RETURN QUERY SELECT false, ('Error validating access: ' || SQLERRM)::TEXT, NULL::JSONB;
END;
$$;
```

---

## Example Call

```sql
-- Validate user access to portal
SELECT * FROM fn_portal_validate_access(
    1::BIGINT,    -- portal_id
    101::INTEGER  -- user_id
);

-- Result:
-- has_access | reason         | allowed_reservation_types
-- -----------|----------------|---------------------------
-- true       | Access granted | ["scheduled","waitlist"]
```

---

## Related Functions / Triggers

| Related Object | Relationship |
|----------------|--------------|
| `fn_portal_create` | Creates portal with access restrictions |
| `fn_authenticate_user` | Called after authentication to validate portal access |

---

## Notes for Developer

- Empty/null allowed_* arrays in portal config means "all allowed"
- Access validation happens after authentication
- Returns allowed reservation types specific to this user at this portal
- User tier and type permissions enforced at portal level
- In consortium environments, permissions may vary by selected site/location
