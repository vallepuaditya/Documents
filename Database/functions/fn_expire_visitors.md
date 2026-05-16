# fn_expire_visitors

## Function Name

**Function:** `public.fn_expire_visitors()`

**Purpose:** Batch expires visitor accounts that have passed their expiration date

**Called By:** Scheduled job/cron (e.g., daily at midnight)

---

## Signature

```sql
CREATE OR REPLACE FUNCTION public.fn_expire_visitors()
RETURNS TABLE(
    expired_count INTEGER,
    u_user_id INTEGER,
    u_login_id VARCHAR,
    u_expired_at TIMESTAMPTZ
)
LANGUAGE plpgsql
AS $$
```

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| None | N/A | N/A | No input parameters |

**Return Type:** `TABLE` - Summary of expired users

| Column | Type | Description |
|--------|------|-------------|
| `expired_count` | `INTEGER` | Total number of users expired |
| `u_user_id` | `INTEGER` | User ID that was expired |
| `u_login_id` | `VARCHAR` | Login ID that was expired |
| `u_expired_at` | `TIMESTAMPTZ` | Timestamp when expiration occurred |

---

## Transaction Behavior

| Aspect | Value |
|--------|-------|
| Runs inside transaction | YES |
| Rollback scope | Full operation (all expirations atomic) |
| Savepoint usage | None |

---

## Preconditions / Validation

- Function can be called at any time
- Only processes users meeting ALL criteria:
  - `expires_at IS NOT NULL`
  - `expires_at <= CURRENT_TIMESTAMP`
  - `is_active = TRUE`
  - `status = 'Active'`

---

## Main Logic Steps

1. **Identify Expired Users:** Find users with expired dates in past who are still active
2. **Update User Status:** Set status='Expired' and is_active=FALSE
3. **Set System Actor:** Use updated_by=-1 to indicate system action
4. **Capture Expired Users:** CTE captures user details for audit and return
5. **Create Audit Log:** Insert audit entries for each expired user
6. **Return Summary:** Return count and details of expired users

---

## Waitlist Behavior

- `[ ]` This function does not directly interact with waitlists
- Expired users may lose reservation privileges
- Future: May trigger waitlist promotion if expired user had active reservations

---

## Audit Logging

| Audit Action | Logged To | Fields Captured |
|--------------|-----------|-----------------|
| User expired | `user_audit_log` | `action='EXPIRE'`, `changed_by=-1`, old/new values |

**Audit Details:**
- `old_values`: `{status: 'Active', is_active: true}`
- `new_values`: `{status: 'Expired', is_active: false, expired_at: TIMESTAMP}`

---

## Error Handling

| Error Code / Condition | Returned / Raised | Message |
|------------------------|-------------------|---------|
| None | N/A | Function does not raise exceptions |

**Note:** If no users need expiring, returns empty result set with expired_count=0.

---

## SQL Implementation

```sql
CREATE OR REPLACE FUNCTION public.fn_expire_visitors()
RETURNS TABLE(...)
LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    WITH expired AS (
        UPDATE public.users AS u SET
            status     = 'Expired',
            is_active  = FALSE,
            updated_by = -1,
            updated_at = CURRENT_TIMESTAMP
        WHERE u.expires_at  IS NOT NULL
          AND u.expires_at  <= CURRENT_TIMESTAMP
          AND u.is_active    = TRUE
          AND u.status       = 'Active'
        RETURNING u.user_id  AS exp_user_id,
                  u.login_id AS exp_login_id
    ),
    audit AS (
        INSERT INTO public.user_audit_log
            (user_id, action, changed_by, old_values, new_values)
        SELECT
            e.exp_user_id, 'EXPIRE', -1,
            jsonb_build_object('status','Active',  'is_active', TRUE),
            jsonb_build_object('status','Expired', 'is_active', FALSE,
                               'expired_at', CURRENT_TIMESTAMP)
        FROM expired AS e
        RETURNING user_id AS aud_user_id
    )
    SELECT
        (SELECT COUNT(*)::INTEGER FROM expired),
        e.exp_user_id,
        e.exp_login_id,
        CURRENT_TIMESTAMP
    FROM expired AS e;
END;
$function$
```

---

## Example Call

```sql
-- Run expiration job
SELECT * FROM fn_expire_visitors();

-- Result when users expired:
-- expired_count | u_user_id | u_login_id  | u_expired_at
-- --------------|-----------|-------------|-------------------------
-- 3             | 123       | visitor001  | 2026-05-16 00:00:00+05:30
-- 3             | 124       | visitor002  | 2026-05-16 00:00:00+05:30
-- 3             | 125       | guest123    | 2026-05-16 00:00:00+05:30

-- Result when no users need expiring:
-- expired_count | u_user_id | u_login_id | u_expired_at
-- --------------|-----------|------------|-------------
-- (empty result set)
```

---

## Related Functions / Triggers

| Related Object | Relationship |
|----------------|--------------|
| `users` table | Updates user status and is_active |
| `user_audit_log` table | Logs expiration actions |
| Cron/scheduler | Calls this function periodically |

---

## Notes for Developer

- **Scheduled execution:** Should run daily (e.g., midnight) via cron or scheduler
- **System actor:** Uses changed_by=-1 to indicate automated system action
- **Idempotent:** Safe to run multiple times - only affects eligible users
- **Atomic operation:** All expirations in single transaction
- **CTE pattern:** Uses writable CTEs for update + audit in one query
- **Visitor focus:** Name suggests focus on visitor accounts, but works for any user with expires_at
- **Status change:** Both status field and is_active flag are updated
- **Timestamp precision:** Uses CURRENT_TIMESTAMP with timezone
- **Return format:** Returns one row per expired user with count repeated
- **Empty result:** Returns no rows if no expirations (count would be 0 if returned)
- **Performance:** Consider adding index on (expires_at, is_active, status) if large user base
