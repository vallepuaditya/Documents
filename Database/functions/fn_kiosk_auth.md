# fn_kiosk_auth

## Function Name

**Function:** `public.fn_kiosk_auth(p_data jsonb)`

**Purpose:** Multi-mode authentication function for kiosk user login, profile retrieval, and auth timestamp updates

**Called By:** Kiosk API authentication endpoints (login, /me profile endpoint)

---

## Signature

```sql
CREATE OR REPLACE FUNCTION public.fn_kiosk_auth(p_data jsonb)
RETURNS JSONB
LANGUAGE plpgsql
AS $$
```

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `p_data` | `JSONB` | YES | JSON object containing mode and context-specific parameters |

**p_data structure by mode:**

**Mode 1 (Pre-login lookup):**
- `p_mode`: `1`
- `p_logon_id`: User's login ID

**Mode 2 (Post-login update):**
- `p_mode`: `2`
- `p_user_id`: User ID
- `p_location_id`: Location where auth occurred (optional)

**Mode 3 (Get profile by user_id):**
- `p_mode`: `3`
- `p_user_id`: User ID

**Return Type:** `JSONB` - Status object with user profile or error details

---

## Transaction Behavior

| Aspect | Value |
|--------|-------|
| Runs inside transaction | YES |
| Rollback scope | Full operation |
| Savepoint usage | None |

---

## Preconditions / Validation

**Mode 1:**
- `p_logon_id` must not be null or empty
- User must exist and not be anonymized
- User must not be banned
- User status must be 'active'
- User must not be expired (if expiry_enabled)

**Mode 2:**
- `p_user_id` must not be null

**Mode 3:**
- `p_user_id` must not be null
- User must exist and not be anonymized

---

## Main Logic Steps

### Mode 1: Pre-login Lookup
1. Validate `p_logon_id` is provided
2. Fetch user record by case-insensitive logon_id match
3. Check if user is banned - return error if true
4. Check if user status is 'active' - return error if not
5. Check if user is expired - return error if true
6. Return full user profile including password_hash for bcrypt verification

### Mode 2: Post-login Update
1. Validate `p_user_id` is provided
2. Update `last_auth_at` to current timestamp
3. Update `last_auth_location_id` if location provided
4. Set `first_auth_at` if NULL (first-time login)
5. Return success message

### Mode 3: Get Profile by User ID
1. Validate `p_user_id` is provided
2. Fetch user record by user_id
3. Check if user is inactive - return error if true
4. Return full user profile (without password_hash)

---

## Waitlist Behavior

- `[ ]` This function does not interact with waitlists
- Authentication only - no reservation logic

---

## Audit Logging

| Audit Action | Logged To | Fields Captured |
|--------------|-----------|-----------------|
| Auth timestamp updates | `users` table | `last_auth_at`, `first_auth_at`, `last_auth_location_id` |

**Note:** Login attempts may be logged by the application layer, not in this function.

---

## Error Handling

### Mode 1 Errors:

| Error Code / Condition | Returned | Message |
|------------------------|----------|---------|
| `MISSING_LOGON_ID` | JSON ERROR | `logon_id is required` |
| `USER_NOT_FOUND` | JSON ERROR | `No account found with that login ID` |
| `USER_BANNED` | JSON ERROR | `Account suspended. Contact staff.` (or custom banned_reason) |
| `USER_INACTIVE` | JSON ERROR | `Account is not active. Contact staff.` |
| `USER_EXPIRED` | JSON ERROR | `Account has expired. Please renew.` |

### Mode 2 Errors:

| Error Code / Condition | Returned | Message |
|------------------------|----------|---------|
| `MISSING_USER_ID` | JSON ERROR | `user_id is required for mode 2` |

### Mode 3 Errors:

| Error Code / Condition | Returned | Message |
|------------------------|----------|---------|
| `MISSING_USER_ID` | JSON ERROR | `user_id is required for mode 3` |
| `USER_NOT_FOUND` | JSON ERROR | `User not found` |
| `FORBIDDEN` | JSON ERROR | `Account deactivated.` |

---

## SQL Implementation

```sql
CREATE OR REPLACE FUNCTION public.fn_kiosk_auth(p_data jsonb)
 RETURNS jsonb
 LANGUAGE plpgsql
AS $function$
DECLARE
    v_mode              INTEGER;
    v_logon_id          VARCHAR;
    v_user_id           INTEGER;
    v_location_id       INTEGER;
    v_user              public.users%ROWTYPE;
BEGIN
    v_mode        := (p_data->>'p_mode')::INTEGER;
    v_logon_id    := p_data->>'p_logon_id';
    v_user_id     := (p_data->>'p_user_id')::INTEGER;
    v_location_id := (p_data->>'p_location_id')::INTEGER;

    -- MODE 1: Pre-login lookup and validation
    IF v_mode = 1 THEN
        -- [Full validation and profile return logic]
        
    -- MODE 2: Post-login update
    ELSIF v_mode = 2 THEN
        -- [Update auth timestamps]
        
    -- MODE 3: Get profile by user_id
    ELSIF v_mode = 3 THEN
        -- [Fetch and return profile]
        
    ELSE
        RETURN jsonb_build_object(
            'status',  'ERROR',
            'code',    'INVALID_MODE',
            'message', 'Valid modes: 1=Login Lookup, 2=Post Login Update, 3=Get Profile'
        );
    END IF;
END;
$function$
```

---

## Example Call

```sql
-- Mode 1: Pre-login lookup
SELECT fn_kiosk_auth(jsonb_build_object(
    'p_mode', 1,
    'p_logon_id', 'john.doe'
));

-- Mode 2: Post-login update
SELECT fn_kiosk_auth(jsonb_build_object(
    'p_mode', 2,
    'p_user_id', 123,
    'p_location_id', 1
));

-- Mode 3: Get profile by user_id
SELECT fn_kiosk_auth(jsonb_build_object(
    'p_mode', 3,
    'p_user_id', 123
));
```

---

## Related Functions / Triggers

| Related Object | Relationship |
|----------------|--------------|
| `users` table | Queries and updates user records |
| FastAPI auth endpoint | Calls Mode 1 before bcrypt verify |
| FastAPI auth endpoint | Calls Mode 2 after successful login |
| JWT /me endpoint | Calls Mode 3 to get current user profile |

---

## Notes for Developer

- **Security:** Mode 1 returns password_hash for bcrypt verification in FastAPI - never expose to client
- **Case-insensitive login:** Uses LOWER() comparison for logon_id matching
- **First-time login tracking:** Mode 2 sets first_auth_at only if NULL
- **Location tracking:** Tracks where user authenticated for audit purposes
- **Anonymized users:** Explicitly excluded from all auth operations
- **Multi-mode design:** Separates pre-auth validation from post-auth updates for security
- Password verification happens in FastAPI, not in database
