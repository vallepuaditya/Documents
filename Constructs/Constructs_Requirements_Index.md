# Constructs Module - Business Requirements Documentation

## Overview
This documentation suite provides comprehensive business requirements for the **Constructs** module, which encompasses the foundational administrative structures that define how the TrackSystems application operates across different geographic locations, server infrastructure, authentication pathways, and access channels.

The Constructs module consists of four primary sub-modules that work together to provide flexible, scalable system configuration.

## Purpose
This documentation is optimized for AI coding agents (Cursor, Claude Code, Copilot, ChatGPT) to understand:
- **Business intent and client expectations**
- **Operational workflows and user interactions**
- **Business rules and validation requirements**
- **System behavior and constraints**
- **Feature relationships and dependencies**

## Documentation Status
All requirements are derived from client CSV specifications and BRD decision points. Items marked as:
- ✓ **Confirmed**: Requirements explicitly stated in source documents
- ⚠️ **Partial**: Requirements partially defined, with clarifications provided
- ❌ **No Info**: Requirements identified as gaps requiring client confirmation

## Sub-Module Documentation

### 1. [Zones](Requirements_Zones.md)
**Business Purpose**: Geographic and organizational scope management for user accounts and groups

**Key Capabilities**:
- Define which Locations, Areas, and Pools users can access
- Control administrative visibility and permissions based on geographic boundaries
- Automatic inheritance of scope when entities are added to Locations or Pools
- Multiple Zone assignment for elevated users
- Pre-defined "Everywhere" Zone for system administrators

**Critical Business Rules**:
- Scope is always inherited, never explicit
- Single Zone per User Group (defaults to "Everywhere")
- Standard users inherit Zone from User Group
- Elevated users can have multiple Zone assignments
- Deleted entities auto-removed from Zone definitions
- Decommissioned entities remain in Zone definitions

**Open Questions**: 14 items requiring clarification
**Status**: ⚠️ Partially defined - Permission matrix needed

---

### 2. [Segments](Requirements_Segments.md)
**Business Purpose**: Server infrastructure management for client connectivity and authentication routing

**Key Capabilities**:
- Communication Segments: Manage workstation-to-server connectivity with failover
- Authentication Segments: Route authentication requests to external identity providers
- Dual-purpose Segments supporting both Communication and Authentication
- Automatic failover and failback to preferred servers
- Load balancing and server preference configurations

**Critical Business Rules**:
- Segments assigned at Location level, inherited by Kiosks and Areas
- Main and Secondary servers (can be same in single-server installations)
- Failback validation via Endpoint API connection (not ping)
- Session continuity during failover (users unaware of server switches)
- Deletion blocked if Segment assigned to Locations
- Pre-defined "Any Server" Segments cannot be deleted

**Open Questions**: 10 items requiring clarification
**Status**: ⚠️ Partially defined - Failover configuration details needed

---

### 3. [Workflows](Requirements_Workflows.md)
**Business Purpose**: Authentication routing and account management strategy configuration

**Key Capabilities**:
- Route authentication requests to appropriate Identity Providers (LDAP, SIP2, local database)
- Map User Types to specific authentication methods
- Control account auto-creation behavior
- Configure field imports from external systems
- Generate aliases/usernames using configurable patterns
- Enable/disable Global Workflows at Location level

**Critical Business Rules**:
- Workflows NOT tied to Segments (avoid excessive definitions)
- Global Workflows defined system-wide, enabled/disabled per Location
- Workflows matched to Locations based on User Type constraints
- Reverse lookup permitted fields configured per Workflow
- Account creation options: auto-create, deny access, or allow without account (Phase 2)
- Location-level text overrides for error messages

**Open Questions**: 13 items requiring clarification
**Status**: ⚠️ Partially defined - Alias generation syntax and multi-Workflow processing logic needed

---

### 4. [Access Portals](Requirements_Access_Portals.md)
**Business Purpose**: Web-accessible reservation interfaces for remote user access

**Key Capabilities**:
- Provide browser-based reservation functionality
- Path-based routing to different Portal configurations
- Assignment to Locations or Pools (Pool-based preferred)
- Implemented as pseudo-virtual Kiosk entries
- Permission enforcement via User Tier, Type, and Group matrices
- Configurable reservation types available per Portal

**Critical Business Rules**:
- Single Portal per Location (path uniquely maps to Location once assigned)
- Pathname differentiates Portals (not hostname)
- Multiple servers can host same Portal paths
- Existing reservations survive Portal decommission
- Portal scope determined by Location/Pool assignment
- Area-level 'Portal Reservation Types' separate from general reservation types

**Open Questions**: 11 items requiring clarification
**Status**: ⚠️ Partially defined - Portal-Kiosk relationship and path format specification needed

---

## Cross-Module Relationships

### Zones ↔ User Access
- **Zones** define WHERE users can operate
- **User Tiers** define WHAT users can do
- Combined evaluation: Permission = Tier (what) + Zone (where)

### Segments ↔ Workflows ↔ Locations
- **Locations** assign Communication Segments and Authentication Segments
- **Workflows** route to Identity Providers (NOT directly to Segments)
- Cross-reference: Location auth Segment ∩ Identity Provider auth Segment = eligible server list
- Authentication requests processed through servers in intersection

### Portals ↔ Kiosks ↔ Locations
- **Portals** implemented as pseudo-virtual Kiosk entries
- Inherit configuration model from Kiosks
- **Locations** or **Pools** determine Portal scope
- Communication Segments inherited from Location configuration

### Workflows ↔ Portals/Kiosks ↔ Authentication
- User authenticates at **Portal** or **Kiosk**
- System identifies **Location** → retrieves enabled **Workflows**
- **Workflow** routes to **Identity Provider** via **Authentication Segment**
- Account created (or not) based on **Workflow** configuration

## Implementation Priorities

### Critical Path Items
1. **Permission Matrix**: Complete matrix mapping User Tier vs Zone permissions for all admin actions
2. **Audit Matrix**: Define which configuration changes are logged across all Constructs sub-modules
3. **Alias Generation Syntax**: Full specification of pattern syntax for Workflow alias generation
4. **Failover Configuration**: Complete specification of latency thresholds, round-robin intervals, random weighting
5. **Portal-Kiosk Relationship**: Architectural specification of pseudo-virtual Kiosk implementation

### Dependency Requirements
- **User Tiers and User Types**: Must be defined before Zones and Workflows can be fully implemented
- **Locations and Areas**: Must exist before Zones, Segments, and Portals can be configured
- **Identity Providers**: Must be defined before Workflows can route authentication
- **Servers**: Physical/virtual servers must exist before Segments can be configured

### Data Model Dependencies
```
Servers → Segments → Locations → Kiosks/Portals
                   ↓
User Groups → Zones → User Accounts
                   ↓
Identity Providers → Workflows → Authentication
```

## Open Questions Summary

### Across All Modules: 48 Total Open Questions
- **Zones**: 14 open questions
- **Segments**: 10 open questions  
- **Workflows**: 13 open questions
- **Access Portals**: 11 open questions

### Critical Clarifications Needed
1. **Permission Matrix**: Complete mapping of Tier-only vs Zone-scoped vs Tier+Zone permissions
2. **Audit Matrix**: Which events logged for each sub-module
3. **Multi-Workflow Processing**: First-match vs process-all-until-success strategy
4. **Portal Path Format**: Validation rules, character restrictions, reserved words
5. **Default Values**: Defaults for new users, User Groups, Segments, Workflows, Portals
6. **CRUD Permissions**: Which User Tiers can manage which Constructs entities
7. **Deletion Restrictions**: Complete rules for when deletion blocked (active references, dependencies)

## Acceptance Testing Scope

### Zones Module
- 9 primary acceptance criteria across definition, assignment, enforcement, and lifecycle

### Segments Module  
- 10 primary acceptance criteria across definition, assignment, communication, authentication, and failover

### Workflows Module
- 11 primary acceptance criteria across Global management, Location configuration, authentication processing, reverse lookup, alias generation, and error handling

### Access Portals Module
- 10 primary acceptance criteria across creation, access, reservation functionality, permissions, lifecycle, and multi-server support

**Total Acceptance Criteria: 40 testable scenarios**

## Business Constraints and Operational Expectations

### Configuration Stability
- **Zones** and **Segments** typically set up during implementation, rarely changed
- Manual effort acceptable for reconfiguration to prevent accidental loss
- Professional assistance expected for complex changes requiring customer IT knowledge

### Security and Access Control
- **Identity Provider credentials** shielded from most administrators
- **Constructs > Workflows** provides business control without exposing credentials
- **Systems > Connections > Identity Providers** restricted to full administrators
- **Zone assignments** prevent administrators from locking themselves out

### User Experience Expectations
- **Transparent failover**: Users unaware of server switches during failures
- **Session continuity**: Active sessions preserved during infrastructure changes
- **Hidden vs Greyed-out**: Sections without permissions hidden; items outside scope greyed out
- **Offline mode**: Automatic fallback when servers/Identity Providers unavailable

### Audit and Compliance
- Complete audit trail needed for configuration changes
- Administrative visibility into Zone assignments, Segment usage, Workflow routing
- Alert generation when infrastructure failures occur
- Activity tracking for reservations made via different access channels (Kiosk vs Portal)

## Document Maintenance

### Version Control
- These documents represent initial requirements capture from client CSV and BRD decision points
- As clarifications received, update relevant sections and remove from "Open Questions"
- Mark updated items with confirmation date and source

### Change Management
- When business rules change, update relevant section and add note in "Notes" section
- Cross-reference related modules if change impacts dependencies
- Update Acceptance Criteria if requirements change

### AI Agent Usage
- AI agents should read relevant sub-module documentation before implementing features
- Cross-module dependencies section helps identify which documents to review together
- Open Questions section indicates areas requiring human decision before implementation
- Acceptance Criteria provides test scenarios for validation

## Related Documentation

### Prerequisites (External Dependencies)
- User Tiers and User Types specification
- User Groups configuration requirements
- Locations and Areas data model
- Resources and Resource Types structure
- Identity Providers integration specifications (LDAP, SIP2, III, etc.)

### Dependent Modules (Reference These Requirements)
- Reservations module (depends on Zones, Portals, Workflows)
- Dashboard and Heatmap (depends on Zones for filtering)
- Admin Portal (depends on Zones for section visibility)
- Kiosks configuration (depends on Segments, Workflows)
- Offline Mode (depends on Segments failover, Workflows)
- Audit Logging (depends on all Constructs modules for event capture)

### Companion Documentation Needed
- Permission Matrix (User Tier ↔ Zone mapping)
- Audit Matrix (Event logging specifications)
- Workflow Pattern Syntax (Alias generation specification)
- Portal Theming Guide (Branding customization)
- Failover Configuration Guide (Segment behavior tuning)

---

## Quick Reference Guide

### For Implementation Planning
1. Read this index to understand module relationships
2. Review specific sub-module docs in order: Zones → Segments → Workflows → Portals
3. Note all "Open Questions" requiring clarification before implementation
4. Review "Acceptance Criteria" for test planning
5. Check "Dependencies" to identify prerequisite modules

### For Feature Development
1. Identify which Constructs sub-module(s) your feature touches
2. Read relevant sub-module documentation completely
3. Review "Business Rules" and "Validations" sections for constraints
4. Check "Edge Cases and Exception Handling" for error scenarios
5. Implement per "Workflow" sections for expected behavior
6. Validate against "Acceptance Criteria"

### For Troubleshooting
1. Review "Business Rules" to confirm expected behavior
2. Check "Edge Cases and Exception Handling" for known scenarios
3. Review "Dependencies" to identify related modules that might be causing issues
4. Consult "Open Questions" - issue might be in undefined area requiring clarification

### For Requirements Clarification
1. Review "Open Questions and Clarifications Needed" in relevant sub-module
2. Check if question already documented as gap
3. If new gap discovered, add to appropriate section with ❌ No Info marker
4. Escalate to client/product owner for decision

---

**Document Created**: Based on `Constructs.csv` specification
**Total Pages**: 4 sub-module requirement documents + 1 index
**Total Requirements Captured**: 100+ discrete business requirements
**Status**: ⚠️ Partial - 48 open questions require client confirmation before full implementation

**Next Steps**:
1. Review with Product Owner for completeness
2. Prioritize "Open Questions" for clarification sessions
3. Create Permission Matrix and Audit Matrix specifications
4. Develop detailed field specifications for each sub-module
5. Begin implementation planning based on dependency order
