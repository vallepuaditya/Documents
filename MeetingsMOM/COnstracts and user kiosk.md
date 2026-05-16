# MOM (Minutes of Meeting)

## Meeting Title

Kiosk Reservation System, Access Portals, Authentication Workflows & Reservation Configuration Discussion

## Meeting Participants

* Steven English
* Satya Sri Nallam
* Aditya Vallepu

## Meeting Purpose

Discussion focused on:

* Access portal and kiosk behavior
* Authentication workflows and identity provider mappings
* Reservation modes and scheduling behavior
* Kiosk UI/UX expectations
* Dynamic account creation
* Multi-language and cascading configuration support
* Security and kiosk lockdown requirements
* Upcoming UAT/demo preparation

Source transcript: 

---

# Key Discussion Points

---

# 1. Access Portal Architecture

## Requirement

Access portals should function primarily as URL-based entry points mapped to specific locations.

## Expected Flow

* Customer configures:

  * Server URL
  * Portal path
  * Linked location

Example:

```text
server.com/ravenhill
```

* Visiting the URL should:

  * Automatically inherit kiosk configuration
  * Behave like a “virtual kiosk”
  * Use the same kiosk settings as physical kiosks

## Important Design Expectation

Access portal creation should automatically create/link:

* Virtual kiosk entry
* Location assignment
* Portal-specific configuration inheritance

## Business Logic

Portal inherits:

* Allowed actions
* Reservation rules
* User permissions
* Resource visibility
* Location-specific behavior

## Important Clarification

Portal is not an independent workflow engine.
It is mainly:

* A routing layer
* Linked to kiosk configuration
* Location-aware



---

# 2. Kiosk Authentication Workflow

## User Login Expectations

Users authenticate directly using institutional credentials.

Examples:

* Student credentials
* Library card credentials
* Guest credentials

## Supported Authentication Providers

System must support:

* LDAP
* SIP2
* Internal DB authentication

## Workflow Decision Logic

Authentication routing depends on:

* User type
* User ID pattern
* Regex rules
* Assigned workflow

Example:

```text
STUxxxx → LDAP student auth
Gxxxx → Guest auth
```

## Critical Requirement

Kiosk determines:

1. User type
2. Matching authentication workflow
3. Correct identity provider
4. Authentication path

## Architecture Flow

```text
Kiosk
 → Parent Server
   → Authentication Segment
      → Identity Provider
```



---

# 3. Dynamic User Account Creation

## Requirement

Users authenticated externally must still have local system accounts created dynamically.

## Why?

System requires internal records for:

* Reservation history
* Notifications
* Tracking
* Policies
* Usage management

## Important Edge Case

Some deployments DO NOT allow automatic account creation.

Possible restrictions:

* Only users from specific Active Directory OU allowed
* Users must be pre-imported
* Imported users only
* External auth alone is insufficient

## Required Configuration Options

Need configurable modes:

* Auto-create user
* Import-only mode
* OU restricted mode
* Block unknown users



Human systems. Always discovering new ways to make “simple login” behave like an intergovernmental treaty negotiation.

---

# 4. Identity Provider Field Mapping

## Important Architectural Decision

Field mapping belongs to:

* Identity Provider level
  NOT
* Workflow level

## Reason

For a given provider:

* Field structure remains consistent

Examples:

```text
LDAP:
sAMAccountName
givenName
mail

SIP2:
specific provider-defined fields
```

## Workflow Responsibility

Workflow only decides:

* What to do with returned fields
* What to cache
* Whether to store passwords
* User creation behavior

## Identity Provider Responsibility

Identity Provider defines:

* Field mappings
* Standardized attributes

Example:

```text
LDAP FirstName → first_name
SIP2 fname → first_name
```



---

# 5. Reservation Modes & Scheduling Logic

## Supported Reservation Modes

System must support combinations of:

* Wait list only
* Scheduled only
* Both
* Immediate reservation
* Future reservation

## Area-Specific Behavior

Reservation behavior is configured per:

* Area
* Resource pool

NOT globally.

## Examples

Some areas:

* Allow immediate use

Other areas:

* Require kiosk reservation

Other areas:

* Scheduled only



---

# 6. Scheduled Reservation Lockout Rules

## Requirement

Customers must configure minimum scheduling lead times.

Examples:

* 15 minutes
* 30 minutes
* 12 hours
* 24 hours

## Business Purpose

Prevents:

* Users reserving instantly just to “claim” resources
* Operational conflicts
* Unprepared rooms/resources

## Important Use Cases

Conference rooms may require:

* Staff preparation
* Unlocking
* Equipment setup

## UI Impact

Available booking slots must respect:

* Lockout period
* Reservation hours
* Operating hours



---

# 7. Area-Based Resource Assignment

## Important Requirement

Some customers require:

* Random workstation assignment
* No direct workstation selection

## Business Reason

Safety/privacy concerns.

Example discussed:

* Preventing users from intentionally sitting next to someone.

## Expected Flow

User:

```text
“I need a computer in West Wing”
```

System:

```text
Assigns PC automatically
Displays workstation number
```

## Configuration

This behavior is:

* Area-specific



---

# 8. Reservation Interval Configuration

## Requirement

Reservation scheduling granularity must be configurable.

Examples:

* Every 5 minutes
* Every 15 minutes
* Every 30 minutes

## Important Customer Edge Case

One customer:

* Forces scheduled reservations only
* Even if computers are available immediately

## UI Behavior

Available time slots must:

* Respect current time
* Respect configured interval
* Respect lockout rules



---

# 9. Dynamic Kiosk UI Behavior

## UI Must Adapt Based On Configuration

### Examples

If:

* Wait list disabled

Then:

* “Reserve Now” button hidden

If:

* Scheduling disabled

Then:

* Date picker hidden

If:

* Only one category exists

Then:

* Category selector hidden

If:

* Guest has no password

Then:

* Password field collapses automatically

## Important Principle

UI should dynamically simplify itself.



---

# 10. Kiosk Auto Logout & Diagnostics

## Requirement

Kiosk should display:

* Auto logout countdown timer

## Benefits

* Better user awareness
* Helps diagnose config propagation issues

Example:

* Config changed from 20 sec → 60 sec
* Countdown visually confirms update propagated



Tiny feature. Massive debugging value. The kind of thing teams ignore for six months and then suddenly discover during a production outage at 2 A.M. Humanity remains consistent.

---

# 11. Kiosk Security & Escape Prevention

## Critical Security Concern

Prevent users from:

* Alt+F4
* Exiting kiosk
* Accessing desktop

## Expected Solution Ideas

* Multi-tap hidden admin access
* Touchscreen-compatible admin unlock
* Offline admin password
* Diagnostics screen

## Required Diagnostics

Admin mode should show:

* Current server connection
* Basic kiosk configuration
* Connection status



---

# 12. Cascading Configuration Model

## Concept

System should support:

* Default values
* Location overrides
* Inherited settings

## Example Use Cases

* Time limits by branch
* Pricing by branch
* Language prompts
* Reservation policies

## Expected Behavior

If no override exists:

* Inherit default

If override exists:

* Use location-specific value

## UI Expectation

Inherited values:

* Greyed out

Overridden values:

* Highlighted



---

# 13. Multi-Language Support

## Phase 1 Languages

* English
* Spanish

## Expected Structure

Prompt-based translation system.

Example:

| Prompt Key | English     | Spanish        |
| ---------- | ----------- | -------------- |
| ReserveNow | Reserve Now | Reservar Ahora |

## Design Requirement

Easy future expansion:

* Add new language as new column

## Important Architectural Point

Translation structure should:

* Avoid separate disconnected language sets
* Centralize prompt management



---

# 14. Demo & UAT Planning

## Agreed Plan

* More UI changes to be completed
* Internal walkthrough before customer presentation
* Tuesday review meeting planned

## Important Direction

Customer primarily wants:

* Functional UX demonstration
  NOT
* Database design walkthrough



---

# 15. Critical Technical Priority

## Steven’s Main Concern

Authentication + workflows + reverse lookup system is the core complexity.

## Important Statement

Previous systems solved customer-specific behavior using:

* Custom scripts

Current system goal:

* Configuration-driven behavior
* Flexible workflows
* No custom scripting dependency

## Key Engineering Priority

Need extensive validation of:

* Edge cases
* Workflow combinations
* Conditional behavior
* Customer-specific variations



This is the real heart of the system. Not the shiny UI screens everyone loves arguing about for three hours. The workflow engine is where enterprise software either becomes a scalable product... or a haunted mansion of customer-specific hacks.

---

# Action Items

| Action Item                                            | Owner       |
| ------------------------------------------------------ | ----------- |
| Finalize kiosk screen workflows                        | Team        |
| Validate all reservation mode combinations             | Team        |
| Design identity provider mapping structure             | Team        |
| Implement dynamic kiosk UI rules                       | Team        |
| Add scheduled reservation lockout config               | Team        |
| Design cascading config model                          | Team        |
| Design multilingual prompt structure                   | Team        |
| Add kiosk logout countdown                             | Team        |
| Define kiosk admin/security escape flow                | Team        |
| Prepare updated UAT demo for Tuesday                   | Team        |
| Review edge cases around account creation/import rules | Team        |
| Send workflow/authentication questions before Monday   | Team/Steven |

---

# Major Architectural Decisions Confirmed

| Topic                   | Decision                                  |
| ----------------------- | ----------------------------------------- |
| Field Mapping Location  | Identity Provider Level                   |
| Workflow Responsibility | Authentication routing & caching behavior |
| Portal Design           | Virtual kiosk tied to location            |
| Reservation Logic       | Area-specific                             |
| UI Behavior             | Fully dynamic/config-driven               |
| Language System         | Prompt-based centralized translation      |
| Config Overrides        | Cascading inheritance model               |
| Authentication          | Multi-provider configurable workflows     |

---

# Risks / Complexity Areas

## High Risk Areas

* Authentication workflow flexibility
* Reverse lookup logic
* Dynamic account creation rules
* Reservation mode combinations
* Area-based behavior combinations
* Kiosk security lockdown
* Cascading override handling

## Potential Failure Point

Trying to hardcode customer-specific behavior instead of designing flexible rule-driven architecture.

Classic enterprise trap. Someone says “just one special case,” and six months later the codebase resembles an archaeological dig site layered with human regret.
