# p_staff_roles

## Function Name

**Function:** `public.p_staff_roles(...)`

**Purpose:** CRUD operations for staff roles with permission management

**Called By:** Admin Portal API roles management endpoints

---

## Signature

```sql
CREATE OR REPLACE FUNCTION public.p_staff_roles(
    p_mode VARCHAR,
    p_id UUID DEFAULT NULL,
    p_role_name VARCHAR DEFAULT NULL,
    p_description TEXT DEFAULT NULL,
    p_permission_ids UUID[] DEFAULT NULL,
    p_actor_id UUID DEFAULT NULL
)
RETURNS TABLE(
    result_code VARCHAR,
    result_message TEXT,
    role_id UUID,
    data JSONB
)
LANGUAGE plpgsql
AS $$
```

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `p_mode` | `VARCHAR` | YES | Operation mode |
| `p_id` | `UUID` | Conditional | Role ID (update/delete) |
| `p_role_name` | `VARCHAR` | Conditional | Role name (insert/update) |
| `p_description` | `TEXT` | NO | Role description |
| `p_permission_ids` | `UUID[]` | NO | Array of permission IDs to assign |
| `p_actor_id` | `UUID` | NO | User performing the action |

**Return Type:** `TABLE` - Result with status code, message, role_id, and data

**Modes:**
- `SELECT` - Get all roles with permissions
- `SELECT_WITH_STAFF_ASSIGNMENTS` - Get roles with staff assignments
- `INSERT` - Create new role with permissions
- `UPDATE` - Update role and replace permissions
- `DELETE` - Soft delete role (if not assigned)

---

## Transaction Behavior

| Aspect | Value |
|--------|-------|
| Runs inside transaction | YES |
| Rollback scope | Full operation |
| Savepoint usage | None |

---

## Preconditions / Validation

**INSERT:**
- Role name must be unique (case-insensitive)

**UPDATE:**
- Role must exist and be active

**DELETE:**
- Role cannot be 'administrator'
- Role must not have active staff assignments

---

## Main Logic Steps

### SELECT Mode:
1. Query all active roles
2. For each role, aggregate assigned permissions
3. Return JSONB array

### SELECT_WITH_STAFF_ASSIGNMENTS Mode:
1. Query all active roles
2. Aggregate permissions per role
3. Aggregate staff assignments (with branch info)
4. Return JSONB array

### INSERT Mode:
1. Validate role name uniqueness
2. Insert role record
3. Insert permission assignments (if provided)
4. Return created role

### UPDATE Mode:
1. Update role name and/or description
2. Delete existing permission assignments
3. Insert new permission assignments
4. Return updated role

### DELETE Mode:
1. Validate role is not 'administrator'
2. Check for active staff assignments
3. Set is_active = FALSE
4. Return success

---

## Waitlist Behavior

- `[ ]` This function does not interact with waitlists
- Role management only

---

## Audit Logging

| Audit Action | Logged To | Fields Captured |
|--------------|-----------|-----------------|
| Created/Updated | `staff_roles` | `created_by`, `updated_by`, timestamps |
| Permission changes | `staff_role_permissions` | `assigned_by`, `assigned_at` |

---

## Error Handling

| Error Code / Condition | Returned | Message |
|------------------------|----------|---------|
| `CONFLICT` | TABLE ROW | `A role with this name already exists.` |
| `NOT_FOUND` | TABLE ROW | `Role not found.` |
| `FORBIDDEN` | TABLE ROW | `Administrator role cannot be deleted.` |
| `CONFLICT` (assigned) | TABLE ROW | `Cannot delete — staff members are assigned to this role.` |
| `INVALID_MODE` | TABLE ROW | `Use SELECT \| SELECT_WITH_STAFF_ASSIGNMENTS \| INSERT \| UPDATE \| DELETE` |

---

## SQL Implementation

```sql
CREATE OR REPLACE FUNCTION public.p_staff_roles(...)
RETURNS TABLE(...)
LANGUAGE plpgsql
AS $function$
DECLARE
    v_id        UUID;
    v_data      JSONB;
    v_role_name VARCHAR(50);
BEGIN
    IF p_mode = 'SELECT' THEN
        -- Query roles with permissions
    ELSIF p_mode = 'SELECT_WITH_STAFF_ASSIGNMENTS' THEN
        -- Query with staff assignment details
    ELSIF p_mode = 'INSERT' THEN
        -- Create role and assign permissions
    ELSIF p_mode = 'UPDATE' THEN
        -- Update role and sync permissions
    ELSIF p_mode = 'DELETE' THEN
        -- Validate and soft delete
    END IF;
END;
$function$
```

---

## Example Call

```sql
-- Get all roles
SELECT * FROM p_staff_roles('SELECT');

-- Get roles with staff assignments
SELECT * FROM p_staff_roles('SELECT_WITH_STAFF_ASSIGNMENTS');

-- Create new role
SELECT * FROM p_staff_roles(
    p_mode := 'INSERT',
    p_role_name := 'librarian',
    p_description := 'Standard librarian role',
    p_permission_ids := ARRAY['perm-uuid-1'::UUID, 'perm-uuid-2'::UUID],
    p_actor_id := 'admin-uuid'
);

-- Update role permissions
SELECT * FROM p_staff_roles(
    p_mode := 'UPDATE',
    p_id := 'role-uuid',
    p_role_name := 'senior_librarian',
    p_permission_ids := ARRAY['perm-uuid-1'::UUID, 'perm-uuid-3'::UUID],
    p_actor_id := 'admin-uuid'
);

-- Delete role
SELECT * FROM p_staff_roles(
    p_mode := 'DELETE',
    p_id := 'role-uuid',
    p_actor_id := 'admin-uuid'
);
```

---

## Related Functions / Triggers

| Related Object | Relationship |
|----------------|--------------|
| `staff_roles` table | Primary CRUD operations |
| `staff_role_permissions` table | Manages role-permission mappings |
| `staff_role_assignments` table | Links roles to staff members |
| `p_staff_members` | Uses roles for staff assignment |

---

## Notes for Developer

- **Protected role:** 'administrator' role cannot be deleted
- **Soft delete:** DELETE sets is_active=FALSE
- **Permission sync:** UPDATE replaces all permissions (not merge)
- **Array handling:** p_permission_ids can be NULL or empty array
- **Role name:** Stored as lowercase
- **ON CONFLICT:** Uses uq_staff_role_permission constraint
- **Staff assignments:** SELECT_WITH_STAFF_ASSIGNMENTS shows branch-specific assignments
- **Cascade protection:** Cannot delete role with active staff assignments
