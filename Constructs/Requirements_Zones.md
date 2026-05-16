# Feature: Zones

## MVP Status
**ZONES ARE MVP2 FUNCTIONALITY - NOT INCLUDED IN MVP RELEASE**

**CRITICAL REQUIREMENT**: Database schema and infrastructure must be designed and implemented NOW during MVP to support Zones functionality, even though the feature will not be activated until MVP2. This is essential to avoid costly architectural rework and data migration in the future.

## Business Objective
Zones enable geographic and organizational scope management for user accounts and user groups. They define which Locations, Areas, and Pools a user can access and manage within the system, ensuring staff members only interact with resources within their authorized geographic boundaries.

## User Story
As an **Organization Administrator**,
I want to define and assign Zones to user accounts and user groups,
So that staff members can only access and manage resources within their authorized geographic scope.

## Business Requirements

### Core Zone Capabilities (MVP2)
- **Zone Composition**: Zones can include Locations, Pools (collections of Areas), and Areas
- **Hierarchical Inheritance**: Scope is never explicit and is always inherited - when a Location is selected, all Areas within that Location are automatically included
- **Dynamic Membership**: Zones automatically update when new Areas are added to included Locations or Pools without requiring manual Zone reconfiguration
- **Pre-defined Universal Zone**: System includes a non-editable, non-deletable "Everywhere" Zone that includes all entities always
- **Multiple Zone Assignment**: Elevated users can be assigned to multiple Zones; standard users inherit one Zone from their User Group
- **Auto-removal on Decommission**: Decommissioned Locations/Areas/Pools are automatically removed from Zone definitions; deleted entities remain removed

### MVP Schema Requirements (MUST IMPLEMENT NOW)
- **Database Tables**: All Zone-related tables must be created during MVP with proper structure and relationships
- **Foreign Keys**: User accounts, User Groups, and related entities must include Zone foreign key relationships
- **Default "Everywhere" Zone**: System must create and maintain the "Everywhere" Zone record even in MVP
- **Future-Proof Design**: Schema must support all planned Zone functionality to avoid migration/rework in MVP2
- **Nullable/Default Behavior**: Zone fields may be nullable or default to "Everywhere" in MVP, but structure must be in place

### Zone Assignment Model
- **Standard Users**: Always inherit Zone from their User Group
- **Elevated Permission Users**: May inherit Zone from User Group OR have specific Zone(s) applied at user account level
- **Default Zone for User Groups**: User Groups are assigned a single Zone, defaulting to "Everywhere"
- **Default for New Users**: Standard users inherit from User Group; elevated User Tiers default to the same (often associated with "Staff" User Group)

## Functional Expectations

### Zone and Permission Interaction
- **Permission Model**: Permissions = what you can do (User Tier) + where you can do it (Zone)
- **Geographic vs Non-Geographic Sections**:
  - Zones restrict geographic scope (Locations/Areas/Resources)
  - User Tier controls access to non-geographic admin sections (Resource Types, Licensing, System Preferences)
- **View vs Edit Permissions**: Viewing and editing permissions are User Tier level settings, not Zone settings
- **Permission Enforcement**: Zone permissions evaluated when editing/deleting messages, reservations, or resources by comparing entity Location/Area against user's assigned Zone

### User Interface Behavior
- **UI Element Visibility**:
  - Sections completely lacking permissions are hidden entirely
  - Specific subsections or items outside Zone scope are greyed out/unclickable
  - Example: Constructs section may be completely hidden if no permissions; specific action items greyed out in visible sections
- **Dashboard and Heatmap Filtering**:
  - Location/Pool/Area dropdowns show all entities with non-permitted items greyed out
  - User's permitted Location is NOT pre-selected by default
- **Lockout Prevention**: System prevents administrators from locking themselves out of the system

## Business Rules

### Zone Definition Rules
- **Inheritance Behavior**: The lowest level entity checked in a Zone inherits everything below it
- **Selective Inclusion**: When an Area is selected under a Location, all other Areas at that Location are excluded until explicitly selected
- **Sub-Groups Handling**: Sub-Groups are below the threshold for explicit Zone inclusion - they are controlled by their parent Area and inherit Area permissions
- **Pool Membership**: If a Zone includes Pool X with Areas A1, A2, A3, adding Area A4 to Pool X automatically brings A4 into Zone scope

### "Everywhere" Zone Rules
- **Non-editable**: Cannot be modified or deleted
- **Default Assignment**: New System Administrators default to the "Everywhere" Zone
- **Non-removable for Admins**: Everywhere Zone cannot be removed from System Administrator accounts to prevent lockout

## Validations

### Zone Configuration Validations
- **Decommission Handling**: When a Location/Area/Pool is deleted, it auto-removes from all Zone definitions
- **Decommission vs Delete**: Decommissioned entities remain in Zone definitions; deleted entities are removed
- **User Group Zone Requirement**: User Groups must have a Zone assigned (defaults to "Everywhere" if not set)

### Permission Enforcement Validations
- **Out-of-Zone Entity Access**: Users cannot edit or delete entities (messages, reservations, resources) outside their assigned Zone(s)
- **Multi-Zone Validation**: For users with multiple Zones, access is granted if entity falls within ANY of the assigned Zones

## User Experience Expectations

### Admin Portal Experience
- **Zone Management UI**: Located under Constructs > Zones section in Admin menu
- **Grid View**: Sortable, filterable, and searchable data grid displaying Zone configurations
- **Permission Matrix Needed**: Complete matrix required showing all admin actions and whether they are (A) Tier-only, (B) Zone-scoped, or (C) both Tier + Zone required

### Visibility and Filtering
- **Hidden Sections**: Admin sections without any permissions are completely hidden from user view
- **Greyed-out Items**: Individual items or subsections outside Zone scope appear greyed out and unclickable
- **Dropdown Filtering**: Location/Area/Pool dropdowns display all options with unpermitted items visibly disabled

## Edge Cases and Exception Handling

### Zone Conflict Scenarios
- **No Zone Assigned to User Group**: If User Group has no Zone configured, users inherit "Everywhere" by default (needs confirmation)
- **User in Multiple Zones**: Elevated users with multiple Zones have cumulative access to all entities within any assigned Zone
- **Deleted Pool Scenario**: When a Pool included in a Zone is deleted, the Pool reference is auto-removed from Zone definition

### Decommission vs Delete
- **Decommissioned Entities**: Remain in Zone definitions but may be marked inactive
- **Deleted Entities**: Automatically removed from all Zone definitions
- **Admin Notification**: Unknown if admins receive alerts when Zones are affected by entity deletion (needs confirmation)

## Dependencies

### Related Modules
- **User Tiers**: Zone effectiveness depends on User Tier permissions defining what actions are allowed
- **User Groups**: Standard users inherit Zones from User Groups
- **Locations**: Zones include Locations as primary geographic boundaries
- **Areas**: Zones include Areas as granular geographic units
- **Pools**: Zones can include Pools (collections of Areas)
- **Dashboard**: Zone filtering affects what data appears in Dashboard views
- **Heatmap**: Zone scope determines visible Heatmap data

### Required Processes
- **User Authentication**: Zone assignment must be evaluated during login and session management
- **Permission Evaluation**: Every admin action requires Zone + User Tier permission check
- **Dynamic Zone Updates**: System must automatically update Zone membership when Areas/Pools change

## Reporting and Audit Expectations

### Audit Requirements
- **Audit Matrix Needed**: Comprehensive audit matrix required to determine which Zone configuration changes are logged
- **Zone Modification Logging**: Zone create/edit/delete events should be captured in Audit Log (confirmation needed)
- **Zone Assignment Logging**: Zone assignment changes to user accounts should be logged (confirmation needed)
- **Audit Log Fields**: Need to specify which fields are captured in Zone-related audit entries

### Administrative Visibility
- **Zone Assignment Tracking**: Administrators should be able to view which users/groups are assigned to specific Zones
- **Zone Impact Analysis**: When modifying or deleting a Zone, admin should see impact (which users/groups affected)

## Open Questions and Clarifications Needed

### Zone Management Permissions
- **CRUD Permissions**: Which User Tiers can create/edit/delete Zones? (No info in BRD)
- **Zone Scope Restrictions**: Can a Location Manager create a Zone that includes Locations outside their own Zone? (No info)
- **Default Permission Model**: Any admin with Zone permissions defined at User Tier level can execute assigned permissions

### Default Zone Behavior
- **New User Default**: Exact default Zone for newly created user accounts before explicit assignment (Everywhere, None/No Access, or User Group inheritance)
- **User Group No Zone**: What happens if User Group itself has no Zone configured? System behavior unclear

### Audit and Logging
- **Audit Events**: Confirm which Zone-related events are logged (create, edit, delete, assign, unassign)
- **Audit Log Queries**: Can auditors query "Who changed Zone on account X and when?" from Audit Log?

## Acceptance Criteria

### Zone Definition
- ✓ Admin can create a Zone including any combination of Locations, Pools, and Areas
- ✓ When a Location is added to a Zone, all current and future Areas within that Location are automatically included
- ✓ When a Pool is added to a Zone, all current and future Areas within that Pool are automatically included
- ✓ Zone definitions automatically update when new Areas are added to included Locations or Pools
- ✓ "Everywhere" Zone exists, includes all entities, and cannot be edited or deleted

### Zone Assignment
- ✓ Standard users inherit Zone from their User Group
- ✓ Elevated users can be assigned multiple Zones at the user account level
- ✓ User Groups can be assigned a single Zone (defaults to "Everywhere")
- ✓ System prevents administrators from removing their own Zone assignments if it would lock them out

### Permission Enforcement
- ✓ Users cannot edit or delete entities (messages, reservations, resources) outside their assigned Zone(s)
- ✓ Admin portal sections without permissions are completely hidden
- ✓ Admin portal items outside Zone scope are greyed out and unclickable
- ✓ Dashboard and Heatmap respect Zone filtering for data visibility

### Zone Lifecycle
- ✓ Deleted Locations/Areas/Pools are automatically removed from all Zone definitions
- ✓ Decommissioned Locations/Areas/Pools remain in Zone definitions (not auto-removed)
- ✓ Zones can be edited and updated without affecting active user sessions immediately (needs confirmation on session refresh)

## Notes

### MVP vs MVP2 Implementation Strategy
**MVP (Current Release)**:
- Database schema fully implemented with all Zone tables, relationships, and constraints
- "Everywhere" Zone created as system default
- All user accounts and user groups reference Zone (defaulting to "Everywhere")
- Zone-related UI elements hidden or disabled (not accessible to users)
- Zone validation logic implemented but effectively bypassed (all users have "Everywhere" access)

**MVP2 (Future Release)**:
- Zone management UI activated under Constructs > Zones
- Zone assignment functionality enabled for user accounts and user groups
- Zone-based permission filtering activated throughout application
- Multiple Zone assignment for elevated users enabled
- Zone-aware dropdown filtering and UI element restrictions activated

### Implementation Priorities
- **CRITICAL**: Database schema must be 100% complete in MVP to avoid future rework
- Permission matrix (User Tier vs Zone) is critical and must be defined before implementation
- Audit logging specification needed for Zone management events
- Default Zone behavior for new accounts and User Groups needs final confirmation
- Zone foreign key relationships must be established in MVP even if functionality is dormant

### Sub-Groups Not Included
Sub-Groups are intentionally excluded from explicit Zone configuration as they are below the threshold - they have no independent settings and are fully controlled by their parent Area. Sub-Group access is automatically inherited from Area permissions.

### Business Constraint
Zones are typically set up during initial implementation and rarely changed afterward. It is acceptable to require manual effort and professional assistance for Zone reconfiguration to ensure proper setup and avoid unintentional configuration loss.

### Critical Architecture Decision
Client explicitly confirmed: Zones are MVP2 only, BUT database and infrastructure must be designed NOW to avoid future rework. This is a firm requirement. Missing foreign keys, incorrect relationships, or incomplete schema in MVP will result in expensive and time-consuming database migrations, data transformations, and potential system downtime in MVP2. The technical team must treat Zone schema design with the same priority as MVP features, even though end-user functionality is deferred.
