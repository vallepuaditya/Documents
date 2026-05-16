# p_staff_permissions

## Function Name

**Function:** `public.p_staff_permissions(...)`

**Purpose:** CRUD operations for staff permissions (system capabilities)

**Called By:** Admin Portal API permissions management endpoints

---

## Signature

```sql
CREATE OR REPLACE FUNCTION public.p_staff_permissions(
    p_mode VARCHAR,
    p_id UUID DEFAULT NULL,
    p_permission_key VARCHAR DEFAULT NULL,
    p_display_name VARCHAR DEFAULT NULL,
    p_description TEXT DEFAULT NULL,
    p_actor_id UUID DEFAULT NULL
)
RETURNS TABLE(
    result_code VARCHAR,
    result_message TEXT,
    permission_id UUID,
    data JSONB
)
LANGUAGE plpgsql
AS $$
```

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `p_mode` | `VARCHAR` | YES | Operation mode (SELECT/INSERT/UPDATE/DELETE) |
| `p_id` | `UUID` | Conditional | Permission ID (update/delete) |
| `p_permission_key` | `VARCHAR` | Conditional | Unique permission key (insert) |
| `p_display_name` | `VARCHAR` | Conditional | User-friendly name (insert/update) |
| `p_description` | `TEXT` | NO | Permission description |
| `p_actor_id` | `UUID` | NO | User performing the action |

**Return Type:** `TABLE` - Result with status code, message, permission_id, and data

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
- permission_key must be unique

**UPDATE:**
- Permission must exist and be active

**DELETE:**
- Permission must not be a default system permission
- Permission must not be assigned to any roles

---

## Main Logic Steps

### SELECT Mode:
1. Query all active permissions
2. Order by creation date
3. Return JSONB array

### INSERT Mode:
1. Check permission_key uniqueness (case-insensitive)
2. Insert new permission
3. Return created record

### UPDATE Mode:
1. Update display_name and/or description
2. Return updated record

### DELETE Mode:
1. Validate permission is not a system default
2. Check permission is not assigned to roles
3. Set is_active = FALSE (soft delete)
4. Return success

---

## Waitlist Behavior

- `[ ]` This function does not interact with waitlists
- Permissions management only

---

## Audit Logging

| Audit Action | Logged To | Fields Captured |
|--------------|-----------|-----------------|
| Created/Updated | `staff_permissions` | `created_by`, `updated_by`, `created_at`, `updated_at` |

---

## Error Handling

| Error Code / Condition | Returned | Message |
|------------------------|----------|---------|
| `CONFLICT` | TABLE ROW | `Permission key already exists.` |
| `NOT_FOUND` | TABLE ROW | `Permission not found.` |
| `FORBIDDEN` | TABLE ROW | `Default system permissions cannot be deleted.` |
| `CONFLICT` (assigned) | TABLE ROW | `Cannot delete — permission is assigned to one or more roles.` |
| `INVALID_MODE` | TABLE ROW | `Use SELECT \| INSERT \| UPDATE \| DELETE` |

---

## Default System Permissions

The following permissions cannot be deleted:
- `patron_management`
- `reservation_management`
- `system_configuration`
- `reporting`

---

## SQL Implementation

```sql
CREATE OR REPLACE FUNCTION public.p_staff_permissions(...)
RETURNS TABLE(...)
LANGUAGE plpgsql
AS $function$
DECLARE
    v_id    UUID;
    v_data  JSONB;
    v_key   VARCHAR(50);
BEGIN
    IF p_mode = 'SELECT' THEN
        -- Query all active permissions
    ELSIF p_mode = 'INSERT' THEN
        -- Validate uniqueness and insert
    ELSIF p_mode = 'UPDATE' THEN
        -- Update fields
    ELSIF p_mode = 'DELETE' THEN
        -- Validate and soft delete
    END IF;
END;
$function$
```

---

## Example Call

```sql
-- Get all permissions
SELECT * FROM p_staff_permissions('SELECT');

-- Create new permission
SELECT * FROM p_staff_permissions(
    p_mode := 'INSERT',
    p_permission_key := 'manage_events',
    p_display_name := 'Manage Events',
    p_description := 'Create and manage library events',
    p_actor_id := 'admin-uuid'
);

-- Update permission
SELECT * FROM p_staff_permissions(
    p_mode := 'UPDATE',
    p_id := 'permission-uuid',
    p_display_name := 'Event Management',
    p_description := 'Full event management capabilities',
    p_actor_id := 'admin-uuid'
);

-- Delete permission
SELECT * FROM p_staff_permissions(
    p_mode := 'DELETE',
    p_id := 'permission-uuid',
    p_actor_id := 'admin-uuid'
);
```

---

## Related Functions / Triggers

| Related Object | Relationship |
|----------------|--------------|
| `staff_permissions` table | Primary CRUD operations |
| `staff_role_permissions` table | Links permissions to roles |
| `p_staff_roles` | Assigns permissions to roles |

---

## Notes for Developer

- **Soft delete:** DELETE sets is_active=FALSE, doesn't remove record
- **Protected permissions:** System defaults cannot be deleted
- **Cascade check:** Cannot delete if assigned to any role
- **Key normalization:** permission_key stored as lowercase
- **Display name:** User-facing label in admin UI
- **Permission model:** Fine-grained capabilities that compose into roles
- **Extensibility:** New permissions can be added dynamically
