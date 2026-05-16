# Database & GUI Structure

> **Note:** All database tables and fields should use lowercase_snake_case

---

## Table of Contents
- [Pre-Loaded Database Entries](#pre-loaded-database-entries)
- [Users Table](#users-table)
- [User Groups Table](#user-groups-table)
- [User Tiers Table](#user-tiers-table)
- [User Types Table](#user-types-table)
- [Resources Table](#resources-table)
- [Resource Types Table](#resource-types-table)
- [Areas](#areas)
- [Kiosks](#kiosks)
- [Locations Table](#locations-table)
- [Free Time Table](#free-time-table)
- [Transactions](#transactions)
- [Messaging Table](#messaging-table)
- [Experience Table](#experience-table)

---

## Pre-Loaded Database Entries

### Pre-Defined Zones
- **Everywhere** (includes everything - always - and cannot be edited)

### Pre-Defined Resource Types
- Standard PC
- Standard Mac
- Laptop
- Study Room
- Conference Room
- Maker Space Station
- A/V Equipment

### Pre-Defined User Tiers
- System Administrator
- Organization Admin
- Desktop Services
- Special Events & Operating Hours
- Location Manager
- Staff Operator
- Basic User

### Pre-Defined User Generation Profile Templates
- Portal Self-Service
- Kiosk Guests

### Pre-Defined Global Default Experience
- Global Default (cannot be deleted)

---

## Users Table
**Table:** `users`

**Setup:** SetupComplete = 0 (defaults to false)

### Core Fields

| Function | Details | Field Name |
|----------|---------|------------|
| Logon ID | Unique ID | - |
| Password | Encrypted | - |
| Active | False/True (0/1) - Indicates whether an account has been inactive for the specified interval | - |
| Active/Inactive Date | Read Only - Updates anytime active/inactive is *modified* (importing without a change = no date change) | - |
| Expired | False/True (0/1) - Indicates whether a special account has expired | - |
| Expired/Enabled Date | Read Only - Updates anytime expire/enabled is *modified* (importing without a change = no date change) | - |
| Banned/Reinstated/Authorized | Default is Authorized for a new account, once banned the only option selectable is reinstated | - |
| Banned/Reinstated Date | Read Only - Updates anytime active/inactive is *modified* (importing without a change = no date change) | - |
| CUID / GUID | Read Only | - |
| Created date | Read Only | - |
| Created Location | - | - |
| First Authentication | Changes from NULL to current date/time on first successful authentication | - |
| Last Authentication | Updates on any successful authentication | - |
| Last Authentication Location | Location code? | - |
| ID history | Read Only - Trigger field - Keep list of x most recent ID numbers with date of change (if enabled - see System > Update ID History) | - |
| User Types | Calculated ???? | - |
| User Automations | Calculated ???? | - |
| User Group | Drop down | - |
| User Tier | Drop down | - |
| User Zone | Admins only? | - |
| Special Account | - | - |
| Total Sessions | - | - |

### Personal Information

| Function | Details | Field Name |
|----------|---------|------------|
| Name: First Name(s) | - | - |
| Name: Middle Name/Initial | Can be hidden/disabled | - |
| Name: Last Name(s) | - | - |
| Email Addresses | Support multiple comma separated email addresses - marking the first as 2FA moves that email to the first entry | - |
| Birthdate | Can be hidden/disabled - If enabled, allows storing user birthdate for age based permissions | - |
| Physical Address | Can be hidden/disabled | - |
| Phone | Can be hidden/disabled - Allows entry of phone number based on defined number format(s) | - |
| Comments | Allows multi-line comments to be entered | - |

### Custom Fields

| Function | Details | Field Name |
|----------|---------|------------|
| Custom Field 1 | Custom field should be displayed by its customizable label (relabeled inside GUI) | - |
| Custom Field 2 | Custom field should be displayed by its customizable label | - |
| Custom Field 3 | Custom field should be displayed by its customizable label | - |
| Custom Field 4 | Custom field should be displayed by its customizable label | - |
| Custom Field 5 | Custom field should be displayed by its customizable label | - |

### External System Integration

| Function | Details | Field Name |
|----------|---------|------------|
| External Record Number | Unique ID number to identify/match user in external system | - |
| External Record Dump | If enabled, cache last dump of patron profile for parsing against in offline scenario | - |
| External Profile | User's external profile affiliation stored from most recent usage, calculated from external record dump if null, drop down list populated from defined patron profiles (if defined) with N/A auto added to the list | - |

### Additional ID Fields

| Function | Details | Field Name |
|----------|---------|------------|
| ID+: Alias | Must be unique | - |
| ID+: Alias Format | Manual (manually entered alias), Mismatched (alias does not match the currently configured format), {Alias Format} (display label of type matched) | - |
| ID+: Barcode number | Check for collisions - offer option of reviewing other account, removing from other account, merging with other account | - |
| ID+: Magstripe number | - | - |
| ID+: QR code ID | - | - |
| ID+: Prox card (plastic) | - | - |
| ID+: Mobile credential | - | - |
| ID+: Watch credential | - | - |
| ID+: Identifier1 | - | - |
| ID+: Identifier2 | - | - |
| ID+: Identifier3 | - | - |
| ID+: Identifier4 | - | - |
| ID+: Government ID # | - | - |
| ID+: Gov ID Type | - | - |

---

## User Groups Table
**Table:** `users_groups`

| Function                    | Details                                   | Field Name |
| -----------------------------| -------------------------------------------| ------------|
| Name / Label                | -                                         | -          |
| Environment                 | -                                         | -          |
| Zone                        | -                                         | -          |
| Max Reservations per day    | Global + Cascading per Location (integer) | -          |
| Max Use Time per day        | Global + Cascading per Location (integer) | -          |
| Session Extension Level 1   | Global + Cascading per Location (integer) | -          |
| Session Extension Level 2   | Global + Cascading per Location (integer) | -          |
| Session Extension Level 3   | Global + Cascading per Location (integer) | -          |
| Max Missed Waitlist Res     | Cascading per Location                    | -          |
| Max Missed Scheduled Res    | Cascading per Location                    | -          |
| Missed Scheduled Res Window | All / Integer of Weeks                    | -          |

---

## User Tiers Table
**Table:** `user_tiers`

| Function | Details | Field Name |
|----------|---------|------------|
| See Core Setup for Basic Use | - | - |
| At the User Type level, display calculated Locations where it is permitted | - | - |

---

## User Types Table
**Table:** `user_types`

| Function | Details | Field Name |
|----------|---------|------------|
| See Core Setup for Basic Use | - | - |

---

## User Generation Profile Template Variables

**Note:** These require direct DB edit

- **Max quantity:** Default to 500, reset down to 500 if higher value entered
- **MinLogonCombinationsAllowed:** 100 (Warn if User Type generation format is likely to fail at creating all accounts due to constraints on unique characters & advise if fewer than requested were generated)
- **MinPasswordCombinationsAllowed:** 100 (Warn if total possible unique passwords is fewer than X)

### Error Messages/Warnings
- Define Ranges/Blocks for Errors
- Odds vs. Evens (server to client vs client to server)
- Unable to generate all users requested

### Prompts/Verbiage
- Wording for unauthenticated reservations (go see staff, or proceed to resource)

---

## Resources Table
**Table:** `resources`

| Function | Details | Field Name |
|----------|---------|------------|
| Hostname | - | - |
| Location | - | - |
| Area | - | - |
| Sub-group | - | - |
| Staff Session? | - | - |
| Needs Attention | - | - |
| Asset tag # | - | - |
| Service Tag / Serial # | - | - |
| Software Version / Schema | - | - |
| Cooldown Remaining | Auto re-enable when timer gets to zero? | - |
| Auto start vs. staff started | For non-authenticated entities (Compound Resource will override sub components) | - |
| Directly Reserve | When making a Resource directly reservable, if Compound Reserve Only is enabled warn before enabling and disable CRO when DR is enabled | - |
| Compound Reserve Only | If only reservable as part of a Compound Resource, warn before disable Direct Reservation when this is enabled | - |
| Linked/Connected to compound resource type? | - | - |

---

## Resource Types Table
**Table:** `resource_types`

| Function | Details | Field Name |
|----------|---------|------------|
| Permitted Reservation Methods | Same for Compound Resource Types | - |
| Permissions Matrix | User Tier / User Type / User Group / Reservation Type | - |
| Experience | - | - |

---

## Areas

| Function | Details | Field Name |
|----------|---------|------------|
| **Workstation Options** | | |
| Lockout Interval | Block logons for X seconds - allows time to trigger reboot while not allowing anyone to log back in | - |
| Session Cooldown | Available Immediately / Disable Indefinitely / Make available after X *seconds* (for ended sessions, allow for cleaning, prevent shoulder-surfers, login prior to reboot, etc) | - |
| Logoff Auto-Reboot | Enable/disable automatic reboot when session ends or system is logged off | - |
| Scheduled Shutdown | Enable self-shutdown (option for X minutes after specified schedule or specific time) | - |
| Schedule | Specify availability of resources in this area | - |
| Shutdown Schedule | Specify Schedule on which shutdowns should be calculated (e.g., building hours, or a maintenance schedule) | - |
| Shutdown | Disabled (Leave On) / X minutes after Shutdown Schedule (5, 10, 15, 20, 30, 45, 60, 90, 120) / Specific time of day | - |
| **Permissions** | | |
| Permissions Matrix | User Tier / User Type / User Group | - |
| **Offline Settings** | | |
| Offline Mode | Allow Logons / Disallow Standard Logons | - |
| Offline Profile | Use last know good Experience / Use Offline Mapping in Experiences | - |
| Offline Enforcement | None / Must match a cached User Type | - |
| Reboot on Logoff | - | - |
| Staff Logon | - | - |
| **Instant Accounts/Reservations** | | |
| Allow Instant Accounts / Reservations | Enable additional button | - |
| Instant Res/Accounts Only | Change logon behavior? | - |
| **Reservation Settings** | | |
| Reservation Types | (Resource Type can supersede this option) | - |
| Reservation Duration - Full Session | Integer (must be greater than Quick Session value) | - |
| Reservation Duration - Quick Session | Integer (must be less than Full Session value) | - |
| Reservation Duration - Calculation | Respect Resource Type, Least Restrictive, Most Restrictive, Force Override | - |
| **Time Allocation** | | |
| Time Allocation Mode | Personal Time Only / Free Time Only / Free Time + Personal Time (allows personal account time to be used, otherwise only minutes from Free time can be used) | - |
| Free Time | Free Time bucket assigned to this Area (greys out if Time mode is set to Personal Time Only) | - |
| Free Time Permissions | Optionally specify if only certain User Tier / User Type / User Group are allowed to spend personal time (greys out if Time mode is set to Personal Time Only) | - |
| **Session Extension** | | |
| Session Extension Matrix | Enabled/Disabled | - |
| Minimal Utilization (Purple) | All Extension Options / Threshold 1 / Threshold 2 / Threshold 3 / Sand timer / Pause only | - |
| Reduced Utilization (Blue) | All Extension Options / Threshold 1 / Threshold 2 / Threshold 3 / Sand timer / Pause only | - |
| Typical Utilization (Green) | All Extension Options / Threshold 1 / Threshold 2 / Threshold 3 / Sand timer / Pause only | - |
| Elevated Utilization (Orange) | All Extension Options / Threshold 1 / Threshold 2 / Threshold 3 / Sand timer / Pause only | - |
| Heavy Utilization (Red) | All Extension Options / Threshold 1 / Threshold 2 / Threshold 3 / Sand timer / Pause only | - |
| Session Extension Level 1 | As per User Group / Override (integer) | - |
| Session Extension Level 2 | As per User Group / Override (integer) | - |
| Session Extension Level 3 | As per User Group / Override (integer) | - |
| **Terms of Service** | | |
| Terms of Service | - | - |
| ToS Declined Behavior | Cancel Session / Block Internet Experience / Filter Internet Experience (Use a ToS Declined Experience) | - |
| **Text String Overrides** | | |
| TBD | Mostly mirrors global errors/warning/prompts | - |

---

## Kiosks

### Common Fields

| Function | Details | Field Name |
|----------|---------|------------|
| Kiosk Name/Label | Free form text string (nvarchar) | - |
| Kiosk Code | 3-4 Character nvarchar Prefix/code used in placeholders and abbreviated references (e.g. KSK) | - |
| Kiosk Description | Free form text string (nvarchar) | - |
| Asset tag # | Free form text string (nvarchar) | - |
| Service Tag / Serial # | Free form text string (nvarchar) | - |

### Core Settings

| Function | Details | Field Name |
|----------|---------|------------|
| Location | Select from dropdown | - |
| Assigned Area/Pool | Select from dropdown | - |
| Pooling Mode | Inherit from Pool / Disable Spillover / Waitlist Triggered (Spillover) / User Selects Area | - |
| Schedule | Select from dropdown | - |
| Permissions Matrix | User Tier / User Type / User Group | - |
| Comms Segment | Select single Segment from dropdown (Segments available determined by Location assigned) | - |
| Comms Behavior | Home server & Behavior comes with Segment assignment (read only?) | - |
| Home Server | - | - |
| Workflow | Selectable from list of Workflows enabled at the Location level | - |
| Terminal ID | Potentially supplied to external systems | - |
| Terminal Type | Workstation vs. Portal | - |
| Portal Association | Read Only (entry associated with Access Portal) | - |
| Software Version | Read only (updated by system at check-in) | - |

### Configuration

| Function | Details | Field Name |
|----------|---------|------------|
| Theme | TBD | - |
| Theme Options | TBD | - |
| Default Interface Size | Small / Medium / Large / Extra Large | - |
| Kiosk Features Enabled | Reservations / User Account "management" | - |
| Kiosk Feature Default | User choice, or specify one | - |
| Session Reservation Types | Instant / Waitlist / Scheduled | - |
| Session Duration Types | Checkboxes: Full / Quick | - |
| Schedule Res Blockout Override | Inherit from Location | - |

### Session Settings

| Function | Details | Field Name |
|----------|---------|------------|
| QR Code Login | Enable / Disable | - |
| Skip "Have Account" choice? | Skip prompt screen asking user to categorize as having account or needing one | - |
| Force Self-Categorization | Enable Kiosk screen that requires Users to choose between "I have an account" and "I do not have an account" (text should be customizable) | - |
| Inactivity Timer | Integer | - |
| Show Timer | Enable / Disable | - |

### Account Creation

| Function | Details | Field Name |
|----------|---------|------------|
| On-Demand User Generation | Disabled / Kiosk button / screen that allows self-service generation of User Account | - |
| User Generation Profile | Maps which User Generation Profile Template is used when creating accounts for end users | - |
| Account Display Interval | Duration of time to display User Account information for newly created accounts (if enabled at Location level) | - |
| Output Type Override | Screen / Printer / Etc | - |
| Missed Session Time Allocation | When logging missed session transactions, allocate time accordingly: Count missed session time against the user, log it as zero minutes, log it as free time/wait time? | - |

### Security Features

| Function | Details | Field Name |
|----------|---------|------------|
| App Menu Access | Taps / Keyboard shortcut / etc. | - |
| Log Off Password | - | - |
| Offline Admin Username | - | - |
| Offline Admin Password | - | - |
| Admin Levels | Specify User Tiers considered Admins (for viewing config at kiosk) | - |

### Text String Overrides
TBD - Mostly mirrors global errors/warning/prompts

---

## Locations Table
**Table:** `locations`

### Location Details

| Function | Details | Field Name |
|----------|---------|------------|
| Name/Label | - | - |
| Name | - | - |
| Location Code | 3-4 Character nvarchar Prefix/code used in placeholders and abbreviated references (e.g. ARD) | - |
| Schedule: Building Accessibility | This is the "public" schedule for the Location | - |
| Time Zone | - | - |

### Public Information

| Function | Details | Field Name |
|----------|---------|------------|
| Public: Location Address | - | - |
| Public: Location Phone | - | - |
| Public: WWW | - | - |
| Contact Info | - | - |
| Vendor Info | - | - |
| Nearby sites/branches | - | - |

### Available Resources

| Function | Details | Field Name |
|----------|---------|------------|
| Available User Types | - | - |
| Available Workflows | - | - |
| Available Segments | - | - |

### Server Configuration

| Function | Details | Field Name |
|----------|---------|------------|
| Preferred Server | Servers are ordered with default/preferred server auto-moved to top of the list | - |
| Failover Behavior | Local (default) Only, Any Server (Prefer Local/default), Any Server | - |
| Failback Interval | Frequency in seconds between check-ins/attempts to return to preferred server (ignored if Any Server is selected) | - |
| Server Marked Offline | - | - |

**Note:** Perhaps a separate table with these entries: Location ID + Segment ID + Preferred Server ID + Behavior Config?

### Private Information

| Function | Details | Field Name |
|----------|---------|------------|
| Private: Location Manager Contact | Require name, phone number, and email address | - |
| Private: Technical Contact | Require same data - Option to inherit from the Organization level | - |
| Private: Vendor Contact | Require same data - Option to inherit from the Organization level | - |

### Session Limits

| Function | Details | Field Name |
|----------|---------|------------|
| Max Sessions per Location | Default to As per User Group (if enabled, the more restrictive policy is followed) | - |

### Timeouts (Default to inherit from globals)

| Function | Details | Field Name |
|----------|---------|------------|
| Timeouts: Idle Session | Default to inherit from globals | - |
| Timeouts: Locked Session | Default to inherit from globals | - |
| Timeouts: Login Attempt | Default to inherit from globals | - |
| Timeouts: Hold After Reboot | Default to inherit from globals | - |
| Timeouts: Reauthenticate | Default to inherit from globals | - |

### Session Time Settings (Default to inherit from globals)

| Function | Details | Field Name |
|----------|---------|------------|
| Session Time: Extension Trigger Point | Default to inherit from globals | - |
| Session Time: Courtesy Notice | Default to inherit from globals | - |
| Session Time: Low Warning | Default to inherit from globals | - |
| Session Time: Critical Alert | Default to inherit from globals | - |
| Session Time: Unauthenticated User | Default to inherit from globals | - |

### Reservation Times (Default to inherit from globals)

| Function | Details | Field Name |
|----------|---------|------------|
| Times: Missed Block Reservation | Default to inherit from globals | - |
| Times: Missed Queued Reservation | Default to inherit from globals | - |
| Times: Missed Scheduled Reservation | Default to inherit from globals | - |
| Times: Scheduled Reservation Overdue Flag | Disabled / Minutes Integer (should be less than Missed Schedule Reservation to have any effect) - Default to inherit from globals | - |

### Reservation Restrictions

| Function | Details | Field Name |
|----------|---------|------------|
| Schedule Res Days Advance | Disallow Scheduled reservations more than X days in advance | - |
| Schedule Res Blockout | Prevent all Scheduled Reservation less than X minutes in the future | - |
| Schedule Res Max Concurrent | Prevent additional Scheduled Reservations if X are already scheduled | - |

### Text String Overrides
TBD - Mostly mirrors global errors/warning/prompts

### User Generation Config / Overrides

| Values                   | Matrix Print                                                                                                                                                                                      | Receipt Print | On-Screen |
| --------------------------| ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------| ---------------| -----------|
| Location Code            | e.g., ARD                                                                                                                                                                                         |               |           |
| Profile Templates        | Check box: Whitelist of Profile Templates available for selection at this Location - including default. New locations allow all and default is first in list of User Generation Profile Templates |               |           |
| Profile Template Default |                                                                                                                                                                                                   |               |           |
| Output Type Default      | e.g., user select, matrix, receipt, on-screen                                                                                                                                                     |               |           |

#### Core Defaults/Option Overrides

| Option | Matrix Print | Receipt Print | On-Screen |
|--------|-------------|---------------|-----------|
| Quantity Overrides | Inherit | Inherit | Inherit |
| User Group Override | Inherit | Inherit | Inherit |
| User Type Override | Inherit | Inherit | Inherit |

#### Print Options

| Option                                                     | Matrix Print | Receipt Print | On-Screen |
| ------------------------------------------------------------| --------------| ---------------| -----------|
| Logo                                                       | Inherit      | Inherit       | Inherit   |
| Title                                                      | Inherit      | Inherit       | Inherit   |
| Receipt Header 1                                           | Inherit      | Inherit       | Inherit   |
| Receipt Header 2                                           | Inherit      | Inherit       | Inherit   |
| Receipt Footer 1                                           | Inherit      | Inherit       | Inherit   |
| Receipt Footer 2                                           | Inherit      | Inherit       | Inherit   |
| Read only - display validity details from User Automations | Inherit      | Inherit       | Inherit   |
| Validity Message                                           | Inherit      | Inherit       | Inherit   |

#### Output Options

| Option | Matrix Print | Receipt Print | On-Screen |
|--------|-------------|---------------|-----------|
| Include Username | Inherit | Inherit | Inherit |
| Include Password | Inherit | Inherit | Inherit |
| Include User Group | Inherit | Inherit | Inherit |
| Include Scannable ID | Inherit | Inherit | Inherit |
| Desired Scannable ID Format/Symbology | Inherit | Inherit | Inherit |
| SSO QR Code? | Inherit | Inherit | Inherit |
| Desired Size (e.g., small, medium, large, extra large) | Inherit | Inherit | Inherit |

---

## Free Time Table
**Table:** `free_time`

| Function | Details | Field Name |
|----------|---------|------------|
| Name/Label | - | - |
| Areas assigned | One or more Areas - Area can only be associated to a single Free Time entity | - |
| Max Daily Time | Set a max time limit per day per account | - |

---

## Transactions
**Table:** `resource_types`

| Function                  | Details                                                                                                                                                   | Field Name |
| ---------------------------| -----------------------------------------------------------------------------------------------------------------------------------------------------------| ------------|
| Transaction Type          | -                                                                                                                                                         | -          |
| Reservation Type          | Block/Maintenance/Scheduled/Waitlist/Walk-Up                                                                                                              | -          |
| Duration Type             | Full/Quick                                                                                                                                                | -          |
| Reservation Flags         | Kiosk/Portal/Endpoint                                                                                                                                     | -          |
|                           | End User/Staff                                                                                                                                            | -          |
|                           | Missed/Cancelled/Extended/Adjusted/Assisted/Group/Abbreviated*/Incomplete/Moved/Overdue/Elevated/Prioritized/PushAuth/Rebooted/Technician/TosDeclined/2FA | -          |
|                           | *AKA Less than guaranteed time - standby, EOB sessions, sessions capped by scheduled/blocked res, etc.                                                    | -          |
| Wait Time                 | Time between creation of reservation and assignment to a PC or cancellation                                                                               | -          |
| Origin of Reservation     | Specific Authenticated Resource, Kiosk, or Portal                                                                                                         | -          |
| Personal Time Used        | -                                                                                                                                                         | -          |
| Free Time Used            | -                                                                                                                                                         | -          |
| Late Time Used            | Used to account for charging missed sessions before timeout and/or late sign-ins for Scheduled session                                                    | -          |
| Session Type/Class/Etc.   | -                                                                                                                                                         | -          |
| Location of Transaction?? | -                                                                                                                                                         | -          |
| Res creation time         | -                                                                                                                                                         | -          |
| Res assignment time       | -                                                                                                                                                         | -          |
| Res scheduled time        | -                                                                                                                                                         | -          |
| Res logon time            | -                                                                                                                                                         | -          |
| Res canceled/missed time  | -                                                                                                                                                         | -          |
| Res Cancelling account    | User / Staff / System Automation                                                                                                                          | -          |
| Res                       | -                                                                                                                                                         | -          |

---

## Messaging Table
**Table:** `messaging`

### Broadcast Message Options

| Function | Details | Field Name |
|----------|---------|------------|
| Broadcast: Audience | Area(s), Pool(?), Location | - |
| Broadcast: Delivery Start | Default to ASAP, allow setting specific time with TZ (do not deliver before) | - |
| Broadcast: Delivery End | Default to Today only (EOB) - Offer a date picker, do not attempt delivery after selected date | - |
| Broadcast: Message | List of canned responses (assignable to zone), or free form (message content included in audit) | - |
| Broadcast: Purge | Read only - Message and delivery status purges after X days (default to 1 year) | - |

**Note:** Zone permissions are evaluated when editing/deleting a message by comparing the Location/Area/etc. of the message against the Zone assigned to the User Account of the logged in user (dictating their abilities to manage a message with pending actions)

### Standard Message Options

| Function | Details | Field Name |
|----------|---------|------------|
| Standard: Audience | User, Authenticated Resource | - |
| Standard: Delivery Start | ASAP (only option) | - |
| Standard: Delivery End | Default to Today only (EOB) - Offer a date picker, do not attempt delivery after selected date | - |
| Standard: Message | List of canned responses (assignable to zone), or free form (audited) | - |
| Standard: Purge | Option to constrain to Location? (Default to constrain? User Tier permission setting?) | - |

### Pending Messages

**Note:** Zone permissions are evaluated to compare the location/area/etc. of the message against the Zone assigned to the User Tier of the logged in user (dictating their abilities to manage a message)

- Hold onto messages that expire for 7 days - option to delete?
- Auto-select user/auth resource when engaging from specific user or resource in admin

---

## Experience Table
**Table:** `experiences`

| Function | Details | Field Name |
|----------|---------|------------|
| Name/Label | - | - |
| Credential Type | Shared (send common/stored credential to OS) or Pass Thru (pass end user credentials to underlying OS) | - |
| Language Enabled | E.g., English, Spanish, Etc. | - |
| ToS Behaviors Enabled | Block all Internet / Filter Internet | - |
| Offline Mappings | Read Only / Calculated: User Types / Location User Types / Etc. | - |
| Username / Domain / Password Matrix | (Standard + ToS options (2)) x Languages | - |
| Permissions Matrix??? | User Tier / User Type / User Group (prevent unintentional assignment to incorrect area?) | - |

---

*End of Document*
