# fn_workstation_management

## Function Name

**Function:** `public.fn_workstation_management(...)`

**Purpose:** Comprehensive CRUD operations for workstation/system management

**Called By:** Admin Portal API workstation management endpoints

---

## Signature

```sql
CREATE OR REPLACE FUNCTION public.fn_workstation_management(
    p_mode INTEGER,
    p_system_id INTEGER DEFAULT NULL,
    p_branch_sk INTEGER DEFAULT NULL,
    p_resource_group_id INTEGER DEFAULT NULL,
    p_system_type_sk INTEGER DEFAULT NULL,
    p_resource_type_id INTEGER DEFAULT NULL,
    p_system_code VARCHAR DEFAULT NULL,
    p_system_name VARCHAR DEFAULT NULL,
    p_is_active BOOLEAN DEFAULT TRUE,
    p_current_status workstation_status_enum DEFAULT NULL,
    p_created_by INTEGER DEFAULT NULL,
    p_updated_by INTEGER DEFAULT NULL
)
RETURNS TABLE(
    system_id INTEGER,
    branch_sk INTEGER,
    resource_group_id INTEGER,
    system_type_sk INTEGER,
    resource_type_id INTEGER,
    system_code VARCHAR,
    system_name VARCHAR,
    is_active BOOLEAN,
    current_status workstation_status_enum,
    created_at TIMESTAMPTZ,
    updated_at TIMESTAMPTZ,
    created_by INTEGER,
    updated_by INTEGER
)
LANGUAGE plpgsql
AS $$
```

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `p_mode` | `INTEGER` | YES | Operation mode (1-8) |
| `p_system_id` | `INTEGER` | Conditional | Workstation ID |
| `p_branch_sk` | `INTEGER` | Conditional | Branch/location SK |
| `p_resource_group_id` | `INTEGER` | Conditional | Resource group ID |
| `p_system_type_sk` | `INTEGER` | Conditional | System type SK |
| `p_resource_type_id` | `INTEGER` | Conditional | Resource type ID (FK to resource_types) |
| `p_system_code` | `VARCHAR` | Conditional | Unique system code |
| `p_system_name` | `VARCHAR` | Conditional | Display name |
| `p_is_active` | `BOOLEAN` | NO | Active status (default: true) |
| `p_current_status` | `workstation_status_enum` | Conditional | Current status |
| `p_created_by` | `INTEGER` | NO | Creating user |
| `p_updated_by` | `INTEGER` | NO | Updating user |

**Return Type:** `TABLE` - Workstation record(s)

**Modes:**
- `1` - Create new workstation
- `2` - Update workstation details
- `3` - Get single workstation by ID
- `4` - Get all workstations (optionally filtered)
- `5` - Deactivate workstation (soft delete)
- `6` - List workstations by branch
- `7` - List workstations by resource group
- `8` - Admin status change (AVAILABLE/OFFLINE/MAINTENANCE only)

**Workstation Status Enum:**
- `AVAILABLE` - Ready for use
- `IN_USE` - Currently in session
- `RESERVED` - Reserved for upcoming session
- `OFFLINE` - Not operational
- `MAINTENANCE` - Under maintenance

---

## Transaction Behavior

| Aspect | Value |
|--------|-------|
| Runs inside transaction | YES |
| Rollback scope | Full operation |
| Savepoint usage | None |

---

## Preconditions / Validation

**Mode 1 (Create):**
- All required fields must be provided
- system_code must be unique

**Mode 2 (Update):**
- system_id must be provided
- Workstation must exist

**Mode 3 (Get):**
- system_id must be provided

**Mode 5 (Deactivate):**
- system_id must be provided
- Workstation must not have status 'IN_USE'

**Mode 6 (List by Branch):**
- branch_sk must be provided

**Mode 7 (List by Resource Group):**
- resource_group_id must be provided

**Mode 8 (Admin Status Change):**
- system_id must be provided
- Status must be AVAILABLE, OFFLINE, or MAINTENANCE (not IN_USE or RESERVED)

---

## Main Logic Steps

### Mode 1: Create Workstation
1. Validate all required parameters
2. Insert new workstation record
3. Set default status to AVAILABLE
4. Return created record

### Mode 2: Update Workstation
1. Validate system_id provided
2. Update provided fields using COALESCE
3. Set updated_at and updated_by
4. Return updated record

### Mode 3: Get Single Workstation
1. Query workstation by system_id
2. Return record

### Mode 4: Get All Workstations
1. Query all workstations (optionally filtered)
2. Order by system_code
3. Return records

### Mode 5: Deactivate Workstation
1. Validate system_id provided
2. Check workstation is not IN_USE
3. Set is_active=FALSE
4. Set current_status=OFFLINE
5. Return updated record

### Mode 6: List by Branch
1. Validate branch_sk provided
2. Query workstations for branch
3. Filter for is_active=TRUE
4. Order by system_code
5. Return records

### Mode 7: List by Resource Group
1. Validate resource_group_id provided
2. Query workstations for resource group
3. Filter for is_active=TRUE
4. Order by system_code
5. Return records

### Mode 8: Admin Status Change
1. Validate system_id and status provided
2. Validate status is not IN_USE or RESERVED
3. Validate workstation exists
4. Update current_status
5. Return updated record

---

## Waitlist Behavior

- `[ ]` This function does not directly trigger waitlist promotion
- Workstation status changes may affect availability for waiting reservations
- External process checks availability and promotes waitlist

---

## Audit Logging

| Audit Action | Logged To | Fields Captured |
|--------------|-----------|-----------------|
| Created/Updated | `work_stations` | `created_by`, `updated_by`, `created_at`, `updated_at` |

---

## Error Handling

| Error Code / Condition | Returned / Raised | Message |
|------------------------|-------------------|---------|
| `MISSING_REQUIRED_FIELD` | EXCEPTION | `{field} is required for mode {mode}` |
| `UNIQUE_VIOLATION` | EXCEPTION | Database constraint error |
| `WORKSTATION_NOT_FOUND` | EXCEPTION | `No workstation with id {system_id}` |
| `HAS_ACTIVE_SESSION` | EXCEPTION | `Cannot deactivate a workstation that is IN_USE. Force logout first.` |
| `STATUS_NOT_ALLOWED` | EXCEPTION | `Cannot manually set IN_USE or RESERVED. These are set by session logic.` |
| `INVALID_MODE` | EXCEPTION | `{mode} not supported. Valid modes: 1-8` |

---

## SQL Implementation

```sql
CREATE OR REPLACE FUNCTION public.fn_workstation_management(...)
RETURNS TABLE(...)
LANGUAGE plpgsql
AS $function$
BEGIN
    IF p_mode = 1 THEN
        -- Create workstation
        RETURN QUERY
        INSERT INTO work_stations (...) VALUES (...)
        RETURNING *;
        
    ELSIF p_mode = 2 THEN
        -- Update workstation
        RETURN QUERY
        UPDATE work_stations ws SET
            branch_sk = COALESCE(p_branch_sk, ws.branch_sk),
            resource_group_id = COALESCE(p_resource_group_id, ws.resource_group_id),
            system_type_sk = COALESCE(p_system_type_sk, ws.system_type_sk),
            resource_type_id = COALESCE(p_resource_type_id, ws.resource_type_id),
            system_code = COALESCE(p_system_code, ws.system_code),
            system_name = COALESCE(p_system_name, ws.system_name),
            is_active = COALESCE(p_is_active, ws.is_active),
            updated_by = COALESCE(p_updated_by, ws.updated_by),
            updated_at = now()
        WHERE ws.system_id = p_system_id
        RETURNING *;
        
    ELSIF p_mode = 5 THEN
        -- Deactivate (soft delete)
        IF EXISTS (
            SELECT 1 FROM work_stations wsd
            WHERE wsd.system_id = p_system_id
              AND wsd.current_status = 'IN_USE'
        ) THEN
            RAISE EXCEPTION 'HAS_ACTIVE_SESSION: Cannot deactivate a workstation that is IN_USE. Force logout first.';
        END IF;
        
        RETURN QUERY
        UPDATE work_stations ws SET
            is_active = FALSE,
            current_status = 'OFFLINE',
            updated_by = COALESCE(p_updated_by, ws.updated_by),
            updated_at = now()
        WHERE ws.system_id = p_system_id
        RETURNING *;
        
    ELSIF p_mode = 8 THEN
        -- Admin status change
        IF p_current_status IN ('IN_USE', 'RESERVED') THEN
            RAISE EXCEPTION 'STATUS_NOT_ALLOWED: Cannot manually set IN_USE or RESERVED. These are set by session logic.';
        END IF;
        
        RETURN QUERY
        UPDATE work_stations ws SET
            current_status = p_current_status,
            updated_by = COALESCE(p_updated_by, ws.updated_by),
            updated_at = now()
        WHERE ws.system_id = p_system_id
        RETURNING *;
    END IF;
END;
$function$
```

---

## Example Call

```sql
-- Create workstation
SELECT * FROM fn_workstation_management(
    p_mode := 1,
    p_branch_sk := 1,
    p_resource_group_id := 10,
    p_system_type_sk := 5,
    p_system_code := 'WS-001',
    p_system_name := 'Computer 1',
    p_created_by := 1
);

-- Update workstation
SELECT * FROM fn_workstation_management(
    p_mode := 2,
    p_system_id := 123,
    p_system_name := 'Computer 1A',
    p_updated_by := 1
);

-- List all workstations for a branch
SELECT * FROM fn_workstation_management(
    p_mode := 6,
    p_branch_sk := 1
);

-- Set workstation to maintenance
SELECT * FROM fn_workstation_management(
    p_mode := 8,
    p_system_id := 123,
    p_current_status := 'MAINTENANCE',
    p_updated_by := 1
);

-- Deactivate workstation
SELECT * FROM fn_workstation_management(
    p_mode := 5,
    p_system_id := 123,
    p_updated_by := 1
);
```

---

## Related Functions / Triggers

| Related Object | Relationship |
|----------------|--------------|
| `work_stations` table | Primary CRUD operations |
| `promote_waiting_list` | Uses workstation availability |
| Session management functions | Update IN_USE/RESERVED status |
| `check_system_availability` | Checks workstation for reservations |

---

## Notes for Developer

- **Status restrictions:** IN_USE and RESERVED can only be set by session management logic
- **Soft delete:** Mode 5 sets is_active=FALSE instead of deleting
- **Active session check:** Cannot deactivate workstation currently in use
- **Branch/group filtering:** Modes 6 and 7 for location-specific queries
- **COALESCE updates:** Only updates provided fields in mode 2
- **Unique constraint:** system_code must be unique across all workstations
- **Status enum:** Uses PostgreSQL enum type for status validation
- **Resource group:** Links workstation to specific resource pool
- **System type:** Categorizes workstation capabilities (e.g., standard, gaming, accessible)
- **Multiple modes:** Single function handles all CRUD operations for consistency
