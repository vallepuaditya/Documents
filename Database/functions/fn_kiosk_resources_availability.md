# fn_kiosk_resources_availability

## Function Name

**Function:** `public.fn_kiosk_resources_availability(...)`

**Purpose:** Returns detailed availability status for all resources of a specific type at a location and time slot

**Called By:** Kiosk API - Resource availability check endpoint

---

## Signature

```sql
CREATE OR REPLACE FUNCTION public.fn_kiosk_resources_availability(
    p_resource_type_id INTEGER,
    p_location_id INTEGER,
    p_reservation_date DATE,
    p_start_time TIME,
    p_booking_mode VARCHAR DEFAULT 'instant'
)
RETURNS JSONB
LANGUAGE plpgsql
AS $$
```

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `p_resource_type_id` | `INTEGER` | YES | Resource type to check |
| `p_location_id` | `INTEGER` | YES | Location to check |
| `p_reservation_date` | `DATE` | YES | Date of desired reservation |
| `p_start_time` | `TIME` | YES | Start time of desired slot |
| `p_booking_mode` | `VARCHAR` | NO | `instant`, `scheduled`, or `specific` (default: instant) |

**Return Type:** `JSONB` - Array of resource availability details

---

## Transaction Behavior

| Aspect | Value |
|--------|-------|
| Runs inside transaction | YES |
| Rollback scope | Read-only operation |
| Savepoint usage | None |

---

## Preconditions / Validation

- All required parameters must be provided
- Resource type must exist and be active
- Booking mode must be valid (`instant`, `scheduled`, `specific`)

---

## Main Logic Steps

1. **Validate Parameters:** Check all required parameters
2. **Validate Booking Mode:** Ensure mode is valid
3. **Get Duration:** Fetch default duration from resource_type
4. **Get Confirmed Status:** Retrieve confirmed reservation status SK from lookup
5. **Calculate Time Slot:** Compute slot_start and slot_end with timezone
6. **Query Candidate Resources:** Get all resources of type at location
7. **Join Linked Resources:** Include addon resource information
8. **Check Primary Overlaps:** Detect if primary resource has conflicting reservations
9. **Check Linked Overlaps:** Detect if linked resource has conflicting reservations
10. **Calculate Availability Status:** Determine status based on resource and reservation state
11. **Determine Selectability:** Set is_selectable flag
12. **Generate Reason:** Create reserved_reason message if not available
13. **Return JSONB Array:** Aggregate all resources into JSONB

---

## Waitlist Behavior

- `[ ]` This function does not interact with waitlists
- Shows current availability status only
- Future: May indicate waitlist option when all resources reserved

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
| `MISSING_RESERVATION_DATE` | EXCEPTION | `p_reservation_date is required` |
| `MISSING_START_TIME` | EXCEPTION | `p_start_time is required` |
| `INVALID_BOOKING_MODE` | EXCEPTION | `must be instant, scheduled, or specific` |
| `RESOURCE_TYPE_NOT_FOUND` | EXCEPTION | `resource_type_id % not found or inactive` |
| `CONFIG_ERROR` | EXCEPTION | `confirmed reservation status not found in lookup` |

---

## Availability Status Values

| Status | Meaning | Selectable |
|--------|---------|------------|
| `available` | Resource is free and operational | Yes |
| `reserved` | Primary resource has conflicting reservation | No |
| `linked_reserved` | Linked resource has conflicting reservation | No |
| `offline` | Primary resource is offline | No |
| `linked_offline` | Linked resource is offline | No |
| `maintenance` | Primary resource under maintenance | No |
| `linked_maintenance` | Linked resource under maintenance | No |
| `unavailable` | Primary resource status not 'Available' | No |
| `linked_unavailable` | Linked resource status not 'Available' | No |

---

## SQL Implementation

```sql
CREATE OR REPLACE FUNCTION public.fn_kiosk_resources_availability(...)
RETURNS jsonb
LANGUAGE plpgsql
AS $function$
DECLARE
    v_duration_minutes integer;
    v_slot_start timestamp with time zone;
    v_slot_end timestamp with time zone;
    v_confirmed_status_sk integer;
    v_result jsonb;
BEGIN
    -- Validations and calculations
    -- Complex CTE-based query with availability logic
    -- Returns JSONB array of resources with detailed status
    
    RETURN v_result;
END;
$function$
```

---

## Example Call

```sql
-- Check availability for desktop computers at location 1
SELECT fn_kiosk_resources_availability(
    p_resource_type_id := 1,
    p_location_id := 1,
    p_reservation_date := CURRENT_DATE,
    p_start_time := '14:00:00',
    p_booking_mode := 'instant'
);

-- Returns JSONB array with detailed status for each resource
```

---

## Related Functions / Triggers

| Related Object | Relationship |
|----------------|--------------|
| `resources` table | Queries resources |
| `resource_types` table | Gets default duration |
| `reservations_new` table | Checks for conflicts |
| `reservation_resources` table | Maps reservations to resources |
| `resource_addons` table | Gets linked resources |
| `fn_kiosk_create_reservation()` | Called after availability confirmed |

---

## Notes for Developer

- **Comprehensive status:** Returns detailed availability information for UI display
- **Timezone handling:** Uses `AT TIME ZONE current_setting('TIMEZONE')` for proper conversion
- **Linked resource checking:** Validates both primary and linked resources are available
- **Status hierarchy:** Offline > Maintenance > Unavailable > Reserved
- **Display status:** Simplified status for UI (maps multiple statuses to simpler categories)
- **Reserved reason:** Provides user-friendly explanation when resource not selectable
- **JSONB output:** Returns array for easy frontend consumption
- **Overlap detection:** Checks if any existing reservation overlaps the requested slot
- **Compound role filter:** Only checks standalone and primary resources
- **Performance:** Complex query with multiple JOINs and CTEs - consider indexing
