# Feature: Workflows

## Business Objective
Workflows define the authentication routing logic that maps user types to specific identity providers and shapes how authentication requests are processed. They enable flexible authentication strategies across different user populations while controlling account creation behavior and field import logic. Workflows support dynamic user type recognition through regex pattern matching and prefix triggers, allowing automatic workflow switching based on detected user type without requiring users to manually select their category.

## User Story
As a **System Administrator**,
I want to define Workflows that route authentication requests to appropriate identity providers,
So that different user types (students, staff, library cardholders, etc.) authenticate through the correct external systems or local database.

## User Story (Secondary)
As a **Location Administrator**,
I want to enable or disable specific Global Workflows for my Location,
So that only relevant authentication methods are available at my branch.

## Business Requirements

### Core Workflow Capabilities
- **Authentication Request Routing**: Workflows map user types to specific integrations (LDAP, SIP2, local database, flat file, etc.)
- **Dynamic User Type Detection**: Automatic identification of users based on entered credentials using regex patterns, prefix triggers, and input pattern matching
- **Identity Provider Mapping**: Workflows constrain/map to Identity Providers but are NOT tied to Segments at Workflow level
- **Multi-Provider Support**: System supports Database authentication, LDAP, SIP2, and other identity providers
- **Flexible Field Mapping**: Field mappings support varying SIP field structures across vendors without scripting-language dependency where possible
- **Global vs Location-Level**: Workflows can be defined globally (system-wide) or configured/overridden at Location level
- **Pre-defined Database Workflow**: Primary database Workflow ships as default; additional Workflows can be added/templatized later
- **Account Creation Control**: Workflows specify whether accounts are auto-created, creation denied, or login allowed without account creation
- **Field Import Configuration**: Workflows define which fields are imported from external identity providers
- **Alias Generation**: Workflows specify alias/username generation patterns based on imported fields
- **Automatic Workflow Switching**: System automatically switches workflows based on detected user type from credential pattern

### Workflow Types
- **Global Workflows**: Defined at system level, available to all Locations
- **Location-Level Workflows**: Enable/disable specific Global Workflows or configure Location-specific constraints
- **Not Scheduled Tasks**: Workflows are authentication routing rules, NOT automated scheduled tasks (nightly cleanup, account expiry)

## Functional Expectations

### Workflow Configuration Fields
- **Workflow Name**: Unique identifier for the Workflow
- **User Type Recognition Pattern**: Regex patterns or prefix triggers to identify user type from credential input
- **Pattern Matching Priority**: First matching regex wins (patterns evaluated in defined order)
- **User Tier Constraints**: Optional restrictions limiting Workflow to specific User Tiers
- **User Type Constraints**: Specific User Types this Workflow applies to (e.g., Student, Staff, Public, Guest, Temporary)
- **Account Type Constraints**: Optional account type restrictions
- **Identity Provider**: Which external or internal identity provider to use (Database, LDAP, SIP2, etc.)
- **Field Mapping Configuration**: Maps external identity provider fields to system fields (supports varying vendor structures)
- **Permitted Reverse Lookups**: Fields permitted for reverse lookup/login from database or external system
- **Account Creation Options**: Configuration for account creation behavior
- **Fields to Import**: List of fields imported from external identity provider
- **Alias Generation Options/Format**: Pattern/format for generating usernames/aliases
- **Error Handling Configuration**: Behavior for various error states

### Global Workflow Configuration
- **System-Wide Definition**: Global Workflows defined at system level under Constructs > Workflows
- **Availability to Locations**: Locations populate available Workflows from Global Workflows matching their defined User Types
- **User Type Matching**: Global Workflows without User Type constraints available to all Locations
- **Cross-Reference with Segments**: Locations specify expected User Types, and available Workflows populated based on match

### Location-Level Workflow Configuration
- **Enable/Disable Global Workflows**: Locations can enable or disable specific Global Workflows
- **No New Workflow Creation**: Locations cannot create entirely new Workflows (only enable/disable Global ones)
- **Local Overrides**: Location-level overrides pertain to specific sections/behaviors and text string overrides for errors/verbiage
- **No Schedule-Based Restrictions**: System does not support automatic enable/disable of User Types on schedules

## Workflow

### Authentication Request Processing Flow
1. User attempts authentication at kiosk/portal/workstation
2. System identifies Location and retrieves available enabled Workflows for that Location
3. System analyzes user input (barcode, username, student ID, etc.)
4. System matches user input against enabled Workflows based on User Type constraints
5. **Multi-Workflow Processing Options** (needs final confirmation):
   - **Option A**: Process against all matched Workflows until success or all have failed
   - **Option B**: Process against first match only (configuration toggle)
6. Selected Workflow routes authentication request to specified Identity Provider
7. Identity Provider authenticates user and returns response
8. Workflow processes response based on account creation settings
9. If account creation allowed and account doesn't exist, system creates account
10. User authenticated and session begins

### Reverse Lookup Flow
1. User initiates reverse lookup (login with alternate field like email or name)
2. System checks database for permitted reverse lookup fields defined in Workflow
3. If internal database lookup: System determines which fields permitted for reverse lookup/login
4. If external Identity Provider lookup: System sends reverse lookup request to external system
5. External system returns response (e.g., SIP 64 response)
6. System parses response using script that checks field prefixes to identify unique fields
7. System makes logic decisions on which fields are cached based on parsing results
8. If match found, authentication continues; if not found, proceeds per account creation settings

### Alias Generation Flow
1. New user authenticates via Workflow with alias generation enabled
2. System retrieves configured alias generation pattern from Workflow
3. System extracts required fields from authentication response or user record
4. System applies pattern (e.g., first 2 letters of first name + first letter of last name + hyphen + last 3 of account number)
5. System checks for duplicate alias
6. If duplicate exists, system appends randomizer suffix (e.g., "-###")
7. Generated alias stored on user account

## Business Rules

### Workflow Assignment Rules
- **Location User Type Matching**: Locations specify expected User Types; Workflows available to Location if they match those User Types
- **User Type Constraint Logic**: Workflows without User Type constraints available to all Locations
- **Identity Provider Cross-Reference**: System cross-references between Identity Provider auth Segment and Location auth Segment to determine eligible servers
- **Segment Independence**: Workflows are NOT tied to Segments - Segments determined at Location and Identity Provider level

### User Type Detection Rules
- **Regex Pattern Matching**: System evaluates user input against defined regex patterns to identify user type
- **First Match Wins**: First matching user-type regex wins; patterns processed in defined order
- **Prefix Trigger Support**: Simple prefix triggers can identify user type (e.g., "G-" for guest, "STU" for student)
- **Input Pattern Matching**: System analyzes credential structure and format to determine appropriate workflow
- **Automatic Workflow Selection**: Once user type detected, system automatically selects corresponding workflow without user intervention

### Multiple Workflow Processing Rules
- **Processing Strategy**: System can process against all matched Workflows until success or all failed (needs confirmation on "first match only" option)
- **Workflow Priority**: If priority order needed, must be defined (currently not specified)
- **Success Criteria**: First successful authentication from any matched Workflow completes authentication process
- **Failure Handling**: If all matched Workflows fail, user receives authentication error per error handling configuration

### Account Creation Rules
- **Auto-Create on Success**: Workflow configured to auto-create account if authentication successful but account doesn't exist
- **Deny Access**: Workflow configured to deny access if account doesn't exist (no creation)
- **Allow Login Without Account** (Phase 2): Future option to allow login without creating account record (not needed for current phase)
- **Account Type Assignment**: Created accounts assigned specific User Type/User Group per Workflow configuration

## Validations

### Workflow Configuration Validations
- **Required Field Validation**: Workflow Name and Identity Provider are required (User Type constraints optional)
- **Duplicate Workflow Name**: System prevents duplicate Workflow names (needs confirmation)
- **Identity Provider Validation**: Selected Identity Provider must exist and be properly configured
- **Alias Pattern Validation**: Alias generation pattern must reference valid fields available from Identity Provider

### Location Workflow Validations
- **User Type Matching**: Workflow only available to Location if User Type constraints match Location's expected User Types
- **Enabled Workflow Requirement**: Location must have at least one enabled Workflow (needs confirmation)
- **Identity Provider Availability**: If Workflow uses specific Identity Provider, that provider must be reachable from Location's auth Segment

### Reverse Lookup Validations
- **Permitted Field Check**: Reverse lookup only allowed on fields explicitly permitted in Workflow configuration
- **Unique Field Requirement**: Reverse lookup fields should uniquely identify user (duplicate handling needs specification)

## User Experience Expectations

### Admin Portal Experience - Global Workflows
- **Workflow Management UI**: Located under Constructs > Workflows section in Admin menu
- **Separate from Identity Providers**: Constructs > Workflows controls routing logic WITHOUT exposing underlying connection credentials
- **Shielded Credentials**: Systems > Connections > Identity Providers contains credentials and is restricted to full admins only
- **Grid View**: Sortable, filterable, searchable data grid displaying Workflow configurations
- **Action Buttons**: Add, Edit, Delete (restrictions on deletion need specification)

### Admin Portal Experience - Location Workflows
- **Location Setup Section**: Location administrators configure available Workflows under Location Setup
- **Enable/Disable Toggles**: Simple toggle interface to enable or disable Global Workflows for Location
- **Text Override Configuration**: Ability to override error messages and verbiage at Location level
- **Available Workflow Population**: Dropdown auto-populates with Global Workflows matching Location's User Types

### End User Experience - Authentication
- **Transparent Routing**: Users unaware of which Workflow processes their authentication
- **Error Messages**: Users see error messages configured in Workflow (with Location overrides if applicable)
- **Account Creation Messaging**: If account auto-created, user may see welcome message (configuration dependent)

### End User Experience - Reverse Lookup
- **Alternate Login Fields**: If reverse lookup enabled, users can login with email, name, or other permitted fields
- **Field-Specific Prompts**: Kiosk/portal may show different prompts based on permitted reverse lookup fields

## Statuses and Conditions

### Workflow Lifecycle States
- **Active**: Workflow defined and available for assignment to Locations
- **Inactive**: Unknown if Workflows can be deactivated without deletion (needs confirmation)
- **Assigned**: Workflow enabled at one or more Locations
- **Unassigned**: Global Workflow defined but not enabled at any Location
- **System-Default**: Pre-defined database Workflow (cannot be deleted - needs confirmation)

### Authentication Response States
- **Success**: User successfully authenticated by Identity Provider
- **Not Found**: User identifier not found in Identity Provider
- **Bad Password**: Credentials incorrect
- **Duplicate Account**: Multiple accounts match user identifier (error handling needs specification)
- **Account Creation Failure**: Authentication successful but account creation failed (error handling needs specification)
- **Identity Provider Unavailable**: External system unreachable or timeout (fallback to offline mode)

## Edge Cases and Exception Handling

### Multiple Workflow Matching
- **Ambiguous User Input**: If user input could match multiple User Types, processing order/priority needs definition
- **First Match vs All**: Need confirmation on whether system processes first matched Workflow only or tries all until success
- **Workflow Conflict Resolution**: If multiple Workflows could apply, conflict resolution strategy needed

### Identity Provider Failures
- **External System Offline**: If SIP2/LDAP server unreachable, fallback to offline mode and alert staff
- **Timeout Handling**: If external system times out mid-authentication, user sees "System Unavailable" message
- **Partial Response**: If external system returns incomplete data, Workflow error handling determines behavior (allow login vs deny)

### Account Creation Failures
- **Successful Auth but Failed Creation**: User authenticated by external system but local account creation fails - error handling strategy needed
- **Duplicate Detection**: If alias generation creates duplicate and randomizer fails multiple times, escalation process needed
- **Missing Required Fields**: If external system doesn't return required fields for account creation, Workflow should fail gracefully

### Reverse Lookup Edge Cases
- **Multiple Matches**: If reverse lookup returns multiple users with same email/name, disambiguation strategy needed
- **Field Parsing Failures**: If SIP 64 response parsing fails to identify fields correctly, fallback behavior needed
- **Cached Field Staleness**: If cached fields from external system become stale, refresh strategy needed

## Dependencies

### Related Modules
- **Identity Providers**: Workflows route to specific Identity Providers (LDAP, SIP2, local database, etc.)
- **Locations**: Workflows enabled/disabled at Location level based on User Type matching
- **User Types**: Workflows constrained by User Types
- **User Tiers**: Workflows can be constrained by User Tiers (optional)
- **Segments**: Location auth Segments and Identity Provider auth Segments cross-referenced to determine eligible servers
- **Account Management**: Workflows control account creation behavior
- **Offline Mode**: When external Identity Providers unavailable, system falls back to offline mode

### External Dependencies
- **External Identity Providers**: LDAP, SIP2, and other external systems must be reachable and properly configured
- **Network Connectivity**: Reliable network required for external authentication
- **Identity Provider Credentials**: Connection credentials stored in Systems > Connections > Identity Providers

### Required Processes
- **Authentication Request Routing**: Core process routing authentication based on Workflow configuration
- **Field Parsing and Caching**: Scripting engine to parse external system responses and cache relevant fields
- **Alias Generation**: Pattern-based alias generation with duplicate handling
- **Account Auto-Creation**: Automated account creation based on Workflow settings

## Reporting and Audit Expectations

### Authentication Activity Tracking
- **Authentication Attempts**: Unknown if system logs authentication attempts per Workflow (needs confirmation)
- **Success/Failure Rates**: Unknown if system tracks success/failure rates per Workflow for reporting
- **Account Creation Events**: Unknown if auto-created accounts logged with Workflow identifier

### Administrative Visibility
- **Workflow Usage Analytics**: Unknown if admins can view which Workflows are most/least used
- **Location Workflow Assignment**: Admins should see which Locations have which Workflows enabled
- **Error Frequency**: Unknown if error states tracked per Workflow for troubleshooting

### Audit Requirements
- **Workflow Configuration Changes**: Unknown if Workflow create/edit/delete events logged (needs audit matrix)
- **Location Workflow Enablement**: Unknown if Location enable/disable Workflow actions logged
- **Identity Provider Changes**: Changes to Identity Provider configurations likely logged separately

## Open Questions and Clarifications Needed

### Workflow Processing Logic
- **First Match vs All**: Does system process first matched Workflow only, or try all until success? Configurable?
- **Priority/Order**: If multiple Workflows match, is there priority/sequence, or parallel processing?
- **Processing Mode Configuration**: Where is "process all vs first match" configured - Global, per-Location, or per-Workflow?

### Account Creation Options
- **Complete Option List**: Confirm all account creation options:
  - Auto-create and allow login
  - Deny login if account doesn't exist
  - Allow login without creating account (Phase 2)
  - Prompt staff to create (option exists?)
- **User Type/Group Assignment**: How is User Type/Group determined for auto-created accounts?
- **Default Values**: What default values applied to auto-created accounts?

### Alias Generation Specification
- **Supported Pattern Syntax**: Complete specification of alias generation pattern syntax needed
- **Pattern Builder UI**: Is there UI pattern builder or free-text field? Regex support?
- **Field Reference Format**: How are fields referenced in patterns (e.g., {FirstName}, [FIRST_NAME], %firstname%)?
- **Duplicate Handling**: Exact duplicate handling logic and randomizer format specification
- **Validation**: Is alias pattern validated when Workflow saved?

### Field Parsing and Caching
- **Permitted Field Configuration**: How are permitted reverse lookup fields configured in Workflow UI?
- **Field Parsing Logic**: Complete specification of SIP 64 and other response parsing needed
- **Field Mapping Flexibility**: How to support varying SIP field structures across vendors without scripting dependency?
- **Vendor-Specific Mappings**: Configuration approach for different SIP2/LDAP vendor field structures
- **Caching Strategy**: Which fields cached, for how long, and refresh logic?
- **Multiple Match Handling**: If reverse lookup returns multiple matches, how is correct user determined?

### Workflow Management Permissions
- **CRUD Permissions**: Which User Tiers can create/edit/delete Global Workflows?
- **Location Override Permissions**: Which User Tiers can enable/disable Workflows at Location level?
- **Identity Provider Visibility**: Which User Tiers can view Identity Provider connection details?

### Error Handling Configuration
- **Error State List**: Complete list of all error states Workflow can handle
- **Per-Error Configuration**: Can each error type have different handling (e.g., not found = auto-create, bad password = retry)?
- **Location Error Overrides**: Exact scope of text overrides at Location level (messages only or behavior too)?

### Pre-defined Workflows
- **Default Workflow**: Confirm "primary database" Workflow is only pre-defined Workflow that ships
- **Template Workflows**: Are template Workflows provided for common scenarios (LDAP, SIP2, etc.)?
- **Example Workflows**: Are example Workflows from BRD actually shipped or just documentation examples?

### User Type Detection Configuration
- **Regex Pattern Syntax**: What regex syntax/flavor is supported for user type detection?
- **Pattern Testing**: Is there a pattern testing/validation tool in the admin UI?
- **Pattern Order Management**: How are regex patterns ordered/prioritized for evaluation?
- **Fallback Behavior**: What happens if no regex pattern matches user input?

## Acceptance Criteria

### Global Workflow Management
- ✓ Admin can create Global Workflow with Name, User Type constraints, Identity Provider, and account creation settings
- ✓ Admin can configure fields to import from Identity Provider
- ✓ Admin can configure alias generation pattern with field references
- ✓ Admin can specify permitted reverse lookup fields
- ✓ Pre-defined database Workflow exists and cannot be deleted
- ✓ Global Workflows visible under Constructs > Workflows without exposing Identity Provider credentials

### Location Workflow Configuration
- ✓ Location admin can view list of available Global Workflows matching Location's User Types
- ✓ Location admin can enable/disable specific Global Workflows for their Location
- ✓ Location admin can override error messages and verbiage for enabled Workflows
- ✓ Workflows without User Type constraints available to all Locations
- ✓ Location cannot create new Workflows, only enable/disable Global ones

### Authentication Processing
- ✓ User authentication routed to correct Identity Provider based on matched Workflow
- ✓ If account doesn't exist and auto-create enabled, account created successfully
- ✓ If account doesn't exist and auto-create disabled, authentication denied with appropriate error
- ✓ System processes authentication against matched Workflows (processing strategy confirmed in implementation)
- ✓ First successful authentication completes process (remaining Workflows skipped)

### Reverse Lookup
- ✓ Users can authenticate using permitted reverse lookup fields (email, name, etc.)
- ✓ System queries database or external Identity Provider for reverse lookup match
- ✓ SIP 64 and other responses parsed correctly to extract and cache fields
- ✓ Duplicate matches handled gracefully (disambiguation strategy implemented)

### Alias Generation
- ✓ Aliases generated based on configured pattern using imported fields
- ✓ Duplicate aliases detected and randomizer suffix appended
- ✓ Generated aliases stored on user account
- ✓ Alias pattern validated when Workflow saved (invalid patterns rejected)

### Error Handling
- ✓ External Identity Provider unavailable triggers fallback to offline mode
- ✓ Staff alerted when external system unreachable
- ✓ Users see appropriate error messages for each error state (not found, bad password, etc.)
- ✓ Location-level error message overrides applied when configured

## Notes

### Implementation Priorities
- Complete alias generation pattern syntax specification critical before implementation
- Reverse lookup field parsing logic needs detailed specification
- Multi-Workflow processing strategy (first match vs all) needs final decision
- Account creation option complete list and behavior specification needed
- Audit matrix required to determine which Workflow events are logged
- Regex pattern matching engine and syntax must be defined
- Field mapping approach for varying vendor structures without scripting dependency must be architected
- User type detection pattern configuration UI needed

### Workflow vs Identity Provider Separation
Constructs > Workflows provides business-level control over authentication routing without exposing technical connection details. Systems > Connections > Identity Providers (shielded from most admins) contains actual connection credentials and technical integration settings. This separation allows Location administrators to control authentication behavior without accessing sensitive credentials.

### Segment Independence
Workflows intentionally NOT tied to Segments to avoid excessive Workflow definitions. Locations affiliate to auth Segments, and potentially Identity Providers as well. The overlap/cross-reference between Location auth Segment and Identity Provider auth Segment determines eligible server list for authentication routing.

### Scripting Engine Flexibility
Existing solution uses scripting engine to parse external system responses and extract fields. This flexibility allows parsing "pretty much any combination of fields" and selecting "how much of the field we want" for alias generation and field caching. Implementation should preserve this flexibility while exploring options to avoid scripting-language dependency where possible for field mappings.

### User Type Detection via Pattern Matching
System identifies user types dynamically using regex patterns, prefix triggers, and input pattern matching. This enables different login experiences per user type without requiring users to manually select their category. For example, library card holders, guests, temporary users, students, and administrators can all be automatically identified based on credential format. First matching user-type regex wins, so pattern ordering is important.

### No Schedule-Based User Type Restrictions
System does not support automatic enable/disable of certain User Types on schedules (e.g., Library Cards Monday-Friday only). Such restrictions must be implemented through other means if needed.
