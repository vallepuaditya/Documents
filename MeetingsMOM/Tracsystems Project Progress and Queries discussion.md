# Meeting Minutes (MoM) – Admin Portal, Locations, Resources, Schedules & User Management Discussion


---

# 1. Meeting Objective

The meeting focused on:

* Reviewing current database structure and admin portal modules
* Discussing locations, schedules, resources, resource categories, and user management
* Validating UI/UX direction for admin workflows
* Clarifying schedule override hierarchy
* Discussing permissions, user tiers, and bulk edit functionality
* Reviewing future modules:

  * User kiosk/reservations
  * Workstation access
  * Resource management
  * Zone-based permissions

Frankly, this was not just a “demo.” It was a requirements correction session. The client repeatedly reshaped assumptions around schedules, overrides, permissions, and admin UX. Which is normal in enterprise software. Humans never know what they want until they see what they definitely don’t want.

---

# 2. Current Database & Core Architecture Discussion

## Confirmed Base Architecture

### Location Table

* `Locations` is the foundational table
* Most records across the system will reference locations via foreign keys
* Location acts as a core organizational entity

### Resource Hierarchy

Current hierarchy discussed:

```text
Location
 └── Resource Categories
      └── Resource Types
           └── Resources
```

### Resource Categories Examples

Examples discussed:

* PCs
* 3D Printers
* Conference Rooms
* Projectors
* Study Rooms
* Research Rooms

Steven clarified:

* Resource categories are acceptable
* Resource types may often be more important than categories
* Resource category management UI will still be required later



---

# 3. Workstation Access & Active Sessions

## Important Clarification

Current implementation status:

* Reservations module exists
* Workstation access tables are NOT fully implemented yet
* Active session tracking is pending

### Planned Future Work

Future module discussion planned for:

* Workstation access tables
* Active session handling
* Session lifecycle tracking

The team clarified:

* Current focus is:

  * Locations
  * Users
  * Resources
  * Admin portal foundation



---

# 4. Admin Portal Strategy

## Critical Architectural Direction

Client emphasized:

> “Admin portal is the base of everything.”

Meaning:

* All modules connect through admin portal
* Admin portal acts as the operational nerve center
* UI consistency and efficient workflows are critical

### Planned Module Order

1. Admin Portal
2. User Kiosk / Reservations
3. Workstation Access



---

# 5. Schedule, Holidays & Override Architecture (Major Discussion)

This was one of the most important discussions in the meeting. And honestly, this changes your database thinking significantly.

## Existing Team Assumption

Current implementation idea:

* Location has:

  * holidays
  * schedule overrides
  * open/close timings

## Client Correction

Steven strongly suggested:

### Schedules should own overrides and holidays

NOT locations.

---

# Correct Hierarchy Expected by Client

```text
Schedule
 ├── Holidays
 ├── Special Closures
 ├── Override Hours
 └── Assigned Locations/Areas
```

### Key Principle

Locations inherit schedule behavior.

NOT:

```text
Location → Override
```

BUT:

```text
Schedule → Override → Assigned Locations inherit
```

---

# Why This Matters

Client scenario:

```text
17 branches share same schedule
```

If all branches close early:

* Admin should create ONE override
* Apply override to schedule(s)
* All assigned locations inherit automatically

Instead of:

* Editing 17 locations individually

This is enterprise-grade thinking. Your original design was becoming location-centric instead of schedule-centric. That scales badly.



---

# 6. Expected Schedule System Design

## Expected Entities

### Schedules

Contains:

* Standard operational hours
* Assignment targets

### Schedule Overrides

Examples:

* Close at 3 PM today
* Open late tomorrow
* Temporary closures

### Holidays

Examples:

* Christmas
* Public holidays
* Institution-wide closure days

### Assignments

Schedules assigned to:

* Locations
* Areas

---

# Expected Functional Behavior

## Example 1

```text
Main Schedule
 ├── Applied to 17 branches
 ├── Holiday: Christmas
 └── Override: Close at 3 PM
```

All branches inherit automatically.

---

## Example 2

Location-specific behavior:

* Create dedicated schedule
* Apply unique override only there

This avoids duplicate override entries everywhere.



---

# 7. User Management & Account Creation

## Important Business Clarification

### Manual account creation should be rare

Client expectation:

* Most accounts generated automatically
* Typical flows:

  * Temporary pass generation
  * Visitor pass creation
  * Automated account generation

### Manual account creation mostly for:

* Staff/admin users

This affects:

* UX priorities
* Form complexity
* Workflow optimization



---

# 8. Admin UI/UX Expectations (Very Important)

Steven repeatedly emphasized:

## Client Strongly Prefers:

# DATA GRID UI

Instead of:

* Popup-heavy workflows
* Card-based editing

---

# Expected UX Pattern

```text
Grid View
 → Click row
 → Edit inline or detail pane
 → Click away
 → Auto commit
```

### Desired Characteristics

* Persistent filters
* Fast editing
* Multi-item workflows
* Minimal clicks
* Rapid admin operations

---

# Explicit Rejection

Client dislikes:

* Constant popup editing
* Reopening dialogs repeatedly
* Losing navigation state



---

# 9. Desired Navigation Structure

## Suggested Navigation Layout

### Left Sidebar

Core modules:

* Users
* User Groups
* Locations
* Resources
* Schedules
* etc.

### Top Navigation

Quick actions:

* Search
* Create
* Merge
* More actions dropdown

Client referenced PaperCut admin UI as preferred inspiration.

---

# Key UX Requirement

Menus should remain visible regardless of scroll position.

Admin users should not:

* hunt visually
* scroll excessively
* lose context

This is actually a valid criticism. Enterprise admins care about speed, not “modern minimalistic card poetry.”



---

# 10. Filtering & Search Expectations

## Current Client Pain Point

Existing solution filtering is considered:

* clumsy
* repetitive
* inefficient

## Expected Improvement

Support:

* multi-field filtering before executing search

Example:

```text
First Name
Last Name
User Group
Location
```

Then:

```text
Single search execution
```

Instead of repeated search actions.



---

# 11. Permission Model Discussion

## Permission Visibility Logic

### Expected Rules

#### Case 1

User can:

* see module
* view data
* edit data

#### Case 2

User can:

* see module exists
* but cannot view details

#### Case 3

User cannot:

* even see module/menu

This permission granularity applies across:

* user tiers
* schedules
* resources
* groups



---

# 12. Bulk Edit Requirements

## Bulk Editable Entities

Client expects bulk operations for:

* User accounts
* User groups
* Resources
* Resource types
* Areas
* Schedule assignments

### Examples

* Move multiple resources
* Change schedule for many areas
* Update permissions in bulk

---

# NOT Bulk Editable

Client clarified:

* User tiers
* User types

Reason:

* Significant structural differences between types



---

# 13. Edit/Delete Button Placement

## Client Recommendation

Avoid:

* Edit/Delete buttons on every row

Preferred:

* Top action toolbar

Workflow:

```text
Select Item
→ Actions enabled on top
→ Edit/Delete/Add
```

This saves screen real estate.



---

# 14. Inline Editing Expectation

## Preferred Workflow

```text
Select item
→ Details appear below
→ Edit inline
→ Changes commit directly
```

Avoid:

* popups
* extra screens
* repeated dialog navigation

Permission-aware editing required:

* view-only
* edit
* delete
* create



---

# 15. User Groups & Automation Rules

## Important Business Rule

User accounts inherit automation rules from user groups.

Examples:

* Visitor purge overnight
* Anonymize inactive users
* Session cleanup rules

---

# Expected User Group Display

Should show:

* Max session minutes
* Max sessions/day
* Privacy automation rules
* Purge/anonymization behavior

Note:
These values may originate from other tables but should be displayed contextually.



---

# 16. Column Visibility Strategy

Client proposed 3 categories:

## Category 1

Always visible by default

## Category 2

Optionally visible columns

## Category 3

Never visible in UI

Example:

* SQL record IDs should NEVER appear

This implies future:

* configurable grid columns
* saved grid layouts



---

# 17. Locations Module Discussion

## Current Fields

* Name
* Address
* Phone
* Email
* Status
* Timezone
* Location code
* Open/close time
* Website

---

# Important Clarification

Client again emphasized:

### Schedule determines hours

NOT location directly.

Meaning:

* Open/close times should come from assigned schedule
* UI may display them
* But source of truth should be schedule



---

# 18. Location Codes

## Decision

Location codes:

* Manual entry acceptable
* Usually abbreviations/initials
* Auto-generation unnecessary for now

Reason:

* Locations are not created frequently



---

# 19. Resource Categories UI

## Current State

Resource category management:

* temporarily embedded inside Resource Types UI

## Future Expectation

Dedicated menu item under:

```text
Resources
 └── Categories
```

Client expects:

* create
* edit
* delete
* manage



---

# 20. Future Resource Category Discovery

Client requested internal review with his team to identify:

* additional real-world categories
* existing client resource structures

Current known categories:

* PCs
* 3D printers
* Conference rooms

More categories expected later.



---

# 21. Schedule Permissions & Staff Restrictions

## Important Permission Concept

Example permissions:

* Create schedule
* Modify schedule
* Create special closure
* Create holiday

Staff may:

* close branch early
* create temporary closure

But may NOT:

* modify base schedules

This is a very important distinction:

# Operational override permissions ≠ configuration permissions



---

# 22. Zone-Based Permissions (Future Architecture)

## Planned After Beta

Zones will define:

* WHERE users can perform actions

Examples:

* Can create areas only in assigned location
* Can edit only assigned resources
* Can manage only assigned collections

This is effectively:

```text
Permission + Scope
```

Not just permission alone.

Very important for enterprise multi-branch systems.



---

# 23. Pending Actions / Next Steps

## Team Actions

* Send MOM
* Share hosted screen links
* Continue workstation access module
* Rework schedule architecture
* Improve grid-based UX
* Implement multiple schedule functionality
* Continue resource category UI

---

## Client Actions

* Provide:

  * preferred columns
  * additional resource categories
  * Thursday/Friday availability
  * additional UI suggestions via email



---

# 24. Critical Architectural Conclusions

## Major Design Corrections from Client

1. Schedule-centric overrides instead of location-centric
2. Grid-first admin UX instead of popup-first
3. Bulk operations are essential
4. Permissions require visibility granularity
5. Zones will become authorization scope boundaries
6. Automation rules inherit from user groups
7. Operational permissions separated from structural permissions

---

# 25. Risks & Design Considerations

## Potential Risks Identified

### 1. Current DB Model Misalignment

Your existing override model may need restructuring.

### 2. UI Complexity

Grid editing with permissions + inline editing + bulk ops becomes significantly more complex than card-based CRUD.

### 3. Permission Explosion

You are drifting toward:

```text
Action + Scope + Visibility + Editability
```

This becomes a serious RBAC system, not “simple admin roles.”

### 4. Future Zone Enforcement

Need future-proof schema now.
Otherwise:

* painful migrations later
* authorization rewrites later

Classic enterprise trap. People always postpone authorization architecture until it becomes a fire in production.

---

# 26. Overall Meeting Outcome

## Status

* Client believes project is moving in correct direction
* Significant clarity achieved
* Several architectural assumptions corrected early
* Admin portal foundation validated
* More detailed kiosk discussions planned next

## Overall Tone

Constructive and collaborative with strong client guidance on:

* operational workflows
* enterprise usability
* schedule modeling
* permission design
* admin efficiency

