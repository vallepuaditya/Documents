# fn_kiosk_resource_categories

## Function Name

**Function:** `public.fn_kiosk_resource_categories()`

**Purpose:** Returns all active resource categories with metadata for kiosk category selection screen

**Called By:** Kiosk API - Category selection endpoint

---

## Signature

```sql
CREATE OR REPLACE FUNCTION public.fn_kiosk_resource_categories()
RETURNS TABLE(
    category_id INTEGER,
    category_name VARCHAR,
    display_name VARCHAR,
    icon_key VARCHAR,
    display_order INTEGER,
    type_count BIGINT,
    auto_skip BOOLEAN,
    default_type_id INTEGER
)
LANGUAGE plpgsql
STABLE PARALLEL SAFE
AS $$
```

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| None | N/A | N/A | No input parameters |

**Return Type:** `TABLE` - Returns rows of category information

| Column | Type | Description |
|--------|------|-------------|
| `category_id` | `INTEGER` | Category unique identifier |
| `category_name` | `VARCHAR` | Internal category name |
| `display_name` | `VARCHAR` | User-facing display name |
| `icon_key` | `VARCHAR` | Icon identifier for UI |
| `display_order` | `INTEGER` | Sort order for display |
| `type_count` | `BIGINT` | Number of active types in this category |
| `auto_skip` | `BOOLEAN` | True if category has only one type (skip type selection) |
| `default_type_id` | `INTEGER` | Type ID to auto-select when auto_skip is true |

---

## Transaction Behavior

| Aspect | Value |
|--------|-------|
| Runs inside transaction | YES |
| Rollback scope | Read-only operation |
| Savepoint usage | None |

---

## Preconditions / Validation

- None - function is always safe to call
- Returns empty set if no active categories exist

---

## Main Logic Steps

1. Query `resource_categories` table for active categories
2. LEFT JOIN with `resource_types` to count active types per category
3. Calculate `auto_skip` flag (true when only 1 active type exists)
4. Determine `default_type_id` when auto_skip is true
5. Group by category attributes
6. Order by display_order and category_name
7. Return result set

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
| None | N/A | Function does not raise exceptions |

**Note:** Returns empty result set if no categories exist.

---

## SQL Implementation

```sql
CREATE OR REPLACE FUNCTION public.fn_kiosk_resource_categories()
 RETURNS TABLE(
    category_id integer,
    category_name character varying,
    display_name character varying,
    icon_key character varying,
    display_order integer,
    type_count bigint,
    auto_skip boolean,
    default_type_id integer
 )
 LANGUAGE plpgsql
 STABLE PARALLEL SAFE
AS $function$
BEGIN
    RETURN QUERY
    SELECT
        rc.category_id,
        rc.category_name,
        COALESCE(rc.display_name, rc.category_name) AS display_name,
        rc.icon_key,
        rc.display_order,
        COUNT(DISTINCT rt.resource_type_id) AS type_count,
        (COUNT(DISTINCT rt.resource_type_id) = 1) AS auto_skip,
        CASE
            WHEN COUNT(DISTINCT rt.resource_type_id) = 1
            THEN MIN(rt.resource_type_id)
            ELSE NULL
        END AS default_type_id
    FROM public.resource_categories rc
    LEFT JOIN public.resource_types rt
        ON  rt.category_id = rc.category_id
        AND rt.status      = 'active'
    WHERE rc.status = 'active'
    GROUP BY
        rc.category_id,
        rc.category_name,
        rc.display_name,
        rc.icon_key,
        rc.display_order
    ORDER BY
        rc.display_order ASC,
        rc.category_name ASC;
END;
$function$
```

---

## Example Call

```sql
-- Get all categories for kiosk selection
SELECT * FROM fn_kiosk_resource_categories();

-- Result:
-- category_id | category_name | display_name | icon_key | display_order | type_count | auto_skip | default_type_id
-- ------------|---------------|--------------|----------|---------------|------------|-----------|----------------
-- 1           | computers     | Computers    | desktop  | 1             | 3          | false     | null
-- 2           | study_rooms   | Study Rooms  | room     | 2             | 1          | true      | 5
-- 3           | equipment     | Equipment    | tool     | 3             | 7          | false     | null
```

---

## Related Functions / Triggers

| Related Object | Relationship |
|----------------|--------------|
| `resource_categories` table | Queries categories |
| `resource_types` table | Joins to count types per category |
| `fn_kiosk_resource_types()` | Called next in kiosk flow (unless auto_skip) |

---

## Notes for Developer

- **Global count:** Type count is NOT location-specific - shows all active types globally
- **auto_skip optimization:** When category has only one type, kiosk can skip type selection screen
- **display_name fallback:** Uses category_name if display_name is null
- **Inactive types excluded:** Only counts resource_types where status='active'
- **Parallel safe:** Can be executed in parallel query contexts
- **Stable function:** Reads from database but doesn't modify data
- **UI integration:** icon_key maps to frontend icon library (e.g., Lucide icons)
- **Sort order:** Primary sort by display_order, secondary by category_name
