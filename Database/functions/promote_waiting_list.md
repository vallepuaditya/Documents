# promote_waiting_list

## Function Name

**Function:** `public.promote_waiting_list()`

**Purpose:** Automatically promotes waiting reservations to allocated status when resources become available

**Called By:** Scheduled job/cron (e.g., every 5-10 minutes)

---

## Signature

```sql
CREATE OR REPLACE FUNCTION public.promote_waiting_list()
RETURNS INTEGER
LANGUAGE plpgsql
AS $$
```

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| None | N/A | N/A | No input parameters |

**Return Type:** `INTEGER` - Count of reservations promoted

---

## Transaction Behavior

| Aspect | Value |
|--------|-------|
| Runs inside transaction | YES |
| Rollback scope | Per reservation (uses FOR UPDATE SKIP LOCKED) |
| Savepoint usage | None |

---

## Preconditions / Validation

- Only processes reservations with:
  - status = 1 (waiting)
  - system_id IS NULL (not yet allocated)
  - start_time <= CURRENT_TIMESTAMP + 1 hour (starting soon)

---

## Main Logic Steps

1. **Find Waiting Reservations:** Query reservations with waiting status, ordered by start_time and priority
2. **Limit Processing:** Process max 5 reservations per run (prevents long locks)
3. **Lock Reservations:** Use FOR UPDATE SKIP LOCKED to avoid contention
4. **For Each Waiting Reservation:**
   - Find available workstation matching criteria (branch, resource_group, system_type)
   - Check workstation availability for the time slot
   - If available workstation found:
     - Update reservation status to 2 (allocated)
     - Assign system_id
     - Set allocated_at timestamp
     - Increment promotion counter
5. **Return Count:** Return total number of promotions

---

## Waitlist Behavior

- `[x]` This is the primary waitlist promotion function
- Promotion order: start_time ASC, then priority DESC
- Only promotes reservations starting within 1 hour
- Uses FIFO within same start time, priority breaks ties

**Waitlist promotion rules:**
- Earlier start times promoted first
- Higher priority within same time slot promoted first
- Only promotes if suitable resource available
- Skips locked reservations (SKIP LOCKED prevents blocking)

---

## Audit Logging

| Audit Action | Logged To | Fields Captured |
|--------------|-----------|-----------------|
| Promotion | `reservation` table | `status=2`, `system_id`, `allocated_at` |

**Note:** No separate audit log - changes tracked via reservation record updates.

---

## Error Handling

| Error Code / Condition | Returned / Raised | Message |
|------------------------|-------------------|---------|
| None | N/A | Function does not raise exceptions |

**Note:** Function returns 0 if no promotions possible, handles errors silently.

---

## Availability Check Logic

Uses `check_system_availability(system_id, start_time, end_time)` function to:
- Verify no overlapping reservations
- Ensure workstation is operational
- Confirm resource is not in maintenance

---

## SQL Implementation

```sql
CREATE OR REPLACE FUNCTION public.promote_waiting_list()
RETURNS integer
LANGUAGE plpgsql
AS $function$
DECLARE
    rec RECORD;
    available_system INT;
    count INT := 0;
BEGIN
    FOR rec IN 
        SELECT r.reservation_id, r.branch_id, r.resource_group_id, 
               r.system_type_sk, r.start_time, r.end_time
        FROM reservation r
        WHERE r.status = 1  -- waiting
          AND r.system_id IS NULL
          AND r.start_time <= CURRENT_TIMESTAMP + INTERVAL '1 hour'
        ORDER BY r.start_time ASC, r.priority DESC
        FOR UPDATE SKIP LOCKED
        LIMIT 5
    LOOP
        -- Find available workstation
        SELECT ws.system_id INTO available_system
        FROM work_stations ws
        WHERE ws.branch_id = rec.branch_id 
          AND ws.resource_group_id = rec.resource_group_id
          AND ws.system_type_sk = rec.system_type_sk
          AND check_system_availability(ws.system_id, rec.start_time, rec.end_time)
        LIMIT 1;
        
        -- Promote if system found
        IF available_system IS NOT NULL THEN
            UPDATE reservation 
            SET status = 2,  -- allocated
                system_id = available_system,
                allocated_at = CURRENT_TIMESTAMP
            WHERE reservation_id = rec.reservation_id;
            
            count := count + 1;
        END IF;
    END LOOP;
    
    RETURN count;
END;
$function$
```

---

## Example Call

```sql
-- Run waitlist promotion
SELECT promote_waiting_list();

-- Returns count of promoted reservations
-- Result: 3 (if 3 reservations were promoted)
-- Result: 0 (if no promotions possible)
```

---

## Related Functions / Triggers

| Related Object | Relationship |
|----------------|--------------|
| `reservation` table | Updates waiting reservations |
| `work_stations` table | Finds available systems |
| `check_system_availability` | Validates workstation availability |
| Cron/scheduler | Calls this function periodically |

---

## Notes for Developer

- **Scheduled execution:** Should run frequently (e.g., every 5-10 minutes)
- **Rate limiting:** LIMIT 5 prevents long-running transactions
- **SKIP LOCKED:** Allows concurrent runs without blocking
- **One-hour window:** Only promotes reservations starting soon (prevents premature allocation)
- **Priority system:** Higher priority values promoted first within same time slot
- **FIFO within priority:** start_time ASC ensures fairness
- **Idempotent:** Safe to run multiple times - only affects eligible reservations
- **Performance:** Uses indexes on status, system_id, start_time for efficiency
- **Availability check:** External function validates time slot conflicts
- **Branch/group matching:** Ensures workstation matches reservation requirements
- **First available:** Takes first matching workstation (LIMIT 1)
- **Atomic per reservation:** Each promotion is independent
- **Return value:** Useful for monitoring promotion activity
- **Future enhancement:** Could add notification/webhook on promotion
