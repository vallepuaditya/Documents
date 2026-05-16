# p_staff_members

## Function Name

**Function:** `public.p_staff_members(...)`

**Purpose:** CRUD operations for staff members including role assignments

**Called By:** Admin Portal API staff management endpoints

---

## Signature

```sql
CREATE OR REPLACE FUNCTION public.p_staff_members(
    p_mode VARCHAR,
    p_id UUID DEFAULT NULL,
    p_first_name VARCHAR DEFAULT NULL,
    p_last_name VARCHAR DEFAULT NULL,
    p_email VARCHAR DEFAULT NULL,
    p_phone VARCHAR DEFAULT NULL,
    p_auth_method VARCHAR DEFAULT 'local',
    p_password_hash TEXT DEFAULT NULL,
    p_status VARCHAR DEFAULT NULL,
    p_role_id UUID DEFAULT NULL,
    p_branch_sk INTEGER DEFAULT NULL,
    p_actor_id UUID DEFAULT NULL,
    p_username VARCHAR DEFAULT NULL
)
RETURNS TABLE(
    result_code VARCHAR,
    result_message TEXT,
    staff_id UUID,
    data JSONB
)
LANGUAGE plpgsql
AS $$
```

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `p_mode` | `VARCHAR` | YES | Operation mode (SELECT/INSERT/UPDATE/DELETE/ASSIGN_ROLE/REVOKE_ROLE) |
| `p_id` | `UUID` | Conditional | Staff member ID (for update/delete/role operations) |
| `p_first_name` | `VARCHAR` | Conditional | First name (insert/update) |
| `p_last_name` | `VARCHAR` | Conditional | Last name (insert/update) |
| `p_email` | `VARCHAR` | Conditional | Email address (insert/update) |
| `p_phone` | `VARCHAR` | NO | Phone number |
| `p_auth_method` | `VARCHAR` | NO | `local` or `ldap` (default: local) |
| `p_password_hash` | `TEXT` | Conditional | Bcrypt hash (required for local auth) |
| `p_status` | `VARCHAR` | NO | `active` or `inactive` |
| `p_role_id` | `UUID` | Conditional | Role ID (for role operations) |
| `p_branch_sk` | `INTEGER` | Conditional | Branch SK (for role assignment) |
| `p_actor_id` | `UUID` | NO | User performing the action (for audit) |
| `p_username` | `VARCHAR` | Conditional | Username (insert/update) |

**Return Type:** `TABLE` - Result with status code, message, staff_id, and data

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
- Email must be unique
- Username must be unique
- Password hash required for local auth

**UPDATE:**
- Staff member must exist and not be inactive

**ASSIGN_ROLE:**
- Staff member and role must exist

**REVOKE_ROLE:**
- Active role assignment must exist

**DELETE:**
- Staff member must exist

---

## Main Logic Steps

### SELECT Mode:
1. Query all staff members (excluding inactive)
2. For each staff member, aggregate role assignments
3. Return JSONB array with full details

### INSERT Mode:
1. Validate email uniqueness
2. Validate username uniqueness
3. Validate password hash if local auth
4. Insert staff member record
5. Log to audit table
6. Return created record

### UPDATE Mode:
1. Update staff member fields (only provided values)
2. Log to audit table
3. Return updated record

### ASSIGN_ROLE Mode:
1. Insert or reactivate role assignment
2. Handle branch-specific or global assignment
3. Log to audit table
4. Return success

### REVOKE_ROLE Mode:
1. Mark role assignment as inactive
2. Set revoked_by and revoked_at
3. Match by role_id and branch_sk
4. Log to audit table
5. Return success

### DELETE Mode:
1. Set status to 'inactive'
2. Revoke all role assignments
3. Log to audit table
4. Return success

---

## Waitlist Behavior

- `[ ]` This function does not interact with waitlists
- Staff management only

---

## Audit Logging

| Audit Action | Logged To | Fields Captured |
|--------------|-----------|-----------------|
| INSERT | `staff_audit_log` | `action='INSERT'`, `new_value=email` |
| UPDATE | `staff_audit_log` | `action='UPDATE'` |
| ASSIGN_ROLE | `staff_audit_log` | `action='ASSIGN_ROLE'`, `new_value=role_id` |
| REVOKE_ROLE | `staff_audit_log` | `action='REVOKE_ROLE'`, `old_value=role_id` |
| DELETE | `staff_audit_log` | `action='DELETE'`, `new_value='inactive'` |

---

## Error Handling

| Error Code / Condition | Returned | Message |
|------------------------|----------|---------|
| `CONFLICT` (email) | TABLE ROW | `A staff member with this email already exists.` |
| `CONFLICT` (username) | TABLE ROW | `Username already taken.` |
| `VALIDATION_ERROR` | TABLE ROW | `Password is required for local authentication.` |
| `NOT_FOUND` | TABLE ROW | `Staff member not found.` |
| `INVALID_MODE` | TABLE ROW | `Use SELECT\|INSERT\|UPDATE\|DELETE\|ASSIGN_ROLE\|REVOKE_ROLE` |

---

## SQL Implementation

```sql
CREATE OR REPLACE FUNCTION public.p_staff_members(...)
RETURNS TABLE(...)
LANGUAGE plpgsql
AS $function$
DECLARE
    v_id    UUID;
    v_data  JSONB;
BEGIN
    IF p_mode = 'SELECT' THEN
        -- Query with role aggregation
    ELSIF p_mode = 'INSERT' THEN
        -- Validate and insert
    ELSIF p_mode = 'UPDATE' THEN
        -- Update fields
    ELSIF p_mode = 'ASSIGN_ROLE' THEN
        -- Upsert role assignment
    ELSIF p_mode = 'REVOKE_ROLE' THEN
        -- Mark assignment inactive
    ELSIF p_mode = 'DELETE' THEN
        -- Soft delete
    END IF;
END;
$function$
```

---

## Example Call

```sql
-- Get all staff members
SELECT * FROM p_staff_members('SELECT');

-- Create new staff member
SELECT * FROM p_staff_members(
    p_mode := 'INSERT',
    p_first_name := 'John',
    p_last_name := 'Doe',
    p_email := 'john.doe@library.org',
    p_username := 'jdoe',
    p_password_hash := '$2b$12$...',
    p_auth_method := 'local',
    p_actor_id := 'admin-uuid'
);

-- Assign role to staff member
SELECT * FROM p_staff_members(
    p_mode := 'ASSIGN_ROLE',
    p_id := 'staff-uuid',
    p_role_id := 'role-uuid',
    p_branch_sk := 1,
    p_actor_id := 'admin-uuid'
);

-- Soft delete staff member
SELECT * FROM p_staff_members(
    p_mode := 'DELETE',
    p_id := 'staff-uuid',
    p_actor_id := 'admin-uuid'
);
```

---

## Related Functions / Triggers

| Related Object | Relationship |
|----------------|--------------|
| `staff_members` table | Primary CRUD operations |
| `staff_role_assignments` table | Manages role assignments |
| `staff_audit_log` table | Logs all changes |
| `p_staff_auth` | Uses staff_members for authentication |

---

## Notes for Developer

- **Soft delete:** DELETE mode sets status='inactive', doesn't remove record
- **Role assignments:** ASSIGN_ROLE uses ON CONFLICT to handle reactivation
- **Branch-specific roles:** Role can be assigned globally (branch_sk=NULL) or per-branch
- **Constraint:** `uq_staff_role_branch` ensures unique role+branch combinations
- **Email/username:** Both converted to lowercase and trimmed
- **Password hashing:** Must be done in API layer before calling function
- **Audit trail:** All operations logged with actor_id for accountability
- **Role aggregation:** SELECT mode includes all active role assignments per staff member
