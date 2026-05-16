# fn_kiosk_resources

## Function Name

**Function:** `public.fn_kiosk_resources(p_resource_type_id integer, p_location_id integer)`

**Purpose:** Returns all bookable resources of a specific type at a location for kiosk resource selection screen

**Called By:** Kiosk API - Resource selection endpoint

---

## Signature

```sql
CREATE OR REPLACE FUNCTION public.fn_kiosk_resources(
    p_resource_type_id INTEGER,
    p_location_id INTEGER
)
RETURNS TABLE(
    resource_id INTEGER,
    resource_name VARCHAR,
    description VARCHAR,
    resource_status_sk INTEGER,
    status_label VARCHAR,
    pc_audience VARCHAR,
    compound_role VARCHAR,
    has_addon BOOLEAN,
    linked_resource_id INTEGER,
    area_id INTEGER,
    area_name VARCHAR,
    resource_metadata JSONB
)
LANGUAGE plpgsql
STABLE PARALLEL SAFE
AS $$
```

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `p_resource_type_id` | `INTEGER` | YES | Resource type to filter |
| `p_location_id` | `INTEGER` | YES | Location to filter resources |

**Return Type:** `TABLE` - Returns rows of resource information

---

## Transaction Behavior

| Aspect | Value |
|--------|-------|
| Runs inside transaction | YES |
| Rollback scope | Read-only operation |
| Savepoint usage | None |

---

## Preconditions / Validation

- `p_resource_type_id` must not be NULL
- `p_location_id` must not be NULL
- Resource type must exist and be active

---

## Main Logic Steps

1. Validate both required parameters are provided
2. Verify resource type exists and is active
3. Query resources matching type and location
4. Filter for bookable resources (standalone or primary compound_role)
5. Filter for available or reserved status (SK: 46, 47)
6. Check for linked addon resources
7. Join with areas and lookup tables
8. Order by status and name
9. Return result set

---

## Waitlist Behavior

- `[ ]` This function does not interact with waitlists
- Read-only query function

---

## Audit Logging

| Audit Action | Logged To | Fields Captured |
|--------------|-----------|-----------------|
| N/A | N/A | Read-only operation - no audit logging |

---

## Error Handling

| Error Code / Condition | Returned / Raised | Message |
|------------------------|-------------------|---------|
| `MISSING_RESOURCE_TYPE_ID` | EXCEPTION | `p_resource_type_id is required` |
| `MISSING_LOCATION_ID` | EXCEPTION | `p_location_id is required` |
| `RESOURCE_TYPE_NOT_FOUND` | EXCEPTION | `No active resource type with id {p_resource_type_id}` |

---

## SQL Implementation

```sql
CREATE OR REPLACE FUNCTION public.fn_kiosk_resources(
    p_resource_type_id integer,
    p_location_id integer
)
RETURNS TABLE(...)
LANGUAGE plpgsql
STABLE PARALLEL SAFE
AS $function$
BEGIN
    -- Validations
    IF p_resource_type_id IS NULL THEN
        RAISE EXCEPTION 'MISSING_RESOURCE_TYPE_ID: p_resource_type_id is required';
    END IF;

    IF p_location_id IS NULL THEN
        RAISE EXCEPTION 'MISSING_LOCATION_ID: p_location_id is required';
    END IF;

    -- Query resources with linkage detection
    RETURN QUERY
    SELECT
        r.resource_id,
        r.resource_name,
        r.description,
        r.resource_status_sk,
        lk.value AS status_label,
        r.pc_audience,
        r.compound_role,
        EXISTS(...) AS has_addon,
        (...) AS linked_resource_id,
        ra.area_id,
        ra.area_name,
        r.resource_metadata
    FROM public.resources r
    JOIN public.resource_areas ra ON ra.area_id = r.area_id
    WHERE r.resource_type_id = p_resource_type_id
      AND ra.location_id = p_location_id
      AND r.resource_status_sk IN (46, 47)
      AND r.compound_role IN ('standalone', 'primary')
    ORDER BY r.resource_status_sk ASC, r.resource_name ASC;
END;
$function$
```

---

## Example Call

```sql
-- Get all desktop computers at location 1
SELECT * FROM fn_kiosk_resources(1, 1);

-- Result shows resources with their addon status
```

---

## Related Functions / Triggers

| Related Object | Relationship |
|----------------|--------------|
| `resources` table | Queries resources |
| `resource_areas` table | Joins for location filtering |
| `resource_addons` table | Checks for linked resources |
| `fn_kiosk_resource_types()` | Called before this in kiosk flow |
| `fn_kiosk_resources_availability()` | More detailed availability checking |

---

## Notes for Developer

- **Compound role filter:** Only shows `standalone` and `primary` resources (not `linked` or `addon`)
- **Status filter:** Hardcoded to SK values 46, 47 (Available, Reserved statuses)
- **Location-specific:** Filters by location through resource_areas join
- **Addon detection:** Uses EXISTS and subquery to detect if resource has addons
- **Linked resource ID:** Returns the ID of linked resource if one exists
- **Metadata included:** Returns resource_metadata JSONB for custom attributes
- **Status label:** Joins with lookup table to get human-readable status
- **Sort order:** Primary by status (available first), secondary by name
