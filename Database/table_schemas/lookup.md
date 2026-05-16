# lookup Table Schema

**Table:** `lookup`

**Purpose:** Central lookup/reference table for storing enumerated values used across the system (branches, system types, user groups, resource statuses, reservation statuses, etc.).

**Setup / Defaults:** The table is pre-seeded with the following lookup values organized by `type`.

### `branch_sk` (Code: `NAME`)

| `sk` | `value` | `display_order` | `is_active` | `created_by` |
|------|---------|-----------------|-------------|------------|
| 1 | All Branches | 1 | true | -1 |
| 2 | Central Library | 2 | true | -1 |
| 3 | Eastside Branch | 3 | true | -1 |
| 4 | North Valley Branch | 4 | true | -1 |

### `system_type_sk` (Code: `STL`)

| `sk` | `value` | `display_order` | `is_active` | `created_by` |
|------|---------|-----------------|-------------|------------|
| 5 | Standard PCs | 1 | true | -1 |
| 6 | Express Stations | 2 | true | -1 |
| 7 | High Performance | 3 | true | -1 |

### `user_group_sk` (Code: `UGL`)

| `sk` | `value` | `display_order` | `is_active` | `created_by` |
|------|---------|-----------------|-------------|------------|
| 12 | Public | 1 | true | -1 |
| 13 | Student | 2 | true | -1 |
| 14 | Faculty | 3 | true | -1 |
| 15 | Staff | 4 | true | -1 |

### `location_type_sk` (Code: `LTL`)

| `sk` | `value` | `display_order` | `is_active` | `created_by` |
|------|---------|-----------------|-------------|------------|
| 17 | Floor Level | 1 | true | -1 |
| 18 | Wing or Section | 2 | true | -1 |
| 19 | Room or Area | 3 | true | -1 |
| 20 | Zone Designation | 4 | true | -1 |

### `user_privilege_group_sk` (Code: `UPG`)

| `sk` | `value` | `display_order` | `is_active` | `created_by` |
|------|---------|-----------------|-------------|------------|
| 23 | Filtered Internet | 1 | true | -1 |
| 24 | Restricted Access | 2 | true | -1 |
| 25 | Basic Access | 3 | true | -1 |

### `user_type_sk` (Code: `USER_TYPE`)

| `sk` | `value` | `display_order` | `is_active` | `created_by` |
|------|---------|-----------------|-------------|------------|
| 26 | patron | 1 | true | -1 |
| 27 | visitor | 2 | true | -1 |

### `reservation_status_sk` (Code: `RESERVATION_STATUS`)

| `sk` | `value` | `display_order` | `is_active` | `created_by` |
|------|---------|-----------------|-------------|------------|
| 28 | confirmed | 1 | true | -1 |
| 55 | cancelled | 2 | true | -1 |
| 56 | completed | 3 | true | -1 |
| 57 | no_show | 4 | true | -1 |

### `reservation_type_sk` (Code: `RESERVATION_STATUS`)

| `sk` | `value` | `display_order` | `is_active` | `created_by` |
|------|---------|-----------------|-------------|------------|
| 29 | confirmed | 1 | true | -1 |

### `lan_logon_type_sk` (Code: `LLT`)

| `sk` | `value` | `display_order` | `is_active` | `created_by` |
|------|---------|-----------------|-------------|------------|
| 31 | LAN accounts only | 1 | true | -1 |
| 32 | Common guest accounts | 2 | true | -1 |

### `visitor_user_group_sk` (Code: `VUG`)

| `sk` | `value` | `display_order` | `is_active` | `created_by` |
|------|---------|-----------------|-------------|------------|
| 33 | visitors | 1 | true | -1 |

### `location_status_sk` (Code: `LST`)

| `sk` | `value` | `display_order` | `is_active` | `created_by` |
|------|---------|-----------------|-------------|------------|
| 34 | Active | 1 | true | -1 |
| 35 | Decommissioned | 2 | true | -1 |
| 36 | Disabled | 3 | true | -1 |
| 37 | Removed | 4 | true | -1 |

### `closure_type_sk` (Code: `CLT`)

| `sk` | `value` | `display_order` | `is_active` | `created_by` |
|------|---------|-----------------|-------------|------------|
| 38 | Full Closure | 1 | true | |
| 39 | Modified Hours | 2 | true | |
| 40 | Special Schedule | 3 | true | |

### `resource_type_sk` (Code: `RTL`)

| `sk` | `value`          | `display_order` | `is_active` | `created_by` |
| ------| ------------------| -----------------| -------------| --------------|
| 41   | Standard PCs     | 1               | true        | -1           |
| 42   | Express Stations | 2               | true        | -1           |
| 43   | High Performance | 3               | true        | -1           |
| 44   | Conference Rooms | 4               | true        | -1           |
| 45   | 3D Printer       | 5               | true        | -1           |

### `resource_status_sk` (Code: `RST`)

| `sk` | `value`        | `display_order` | `is_active` | `created_by` |
| ------| ----------------| -----------------| -------------| --------------|
| 46   | Available      | 1               | true        | -1           |
| 47   | In Use         | 2               | true        | -1           |
| 48   | Reserved       | 3               | true        | -1           |
| 49   | Offline        | 4               | true        | -1           |
| 50   | Maintenance    | 5               | true        | -1           |
| 51   | Decommissioned | 6               | true        | -1           |

### `resource_category_sk` (Code: `RCT`)

| `sk` | `value` | `display_order` | `is_active` | `created_by` |
|------|---------|-----------------|-------------|------------|
| 52 | PC | 1 | true | -1 |
| 53 | 3D Printer | 2 | true | -1 |
| 54 | Conference Room | 3 | true | -1 |

---

## New Tables Lookup Values (Auto-incremented SK)

The following lookup types are seeded by `seed_lookup_new_tables.sql` for newly created tables. `sk` values are auto-generated by `lookup_sk_seq`.

### `portal_status_sk` (Code: `PSS`) — `access_portals`

| `value` | `display_order` | `is_active` | `created_by` |
|---------|-----------------|-------------|------------|
| active | 1 | true | -1 |
| inactive | 2 | true | -1 |
| config_incomplete | 3 | true | -1 |
| decommissioned | 4 | true | -1 |

### `identity_provider_type_sk` (Code: `IPT`) — `identity_providers`

| `value` | `display_order` | `is_active` | `created_by` |
|---------|-----------------|-------------|------------|
| local | 1 | true | -1 |
| ldap | 2 | true | -1 |
| sip2 | 3 | true | -1 |
| oauth | 4 | true | -1 |
| saml | 5 | true | -1 |

### `identity_provider_status_sk` (Code: `IPS`) — `identity_providers`

| `value` | `display_order` | `is_active` | `created_by` |
|---------|-----------------|-------------|------------|
| active | 1 | true | -1 |
| inactive | 2 | true | -1 |
| error | 3 | true | -1 |

### `connection_mode_sk` (Code: `CMO`) — `location_segments`

| `value` | `display_order` | `is_active` | `created_by` |
|---------|-----------------|-------------|------------|
| local_only | 1 | true | -1 |
| local_then_any | 2 | true | -1 |
| any_available | 3 | true | -1 |

### `pool_status_sk` (Code: `PLS`) — `pools`

| `value` | `display_order` | `is_active` | `created_by` |
|---------|-----------------|-------------|------------|
| Active | 1 | true | -1 |
| Inactive | 2 | true | -1 |

### `server_role_sk` (Code: `SRO`) — `segment_servers`

| `value` | `display_order` | `is_active` | `created_by` |
|---------|-----------------|-------------|------------|
| Main | 1 | true | -1 |
| Secondary | 2 | true | -1 |

### `segment_type_sk` (Code: `SGT`) — `segments`

| `value` | `display_order` | `is_active` | `created_by` |
|---------|-----------------|-------------|------------|
| Communication | 1 | true | -1 |
| Authentication | 2 | true | -1 |
| Both | 3 | true | -1 |

### `server_preference_mode_sk` (Code: `SPM`) — `segments`

| `value` | `display_order` | `is_active` | `created_by` |
|---------|-----------------|-------------|------------|
| Prefer Main | 1 | true | -1 |
| Combination | 2 | true | -1 |
| Any | 3 | true | -1 |
| Load Balance | 4 | true | -1 |

### `failover_mode_sk` (Code: `FMO`) — `segments`

| `value` | `display_order` | `is_active` | `created_by` |
|---------|-----------------|-------------|------------|
| Latency | 1 | true | -1 |
| Round Robin | 2 | true | -1 |
| Random | 3 | true | -1 |

### `segment_status_sk` (Code: `SST`) — `segments`

| `value` | `display_order` | `is_active` | `created_by` |
|---------|-----------------|-------------|------------|
| Active | 1 | true | -1 |
| Inactive | 2 | true | -1 |

### `server_type_sk` (Code: `SVT`) — `servers`

| `value` | `display_order` | `is_active` | `created_by` |
|---------|-----------------|-------------|------------|
| Application | 1 | true | -1 |
| Database | 2 | true | -1 |
| Authentication | 3 | true | -1 |
| Web | 4 | true | -1 |

### `server_status_sk` (Code: `SES`) — `servers`

| `value` | `display_order` | `is_active` | `created_by` |
|---------|-----------------|-------------|------------|
| Active | 1 | true | -1 |
| Inactive | 2 | true | -1 |
| Maintenance | 3 | true | -1 |
| Offline | 4 | true | -1 |

### `health_check_status_sk` (Code: `HCS`) — `servers`

| `value` | `display_order` | `is_active` | `created_by` |
|---------|-----------------|-------------|------------|
| Online | 1 | true | -1 |
| Offline | 2 | true | -1 |
| Degraded | 3 | true | -1 |
| Unknown | 4 | true | -1 |

### `detection_method_sk` (Code: `DTM`) — `workflows`

| `value` | `display_order` | `is_active` | `created_by` |
|---------|-----------------|-------------|------------|
| Regex | 1 | true | -1 |
| Prefix | 2 | true | -1 |
| Exact | 3 | true | -1 |

### `account_creation_mode_sk` (Code: `ACM`) — `workflows`

| `value` | `display_order` | `is_active` | `created_by` |
|---------|-----------------|-------------|------------|
| Auto Create | 1 | true | -1 |
| Deny Access | 2 | true | -1 |
| Allow Without Account | 3 | true | -1 |

### `workflow_status_sk` (Code: `WFS`) — `workflows`

| `value` | `display_order` | `is_active` | `created_by` |
|---------|-----------------|-------------|------------|
| Active | 1 | true | -1 |
| Inactive | 2 | true | -1 |
| Testing | 3 | true | -1 |

---

## Dependencies

| Depends On | Relationship | Notes |
|------------|-------------|-------|
| [FILL] | [FILL] | [FILL] |

---

## Columns

| Column Name | Data Type | Nullable | Default | Constraints | Description |
|-------------|-----------|----------|---------|-------------|-------------|
| `sk` | `integer(32)` | NO | `nextval('lookup_sk_seq'::regclass)` |  | [FILL] |
| `type` | `character varying(50)` | NO |  |  | [FILL] |
| `code` | `character varying(100)` | NO |  |  | [FILL] |
| `value` | `character varying(255)` | NO |  |  | [FILL] |
| `display_order` | `integer(32)` | YES |  |  | [FILL] |
| `is_active` | `boolean` | YES |  |  | [FILL] |
| `created_by` | `integer(32)` | YES | `'-1'::integer` |  | [FILL] |
| `created_at` | `timestamp with time zone` | YES | `now()` |  | [FILL] |
| `updated_by` | `integer(32)` | YES | `'-1'::integer` |  | [FILL] |
| `updated_at` | `timestamp with time zone` | YES | `now()` |  | [FILL] |

---

## Indexes

| Index Name | Columns | Type | Purpose |
|------------|---------|------|---------|
| [FILL] | [FILL] | B-tree | [FILL] |

---

## Foreign Keys

| Column | References | On Delete | On Update | Notes |
|--------|------------|-----------|-----------|-------|
| [FILL] | [FILL] | [FILL] | [FILL] | [FILL] |

---

## Triggers

| Trigger Name | Event | Function | Purpose |
|--------------|-------|----------|---------|
| `trg_lookup_updated_at` | BEFORE UPDATE | `update_updated_at_column()` | Auto-update updated_at |

---

## Constraints

| Constraint Name | Type | Columns / Expression | Notes |
|-----------------|------|----------------------|-------|
| [FILL] | CHECK/UNIQUE | [FILL] | [FILL] |

---

## Waitlist Support

- [ ] This table directly represents a reservable resource
- [ ] This table has a related waitlist table
- [ ] Waitlist promotion handled by: [FILL]

---

## Audit Requirements

- [ ] Changes logged to: [FILL]
- [ ] Audit function: [FILL]

---

## SQL DDL

```sql
-- See actual database schema
-- Use: \d lookup in psql or pg_dump
```

---

## Notes for Developer

- [FILL: Important notes about this table]
