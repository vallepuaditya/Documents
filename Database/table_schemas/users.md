# users Table Schema

**Table:** `users`

**Purpose:** Stores patron and staff user accounts, authentication credentials, contact info, and status.

**Setup / Defaults:** Status defaults to `'active'`. `is_banned`, `expiry_enabled`, `is_anonymized` default to `false`.

---

## Dependencies

| Depends On | Relationship | Notes |
|------------|-------------|-------|
| `locations` | `FK (location_id)` | User's primary/home location |
| `user_groups` | `FK (user_group_id)` | Group assignment for permissions |
| `user_tiers` | `FK (user_tier_id)` | Tier/level assignment |
| `user_types` | `FK (user_type_id)` | Classification of user |

---

## Columns

| Column Name | Data Type | Nullable | Default | Constraints | Description |
|-------------|-----------|----------|---------|-------------|-------------|
| `user_id` | `integer` | NO | `GENERATED ALWAYS AS IDENTITY` | `PRIMARY KEY` | Surrogate primary key |
| `first_name` | `character varying(100)` | YES | | | First name(s) |
| `middle_name` | `character varying(100)` | YES | | | Middle name/initial |
| `last_name` | `character varying(100)` | YES | | | Last name(s) |
| `alias` | `character varying(150)` | YES | | | Must be unique alias |
| `date_of_birth` | `date` | YES | | | Birthdate for age-based permissions |
| `logon_id` | `character varying(150)` | NO | | `UNIQUE` | Login identifier |
| `password_hash` | `text` | YES | | | Encrypted password |
| `card_number` | `character varying(100)` | YES | | | Barcode / card number |
| `external_id` | `character varying(150)` | YES | | | External system ID |
| `email` | `character varying(255)` | YES | | | Email address(es) |
| `phone` | `character varying(50)` | YES | | | Phone number |
| `address_line1` | `character varying(255)` | YES | | | Street address line 1 |
| `address_line2` | `character varying(255)` | YES | | | Street address line 2 |
| `city` | `character varying(100)` | YES | | | City |
| `state` | `character varying(100)` | YES | | | State/Province |
| `postal_code` | `character varying(20)` | YES | | | Postal/ZIP code |
| `country` | `character varying(100)` | YES | | | Country |
| `user_type_id` | `integer` | YES | | `FK -> user_types` | User classification |
| `user_group_id` | `integer` | YES | | `FK -> user_groups` | Permission group |
| `user_tier_id` | `integer` | YES | | `FK -> user_tiers` | Tier/level |
| `location_id` | `integer` | YES | | `FK -> locations` | Home location |
| `minutes_allowed_today` | `integer` | YES | | | Daily usage limit (minutes) |
| `sessions_allowed_today` | `integer` | YES | | | Daily session limit |
| `status` | `character varying(50)` | NO | `'active'` | `CHECK` | active, inactive, expired, banned, anonymized, archived |
| `is_banned` | `boolean` | YES | `false` | | Banned flag |
| `banned_at` | `timestamp with time zone` | YES | | | When user was banned |
| `banned_reason` | `text` | YES | | | Reason for ban |
| `reinstated_at` | `timestamp with time zone` | YES | | | When user was reinstated |
| `expiry_enabled` | `boolean` | YES | `false` | | Account expiry enabled |
| `expired_at` | `timestamp with time zone` | YES | | | Account expiration date/time |
| `first_auth_at` | `timestamp with time zone` | YES | | | First successful authentication |
| `last_auth_at` | `timestamp with time zone` | YES | | | Most recent successful authentication |
| `last_auth_location_id` | `integer` | YES | | | Location of last authentication |
| `comments` | `text` | YES | | | Multi-line staff comments |
| `custom_fields` | `jsonb` | YES | | | Extensible custom field data |
| `is_anonymized` | `boolean` | YES | `false` | | GDPR/privacy anonymized |
| `anonymized_at` | `timestamp with time zone` | YES | | | When anonymized |
| `created_at` | `timestamp with time zone` | YES | `CURRENT_TIMESTAMP` | | Record creation timestamp |
| `updated_at` | `timestamp with time zone` | YES | `CURRENT_TIMESTAMP` | | Last update timestamp (trigger-maintained) |
| `created_by` | `integer` | YES | | | User who created this record |
| `updated_by` | `integer` | YES | | | User who last updated this record |

---

## Indexes

| Index Name | Columns | Type | Purpose |
|------------|---------|------|---------|
| `idx_users_is_banned` | `is_banned` | B-tree | Filter banned users quickly |
| `idx_users_last_auth_at` | `last_auth_at` | B-tree | Query by last login time |
| `idx_users_location_id` | `location_id` | B-tree | Join/filter by location |
| `idx_users_logon_id` | `logon_id` | B-tree | Fast login lookups |
| `idx_users_status` | `status` | B-tree | Filter by user status |
| `idx_users_user_group_id` | `user_group_id` | B-tree | Join/filter by group |
| `idx_users_user_type_id` | `user_type_id` | B-tree | Join/filter by user type |

---

## Foreign Keys

| Column | References | On Delete | On Update | Notes |
|--------|------------|-----------|-----------|-------|
| `location_id` | `locations(location_id)` | `SET NULL` | `NO ACTION` | User's home location |
| `user_group_id` | `user_groups(user_group_id)` | `SET NULL` | `NO ACTION` | Permission group |
| `user_tier_id` | `user_tiers(user_tier_id)` | `SET NULL` | `NO ACTION` | Tier assignment |
| `user_type_id` | `user_types(user_type_id)` | `SET NULL` | `NO ACTION` | User classification |

---

## Triggers

| Trigger Name | Event | Function | Purpose |
|--------------|-------|----------|---------|
| `trg_users_updated_at` | `BEFORE UPDATE` | `update_updated_at_column()` | Auto-update `updated_at` on every update |

---

## Constraints

| Constraint Name | Type | Columns / Expression | Notes |
|-----------------|------|----------------------|-------|
| `users_pkey` | `PRIMARY KEY` | `user_id` | |
| `uq_users_logon_id` | `UNIQUE` | `logon_id` | Login ID must be unique |
| `chk_users_status` | `CHECK` | `status IN ('active','inactive','expired','banned','anonymized','archived')` | Valid status values |

---

## Waitlist Support

- [ ] This table directly represents a reservable resource
- [ ] This table has a related waitlist table (name: ``)
- [ ] Waitlist promotion is handled by: ``

---

## Audit Requirements

> Every reservation action must be auditable.

- [ ] Changes are logged to `user_auth_logs` / `staff_audit_log` (as appropriate)
- [ ] Trigger or function captures: old value, new value, changed by, changed at, action type
- [ ] Audit function name: `[FILL: e.g. fn_audit_user_change]`

---

## SQL DDL

```sql
-- Table: public.users
-- DROP TABLE IF EXISTS public.users;

CREATE TABLE IF NOT EXISTS public.users
(
    user_id integer NOT NULL GENERATED ALWAYS AS IDENTITY
        (INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1),
    first_name character varying(100) COLLATE pg_catalog."default",
    middle_name character varying(100) COLLATE pg_catalog."default",
    last_name character varying(100) COLLATE pg_catalog."default",
    alias character varying(150) COLLATE pg_catalog."default",
    date_of_birth date,
    logon_id character varying(150) COLLATE pg_catalog."default" NOT NULL,
    password_hash text COLLATE pg_catalog."default",
    card_number character varying(100) COLLATE pg_catalog."default",
    external_id character varying(150) COLLATE pg_catalog."default",
    email character varying(255) COLLATE pg_catalog."default",
    phone character varying(50) COLLATE pg_catalog."default",
    address_line1 character varying(255) COLLATE pg_catalog."default",
    address_line2 character varying(255) COLLATE pg_catalog."default",
    city character varying(100) COLLATE pg_catalog."default",
    state character varying(100) COLLATE pg_catalog."default",
    postal_code character varying(20) COLLATE pg_catalog."default",
    country character varying(100) COLLATE pg_catalog."default",
    user_type_id integer,
    user_group_id integer,
    user_tier_id integer,
    location_id integer,
    minutes_allowed_today integer,
    sessions_allowed_today integer,
    status character varying(50) COLLATE pg_catalog."default" NOT NULL DEFAULT 'active'::character varying,
    is_banned boolean DEFAULT false,
    banned_at timestamp with time zone,
    banned_reason text COLLATE pg_catalog."default",
    reinstated_at timestamp with time zone,
    expiry_enabled boolean DEFAULT false,
    expired_at timestamp with time zone,
    first_auth_at timestamp with time zone,
    last_auth_at timestamp with time zone,
    last_auth_location_id integer,
    comments text COLLATE pg_catalog."default",
    custom_fields jsonb,
    is_anonymized boolean DEFAULT false,
    anonymized_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_by integer,
    updated_by integer,
    CONSTRAINT users_pkey PRIMARY KEY (user_id),
    CONSTRAINT uq_users_logon_id UNIQUE (logon_id),
    CONSTRAINT fk_users_location FOREIGN KEY (location_id)
        REFERENCES public.locations (location_id) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE SET NULL,
    CONSTRAINT fk_users_user_group FOREIGN KEY (user_group_id)
        REFERENCES public.user_groups (user_group_id) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE SET NULL,
    CONSTRAINT fk_users_user_tier FOREIGN KEY (user_tier_id)
        REFERENCES public.user_tiers (user_tier_id) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE SET NULL,
    CONSTRAINT fk_users_user_type FOREIGN KEY (user_type_id)
        REFERENCES public.user_types (user_type_id) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE SET NULL,
    CONSTRAINT chk_users_status CHECK (
        status::text = ANY (
            ARRAY['active','inactive','expired','banned','anonymized','archived']::text[]
        )
    )
);

-- Indexes
CREATE INDEX IF NOT EXISTS idx_users_is_banned
    ON public.users USING btree (is_banned ASC NULLS LAST);
CREATE INDEX IF NOT EXISTS idx_users_last_auth_at
    ON public.users USING btree (last_auth_at ASC NULLS LAST);
CREATE INDEX IF NOT EXISTS idx_users_location_id
    ON public.users USING btree (location_id ASC NULLS LAST);
CREATE INDEX IF NOT EXISTS idx_users_logon_id
    ON public.users USING btree (logon_id COLLATE pg_catalog."default" ASC NULLS LAST);
CREATE INDEX IF NOT EXISTS idx_users_status
    ON public.users USING btree (status COLLATE pg_catalog."default" ASC NULLS LAST);
CREATE INDEX IF NOT EXISTS idx_users_user_group_id
    ON public.users USING btree (user_group_id ASC NULLS LAST);
CREATE INDEX IF NOT EXISTS idx_users_user_type_id
    ON public.users USING btree (user_type_id ASC NULLS LAST);

-- Trigger
CREATE OR REPLACE TRIGGER trg_users_updated_at
    BEFORE UPDATE ON public.users
    FOR EACH ROW
    EXECUTE FUNCTION public.update_updated_at_column();
```

---

## Notes for Developer

- `user_id` is `integer` (not `BIGSERIAL`). Do not assume `BIGINT` in joins.
- `status` is restricted to: `active`, `inactive`, `expired`, `banned`, `anonymized`, `archived`. Never invent new statuses without updating the `CHECK` constraint.
- `logon_id` is case-sensitive via `pg_catalog."default"` collation.
- `custom_fields` is `jsonb` — query with JSONB operators (`->`, `->>`, `@>`).
- `created_by` and `updated_by` are `integer` (FK to `users.user_id`), not `BIGINT`.

