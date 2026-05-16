# manage_global_settings

## Function Name

**Function:** `public.manage_global_settings(...)`

**Purpose:** Manages global system settings and configuration parameters

**Called By:** Admin Portal API settings management endpoints

---

## Signature

```sql
CREATE OR REPLACE FUNCTION public.manage_global_settings(
    p_mode VARCHAR,
    p_lan_login_mode_sk INTEGER DEFAULT NULL,
    p_advance_reservation_days INTEGER DEFAULT NULL,
    p_min_minutes_before_first_slot INTEGER DEFAULT NULL,
    p_max_pending_reservations_per_patron INTEGER DEFAULT NULL,
    p_auto_delete_signup_username BOOLEAN DEFAULT NULL,
    p_auto_delete_after_hours INTEGER DEFAULT NULL,
    p_unclaimed_scheduled_session_timeout_minutes INTEGER DEFAULT NULL,
    p_unclaimed_queued_session_timeout_minutes INTEGER DEFAULT NULL,
    p_inactivity_timeout_minutes INTEGER DEFAULT NULL,
    p_lock_computer_timeout_minutes INTEGER DEFAULT NULL,
    p_logon_timeout_seconds INTEGER DEFAULT NULL,
    p_warning_time_low_minutes INTEGER DEFAULT NULL,
    p_warning_time_critical_minutes INTEGER DEFAULT NULL,
    p_visitor_account_active_days INTEGER DEFAULT NULL,
    p_visitor_default_user_group_sk INTEGER DEFAULT NULL,
    p_updated_by INTEGER DEFAULT -1
)
RETURNS JSONB
LANGUAGE plpgsql
AS $$
```

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `p_mode` | `VARCHAR` | YES | Operation mode (GET/GET_OPTIONS/UPDATE) |
| `p_lan_login_mode_sk` | `INTEGER` | Conditional | LAN login mode lookup SK |
| `p_advance_reservation_days` | `INTEGER` | Conditional | Max days in advance for reservations (1-365) |
| `p_min_minutes_before_first_slot` | `INTEGER` | Conditional | Minimum lead time for first slot |
| `p_max_pending_reservations_per_patron` | `INTEGER` | Conditional | Max pending reservations per user |
| `p_auto_delete_signup_username` | `BOOLEAN` | Conditional | Auto-delete temporary signup accounts |
| `p_auto_delete_after_hours` | `INTEGER` | Conditional | Hours before auto-deletion |
| `p_unclaimed_scheduled_session_timeout_minutes` | `INTEGER` | Conditional | Timeout for unclaimed scheduled sessions |
| `p_unclaimed_queued_session_timeout_minutes` | `INTEGER` | Conditional | Timeout for unclaimed queued sessions |
| `p_inactivity_timeout_minutes` | `INTEGER` | Conditional | Session inactivity timeout |
| `p_lock_computer_timeout_minutes` | `INTEGER` | Conditional | Computer lock timeout |
| `p_logon_timeout_seconds` | `INTEGER` | Conditional | Login timeout |
| `p_warning_time_low_minutes` | `INTEGER` | Conditional | Low time warning threshold |
| `p_warning_time_critical_minutes` | `INTEGER` | Conditional | Critical time warning threshold |
| `p_visitor_account_active_days` | `INTEGER` | Conditional | Visitor account validity period |
| `p_visitor_default_user_group_sk` | `INTEGER` | Conditional | Default user group for visitors |
| `p_updated_by` | `INTEGER` | NO | User performing update (default: -1) |

**Return Type:** `JSONB` - Settings data or operation result

**Modes:**
- `GET` - Retrieve current global settings
- `GET_OPTIONS` - Get available options for lookup fields
- `UPDATE` - Update global settings

---

## Transaction Behavior

| Aspect | Value |
|--------|-------|
| Runs inside transaction | YES |
| Rollback scope | Full operation |
| Savepoint usage | None |

---

## Preconditions / Validation

**UPDATE mode validations:**
- `lan_login_mode_sk` must exist in lookup table with type='lan_logon_type_sk'
- `visitor_default_user_group_sk` must exist in lookup table with type='visitor_user_group_sk'
- `advance_reservation_days` must be between 1 and 365
- `warning_time_critical_minutes` must be less than `warning_time_low_minutes`

---

## Main Logic Steps

### GET Mode:
1. Query global_settings table (single row expected)
2. Join with lookup tables for human-readable values
3. Return JSONB with all settings and their labels

### GET_OPTIONS Mode:
1. Query lookup table for relevant option types
2. Filter for types: 'lan_logon_type_sk', 'visitor_user_group_sk'
3. Return JSONB array of available options

### UPDATE Mode:
1. Validate lan_login_mode_sk exists in lookup
2. Validate visitor_default_user_group_sk exists in lookup (if provided)
3. Validate advance_reservation_days range (1-365)
4. Validate warning time relationship (critical < low)
5. Update global_settings record
6. Return success with updated timestamp

---

## Waitlist Behavior

- `[ ]` This function does not directly interact with waitlists
- Settings may affect waitlist behavior (e.g., timeout settings)

---

## Audit Logging

| Audit Action | Logged To | Fields Captured |
|--------------|-----------|-----------------|
| Updated | `global_settings` | `updated_by`, `updated_at` |

**Note:** Function updates single global_settings record (should only be one row).

---

## Error Handling

| Error Code / Condition | Returned / Raised | Message |
|------------------------|-------------------|---------|
| Invalid lan_login_mode_sk | JSONB | `{success: false, message: 'Invalid lan_login_mode_sk value'}` |
| Invalid visitor_default_user_group_sk | JSONB | `{success: false, message: 'Invalid visitor_default_user_group_sk value'}` |
| Invalid advance_reservation_days | JSONB | `{success: false, message: 'advance_reservation_days must be between 1 and 365'}` |
| Warning time conflict | JSONB | `{success: false, message: 'warning_time_critical_minutes must be less than warning_time_low_minutes'}` |
| Invalid mode | JSONB | `{success: false, message: 'Invalid p_mode. Use GET \| GET_OPTIONS \| UPDATE'}` |
| Any exception | JSONB | `{success: false, message: SQLERRM}` |

---

## Settings Categories

**Reservation Settings:**
- advance_reservation_days
- min_minutes_before_first_slot
- max_pending_reservations_per_patron

**Session Timeout Settings:**
- unclaimed_scheduled_session_timeout_minutes
- unclaimed_queued_session_timeout_minutes
- inactivity_timeout_minutes
- lock_computer_timeout_minutes
- logon_timeout_seconds

**Warning Settings:**
- warning_time_low_minutes
- warning_time_critical_minutes

**Visitor Account Settings:**
- visitor_account_active_days
- visitor_default_user_group_sk
- auto_delete_signup_username
- auto_delete_after_hours

**Authentication Settings:**
- lan_login_mode_sk

---

## SQL Implementation

```sql
CREATE OR REPLACE FUNCTION public.manage_global_settings(...)
RETURNS jsonb
LANGUAGE plpgsql
AS $function$
DECLARE
    v_result        JSONB;
    v_updated_at    TIMESTAMP WITH TIME ZONE;
BEGIN
    IF p_mode = 'GET' THEN
        SELECT jsonb_build_object(
            'success', true,
            'sk', gs.sk,
            'lan_login_mode_sk', gs.lan_login_mode_sk,
            'lan_login_mode_value', l1.value,
            -- ... all settings fields
        ) INTO v_result
        FROM global_settings gs
        LEFT JOIN lookup l1 ON l1.sk = gs.lan_login_mode_sk
        LEFT JOIN lookup l2 ON l2.sk = gs.visitor_default_user_group_sk
        LIMIT 1;
        
        RETURN v_result;

    ELSIF p_mode = 'GET_OPTIONS' THEN
        SELECT jsonb_build_object(
            'success', true,
            'options', jsonb_agg(...)
        ) INTO v_result
        FROM lookup l
        WHERE l.type IN ('lan_logon_type_sk', 'visitor_user_group_sk')
          AND l.is_active = true;
        
        RETURN v_result;

    ELSIF p_mode = 'UPDATE' THEN
        -- Validations
        IF NOT EXISTS (...) THEN
            RETURN jsonb_build_object('success', false, 'message', '...');
        END IF;
        
        -- Update
        UPDATE global_settings SET ... RETURNING updated_at INTO v_updated_at;
        
        RETURN jsonb_build_object(
            'success', true,
            'message', 'Global settings updated successfully',
            'updated_at', v_updated_at
        );
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        RETURN jsonb_build_object('success', false, 'message', SQLERRM);
END;
$function$
```

---

## Example Call

```sql
-- Get current settings
SELECT manage_global_settings('GET');

-- Get available options
SELECT manage_global_settings('GET_OPTIONS');

-- Update settings
SELECT manage_global_settings(
    p_mode := 'UPDATE',
    p_lan_login_mode_sk := 1,
    p_advance_reservation_days := 30,
    p_warning_time_low_minutes := 10,
    p_warning_time_critical_minutes := 5,
    p_visitor_account_active_days := 90,
    p_updated_by := 1
);
```

---

## Related Functions / Triggers

| Related Object | Relationship |
|----------------|--------------|
| `global_settings` table | Primary settings storage |
| `lookup` table | Provides option values |
| Reservation functions | Use advance_reservation_days setting |
| Session management | Use timeout settings |

---

## Notes for Developer

- **Singleton table:** global_settings should have exactly one row
- **Lookup integration:** Settings reference lookup table for dropdown values
- **Validation order:** Check FK constraints before range validations
- **Warning times:** Critical must be less than low (e.g., 5 min < 10 min)
- **Day range:** 1-365 days prevents unreasonable advance booking windows
- **System defaults:** updated_by=-1 indicates system/default values
- **JSONB response:** Always returns JSONB (never raises exceptions to caller)
- **GET mode:** Includes both SK values and human-readable labels
- **GET_OPTIONS mode:** For populating admin UI dropdowns
