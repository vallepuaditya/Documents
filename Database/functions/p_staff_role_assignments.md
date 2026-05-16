# p_staff_role_assignments

## Function Name

**Function:** `public.p_staff_role_assignments(...)`

**Purpose:** Manages staff role assignments with location/branch-level granularity

**Called By:** Admin Portal API role assignment endpoints

---

## Signature

```sql
CREATE OR REPLACE FUNCTION public.p_staff_role_assignments(
    p_mode TEXT,
    p_staff_member_id UUID DEFAULT NULL,
    p_role_id UUID DEFAULT NULL,
    p_branch_sks INTEGER[] DEFAULT NULL,
    p_all_branches BOOLEAN DEFAULT FALSE,
    p_actor_id UUID DEFAULT NULL
)
RETURNS JSON
LANGUAGE plpgsql
AS $$
```

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `p_mode` | `TEXT` | YES | Operation mode |
| `p_staff_member_id` | `UUID` | Conditional | Staff member to query/assign |
| `p_role_id` | `UUID` | Conditional | Role to assign |
| `p_branch_sks` | `INTEGER[]` | NO | Array of branch SKs for location-specific assignment |
| `p_all_branches` | `BOOLEAN` | NO | True for global role assignment |
| `p_actor_id` | `UUID` | NO | User performing the action |

**Return Type:** `JSON` - Result with status and data

**Modes:**
- `GET_BY_STAFF` - Get all active role assignments for a staff member
- `GET_ALL` - Get all staff with their role assignments
- `SYNC_BRANCH_ASSIGNMENTS` - Replace all branch assignments for a staff+role combination

---

## Transaction Behavior

| Aspect | Value |
|--------|-------|
| Runs inside transaction | YES |
| Rollback scope | Full operation |
| Savepoint usage | None |

---

## Preconditions / Validation

**GET_BY_STAFF:**
- staff_member_id must be provided

**GET_ALL:**
- None

**SYNC_BRANCH_ASSIGNMENTS:**
- staff_member_id and role_id must be provided
- Either p_all_branches=TRUE or p_branch_sks must be provided

---

## Main Logic Steps

### GET_BY_STAFF Mode:
1. Query active role assignments for staff member
2. Join with roles table for role details
3. Return JSON with assignment details including location_id

### GET_ALL Mode:
1. Query all active staff members
2. Aggregate role assignments per staff member
3. For each staff+role, show if global or branch-specific
4. Return JSON array with all staff and their assignments

### SYNC_BRANCH_ASSIGNMENTS Mode:
1. Revoke all existing assignments for staff+role combination
2. If p_all_branches=TRUE, insert global assignment (location_id=NULL)
3. If p_branch_sks provided, insert one assignment per branch
4. Return success message

---

## Waitlist Behavior

- `[ ]` This function does not interact with waitlists
- Role assignment management only

---

## Audit Logging

| Audit Action | Logged To | Fields Captured |
|--------------|-----------|-----------------|
| Assignment created | `staff_role_assignments` | `assigned_by`, `assigned_at` |
| Assignment revoked | `staff_role_assignments` | `revoked_by`, `revoked_at`, `is_active=FALSE` |

---

## Error Handling

| Error Code / Condition | Returned | Message |
|------------------------|----------|---------|
| `INVALID_MODE` | JSON ERROR | `Use GET_BY_STAFF \| GET_ALL \| SYNC_BRANCH_ASSIGNMENTS` |

---

## Location-Level vs Global Assignments

**Global Assignment (location_id=NULL):**
- Staff member has role at ALL locations
- Used for administrators or roles not location-specific

**Location-Specific Assignment:**
- Staff member has role only at specified locations
- Multiple assignments can exist for same staff+role at different locations

---

## SQL Implementation

```sql
CREATE OR REPLACE FUNCTION public.p_staff_role_assignments(...)
RETURNS json
LANGUAGE plpgsql
AS $function$
BEGIN
    IF p_mode = 'GET_BY_STAFF' THEN
        -- Query assignments for staff member
        RETURN (SELECT json_build_object(...));
        
    ELSIF p_mode = 'GET_ALL' THEN
        -- Aggregate all staff with assignments
        RETURN (SELECT json_build_object(...));
        
    ELSIF p_mode = 'SYNC_BRANCH_ASSIGNMENTS' THEN
        -- Revoke existing
        UPDATE staff_role_assignments SET is_active = FALSE, ...
        
        -- Insert new assignments
        IF p_all_branches = TRUE THEN
            INSERT INTO staff_role_assignments (location_id = NULL);
        ELSIF p_branch_sks IS NOT NULL THEN
            INSERT INTO staff_role_assignments ... UNNEST(p_branch_sks);
        END IF;
        
        RETURN json_build_object('result_code', 'SUCCESS', ...);
    END IF;
END;
$function$
```

---

## Example Call

```sql
-- Get assignments for a staff member
SELECT p_staff_role_assignments(
    p_mode := 'GET_BY_STAFF',
    p_staff_member_id := 'staff-uuid'
);

-- Get all staff with assignments
SELECT p_staff_role_assignments(p_mode := 'GET_ALL');

-- Assign role globally
SELECT p_staff_role_assignments(
    p_mode := 'SYNC_BRANCH_ASSIGNMENTS',
    p_staff_member_id := 'staff-uuid',
    p_role_id := 'role-uuid',
    p_all_branches := TRUE,
    p_actor_id := 'admin-uuid'
);

-- Assign role at specific branches
SELECT p_staff_role_assignments(
    p_mode := 'SYNC_BRANCH_ASSIGNMENTS',
    p_staff_member_id := 'staff-uuid',
    p_role_id := 'role-uuid',
    p_branch_sks := ARRAY[1, 2, 3],
    p_actor_id := 'admin-uuid'
);
```

---

## Related Functions / Triggers

| Related Object | Relationship |
|----------------|--------------|
| `staff_role_assignments` table | Primary operations |
| `staff_members` table | References staff |
| `staff_roles` table | References roles |
| `p_staff_members` | Calls ASSIGN_ROLE/REVOKE_ROLE modes |

---

## Notes for Developer

- **Sync pattern:** SYNC_BRANCH_ASSIGNMENTS revokes all then recreates (not incremental)
- **UNNEST usage:** Inserts multiple branch assignments in single statement
- **NULL location_id:** Indicates global (all branches) assignment
- **Soft revocation:** Sets is_active=FALSE rather than deleting
- **Constraint:** uq_staff_role_branch ensures unique staff+role+branch combinations
- **Array aggregation:** GET_ALL uses array_agg for branch lists
- **bool_or:** Used to detect if any assignment is global
