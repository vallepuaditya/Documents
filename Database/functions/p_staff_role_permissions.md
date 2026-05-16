# p_staff_role_permissions

## Function Name

**Function:** `public.p_staff_role_permissions(...)`

**Purpose:** Manages permission assignments to roles

**Called By:** Admin Portal API role-permission management endpoints

---

## Signature

```sql
CREATE OR REPLACE FUNCTION public.p_staff_role_permissions(
    p_mode TEXT,
    p_role_id UUID DEFAULT NULL,
    p_permission_id UUID DEFAULT NULL,
    p_permission_ids UUID[] DEFAULT NULL,
    p_actor_id UUID DEFAULT NULL
)
RETURNS JSON
LANGUAGE plpgsql
AS $$
```

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `p_mode` | `TEXT` | YES | Operation mode |
| `p_role_id` | `UUID` | Conditional | Role to query/update |
| `p_permission_id` | `UUID` | NO | Single permission (deprecated) |
| `p_permission_ids` | `UUID[]` | Conditional | Array of permissions to sync |
| `p_actor_id` | `UUID` | NO | User performing the action |

**Return Type:** `JSON` - Result with status and data

**Modes:**
- `GET_BY_ROLE` - Get all permissions assigned to a role
- `GET_ALL_ROLES_WITH_PERMISSIONS` - Get all roles and all permissions (for UI matrix)
- `SYNC_PERMISSIONS` - Replace all permissions for a role

---

## Transaction Behavior

| Aspect | Value |
|--------|-------|
| Runs inside transaction | YES |
| Rollback scope | Full operation |
| Savepoint usage | None |

---

## Preconditions / Validation

**GET_BY_ROLE:**
- role_id must be provided

**GET_ALL_ROLES_WITH_PERMISSIONS:**
- None

**SYNC_PERMISSIONS:**
- role_id must be provided
- p_permission_ids can be empty array (removes all permissions)

---

## Main Logic Steps

### GET_BY_ROLE Mode:
1. Query permissions assigned to role
2. Join with permissions table for details
3. Return JSON array of permissions

### GET_ALL_ROLES_WITH_PERMISSIONS Mode:
1. Query all active permissions (for reference list)
2. Query all active roles
3. For each role, aggregate assigned permissions
4. Return JSON with both full permission list and role assignments

### SYNC_PERMISSIONS Mode:
1. Delete all existing permission assignments for role
2. If p_permission_ids provided and not empty, insert new assignments
3. Use UNNEST to insert multiple permissions in one statement
4. Return success message

---

## Waitlist Behavior

- `[ ]` This function does not interact with waitlists
- Permission management only

---

## Audit Logging

| Audit Action | Logged To | Fields Captured |
|--------------|-----------|-----------------|
| Permissions assigned | `staff_role_permissions` | `assigned_by`, `assigned_at` |

**Note:** Deletions are permanent (not soft delete) since this is a many-to-many mapping table.

---

## Error Handling

| Error Code / Condition | Returned | Message |
|------------------------|----------|---------|
| `INVALID_MODE` | JSON ERROR | `Use GET_BY_ROLE \| GET_ALL_ROLES_WITH_PERMISSIONS \| SYNC_PERMISSIONS` |

---

## SQL Implementation

```sql
CREATE OR REPLACE FUNCTION public.p_staff_role_permissions(...)
RETURNS json
LANGUAGE plpgsql
AS $function$
BEGIN
    IF p_mode = 'GET_BY_ROLE' THEN
        RETURN (
            SELECT json_build_object(
                'result_code', 'SUCCESS',
                'data', COALESCE(json_agg(...), '[]'::json)
            )
            FROM staff_role_permissions srp
            JOIN staff_permissions sp ON sp.id = srp.permission_id
            WHERE srp.role_id = p_role_id
        );

    ELSIF p_mode = 'GET_ALL_ROLES_WITH_PERMISSIONS' THEN
        RETURN (
            SELECT json_build_object(
                'all_permissions', (...),
                'roles', COALESCE(json_agg(...), '[]'::json)
            )
            FROM staff_roles r
        );

    ELSIF p_mode = 'SYNC_PERMISSIONS' THEN
        DELETE FROM staff_role_permissions WHERE role_id = p_role_id;
        
        IF p_permission_ids IS NOT NULL AND array_length(p_permission_ids, 1) > 0 THEN
            INSERT INTO staff_role_permissions (role_id, permission_id, assigned_by, assigned_at)
            SELECT p_role_id, UNNEST(p_permission_ids), p_actor_id, NOW();
        END IF;
        
        RETURN json_build_object('result_code', 'SUCCESS', ...);
    END IF;
END;
$function$
```

---

## Example Call

```sql
-- Get permissions for a role
SELECT p_staff_role_permissions(
    p_mode := 'GET_BY_ROLE',
    p_role_id := 'role-uuid'
);

-- Get all roles with permissions (for permission matrix UI)
SELECT p_staff_role_permissions(
    p_mode := 'GET_ALL_ROLES_WITH_PERMISSIONS'
);

-- Sync permissions for a role
SELECT p_staff_role_permissions(
    p_mode := 'SYNC_PERMISSIONS',
    p_role_id := 'role-uuid',
    p_permission_ids := ARRAY['perm-1'::UUID, 'perm-2'::UUID, 'perm-3'::UUID],
    p_actor_id := 'admin-uuid'
);

-- Remove all permissions from a role
SELECT p_staff_role_permissions(
    p_mode := 'SYNC_PERMISSIONS',
    p_role_id := 'role-uuid',
    p_permission_ids := ARRAY[]::UUID[],
    p_actor_id := 'admin-uuid'
);
```

---

## Related Functions / Triggers

| Related Object | Relationship |
|----------------|--------------|
| `staff_role_permissions` table | Primary operations |
| `staff_roles` table | References roles |
| `staff_permissions` table | References permissions |
| `p_staff_roles` | Calls this during UPDATE mode |

---

## Notes for Developer

- **Sync pattern:** SYNC_PERMISSIONS deletes all then recreates (not incremental merge)
- **UNNEST usage:** Inserts multiple permissions in single statement
- **Empty array:** Passing empty array removes all permissions from role
- **NULL vs empty:** NULL means don't change, empty array means remove all
- **UI matrix:** GET_ALL_ROLES_WITH_PERMISSIONS designed for permission matrix UI
- **No soft delete:** Mapping table uses hard delete (DELETE not UPDATE)
- **Constraint:** uq_staff_role_permission ensures unique role+permission combinations
