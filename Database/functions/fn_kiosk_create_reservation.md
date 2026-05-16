# fn_kiosk_create_reservation

## Function Name

**Function:** `public.fn_kiosk_create_reservation(...)`

**Purpose:** Creates a new reservation for kiosk users, including validation, slot conflict checking, and linked resource handling

**Called By:** Kiosk API reservation creation endpoint

---

## Signature

```sql
CREATE OR REPLACE FUNCTION public.fn_kiosk_create_reservation(
    p_user_id INTEGER,
    p_primary_resource_id INTEGER,
    p_booking_mode VARCHAR,
    p_reservation_date DATE,
    p_start_time TIME,
    p_created_by INTEGER DEFAULT -1
)
RETURNS JSONB
LANGUAGE plpgsql
AS $$
```

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `p_user_id` | `INTEGER` | YES | User making the reservation |
| `p_primary_resource_id` | `INTEGER` | YES | Primary resource to reserve |
| `p_booking_mode` | `VARCHAR` | YES | `instant`, `scheduled`, or `specific` |
| `p_reservation_date` | `DATE` | YES | Date of reservation |
| `p_start_time` | `TIME` | YES | Start time of reservation slot |
| `p_created_by` | `INTEGER` | NO | User ID creating the reservation (default: -1 for system) |

**Return Type:** `JSONB` - Reservation details or error message

---

## Transaction Behavior

| Aspect | Value |
|--------|-------|
| Runs inside transaction | YES |
| Rollback scope | Full operation on any exception |
| Savepoint usage | None |

---

## Preconditions / Validation

- User must exist in `users` table
- Primary resource must exist and be bookable (`standalone` or `primary` compound_role)
- Primary resource status must be 'Available'
- Booking mode must be one of: `instant`, `scheduled`, or `specific`
- Resource type must have a valid default duration
- No overlapping reservations for primary or linked resources

---

## Main Logic Steps

1. **Validate Required Parameters:** Check all required parameters are provided
2. **Validate User:** Ensure user exists in database
3. **Fetch Primary Resource Details:** Get resource info, status, type, location, area
4. **Validate Resource Bookability:** Check compound_role is `standalone` or `primary`
5. **Validate Resource Status:** Ensure status is 'Available'
6. **Get Duration:** Fetch default_duration_minutes from resource_type
7. **Calculate Time Slot:** Compute start and end timestamps with timezone
8. **Get Confirmed Status SK:** Fetch reservation status lookup value
9. **Check for Linked Resources:** Find addon resources attached to primary
10. **Validate Linked Resource Status:** Ensure linked resource is 'Available'
11. **Check Slot Conflicts:** Verify no overlapping reservations for primary resource
12. **Check Linked Slot Conflicts:** Verify no overlapping reservations for linked resource
13. **Create Reservation:** Insert into `reservations_new` table
14. **Link Primary Resource:** Insert into `reservation_resources` with role='primary'
15. **Link Addon Resource:** Insert into `reservation_resources` with role='linked' if exists
16. **Return Success:** Return full reservation details as JSONB

---

## Waitlist Behavior

- `[x]` This function creates a reservation directly (no waitlist)
- Reservations are created as 'confirmed' status immediately
- Future enhancement: May trigger waitlist if resource unavailable

---

## Audit Logging

| Audit Action | Logged To | Fields Captured |
|--------------|-----------|-----------------|
| Reservation created | `reservations_new` | All reservation fields with timestamps |
| Resource linkage | `reservation_resources` | resource_id, resource_role, reservation_id |

---

## Error Handling

| Error Code / Condition | Returned / Raised | Message |
|------------------------|-------------------|---------|
| `MISSING_USER_ID` | EXCEPTION | `p_user_id is required` |
| `MISSING_PRIMARY_RESOURCE_ID` | EXCEPTION | `p_primary_resource_id is required` |
| `MISSING_RESERVATION_DATE` | EXCEPTION | `p_reservation_date is required` |
| `MISSING_START_TIME` | EXCEPTION | `p_start_time is required` |
| `INVALID_BOOKING_MODE` | EXCEPTION | `must be instant, scheduled, or specific` |
| `USER_NOT_FOUND` | EXCEPTION | `user_id % not found` |
| `RESOURCE_NOT_FOUND` | EXCEPTION | `resource_id % not found` |
| `RESOURCE_NOT_BOOKABLE` | EXCEPTION | `Only standalone or primary resources can be booked directly` |
| `RESOURCE_NOT_AVAILABLE` | EXCEPTION | `Primary resource status is %` |
| `INVALID_RESOURCE_DURATION` | EXCEPTION | `default duration missing for resource_type_id %` |
| `CONFIG_ERROR` | EXCEPTION | `confirmed reservation status not found in lookup` |
| `LINKED_RESOURCE_NOT_AVAILABLE` | EXCEPTION | `linked resource status is %` |
| `RESOURCE_SLOT_CONFLICT` | EXCEPTION | `primary resource is already reserved in this slot` |
| `LINKED_RESOURCE_SLOT_CONFLICT` | EXCEPTION | `linked resource is already reserved in this slot` |

---

## SQL Implementation

```sql
CREATE OR REPLACE FUNCTION public.fn_manage_reservations(p_data jsonb)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$

DECLARE

    v_mode                 INTEGER;
    v_reservation_id       BIGINT;
    v_resource_id_sk       INTEGER;
    v_user_id_sk           INTEGER;
    v_status_sk            INTEGER;
    v_allocation_date      DATE;
    v_allocation_time      TIME;
    v_allocation_duration  INTEGER;
    v_created_by           INTEGER;

    v_delete_status_sk     INTEGER;
    v_exists               BIGINT;

BEGIN

    ----------------------------------------------------------------
    -- GET VALUES FROM JSON
    ----------------------------------------------------------------

    v_mode := (p_data->>'p_mode')::INTEGER;

    v_reservation_id := COALESCE((p_data->>'p_reservation_id')::BIGINT, 0);

    v_resource_id_sk := COALESCE((p_data->>'p_resource_id_sk')::INTEGER, 0);

    v_user_id_sk := COALESCE((p_data->>'p_user_id_sk')::INTEGER, 0);

    v_status_sk := COALESCE((p_data->>'p_status_sk')::INTEGER, 0);

    v_allocation_date := (p_data->>'p_allocation_date')::DATE;

    v_allocation_time := (p_data->>'p_allocation_time')::TIME;

    v_allocation_duration := COALESCE((p_data->>'p_allocation_duration')::INTEGER, 0);

    v_created_by := COALESCE((p_data->>'p_created_by')::INTEGER, -1);

    ----------------------------------------------------------------
    -- GET DELETE STATUS
    ----------------------------------------------------------------

    SELECT sk
    INTO v_delete_status_sk
    FROM lookup
    WHERE code = 'LST'
      AND value = 'Removed'
    LIMIT 1;

    ----------------------------------------------------------------
    -- VALIDATE OVERLAP (ADD / EDIT)
    ----------------------------------------------------------------

    IF v_mode IN (0,1) THEN

        SELECT reservation_id
        INTO v_exists
        FROM reservations
        WHERE resource_id_sk = v_resource_id_sk
          AND status_sk <> v_delete_status_sk
          AND allocation_date = v_allocation_date
          AND (v_mode = 0 OR reservation_id <> v_reservation_id)
          AND (
                (allocation_time,
                 allocation_time + (allocation_duration || ' minutes')::INTERVAL)
                OVERLAPS
                (v_allocation_time,
                 v_allocation_time + (v_allocation_duration || ' minutes')::INTERVAL)
              )
        LIMIT 1;

        IF v_exists IS NOT NULL THEN
            RETURN jsonb_build_object(
                'status', false,
                'message', 'Selected time slot already reserved'
            );
        END IF;

    END IF;

    ----------------------------------------------------------------
    -- ADD
    ----------------------------------------------------------------

    IF v_mode = 0 THEN

        SELECT reservation_id
        INTO v_exists
        FROM reservations
        WHERE resource_id_sk = v_resource_id_sk
          AND status_sk <> v_delete_status_sk
          AND allocation_date = v_allocation_date
          AND COALESCE(allocation_time,'00:00:00'::TIME)
              = COALESCE(v_allocation_time,'00:00:00'::TIME);

        IF v_exists IS NOT NULL THEN
            RETURN jsonb_build_object(
                'status', false,
                'message', 'Reservation already exists',
                'reservation_id', v_exists
            );
        END IF;

        INSERT INTO reservations
        (
            resource_id_sk,
            user_id_sk,
            status_sk,
            allocation_date,
            allocation_time,
            allocation_duration,
            created_by,
            created_at
        )
        VALUES
        (
            v_resource_id_sk,
            v_user_id_sk,
            v_status_sk,
            v_allocation_date,
            v_allocation_time,
            v_allocation_duration,
            v_created_by,
            NOW()
        )
        RETURNING reservation_id INTO v_reservation_id;

        RETURN jsonb_build_object(
            'status', true,
            'message', 'Reservation added successfully',
            'reservation_id', v_reservation_id
        );

    ----------------------------------------------------------------
    -- EDIT
    ----------------------------------------------------------------

    ELSIF v_mode = 1 THEN

        SELECT reservation_id
        INTO v_exists
        FROM reservations
        WHERE resource_id_sk = v_resource_id_sk
          AND status_sk <> v_delete_status_sk
          AND allocation_date = v_allocation_date
          AND COALESCE(allocation_time,'00:00:00'::TIME)
              = COALESCE(v_allocation_time,'00:00:00'::TIME)
          AND reservation_id <> v_reservation_id;

        IF v_exists IS NOT NULL THEN
            RETURN jsonb_build_object(
                'status', false,
                'message', 'Duplicate reservation already exists',
                'reservation_id', v_exists
            );
        END IF;

        UPDATE reservations
        SET
            resource_id_sk = v_resource_id_sk,
            user_id_sk = v_user_id_sk,
            status_sk = v_status_sk,
            allocation_date = v_allocation_date,
            allocation_time = v_allocation_time,
            allocation_duration = v_allocation_duration,
            updated_by = v_created_by,
            updated_at = NOW()
        WHERE reservation_id = v_reservation_id
          AND status_sk <> v_delete_status_sk;

        RETURN jsonb_build_object(
            'status', true,
            'message', 'Reservation updated successfully',
            'reservation_id', v_reservation_id
        );

    ----------------------------------------------------------------
    -- DELETE (SOFT DELETE)
    ----------------------------------------------------------------

    ELSIF v_mode = 2 THEN

        IF NOT EXISTS (
            SELECT 1
            FROM reservations
            WHERE reservation_id = v_reservation_id
              AND status_sk <> v_delete_status_sk
        ) THEN
            RETURN jsonb_build_object(
                'status', false,
                'message', 'Reservation not found'
            );
        END IF;

        UPDATE reservations
        SET status_sk = v_delete_status_sk
        WHERE reservation_id = v_reservation_id;

        RETURN jsonb_build_object(
            'status', true,
            'message', 'Reservation deleted successfully',
            'reservation_id', v_reservation_id
        );

    ELSE

        RETURN jsonb_build_object(
            'status', false,
            'message', 'Invalid mode. Use 0=ADD, 1=EDIT, 2=DELETE'
        );

    END IF;

EXCEPTION
    WHEN OTHERS THEN
        RETURN jsonb_build_object(
            'status', false,
            'message', SQLERRM
        );

END;

$function$

```

---

## Example Call

```sql
-- Create instant reservation
SELECT fn_kiosk_create_reservation(
    p_user_id := 123,
    p_primary_resource_id := 45,
    p_booking_mode := 'instant',
    p_reservation_date := CURRENT_DATE,
    p_start_time := '14:00:00',
    p_created_by := 123
);

-- Result:
-- {
--   "reservation_id": 789,
--   "primary_resource_id": 45,
--   "user_id": 123,
--   "status_sk": 46,
--   "booking_mode": "instant",
--   "start_at": "2026-05-16T14:00:00+05:30",
--   "end_at": "2026-05-16T15:00:00+05:30",
--   "duration_minutes": 60,
--   "linked_resource_id": 46,
--   "message": "Reservation created successfully"
-- }
```

---

## Related Functions / Triggers

| Related Object | Relationship |
|----------------|--------------|
| `reservations_new` table | Inserts reservation record |
| `reservation_resources` table | Inserts resource linkages |
| `resources` table | Queries resource details and status |
| `resource_addons` table | Queries linked resources |
| `lookup` table | Queries confirmed status SK |
| `fn_kiosk_resources_availability` | Used before this to check availability |

---

## Notes for Developer

- **Timezone handling:** Uses `AT TIME ZONE current_setting('TIMEZONE')` for proper timestamp conversion
- **Compound resources:** Only `standalone` and `primary` resources can be directly booked
- **Linked resources:** Automatically includes addon resources in reservation
- **Slot conflicts:** Checks both primary and linked resources for overlaps
- **Status lookup:** Retrieves confirmed status from lookup table dynamically
- **Duration source:** Duration comes from resource_type.default_duration_minutes
- **Atomic operation:** All insertions happen in single transaction
- **Future enhancement:** Add waitlist logic when resource unavailable instead of immediate exception


