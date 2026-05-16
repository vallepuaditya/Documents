# p_staff_auth

## Function Name

**Function:** `public.p_staff_auth(p_mode text, p_email text, p_staff_id uuid, p_refresh_token text, p_username text)`

**Purpose:** Multi-mode authentication function for staff login, token management, and account security

**Called By:** Admin Portal API authentication endpoints

---

## Signature

```sql
CREATE OR REPLACE FUNCTION public.p_staff_auth(
    p_mode TEXT,
    p_email TEXT DEFAULT NULL,
    p_staff_id UUID DEFAULT NULL,
    p_refresh_token TEXT DEFAULT NULL,
    p_username TEXT DEFAULT NULL
)
RETURNS JSON
LANGUAGE plpgsql
AS $$
```

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `p_mode` | `TEXT` | YES | Operation mode (see modes below) |
| `p_email` | `TEXT` | Conditional | Staff email (mode-dependent) |
| `p_staff_id` | `UUID` | Conditional | Staff member ID (mode-dependent) |
| `p_refresh_token` | `TEXT` | Conditional | JWT refresh token (mode-dependent) |
| `p_username` | `TEXT` | Conditional | Staff username for login |

**Return Type:** `JSON` - Status object with authentication result or error details

**Modes:**
- `LOGIN_FETCH` - Pre-login: fetch staff profile with password hash
- `FETCH_BY_ID` - Get profile by staff_id (for JWT /me endpoint)
- `LOGIN_FAILED` - Record failed login attempt, handle account locking
- `LOGIN_SUCCESS` - Reset failed attempts after successful login
- `SAVE_REFRESH_TOKEN` - Store refresh token after login
- `VERIFY_REFRESH_TOKEN` - Validate refresh token for token refresh
- `REVOKE_REFRESH_TOKEN` - Logout: revoke specific token
- `REVOKE_ALL_TOKENS` - Logout all sessions for a staff member
- `CLEANUP_EXPIRED_TOKENS` - Maintenance: remove expired/revoked tokens

---

## Transaction Behavior

| Aspect | Value |
|--------|-------|
| Runs inside transaction | YES |
| Rollback scope | Full operation |
| Savepoint usage | None |

---

## Preconditions / Validation

**LOGIN_FETCH:**
- Username must be provided
- Staff member must exist and not be inactive
- Account must not be locked

**FETCH_BY_ID:**
- staff_id must be provided

**LOGIN_FAILED:**
- staff_id must be provided

**LOGIN_SUCCESS:**
- staff_id must be provided

**SAVE_REFRESH_TOKEN:**
- staff_id and refresh_token must be provided

**VERIFY_REFRESH_TOKEN:**
- refresh_token must be provided

---

## Main Logic Steps

### LOGIN_FETCH Mode:
1. Fetch staff record by username (case-insensitive)
2. Aggregate all roles and permissions
3. Check if account is inactive - return error if true
4. Check if account is locked - return error with remaining lock time
5. Return profile with password_hash and permissions

### FETCH_BY_ID Mode:
1. Fetch staff record by staff_id
2. Aggregate all roles and permissions
3. Check if inactive - return error if true
4. Return profile without password_hash

### LOGIN_FAILED Mode:
1. Increment failed_login_count
2. If count >= max_attempts (5), set locked_until timestamp
3. Return lock status or remaining attempts

### LOGIN_SUCCESS Mode:
1. Reset failed_login_count to 0
2. Clear locked_until
3. Update last_login_at timestamp

### SAVE_REFRESH_TOKEN Mode:
1. Insert refresh token with 7-day expiration

### VERIFY_REFRESH_TOKEN Mode:
1. Check token exists, not revoked, not expired
2. Return staff_id if valid

### REVOKE_REFRESH_TOKEN Mode:
1. Mark specific token as revoked

### REVOKE_ALL_TOKENS Mode:
1. Mark all tokens for staff member as revoked

### CLEANUP_EXPIRED_TOKENS Mode:
1. Delete expired and revoked tokens

---

## Waitlist Behavior

- `[ ]` This function does not interact with waitlists
- Staff authentication only

---

## Audit Logging

| Audit Action | Logged To | Fields Captured |
|--------------|-----------|-----------------|
| Login attempts | `staff_members` | `failed_login_count`, `locked_until`, `last_login_at` |
| Token operations | `staff_refresh_tokens` | `refresh_token`, `expires_at`, `is_revoked` |

---

## Error Handling

| Error Code / Condition | Returned | Message |
|------------------------|----------|---------|
| `NOT_FOUND` | JSON ERROR | `Invalid username or password` |
| `FORBIDDEN` | JSON ERROR | `Account deactivated. Contact admin.` |
| `ACCOUNT_LOCKED` | JSON ERROR | `Account locked. Try again in X minutes.` |
| `INVALID_CREDENTIALS` | JSON ERROR | `Invalid username or password` + attempts left |
| `INVALID_MODE` | JSON ERROR | `Invalid mode: {mode}` |

---

## Security Features

**Account Locking:**
- Max failed attempts: 5
- Lock duration: 15 minutes
- Automatic unlock after duration

**Token Management:**
- Refresh tokens expire after 7 days
- Revocation support for logout
- Cleanup mechanism for expired tokens

---

## SQL Implementation

```sql
CREATE OR REPLACE FUNCTION public.p_staff_auth(...)
RETURNS json
LANGUAGE plpgsql
AS $function$
DECLARE
  v_staff         RECORD;
  v_lock_minutes  INT := 15;
  v_max_attempts  INT := 5;
  v_remaining     TEXT;
BEGIN
  -- Mode-specific logic
  IF p_mode = 'LOGIN_FETCH' THEN
    -- Fetch with permissions aggregation
  ELSIF p_mode = 'FETCH_BY_ID' THEN
    -- Fetch by ID
  ELSIF p_mode = 'LOGIN_FAILED' THEN
    -- Increment failures, lock if needed
  -- ... other modes
  END IF;
END;
$function$
```

---

## Example Call

```sql
-- Pre-login fetch
SELECT p_staff_auth(
    p_mode := 'LOGIN_FETCH',
    p_username := 'admin@library.org'
);

-- Record failed login
SELECT p_staff_auth(
    p_mode := 'LOGIN_FAILED',
    p_staff_id := 'uuid-here'
);

-- Save refresh token
SELECT p_staff_auth(
    p_mode := 'SAVE_REFRESH_TOKEN',
    p_staff_id := 'uuid-here',
    p_refresh_token := 'token-string'
);

-- Verify refresh token
SELECT p_staff_auth(
    p_mode := 'VERIFY_REFRESH_TOKEN',
    p_refresh_token := 'token-string'
);
```

---

## Related Functions / Triggers

| Related Object | Relationship |
|----------------|--------------|
| `staff_members` table | Queries and updates staff records |
| `staff_refresh_tokens` table | Manages JWT refresh tokens |
| `staff_roles` table | Joins for role information |
| `staff_permissions` table | Joins for permission information |
| `staff_role_assignments` table | Links staff to roles |

---

## Notes for Developer

- **Password verification:** Happens in API layer (bcrypt), not in database
- **Permission aggregation:** Uses json_agg to return all permissions
- **Case-insensitive username:** Uses LOWER() for matching
- **Lock timer calculation:** Displays remaining minutes to user
- **Token expiration:** 7 days from creation
- **Cleanup job:** Should be run periodically (e.g., daily cron)
- **Multi-session support:** Users can have multiple active refresh tokens
- **Security:** Never return password_hash to client (only for bcrypt verify)
