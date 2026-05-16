# fn_kiosk_resource_addons

## Function Name

**Function:** `public.fn_kiosk_resource_addons(p_resource_id integer, p_location_id integer)`

**Purpose:** Returns a resource and its linked addon resource (if any) for kiosk resource detail view

**Called By:** Kiosk API - Resource detail endpoint

---

## Signature

```sql
CREATE OR REPLACE FUNCTION public.fn_kiosk_resource_addons(
    p_resource_id INTEGER,
    p_location_id INTEGER
)
RETURNS TABLE(
    role VARCHAR,
    resource_id INTEGER,
    resource_name VARCHAR,
    resource_type_id INTEGER,
    type_name VARCHAR,
    category_id INTEGER,
    category_name VARCHAR,
    category_code VARCHAR,
    area_id INTEGER,
    area_name VARCHAR,
    location_id INTEGER,
    description VARCHAR,
    resource_status_sk INTEGER,
    status_label VARCHAR,
    pc_audience VARCHAR,
    compound_role VARCHAR,
    resource_metadata JSONB
)
LANGUAGE plpgsql
STABLE PARALLEL SAFE
AS $$
```

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `p_resource_id` | `INTEGER` | YES | Resource to query |
| `p_location_id` | `INTEGER` | YES | Location to validate |

**Return Type:** `TABLE` - Returns 1-2 rows (self + linked resource if exists)

---

## Transaction Behavior

| Aspect | Value |
|--------|-------|
| Runs inside transaction | YES |
| Rollback scope | Read-only operation |
| Savepoint usage | None |

---

## Preconditions / Validation

- `p_resource_id` must not be NULL
- `p_location_id` must not be NULL
- Resource must exist at the specified location
- Resource area must be active

---

## Main Logic Steps

1. **Validate Parameters:** Check both parameters provided
2. **Validate Resource Location:** Ensure resource exists at location
3. **Return Self:** First row returns the requested resource with role='self'
4. **Find Linked Resource:** Check resource_addons for bidirectional link
5. **Return Linked:** Second row returns linked resource with role='linked' (if exists)

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
| `MISSING_RESOURCE_ID` | EXCEPTION | `p_resource_id is required` |
| `MISSING_LOCATION_ID` | EXCEPTION | `p_location_id is required` |
| `RESOURCE_NOT_FOUND_AT_LOCATION` | EXCEPTION | `Resource % not found at this location` |

---

## SQL Implementation

```sql
CREATE OR REPLACE FUNCTION public.fn_kiosk_resource_addons(
    p_resource_id integer,
    p_location_id integer
)
RETURNS TABLE(...)
LANGUAGE plpgsql
STABLE PARALLEL SAFE
AS $function$
DECLARE
    v_linked_id INTEGER;
BEGIN
    -- Validations
    IF p_resource_id IS NULL THEN
        RAISE EXCEPTION 'MISSING_RESOURCE_ID: p_resource_id is required';
    END IF;

    IF p_location_id IS NULL THEN
        RAISE EXCEPTION 'MISSING_LOCATION_ID: p_location_id is required';
    END IF;

    -- Validate resource exists at location
    IF NOT EXISTS (
        SELECT 1
        FROM public.resources r
        JOIN public.resource_areas ra ON ra.area_id = r.area_id
        WHERE r.resource_id = p_resource_id
          AND ra.location_id = p_location_id
          AND ra.status = 'active'
    ) THEN
        RAISE EXCEPTION 'RESOURCE_NOT_FOUND_AT_LOCATION: Resource % not found at this location', p_resource_id;
    END IF;

    -- Return self
    RETURN QUERY
    SELECT 'self'::VARCHAR(10), ...
    FROM public.resources r
    WHERE r.resource_id = p_resource_id;

    -- Find and return linked resource
    SELECT COALESCE(ad1.addon_resource_id, ad2.primary_resource_id)
    INTO v_linked_id
    FROM public.resource_addons ad1
    LEFT JOIN public.resource_addons ad2 ON ad2.addon_resource_id = p_resource_id
    WHERE (ad1.primary_resource_id = p_resource_id AND ad1.is_active = TRUE)
       OR (ad2.addon_resource_id = p_resource_id AND ad2.is_active = TRUE)
    LIMIT 1;

    IF v_linked_id IS NOT NULL THEN
        RETURN QUERY
        SELECT 'linked'::VARCHAR(10), ...
        FROM public.resources r2
        WHERE r2.resource_id = v_linked_id;
    END IF;
END;
$function$
```

---

## Example Call

```sql
-- Get resource and its addon
SELECT * FROM fn_kiosk_resource_addons(45, 1);

-- Result:
-- role    | resource_id | resource_name | ...
-- --------|-------------|---------------|----
-- self    | 45          | Computer #1   | ...
-- linked  | 46          | Headphones #1 | ...
```

---

## Related Functions / Triggers

| Related Object | Relationship |
|----------------|--------------|
| `resources` table | Queries resource details |
| `resource_addons` table | Finds linked resources |
| `resource_areas` table | Validates location |
| `fn_kiosk_create_reservation()` | Uses this to validate linked resources |

---

## Notes for Developer

- **Bidirectional linking:** Checks both primary→addon and addon→primary directions
- **Role indicator:** 'self' for requested resource, 'linked' for addon
- **Complete details:** Returns full resource information including category, type, area
- **Location validation:** Ensures resource actually exists at the location
- **Active areas only:** Filters out resources in inactive areas
- **Single linked resource:** Assumes max one linked resource per primary
- **LIMIT 1 safety:** Prevents multiple links (though schema should enforce this)
- **Metadata included:** Returns resource_metadata JSONB for custom attributes
