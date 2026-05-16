# Feature: Access Portals

## Business Objective
Access Portals provide web-accessible reservation interfaces for end users to make and manage reservations remotely without requiring physical presence at a kiosk. Portals enable patrons to schedule resources, view availability, and manage their reservations from any web browser while maintaining proper Location-based scoping and permissions. Portal behavior adapts dynamically based on selected site/location to support consortium models where access rules and permissions vary by branch or organization.

## User Story
As a **System Administrator**,
I want to create and configure Access Portals for different Locations,
So that end users can access reservation functionality via web browsers from remote locations.

## User Story (Secondary)
As an **End User/Patron**,
I want to access a web portal to make reservations,
So that I can schedule resources without visiting a physical kiosk.

## Business Requirements

### Core Portal Capabilities
- **Web-Based Access**: Portals provide browser-accessible reservation interfaces
- **Location Association**: Each Portal associated with a specific Location or Pool
- **Path-Based Routing**: Portals differentiated by pathname in URL (not hostname-based)
- **Single Portal per Location Rule**: Single portal allowed per Location (path uniquely maps to specific Location once assigned)
- **Pseudo-Virtual Kiosk**: Portals implemented as pseudo-virtual Kiosk entries to control settings and configurations
- **Permissions Matrix**: Portals enforce permissions based on User Tier, User Type, and User Group
- **Reservation Type Control**: Portals allow specific reservation types based on Area and Portal configuration
- **Context-Based Behavior**: Portal behavior adapts based on selected location/site in consortium environments
- **Site-Based Permission Validation**: User permissions validated against selected site before granting reservation access
- **Consortium Support**: Portals support multi-site consortium models with varying access rules per location

### Portal vs Kiosk Differences
- **Physical vs Virtual**: Kiosks are physical devices; Portals are web-accessible virtual endpoints
- **Location Selection Required**: Portals require users to select preferred Location before full functionality available
- **Remote Access**: Portals accessible from anywhere with internet connection; Kiosks tied to physical location
- **Configuration Inheritance**: Portals behave as Kiosks but with web-specific configurations

## Functional Expectations

### Portal Definition Fields
- **Portal Name**: Descriptive name for administrative identification
- **Associated Location**: Location this Portal serves (required) - OR Pool assignment (preferred common use case)
- **Server/URI**: Server hosting the Portal (URI of server)
- **Path**: Unique pathname differentiating this Portal (e.g., /branchA, /portal1, /ravenhill)
- **Pooling Mode**: Unknown - may relate to Pool assignment options (needs clarification)
- **Communication Segment**: Segment used for server communication (inherited from Location configuration)
- **Permissions Matrix**: User Tier, User Type, User Group permissions configuration
- **Portal Schedule**: Unknown if Portals have operational schedules (needs confirmation)
- **API Processing Configuration**: How API processes engagement/requests for this Portal

### Minimum Required Fields
- **Location Association**: At minimum, Location required (OR Pool for broader scope)
- **Path**: Unique path identifier required
- **Alternative Model**: Perhaps just Location assignment with Location Code automatically becoming the path
- **Server/URI**: May be required or defaulted to available server hosting Endpoint APIs

### Portal Assignment Options
- **Location-Based**: Portal assigned to single Location, scoped to that Location's Areas and Resources
- **Pool-Based** (Preferred): Portal assigned to Pool spanning multiple Areas/Locations to allow reservations across Pool member Areas
- **Example**: Pool 'Maker Spaces' contains Areas at 3 branches - one Portal assigned to Pool allows patrons to reserve any Maker Space item across all 3 branches

## Workflow

### Portal Access Flow - Without Pre-Selection
1. User navigates to base server URL (e.g., https://servername/)
2. System displays Location selection landing page (since no specific path provided)
3. User selects preferred Location from available list
4. System routes to appropriate Portal configuration based on Location selection
5. User authenticates via configured Workflows for that Location
6. User gains access to reservation interface scoped to selected Location/Pool

### Portal Access Flow - With Pathname
1. User navigates to specific Portal URL (e.g., https://servername/branchA)
2. System matches pathname to configured Portal
3. System identifies associated Location/Pool from Portal configuration
4. User authenticates via configured Workflows for that Location
5. User gains access to reservation interface scoped to Portal's Location/Pool
6. User can view availability, make reservations, manage existing reservations

### Reservation Creation via Portal
1. Authenticated user accesses Portal
2. System displays available Areas based on Portal's Location/Pool assignment
3. User selects Area and views available Resources
4. System filters Resource Types and Reservation Types based on Area configuration and Portal permissions
5. User selects Resource and Reservation Type (Scheduled, Waitlist, Walk-Up - based on permissions)
6. User specifies reservation details (date, time, duration)
7. System validates against business rules and availability
8. If valid, reservation created and confirmation shown to user
9. If invalid, error message displayed per Location overrides or default messaging

### Portal Decommission Impact
1. Admin decommissions/deletes Portal
2. Existing reservations made through Portal remain active (not affected)
3. Portal URL becomes inaccessible or redirects to Location selection page
4. Users not notified of Portal decommission (no automatic notifications)
5. Future reservation attempts via old Portal URL fail gracefully or redirect

## Business Rules

### Single Portal per Location Rule
- **Path Uniqueness**: Once a path is assigned to a Location, that path not available for assignment to another Location
- **Location Exclusivity**: Each Location can only have one Portal path assigned
- **Alternative Interpretation**: Rule may mean one PRIMARY public-facing portal per Location (staff/admin portals may be separate)

### Portal URL Structure
- **Path-Based Differentiation**: Portals differentiated by pathname, not hostname
- **Multiple Servers Supported**: Various servers (different hostnames) may be in play
- **Pathname as Differentiator**: Pathname determines which "Kiosk" configuration to use
- **Server Independence**: Multiple servers could facilitate same requests; pathname determines Location preference/behavior

### Portal Scoping Rules
- **Location Scope**: Portal assigned to Location shows only that Location's Areas and Resources
- **Pool Scope**: Portal assigned to Pool shows all Areas and Resources within Pool member Areas across Locations
- **Zone Interaction**: User Zone may further restrict what user sees, but Portal's Location/Pool assignment is primary scope
- **Consortium Rules**: User access rules may differ by consortium/site - portal validates permissions against selected location
- **Site Selection Validation**: Portal validates user permissions against selected site before allowing reservation functionality
- **User Type Permitted Locations**: User types not permitted in a location must be blocked immediately upon site selection
- **Example**: Portal assigned to Branch A - user with Zone = 'Everywhere' logs in - can they reserve at Branch B? Portal Location assignment and user type permissions for that location determine access

### Portal Context Management
- **Dynamic Behavior**: Portal behavior changes based on selected site/location in consortium environments
- **Site-Specific Rules**: User access rules, permissions, and available reservation types may differ by consortium member site
- **Pre-Access Validation**: Portal must validate user permissions against selected site before granting reservation access
- **Location Selection Impact**: Once location selected, portal enforces that location's specific rules for user types, reservation types, and workflows
- **Consortium vs Single-Site**: Single-site installations have static portal behavior; consortium installations require dynamic adaptation

### Reservation Type Availability
- **Area-Level Configuration**: Areas have specific 'Portal Reservation Types' setting separate from general 'Reservation Types'
- **User Tier Filtering**: User's Tier further filters which reservation types available
- **Customer-Facing vs Staff**: Customer-facing portals typically allow Scheduled and possibly Waitlist; Block and Maintenance types typically staff-only
- **Configuration Dependency**: Exact allowed types depend on Areas connected to Portal and user's permissions

## Validations

### Portal Configuration Validations
- **Unique Path Requirement**: Path must be unique across all Portals (system prevents duplicate paths)
- **Location/Pool Required**: Portal must be assigned to either Location or Pool before activation
- **Server Reachability**: Server/URI must be reachable and hosting Endpoint APIs
- **Path Format**: Path format validation (must start with /, no special characters, etc.) - specification needed

### Portal Assignment Validations
- **Single Assignment Check**: System enforces single Portal per Location rule (if path-based, this is implicit)
- **Pool Membership**: If assigned to Pool, Pool must exist and have member Areas
- **Location Existence**: Associated Location must exist and not be decommissioned

### User Access Validations
- **Authentication Required**: Users must authenticate before accessing reservation functionality
- **Permission Check**: User's Tier/Type/Group must have permissions for Portal access
- **Zone Validation**: If user has Zone restrictions, Portal access may be further scoped (needs clarification)
- **Location Selection Validation**: If Location selection required, user must select valid Location before proceeding

## User Experience Expectations

### Admin Portal Experience
- **Portal Management UI**: Located under Constructs > Access Portals section in Admin menu
- **Grid View**: Sortable, filterable, searchable data grid displaying Portal configurations
- **Default Columns**: Likely includes Portal Name, Associated Location/Pool, Path, Server, Status, Date Created (complete list needs confirmation)
- **Action Buttons**: Add, Edit, Decommission/Disable, Delete (with restrictions)

### End User Portal Experience
- **Location Selection Page**: If no specific path in URL, user sees Location selection landing page
- **Authentication Screen**: User authenticates via configured Workflows for selected Location
- **Reservation Interface**: User-friendly interface showing available Areas, Resources, time slots
- **Real-Time Availability**: Availability updates in real-time as other users make reservations
- **Reservation Management**: Users can view upcoming reservations, cancel, modify (based on business rules)
- **Responsive Design**: Portal should work on desktop, tablet, mobile browsers

### Branding and Theming
- **Single Theme (Current Phase)**: All Portals share single theming/branding configuration
- **Future Multi-Branding**: Long-term, branding/theming should be individually customizable per Portal
- **Theming Elements**: Logo, color scheme, background image, CSS overrides
- **Kiosk Theming Reference**: BRD mentions "Kiosk theming — specify what all can be customized including background images" - applies to Portals as well

## Statuses and Conditions

### Portal Lifecycle States
- **Active**: Portal operational and accessible via URL
- **Inactive/Disabled**: Portal temporarily disabled without deletion (decommission toggle needed - confirmation required)
- **Decommissioned**: Portal taken offline, URL inaccessible
- **Deleted**: Portal permanently removed from configuration
- **Path Assigned**: Portal has unique path and is "live" for selection
- **Path Unassigned**: Portal configuration exists but no path assigned (not accessible)

### Portal Accessibility Conditions
- **Server Online**: Server hosting Portal must be online and reachable
- **Location Active**: Associated Location must be active (not decommissioned)
- **Pool Active**: If assigned to Pool, Pool must exist and have active member Areas
- **Network Accessible**: Portal URL must be accessible from internet/network

## Edge Cases and Exception Handling

### Multiple Server Scenarios
- **Different Hostnames**: Client wants portal1.branchA.com and portal2.branchB.com (different DNS entries)
- **Supported Model**: Multiple servers with different hostnames can host Portals
- **Pathname Differentiator**: Even with different hostnames, pathname determines Portal/Kiosk behavior
- **Location Assignment**: Each pathname maps to specific Location preference

### Portal Decommission with Active Reservations
- **Existing Reservations**: When Portal decommissioned, existing reservations made through it remain active and honored
- **No User Notification**: Users not automatically notified of Portal decommission
- **Future Access**: Users attempting to access decommissioned Portal see error or redirect to Location selection
- **Grace Period**: Unknown if grace period enforced before decommission (needs confirmation)

### Staff vs Admin vs Public Portals
- **Different Paths**: Staff interface and Admin interface likely have their own distinct paths (not customer-facing paths)
- **Path Differentiation**: Example paths:
  - /public or /branchA for patrons
  - /staff for staff reservation management
  - /admin for administrative functions
- **Single vs Multiple Portals**: Clarification needed if Branch A needs public patron portal AND staff portal - is that two Portals or one with role-based views?

### Location Selection Landing Page
- **No Path Scenario**: If user accesses base URL without specific path, should they see Location selection landing page?
- **All Locations vs Permitted**: Does landing page show all Locations or only those user has permissions for?
- **Auto-Redirect**: If user has only one permitted Location, should they auto-redirect to that Portal?

### Portal Path Conflicts
- **Path Already Assigned**: Admin attempts to assign path /branchA but it's already assigned to another Portal/Location
- **System Prevention**: System blocks duplicate path assignment
- **Error Messaging**: Admin sees clear error indicating path already in use

## Dependencies

### Related Modules
- **Locations**: Portals primarily assigned to Locations
- **Pools**: Portals can be assigned to Pools (preferred for broader scope)
- **Areas**: Portal scope determines which Areas visible for reservations
- **Resources**: Available Resources filtered by Portal's Location/Pool assignment
- **Kiosks**: Portals implemented as pseudo-virtual Kiosk entries
- **Workflows**: Authentication at Portal uses configured Workflows for Location
- **User Tiers/Types/Groups**: Permission matrix controls Portal access and functionality
- **Zones**: User Zones may further filter Portal access (interaction needs clarification)
- **Segments**: Portals use Communication Segments from Location configuration
- **Theming**: Portal appearance controlled by Theming configuration

### External Dependencies
- **Web Server**: Server must host Portal application and Endpoint APIs
- **Network Infrastructure**: Internet/network connectivity required for remote access
- **DNS Configuration**: If custom hostnames used, DNS must resolve properly
- **SSL Certificates**: HTTPS likely required for Portals (security best practice - confirmation needed)
- **Browser Compatibility**: Portals must work across modern browsers (Chrome, Firefox, Safari, Edge)

### Required Processes
- **User Authentication**: Portal authentication via Workflows
- **Session Management**: User sessions managed across web requests
- **Real-Time Availability Updates**: Availability data refreshed to prevent double-booking
- **Reservation Creation/Modification**: Full reservation lifecycle management
- **Permission Evaluation**: User permissions evaluated for every action

## Reporting and Audit Expectations

### Portal Usage Tracking
- **Access Logs**: Unknown if Portal access logged (user logins, reservation attempts) - needs confirmation
- **Reservation Analytics**: Reservations made via Portal vs Kiosk differentiation for reporting (needs confirmation)
- **Portal Performance**: Unknown if system tracks Portal response times, errors, uptime

### Administrative Visibility
- **Active Portals List**: Admins can view all configured Portals with status
- **Portal Assignment**: Admins can see which Locations/Pools have Portals assigned
- **Reservation Source**: Unknown if admins can see which Portal user used to make reservation

### Audit Requirements
- **Portal Configuration Changes**: Unknown if Portal create/edit/delete events logged in Audit Log (needs audit matrix)
- **Portal Access Events**: Unknown if user access to Portal logged
- **Decommission Events**: Unknown if Portal decommission logged with admin user and timestamp

## Open Questions and Clarifications Needed

### Portal Definition Clarity
- **Kiosk Entry Relationship**: Exact relationship between Portal and pseudo-virtual Kiosk entry needs specification
- **Full Settings List**: Complete list of settings available for Portal configuration (inherited from Kiosk model)
- **Required vs Optional Fields**: Final confirmation of minimum required fields to create Portal

### Single Portal per Location Rule
- **Staff vs Public Portals**: Can Branch A have one public patron portal AND one staff portal, or is that violation of single-portal rule?
- **Path Interpretation**: Is "single portal" rule about paths (one path per Location) or about portal COUNT?
- **Exception Cases**: Are there exceptions to single portal rule for multi-tenant scenarios?

### Portal URL and Path Structure
- **HTTPS Requirement**: Is HTTPS required or optional for Portal access?
- **Path Format Specification**: Detailed path format requirements (character restrictions, length limits, reserved words)
- **Base URL Behavior**: What happens when user accesses base server URL without path - Location selection page or error?
- **Subdomain Support**: Can Portals use subdomains (branchA.domain.com) or path-only (/branchA)?
- **Portal Identifier Behavior**: How should portal identifiers behave in consortium environments? (Noted as open question from meeting)

### Zone and Portal Interaction
- **Zone Enforcement**: Does user's Zone restrict what they can access through Portal?
- **Portal Scope Primary**: Is Portal's Location/Pool assignment primary scope, with Zone as secondary filter?
- **Example Scenario**: Portal assigned to Branch A - user with Zone = 'Everywhere' - can they see/reserve Branch B resources?
- **Consortium User Access**: In consortium models, how do user type permissions at different sites interact with Zone permissions?
- **Multi-Site Validation**: When user permitted at multiple consortium sites, how does portal determine which site's rules to apply?

### Reservation Types via Portal
- **Complete Type List**: Which reservation types can users make via Portal: Walk-Up, Scheduled, Waitlist? Block and Maintenance excluded?
- **Area-Level Portal Types**: How is 'Portal Reservation Types' configured at Area level vs general 'Reservation Types'?
- **Permission Interaction**: How do User Tier permissions interact with Area-level Portal Reservation Types?

### Portal Deactivation Options
- **Decommission vs Delete**: Can Portal be temporarily disabled (decommissioned) without deletion?
- **Scheduled Downtime**: Can Portal downtime be scheduled in advance?
- **Maintenance Mode**: Is there maintenance mode to show "Portal temporarily unavailable" message to users?

### Branding and Theming
- **Current Phase Scope**: Single global theming sufficient for current phase?
- **Future Customization**: Timeline for per-Portal branding customization?
- **Theming Elements**: Complete list of customizable theming elements (logo, colors, fonts, backgrounds, CSS)?

### Portal Management Permissions
- **CRUD Permissions**: Which User Tiers can create/edit/delete Portals?
- **Zone Restrictions**: Can Location Manager only manage Portals within their Zone?
- **Deletion Restrictions**: Can Portal with active reservations be deleted, or must reservations expire first?

## Acceptance Criteria

### Portal Creation and Configuration
- ✓ Admin can create Portal with Name, Location/Pool assignment, and unique Path
- ✓ System enforces unique path constraint (prevents duplicate paths)
- ✓ Portal can be assigned to Location OR Pool
- ✓ Pool-assigned Portal shows all Areas and Resources within Pool member Areas
- ✓ Location-assigned Portal shows only that Location's Areas and Resources

### Portal Access
- ✓ User accesses Portal via URL with pathname (e.g., https://servername/branchA)
- ✓ System routes user to correct Portal configuration based on pathname
- ✓ User authenticates via configured Workflows for Portal's associated Location
- ✓ Authenticated user sees reservation interface scoped to Portal's Location/Pool
- ✓ If user accesses base URL without path, Location selection landing page shown (if implemented)

### Portal Reservation Functionality
- ✓ User can view available Areas and Resources through Portal
- ✓ User can make reservations of permitted types (Scheduled, Waitlist - based on Area and permissions)
- ✓ System enforces Area-level 'Portal Reservation Types' configuration
- ✓ System validates reservations against business rules and availability
- ✓ User can view, modify, cancel existing reservations (based on business rules)

### Portal Permissions
- ✓ Portal enforces permission matrix based on User Tier, Type, and Group
- ✓ Users without appropriate permissions denied Portal access with error message
- ✓ Portal respects Area-level reservation type restrictions
- ✓ Staff-only reservation types (Block, Maintenance) not available to standard users via Portal

### Portal Lifecycle Management
- ✓ Admin can decommission Portal (temporarily disable or delete)
- ✓ Existing reservations made through decommissioned Portal remain active
- ✓ Users not automatically notified of Portal decommission
- ✓ Decommissioned Portal URL inaccessible or shows appropriate error/redirect

### Multi-Server Support
- ✓ Portals can be hosted on different servers with different hostnames
- ✓ Pathname remains primary differentiator regardless of hostname
- ✓ Multiple servers can facilitate same Portal requests
- ✓ Portal configuration independent of specific server hostname

## Notes

### Implementation Priorities
- Portal definition field specification needed (required vs optional fields)
- Relationship between Portal and pseudo-virtual Kiosk entry must be architected
- Path format validation rules needed
- Complete permission matrix specification required
- Location selection landing page design needed (if implementing base URL access)

### Pseudo-Virtual Kiosk Concept
Portals implemented as pseudo-virtual Kiosk entries to leverage existing Kiosk configuration infrastructure. This allows Portals to inherit settings, permissions, schedules, and behavior from Kiosk model while providing web-based access instead of physical device access.

### Pool Assignment Preferred
While Portals CAN be assigned to individual Locations, Pool assignment is preferred common use case. Pool-assigned Portals allow users to reserve resources across multiple Areas/Locations within the Pool, providing broader access and better user experience.

### Path-Based Routing Strategy
Pathname-based routing (not hostname-based) simplifies configuration and allows multiple Portals on same server infrastructure. Different servers/hostnames supported but pathname remains primary differentiator for Portal/Location mapping.

### Single Theme Acceptable for Current Phase
Global theming across all Portals and Kiosks acceptable for current implementation phase. Future enhancement should support per-Portal branding customization (different logos, colors, themes for different organizations/branches).

### Staff and Admin Interfaces
Staff reservation management interface and administrative interface likely have their own distinct paths, separate from customer-facing Portal paths. Clarification needed on whether these count as separate "Portals" or are different applications entirely.

### No Automatic Notifications on Decommission
When Portal decommissioned, users NOT automatically notified. Existing reservations remain valid. This is acceptable business behavior - reservations honored regardless of how they were created.

### Future HTTPS Requirement
While not explicitly stated in BRD, HTTPS strongly recommended for Portal access (security best practice for web-based authentication and reservation data). Implementation should support HTTPS and potentially require it for production deployments.
