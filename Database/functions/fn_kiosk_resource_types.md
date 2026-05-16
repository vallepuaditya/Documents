# fn_kiosk_resource_types

## Function Name

**Function:** `public.fn_kiosk_resource_types(p_category_id integer)`

**Purpose:** Returns all active resource types within a category for kiosk type selection screen

**Called By:** Kiosk API - Resource type selection endpoint

---

## Signature

```sql
CREATE OR REPLACE FUNCTION public.fn_kiosk_resource_types(p_category_id INTEGER)
RETURNS TABLE(
    resource_type_id INTEGER,
    type_name VARCHAR,
    description VARCHAR,
    icon_key VARCHAR,
    display_order INTEGER,
    default_duration_minutes INTEGER,
    waitlist_enabled BOOLEAN
)
LANGUAGE plpgsql
STABLE PARALLEL SAFE
AS $$
```

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `p_category_id` | `INTEGER` | YES | Category ID to filter resource types |

**Return Type:** `TABLE` - Returns rows of resource type information

| Column | Type | Description |
|--------|------|-------------|
| `resource_type_id` | `INTEGER` | Type unique identifier |
| `type_name` | `VARCHAR` | Type display name |
| `description` | `VARCHAR` | Type description |
| `icon_key` | `VARCHAR` | Icon identifier for UI |
| `display_order` | `INTEGER` | Sort order for display |
| `default_duration_minutes` | `INTEGER` | Default reservation duration |
| `waitlist_enabled` | `BOOLEAN` | Whether waitlist is enabled for this type |

---

## Transaction Behavior

| Aspect | Value |
|--------|-------|
| Runs inside transaction | YES |
| Rollback scope | Read-only operation |
| Savepoint usage | None |

---

## Preconditions / Validation

- `p_category_id` must not be NULL
- Category must exist and be active

---

## Main Logic Steps

1. Validate `p_category_id` is not NULL
2. Check category exists and is active in `resource_categories`
3. Query `resource_types` for all active types in the category
4. Order by display_order and type_name
5. Return result set

---

## Waitlist Behavior

- `[ ]` This function does not directly manage waitlists
- Returns `waitlist_enabled` flag to indicate if type supports waitlisting

---

## Audit Logging

| Audit Action | Logged To | Fields Captured |
|--------------|-----------|-----------------|
| N/A | N/A | Read-only operation - no audit logging |

---

## Error Handling

| Error Code / Condition | Returned / Raised | Message |
|------------------------|-------------------|---------|
| `MISSING_CATEGORY_ID` | EXCEPTION | `p_category_id is required` |
| `CATEGORY_NOT_FOUND` | EXCEPTION | `No active category with id {p_category_id}` |

---

## SQL Implementation

```sql
CREATE OR REPLACE FUNCTION public.fn_kiosk_resource_types(p_category_id integer)
 RETURNS TABLE(
    resource_type_id integer,
    type_name character varying,
    description character varying,
    icon_key character varying,
    display_order integer,
    default_duration_minutes integer,
    waitlist_enabled boolean
 )
 LANGUAGE plpgsql
 STABLE PARALLEL SAFE
AS $function$
BEGIN
    IF p_category_id IS NULL THEN
        RAISE EXCEPTION 'MISSING_CATEGORY_ID: p_category_id is required';
    END IF;

    IF NOT EXISTS (
        SELECT 1 FROM public.resource_categories
        WHERE category_id = p_category_id
          AND status      = 'active'
    ) THEN
        RAISE EXCEPTION 'CATEGORY_NOT_FOUND: No active category with id %', p_category_id;
    END IF;

    RETURN QUERY
    SELECT
        rt.resource_type_id,
        rt.type_name,
        rt.description,
        rt.icon_key,
        rt.display_order,
        rt.default_duration_minutes,
        rt.waitlist_enabled
    FROM public.resource_types rt
    WHERE
        rt.category_id = p_category_id
        AND rt.status  = 'active'
    ORDER BY
        rt.display_order ASC,
        rt.type_name     ASC;
END;
$function$
```

---

## Example Call

```sql
-- Get all types in the 'computers' category (category_id = 1)
SELECT * FROM fn_kiosk_resource_types(1);

-- Result:
-- resource_type_id | type_name          | description              | icon_key | display_order | default_duration_minutes | waitlist_enabled
-- -----------------|--------------------|--------------------------| ---------|---------------|--------------------------|------------------
-- 1                | Desktop Computer   | Standard desktop PC      | desktop  | 1             | 60                       | true
-- 2                | Laptop             | Portable laptop computer | laptop   | 2             | 120                      | true
-- 3                | Gaming Station     | High-performance gaming  | gamepad  | 3             | 90                       | false

-- Invalid category raises exception
SELECT * FROM fn_kiosk_resource_types(9999);
-- ERROR: CATEGORY_NOT_FOUND: No active category with id 9999
```

---

## Related Functions / Triggers

| Related Object | Relationship |
|----------------|--------------|
| `resource_categories` table | Validates category exists |
| `resource_types` table | Queries types |
| `fn_kiosk_resource_categories()` | Called before this in kiosk flow |
| `fn_kiosk_resources()` | Called next in kiosk flow |

---

## Notes for Developer

- **Location-independent:** Does NOT filter by location - shows all types globally
- **Availability handled later:** Resource availability is checked in `fn_kiosk_resources()` or `fn_kiosk_resources_availability()`
- **resource_count removed:** Previous versions included count - now removed to avoid confusion
- **Parallel safe:** Can be executed in parallel query contexts
- **Stable function:** Reads from database but doesn't modify data
- **Duration importance:** `default_duration_minutes` is critical for reservation calculations
- **Waitlist flag:** Frontend uses this to show/hide waitlist options
- **Inactive types excluded:** Only shows types where status='active'
- **Sort priority:** Primary by display_order, secondary by type_name alphabetically
