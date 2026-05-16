# Feature: Segments

## Business Objective
Segments define groups of servers that handle client workstation connectivity (Communication Segments) and external authentication requests (Authentication Segments). They enable load balancing, failover capabilities, proper routing of authentication requests across the server infrastructure, and intelligent network segmentation to support environments with restricted inter-branch communication or specialized authentication routing requirements.

## User Story
As a **System Administrator**,
I want to define Communication and Authentication Segments,
So that workstations can connect reliably to available servers and authentication requests are routed to the appropriate external identity providers.

## Business Requirements

### Segment Types
- **Communication Segments**: Group of servers for workstation-to-server and server-to-main-server communications
- **Authentication Segments**: Group of servers capable of sending authentication attempts to external authorities (LDAP, SIP2, etc.)
- **Dual-Purpose Segments**: Single Segment can be configured for both Communication and Authentication capabilities (multi-select option)

### Core Segment Capabilities
- **Main and Secondary Servers**: Each Segment can define main servers and secondary servers (often the same server in single-server installations)
- **Pre-defined Segments**: Two non-deletable system Segments exist:
  - "Any Server - Communication": Collection of all servers hosting Endpoint APIs
  - "Any Server - Authentication": Collection of all servers capable of authentication
- **Dynamic Server Routing**: Segments support failover, load balancing, and preferred server configurations
- **Location-Level Assignment**: Segments are assigned at Location level and inherited by Areas and Kiosks within that Location

## Functional Expectations

### Segment Configuration Fields
- **Segment Name**: Unique identifier for the Segment
- **Segment Type(s)**: Authentication / Communication / Authentication & Communication (multi-select)
- **Main Servers**: Primary server list for the Segment
- **Secondary Servers**: Backup server list (can be same as Main Servers in single-server setups)
- **Relay All Auth Through Mains**: Binary flag (0/1) indicating if authentication must route through main servers
- **Server Preference Mode**: Options include:
  - Prefer Main Server 1, 2, 3
  - Combination preference
  - Any (no preference)
  - Load balance

### Communication Segment Behavior
- **Connection Modes**: Configured at Location level:
  - Local only
  - Local then any
  - Any available
- **Home/Preferred Server**: Each Location specifies preferred server from assigned Segment
- **Intelligent Failover**: Workstations prefer local servers and fail over to alternate servers when local unavailable
- **Network Topology Awareness**: Some environments restrict inter-branch communication; segments must respect these constraints
- **Failover Logic**: When preferred server is unavailable, workstation connects to next available server in Segment
- **Failover Order Options**: Configuration at Location level could dictate:
  - Latency-based selection (with threshold for "offline" determination, e.g., >1000ms)
  - Round robin (with interval in minutes or number of requests before switching)
  - Random (with configurable weighting/influence mechanism)
- **Dynamic Server Selection**: Workstations route intelligently based on segment membership and network accessibility

### Authentication Segment Behavior
- **Separate from Communication**: Authentication routing may differ from communication routing - segments handle this separation
- **Identity Provider Routing**: Authentication Segments can be attached to Identity Provider definitions to explicitly define servers capable of handling specific authentication methods
- **Network Restrictions**: Some servers may be restricted from SIP communication or other authentication protocols
- **Segment Membership Control**: Segment membership determines which servers can handle authentication for specific protocols
- **Cross-Reference Model**: System cross-references Identity Provider auth Segment with Location auth Segment to determine eligible servers
- **Alternative Model**: All auth servers in a Segment are capable of handling all authentication methods for the given Location (less preferred approach)
- **Failover Handling**: Authentication requests fail over dynamically when primary auth servers become unavailable

## Workflow

### Workstation Connection Flow
1. Workstation boots up and needs to connect to application server
2. System checks Location assignment to determine Communication Segment
3. System retrieves Home/Preferred Server from Location settings
4. Workstation attempts connection to Preferred Server
5. If Preferred Server unavailable:
   - Workstation connects to next available server based on failover mode (latency/round-robin/random)
   - Workstation notes failover state internally
6. System starts Failback Interval timer
7. At Failback Interval expiration:
   - Workstation checks if Preferred Server is available via Endpoint API connection validation
   - If available, workstation switches back to Preferred Server
   - User session continues uninterrupted (transparent failover)

### Authentication Request Flow
1. User attempts to authenticate at workstation/kiosk/portal
2. System determines Location and retrieves assigned Authentication Segment
3. System identifies required Identity Provider based on User Type/Workflow
4. System cross-references Location auth Segment with Identity Provider auth Segment
5. System selects eligible server from intersection of both Segments
6. Authentication request routed to selected server
7. Server forwards authentication request to external authority (LDAP, SIP2, etc.)
8. Response returned through same server to workstation

## Business Rules

### Segment Assignment Rules
- **Location-Level Assignment**: Segments are assigned at Location level
- **Inheritance Behavior**:
  - If only one Communication Segment assigned to Location, new Kiosks/Areas automatically use that Segment
  - If multiple Communication Segments assigned to Location, new Kiosks default to first/highest and dropdown populates all available Segments
- **Override Capability**: Individual Kiosks can override Location default and select different Segment from those assigned to Location

### Home Server Rules
- **Segment Dependency**: Location cannot have a "home" server unless it is defined within an assigned Segment
- **Physical Location Irrelevant**: System does not consider physical server location - server must be in assigned Segment to be selectable as home server
- **Home Server Assignment**: Server must be included in Segment, Segment assigned to Location, then server set as first entry/primary/preferred in Segment server list

### Failback Interval Rules
- **Polling Mechanism**: Amount of time that passes between checks to see if preferred server is available again
- **Validation Method**: Successful connection to Endpoint API plus validation check (NOT ping-based)
- **Network Constraint**: Pings are not used because they are not in scope of network requirements and customer sites not expected to allow them
- **Automatic Failback**: Upon successful validation, workstation automatically switches back to preferred server

### Network Segmentation Rules
- **Inter-Branch Restrictions**: Some environments restrict inter-branch communication - segments must support these topologies
- **Communication vs Authentication Separation**: Authentication routing may differ from communication routing paths
- **Protocol Restrictions**: Some servers may be restricted from specific protocols (e.g., SIP2 communication)
- **Segment Membership**: Segment membership determines which servers can communicate with which workstations/locations
- **Network Accessibility**: System must respect network topology constraints when routing requests

## Validations

### Segment Configuration Validations
- **Minimum Server Requirement**: At least one Main Server required to create Segment (confirmation needed)
- **Secondary Server Optionality**: Secondary Servers optional (can be same as Main Servers)
- **Duplicate Server Prevention**: Unknown if system prevents same server appearing in both Main and Secondary lists
- **Segment Type Selection**: At least one type (Communication or Authentication) must be selected

### Segment Assignment Validations
- **Location Assignment Restrictions**: When Segment assigned to Locations, deletion blocked until manually unassigned
- **Manual Unassignment Required**: System blocks Segment deletion if assigned to any Location - requires explicit manual unassignment first
- **No Auto-Unassignment**: System intentionally does not auto-unassign to prevent configuration loss requiring customer IT knowledge to restore

### Server Availability Validations
- **Latency Threshold**: If latency-based failover enabled, latency over configured threshold (e.g., 1000ms) considered offline and triggers alert logging
- **Endpoint API Reachability**: Connection validation based on successful Endpoint API connection, not ping response
- **Multiple Validation Attempts**: Unknown if single successful connection sufficient or multiple required before failback

## User Experience Expectations

### Admin Portal Experience
- **Segment Management UI**: Located under Constructs > Segments section in Admin menu
- **Grid View**: Sortable, filterable, searchable data grid displaying Segment configurations
- **Default Columns**: Complete column list needs confirmation - likely includes:
  - Segment Name
  - Type (Communication/Authentication/Both)
  - Server Count
  - Assigned Locations Count
  - Status (active/inactive)
  - Date Created
  - Last Modified
- **Action Buttons**: Add, Edit, Delete with deletion restrictions

### Workstation/Kiosk Experience
- **Transparent Failover**: Users unaware of server switches during failover events
- **Session Continuity**: Active user sessions continue uninterrupted during server failover
- **Offline Mode Trigger**: If no server available in Segment, offline mode automatically triggered

### Staff Experience
- **Server Unavailability Alerts**: Staff alerted when external Identity Provider unreachable and system falls back to offline mode
- **No Manual Intervention**: Server failover and failback occur automatically without staff action

## Statuses and Conditions

### Segment Lifecycle States
- **Active**: Segment operational and available for assignment
- **Inactive**: Unknown if Segments can be deactivated without deletion (needs confirmation)
- **Assigned**: Segment assigned to one or more Locations
- **Unassigned**: Segment defined but not assigned to any Location
- **System-Defined**: Pre-defined Segments ("Any Server - Communication" and "Any Server - Authentication") cannot be deleted

### Server States Within Segment
- **Online/Available**: Server reachable via Endpoint API and accepting connections
- **Offline/Unavailable**: Server unreachable, latency exceeds threshold, or Endpoint API validation fails
- **Preferred**: Server designated as home/preferred server for Location
- **Failover**: Server currently handling connections due to preferred server unavailability

## Edge Cases and Exception Handling

### "Any Server" Pre-defined Segments
- **Any Server - Communication**: Automatically includes all servers hosting Endpoint APIs
- **Location Mode Settings**: Each Location using "Any Server - Communication" can specify:
  - Connection mode (local only, local then any, or any)
  - Home/preferred server
- **Failover Logic**: Same failover rules apply (latency/round-robin/random) based on Location configuration
- **Dynamic Server List**: As new servers added to infrastructure, they automatically included in "Any Server" Segments

### Server Failure Mid-Session
- **Session Preservation**: User sessions continue with remaining time intact when server fails over
- **Example**: User in minute 20 of 60-minute session when Server 1 crashes - failover to Server 2 occurs, session continues with 40 minutes remaining
- **User Transparency**: User should be unaware of server switches
- **No Server Available**: If no server available in Segment, offline mode triggered instead of session termination

### Segment Deletion Attempts
- **Deletion Blocked**: System blocks deletion when Segment assigned to Locations
- **Manual Process Required**: Administrator must manually unassign Segment from all Locations before deletion allowed
- **Rationale**: Segments typically set up during implementation and rarely changed - acceptable to require manual effort and professional assistance to prevent accidental configuration loss

### Round-Robin and Random Mode Edge Cases
- **Round-Robin Interval**: If round-robin mode enabled, configuration needed for:
  - Interval in minutes before switching servers
  - OR number of requests processed before switching
- **Random Selection Control**: If random mode enabled:
  - Stored procedure or configuration to influence/weight random server selection
  - Prevents excessive switching or server preference biases

## Dependencies

### Related Modules
- **Locations**: Segments assigned at Location level
- **Areas**: Inherit Segment from Location
- **Kiosks**: Inherit Communication Segment from Location (can override if multiple available)
- **Servers**: Segments define collections of physical/virtual servers
- **Identity Providers**: Authentication Segments may be linked to specific Identity Providers
- **Workflows**: Authentication routing depends on Segment and Workflow configuration

### External Dependencies
- **Network Infrastructure**: Server connectivity depends on network reliability
- **External Authentication Systems**: LDAP, SIP2, and other identity providers must be reachable
- **DNS Resolution**: Server URIs must resolve properly for connections
- **Endpoint APIs**: All servers in Communication Segments must host functioning Endpoint APIs

### Required Processes
- **Server Health Monitoring**: Continuous monitoring of server availability for failover decisions
- **Failback Polling**: Regular polling at Failback Interval to detect preferred server availability
- **Load Balancing**: If load balance mode enabled, traffic distribution across servers
- **Session State Management**: Session state must be accessible across servers for seamless failover

## Reporting and Audit Expectations

### Monitoring Requirements
- **Server Availability Tracking**: System should log when servers become unavailable or latency exceeds threshold
- **Failover Event Logging**: Unknown if failover events are logged (needs confirmation)
- **Failback Event Logging**: Unknown if failback events are logged (needs confirmation)
- **Alert Generation**: Staff should be alerted when external Identity Provider unreachable

### Administrative Visibility
- **Segment Assignment Visibility**: Admins should see which Locations assigned to each Segment
- **Server Status Dashboard**: Unknown if admin dashboard shows real-time server availability within Segments
- **Connection Analytics**: Unknown if system tracks connection distribution across servers in load-balanced Segments

### Audit Requirements
- **Segment Configuration Changes**: Unknown if Segment create/edit/delete logged in Audit Log (needs audit matrix)
- **Segment Assignment Changes**: Unknown if Segment assignment to Locations logged
- **Server Addition/Removal**: Unknown if changes to server lists within Segments logged

## Open Questions and Clarifications Needed

### Segment Grid Configuration
- **Default Columns**: Complete list of default columns in Segments grid needed
- **Field Mapping**: Fields mapped for SIP, III, and other integrations need determination
- **Column Customization**: Can admins add/remove columns from grid view?
- **Default Sort Order**: What is default sort order for Segments list?

### Failover Configuration Details
- **Latency Threshold**: What is default/recommended latency threshold for offline determination?
- **Round-Robin Interval**: Default interval before switching servers in round-robin mode?
- **Random Selection Weighting**: How are random selections influenced/weighted if at all?
- **Validation Retry Logic**: How many successful API validations required before failback?
- **Network Topology Detection**: How does system detect and respect inter-branch communication restrictions?
- **Authentication Protocol Restrictions**: How are per-server authentication protocol restrictions configured and enforced?

### Segment Management Permissions
- **CRUD Permissions**: Which User Tiers can create/edit/delete Segments?
- **Zone Interaction**: Do Zones restrict which Segments an admin can manage?
- **Minimum Required Fields**: Final confirmation of minimum fields to create Segment

### Deactivation vs Deletion
- **Deactivate Option**: Can Segments be deactivated without deletion?
- **Deactivation Impact**: If deactivated, what happens to Locations using that Segment?

## Acceptance Criteria

### Segment Definition
- ✓ Admin can create Segment with Name, Type(s), Main Servers, Secondary Servers, and preference mode
- ✓ Segment Type can be Communication, Authentication, or both (multi-select)
- ✓ Main and Secondary Servers can be the same (single-server installations)
- ✓ Pre-defined "Any Server - Communication" and "Any Server - Authentication" Segments exist and cannot be deleted

### Segment Assignment
- ✓ Segments can be assigned to Locations
- ✓ Kiosks/Areas inherit Segment from Location
- ✓ If multiple Communication Segments assigned to Location, Kiosks can select from dropdown
- ✓ System blocks Segment deletion if assigned to any Location

### Communication Segment Behavior
- ✓ Workstations connect to preferred/home server from assigned Communication Segment
- ✓ If preferred server unavailable, workstation automatically fails over to next available server
- ✓ User sessions continue uninterrupted during failover (session state preserved)
- ✓ Workstation automatically fails back to preferred server when it becomes available again
- ✓ Failback polling uses Endpoint API connection validation, not ping

### Authentication Segment Behavior
- ✓ Authentication requests route through servers in assigned Authentication Segment
- ✓ Authentication Segments can be linked to Identity Providers to restrict which servers handle specific auth types
- ✓ System cross-references Location auth Segment with Identity Provider auth Segment
- ✓ If external Identity Provider unreachable, system falls back to offline mode and alerts staff

### Failover and Failback
- ✓ Failover occurs automatically without user intervention
- ✓ Users are unaware of server switches (transparent failover)
- ✓ Session time remaining preserved during failover (not reset)
- ✓ Failback Interval configuration controls frequency of preferred server availability checks
- ✓ If no servers available, offline mode triggered instead of session termination

## Notes

### Implementation Priorities
- Failover logic configuration (latency/round-robin/random) needs detailed specification
- Audit matrix needed to determine which Segment events are logged
- Server health monitoring and alerting system required
- Complete field list and validation rules needed before implementation
- Network topology awareness and inter-branch restriction handling must be designed
- Authentication vs communication routing separation architecture required

### Business Constraint
Segments typically set up during initial implementation and rarely changed. Manual effort and professional assistance required for reconfiguration is acceptable and desirable to ensure proper configuration and avoid accidental loss of settings requiring customer IT knowledge to restore.

### Ping Usage Restriction
Pings cannot be used for server availability validation because they are not in scope of network requirements. Customer sites not required to allow ping traffic. All server availability checks must use Endpoint API connection and validation.

### Field Mapping Open Item
Specific fields need to be mapped for various integration types (SIP, III, etc.) - this is noted as requiring determination in coordination with integration specifications.
