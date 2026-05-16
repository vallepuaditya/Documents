  

| Nerve Center | Administrator | User Access |
| --- |
| SignUp Portal |
| Business Requirement Document |
| Version no. | Updated by | Reviewed by | Status |
| --- | --- | --- | --- |
| V1.0 | Sid D | Steven |  |
| V2.0 | Sid D | Steven |  |
|  |  |  |  |

Sid D

11-19-2025

Table of Contents

[Version history: 3](#_Toc222257729)

[Name of the Epic 3](#_Toc222257730)

[Title of the requirement 3](#_Toc222257731)

[Executive Summary: 3](#_Toc222257732)

[Purpose and Scope: 3](#_Toc222257733)

[Goal: 4](#_Toc222257734)

[Assumptions: 5](#_Toc222257735)

[Dependencies: 6](#_Toc222257736)

[Product Owner: 6](#_Toc222257737)

[Identification of the stakeholders: 6](#_Toc222257738)

[Identification of the end users for UAT: 6](#_Toc222257739)

[Priority: 6](#_Toc222257740)

[Deliver By: 6](#_Toc222257741)

[Requirement list: 7](#_Toc222257742)

[Functional Requirements Details: 9](#_Toc222257743)

[Module 1: User Kiosk 9](#_Toc222257744)

[i. Welcome Screen: 9](#_Toc222257745)

[ii. Login Screen for Patrons 11](#_Toc222257746)

[iii. Make a Reservation 13](#_Toc222257747)

[iv. Select a PC Type and Workstation (Workstation Reservation) 14](#_Toc222257748)

[v. Get Confirmation Details (PC Workflow) 15](#_Toc222257749)

[vi. Reserve a Conference Room 16](#_Toc222257750)

[vii. Get Confirmation Details (Conference Room Workflow) 18](#_Toc222257751)

[viii. Reserve a 3D printer 19](#_Toc222257752)

[vii. Get Confirmation Details (3D Printer Workflow) 20](#_Toc222257753)

[ix. Join a Waitlist 21](#_Toc222257754)

[x. View Waitlist 22](#_Toc222257755)

[xi. Existing Reservation Listing 24](#_Toc222257756)

[Module 2: Admin/Nerve Center 25](#_Toc222257757)

[i. Login Screen: 25](#_Toc222257758)

[ii. Dashboard 27](#_Toc222257759)

[iii. Search for Patron 29](#_Toc222257760)

[iv. Modify Patron Details 30](#_Toc222257761)

[v. Create Patron 32](#_Toc222257762)

[vi. Create Visitor 34](#_Toc222257763)

[vii. Batch Visitors 36](#_Toc222257764)

[viii. Receipt Visitors 38](#_Toc222257765)

[ix. SignUp Global Settings: 40](#_Toc222257766)

[x. Branches 42](#_Toc222257767)

[xi. Resource Groups 43](#_Toc222257768)

[xii. Resource Types 45](#_Toc222257769)

[xiii. Branch Hours & Schedule 47](#_Toc222257770)

[xiv. Scheduled Reservations 48](#_Toc222257771)

[xv. Waitlists 50](#_Toc222257772)

[xvi. System Configuration 52](#_Toc222257773)

[Module 3: PC/Workstation Access 56](#_Toc222257774)

[i. Welcome Screen: 56](#_Toc222257775)

[ii. Policy Screen: 57](#_Toc222257776)

[iii. Login Screen: 58](#_Toc222257777)

[iv. Time Tracker Display (PC Access) 59](#_Toc222257778)

[v. Session Extension Wizard (PC Access) 60](#_Toc222257779)

[vi. Optional Work Saving (PC Access) 61](#_Toc222257780)

# Version history:

| Version no. | Updated by | Reviewed by | Description | Status |
| --- | --- | --- | --- | --- |
| V1.0 |  |  | Initial version of the document | first draft |
| V2.0 | Satya |  | Updated the document as per the latest requirements | second draft |
| V2.1 | Steven | Steven | Added doc version to footer and clarified sign-off note | third draft |
| V2.2 | Development Team | Pending | Added System Architecture & Core Constructs section including Zones (MVP2), Communication/Authentication Segments, Permission Framework, User Type Detection, Portal Context Management, Schedule Management, and Reporting Framework based on client meeting requirements | in review |
|  |  |  |  | final draft |
|  |  |  |  | signed off |

# Name of the Epic

**_TRAC_SYSTEMS SignUp Portal**

# Title of the requirement

**Replacing current Pharos SignUp Product**

# Executive Summary:

The TRACSYSTEMS SignUp Platform is a modern, fully integrated library workstation reservation and management system designed to replace the legacy Pharos SignUp product. The platform enables patrons to seamlessly reserve and access computers, provides library staff with real-time operational oversight, and equips administrators with unified configuration and policy management tools across all branches.

Developed as a proprietary, cloud-ready solution, the platform eliminates legacy technical constraints and vendor dependency while delivering improved scalability, security, and performance. Through streamlined workflows, intuitive user interfaces, and SIP2 integration with major Integrated Library Systems, TRACSYSTEMS provides a cohesive and efficient environment for managing workstation utilization, reservations, waitlists, visitor access, and system-wide policies.

This modernization initiative enhances the overall patron experience, reduces staff workload, and positions TRACSYSTEMS with a competitive, future-focused offering that supports long-term strategic growth.

# Purpose and Scope:

Purpose:

*   This document outlines the functional requirements for the _TRAC_SYSTEMS Library Management Platform, designed to replace the legacy Pharos SignUp system with a modern, proprietary solution. The platform enables library patrons to reserve workstations, library staff to monitor and manage resources in real-time, and IT administrators to configure and maintain the system efficiently across multiple library branches.

Scope:

*   The _TRAC_SYSTEMS platform encompasses four integrated applications: Patron Kiosk (self-service reservation), Workstation Client (cross-platform session management), Staff Portal (real-time monitoring and control), and Admin Console (system configuration and policy management). It will be accessible to patrons, library staff, and IT administrators, with role-based permissions ensuring secure and efficient access. The platform integrates with Integrated Library Systems (ILS) via SIP2 protocol, email/SMS notification services, and workstation management tools to deliver a comprehensive library technology solution.

# Goal:

*   What is the purpose of this requirement?

This requirement aims to modernize _TRAC_SYSTEMS' library technology offerings by delivering a proprietary, cloud-ready platform that eliminates vendor dependency, enhances competitive positioning, and establishes the foundation for long-term growth. The solution addresses immediate business imperatives while maintaining operational continuity for existing library customers.

*   What are the problems to be solved by this?

This project addresses multiple critical challenges facing _TRAC_SYSTEMS and their library customers:

*   *   Technical Debt Elimination: The legacy Pharos SignUp system represents significant vendor dependency and lacks modern features expected by library patrons and staff. The new platform provides complete ownership and control over the technology stack.
    *   Scalability Constraints: The legacy architecture cannot support modern deployment models including cloud hosting, multi-tenancy, or geographic distribution, limiting _TRAC_SYSTEMS' ability to serve growing library networks efficiently.
    *   User Experience Gap: Library patrons expect an intuitive interface. The current system lacks responsive design, mobile reservation capabilities, and proactive notifications, resulting in patron frustration and increased staff intervention.
    *   Competitive Disadvantage: Competitors like Envisionware and MYPC offer superior features including mobile reservations, cross-platform support, and cloud deployment options. _TRAC_SYSTEMS must establish market leadership through proprietary innovation rather than value-added reselling.
*   What are the benefits?  
    The _TRAC_SYSTEMS Library Management Platform delivers transformative value through complete technology ownership, enabling rapid innovation and strategic autonomy. Its cloud-ready architecture scales efficiently across expanding library networks while reducing infrastructure complexity. Patrons experience consumer-grade digital interfaces, staff gain real-time visibility and control, and IT administrators benefit from simplified configuration workflows that reduce support burden. These improvements strengthen competitive positioning, create sustainable market differentiation, and establish a foundation for long-term revenue growth and market leadership in the library technology sector.
*   What is the vision?

The vision is to establish _TRAC_SYSTEMS as the market leader in library technology solutions through a state-of-the-art platform that serves as the central hub for all library workstation management operations. This platform will deliver seamless integration between patron self-service, staff management tools, and administrative functions, ensuring robust security, intuitive user experiences, and operational excellence. The solution will empower library patrons with consumer-grade user experiences, library staff with real-time visibility and control, and IT administrators with simplified configuration and maintenance workflows. By establishing complete technology ownership and cloud-ready architecture, _TRAC_SYSTEMS will drive efficiency, responsiveness, and innovation while creating sustainable competitive advantages and enabling long-term revenue growth.

# Assumptions:

*   _TRAC_SYSTEMS will provide timely access to representative library sites (including the pilot library identified by Week 1) for requirements validation, user testing, and deployment activities to ensure real-world validation of platform capabilities.
*   Existing ILS systems will remain operational and accessible for integration testing throughout the development period. SIP2 protocol documentation and test environment access for all target ILS platforms (Polaris, Sierra, Aleph, TLC, Sirsi Dynix Symphony) will be provided by Week 3.
*   _TRAC_SYSTEMS IT team stakeholders subject matter experts will participate actively in scheduled requirements workshops, sprint demos, UAT sessions, and provide timely feedback and approvals for feature implementations, UI designs, and workflow validations.
*   On-premises infrastructure meeting minimum technical requirements (as specified by Seanergy) will be provisioned by Week 13 to support pilot library deployment, including appropriate server resources, network connectivity, and security configurations.
*   Development and deployment environments will be provided with necessary infrastructure, access credentials, security permissions, and network access to support efficient and uninterrupted development, testing, and integration activities.
*   End users (library patrons, staff, and administrators) will be supported through comprehensive documentation including user guides, video tutorials, administrator runbooks, and operational procedures to facilitate smooth onboarding and independent system navigation.
*   Legacy Pharos SignUp system will remain accessible during transition period to support optional coexistence strategy and provide rollback capability if needed.

# Dependencies:

*   Cross-functional collaboration across Marketing, Sales, IT, and Operations is necessary to ensure accurate requirement alignment and smooth user adoption.
*   Access to external systems (WMS, TMS, ERP, HubSpot, JIRA) and related API documentation must be shared to enable real-time integration.
*   Reliable and consistent backend data is essential for generating accurate reports, dashboards, and analytics.
*   Stakeholders must be actively involved in reviews and approvals to validate feature alignment with business expectations.
*   Required environments, infrastructure, and user access credentials must be provisioned to support development, testing, and deployment.
*   API keys and configurations for third-party tools should be made available during the integration phase.

# Product Owner:

*   Steven English

# Identification of the stakeholders:

*   Chris Trail, Jeffery Libby

# Identification of the end users for UAT:

*   Steven English, Chris Trail and Jeffery Libby

# Requirement list:

| Module                  | #                                                          | Screen                                                                                                                                                                                                                            | Description                                                                                                                          |
| -------------------------| ------------------------------------------------------------| -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------| --------------------------------------------------------------------------------------------------------------------------------------|
| User Kiosk              | 1                                                          | Welcome Screen                                                                                                                                                                                                                    | Initial landing page that provides access options for patrons and visitors to the library PC reservation system.                     |
| 2                       | Login Screen for Patrons                                   | Authentication interface for registered library patrons to access reservation features using their library credentials.                                                                                                           |                                                                                                                                      |
| 3                       | Make a Reservation                                         | Selection screen allowing patrons to choose from various resource types (workstations, conference room, 3D printers).                                                                                                             |                                                                                                                                      |
| 4                       | Select a PC Type and Workstation (Workstation Reservation) | Interface for patrons to choose their preferred PC configuration (e.g., standard, express, High-performance between immediate usage or scheduling a future reservation.                                                           |                                                                                                                                      |
| 5                       | Get Confirmation Details                                   | Display screen showing assigned PC number, location, session duration, and check-in instructions.                                                                                                                                 |                                                                                                                                      |
| 6                       | Reserve a Conference Room                                  | Selection screen allowing patrons to choose a conference room between immediate usage or scheduling a future reservation.                                                                                                         |                                                                                                                                      |
| 7                       | Get Confirmation Details                                   | Display screen showing assigned conference room, location, session duration, and check-in instructions.                                                                                                                           |                                                                                                                                      |
| 8                       | Reserve a 3D printer                                       | Selection screen allowing patrons to choose a 3D printer between immediate usage or scheduling a future reservation.                                                                                                              |                                                                                                                                      |
| 9                       | Get Confirmation Details                                   | Display screen showing assigned 3D printer, location, session duration, and check-in instructions.                                                                                                                                |                                                                                                                                      |
| 10                      | Join a Waitlist                                            | Access waitlist when computers are unavailable                                                                                                                                                                                    |                                                                                                                                      |
| 11                      | View Waitlist                                              | Screen showing current waitlist status if PCs are fully booked, or message indicating no active waitlist.                                                                                                                         |                                                                                                                                      |
| 12                      | Existing Reservation Listing                               | View all personal bookings; manage upcoming reservations.                                                                                                                                                                         |                                                                                                                                      |
| Nerve Center / IT Admin | 13                                                         | Login Screen for Nerve Center Users/ IT admins                                                                                                                                                                                    | Authentication interface for registered IT administrators and nerve center users to access various features using their credentials. |
| 14                      | Dashboard                                                  | The overview screen displays real-time statistics of computer availability, active sessions, utilization rates, queued reservations, scheduled reservations, and system issues across selected branch and group.                  |                                                                                                                                      |
| 15                      | Search for Patron                                          | Search interface allowing library staff to find patron accounts using various criteria like name, ID number, email, or phone number.                                                                                              |                                                                                                                                      |
| 16                      | Modify Patron Details                                      | Form screen for editing existing patron information including contact details, membership status, and account settings.                                                                                                           |                                                                                                                                      |
| 17                      | Create Patron                                              | Registration form for adding new registered library patrons with required information and membership details.                                                                                                                     |                                                                                                                                      |
| 18                      | Create Visitor                                             | Quick registration form for creating temporary visitor accounts with limited access privileges for non-members.                                                                                                                   |                                                                                                                                      |
| 19                      | Batch Visitors                                             | Bulk registration screen for creating multiple visitor accounts simultaneously, useful for group visits or events.                                                                                                                |                                                                                                                                      |
| 20                      | Receipt Visitors                                           | Screen for generating and printing visitor receipts or temporary access passes for walk-in users.                                                                                                                                 |                                                                                                                                      |
| 21                      | Sign Up Global Settings                                    | Configuration screen for system-wide reservation policies including LAN logon settings, scheduled reservation rules, timeout policies, cancellation warnings, and visitor account parameters.                                     |                                                                                                                                      |
| 22                      | Branches                                                   | Branch configuration screen for managing all library locations, their operating hours, time zone settings, and computer inventory at each branch.                                                                                 |                                                                                                                                      |
| 23                      | Resource Groups                                            | Configuration interface for organizing computers into physical location-based groups within a branch, allowing administrators to set availability properties and session parameters specific to each grouped subset of computers. |                                                                                                                                      |
| 24                      | Resource Types                                             | Resource Types editor for organizing PCs into categories such as Standard PCs, Express Stations, and High-Performance computers, with configurable default session durations and real-time status monitoring.                     |                                                                                                                                      |
| 25                      | Reservations                                               | Comprehensive view of all PC reservations showing past, current, and future bookings with options to modify, cancel, or manually create reservations.                                                                             |                                                                                                                                      |
| 26                      | Queue                                                      | Management screen for viewing and processing patrons waiting for available computers, including queue priority and estimated wait times.                                                                                          |                                                                                                                                      |
| 27                      | Schedule                                                   | Configuration screen for setting library branch operating hours for each day of the week and managing holiday closures or special schedule exceptions.                                                                            |                                                                                                                                      |
| 28                      | System                                                     | System configuration screen for managing core application settings, user permissions, database connections, security policies, and technical administration options.                                                              |                                                                                                                                      |
| PC Access               | 29                                                         | Welcome Screen                                                                                                                                                                                                                    | Initial screen displayed on the physical PC when powered on, welcoming users to the library computer system.                         |
| 30                      | Policy                                                     | Screen displaying library computer usage policies, acceptable use terms, and rules that users must acknowledge before accessing the PC.                                                                                           |                                                                                                                                      |
| 31                      | Patron Login                                               | Client-side authentication on workstation; session start.                                                                                                                                                                         |                                                                                                                                      |
| 32                      | Time Tracker                                               | Display Visual countdown of session time; low-time and critical warnings.                                                                                                                                                         |                                                                                                                                      |

# Functional Requirements Details:

# Module 1: User Kiosk

## i. Welcome Screen:

*   The sign-in selection screen must serve as the authentication gateway following the welcome screen, presenting patrons and visitors with clearly defined login pathways to access the library PC reservation system.
*   The screen must display the system logo (e.g., TRACSYSTEMS branding with tagline "Print. Copy. Reserve. Save.") in the top-left corner. This logo must be customizable for each client deployment.
*   A prominent heading "Welcome to The Library" must be displayed centrally, where "The Library" is styled in a distinct accent color (e.g., purple/indigo) to denote the client-specific library name. This library name must be customizable per deployment.
*   Instructional subtext reading "Choose how you'd like to sign in." must appear directly beneath the heading to guide the user toward selecting an authentication method.
*   Two sign-in option cards must be presented side by side in a horizontally centered layout, each functioning as a selectable button:
*   Patron Card: Must display a card/badge icon, the label "Patron," and the descriptive text "Sign in with your card number and PIN." Selecting this option must route the user to the patron authentication screen where library card credentials are required.
*   Guest Card: Must display a person/guest icon, the label "I am a guest," and the descriptive text "Make a one-time reservation." Selecting this option must route the user to a guest reservation workflow that does not require existing library credentials.
*   Each sign-in card must provide clear visual feedback (e.g., hover state, press state, or elevation change) when interacted with to confirm user selection.
*   The system must display the current date and time in the top-right corner of the screen (e.g., "Tuesday, Feb 17, 2026 | 1:18 AM") to provide temporal context for patrons.
*   The screen must include a footer section displaying "Powered by TRACSYSTEMS | For assistance, please see a librarian" to provide system attribution and direct patrons to staff support when needed. This footer text must be customizable per client.
*   The screen must support touch interaction as the primary input method, with each sign-in card acting as a tappable region that advances users to the corresponding authentication or reservation workflow.
*   The screen must be optimized for display on various screen sizes and orientations while maintaining consistent card layout, branding, readability, and usability across different hardware configurations.
*   The system must support the same accessibility features available on other screens, including zoom/sizing controls and language selection options, accessible through special gestures or dedicated interface elements.
*   The sign-in selection screen must remain active in an idle state until user interaction is detected. If no interaction occurs within a configurable timeout period, the system should return to the initial welcome/swipe-to-start screen.

## ii. Login Screen for Patrons

*   The login screen must serve as the primary authentication interface where library visitors identify themselves using their library credentials to access Reserve a PC.
*   The form must contain the following configurable input fields:
    *   Library Card Number field with customizable label (e.g., "ID", "Library Barcode", "Barcode", "Card Number")
    *   PIN field with customizable label and masked input for security
    *   Placeholder/hint text must be configurable for both fields to accommodate different organizational terminology
*   Each input field must display appropriate iconography (user icon for card number, lock/security icon for PIN) to provide visual cues for the type of information required.
*   The PIN field must mask input characters (displayed as dots/asterisks) to maintain confidentiality and prevent shoulder-surfing attacks.
*   The User ID field must mask input characters (displayed as dots/asterisks) to maintain confidentiality and prevent shoulder-surfing attacks (based on a toggle at the kiosk level or configured as per user category).
*   The system must implement enhanced login intelligence with regex filtering to automatically detect user types based on ID format patterns:
    *   Detect whether the user is a library card holder or guest based on the entered ID format
    *   Automatically update field hints and labels based on what is being typed (e.g., "Looks like you're entering a guest ID. Guest IDs don't need passwords")
    *   Dynamically disable or hide the password/PIN field for guest accounts if they do not require password authentication.
    *   The User ID field must mask input characters (displayed as dots/asterisks) to maintain confidentiality and prevent shoulder-surfing attacks (based on a toggle at the kiosk level or configured as per user category).
    *   Provide a preview toggle feature for PIN field as it is temporary password being entered into the system.
    *   Recognize library card prefixes and patterns to build user expectations and adapt the UI accordingly
*   Login fields must automatically receive focus when the page loads to enable immediate data entry and support barcode scanner integration.
*   The system must support barcode scanner input such that:
    *   If a user scans their library card on the welcome screen, the system automatically advances to the login screen and populates the appropriate field
    *   The first keystroke captured on the welcome screen triggers automatic advancement to the login screen with the scanned data populated in the correct field
    *   Barcode scanners connected via USB or other interfaces are recognized and treated as standard keyboard input
*   All text content, labels, field names, and button text must be fully customizable by administrators (at a global level) to accommodate different organizational terminology and workflows.
*   The system must not display personally identifiable information in plain text; instead, use alias fields that combine characters from the user's first name and barcode/ID for privacy protection.
*   After unsuccessful login attempts, the system must provide clear, actionable error messaging indicating the nature of the authentication failure without compromising security (e.g., avoid specifying whether username or password was incorrect).
*   The login screen must support touch interaction as the primary input method while also accommodating physical keyboard input for environments with traditional input devices.
*   The portal must support language selection between English and Spanish, with an icon-based toggle.
*   Language Selection option must be persistently available across all pages of the portal, enabling users to switch languages seamlessly without leaving the current screen.
*   Reservation system in the library should not save the login credentials.

## iii. Make a Reservation

*   The reservation type selection screen must be displayed immediately after successful patron authentication, allowing users to choose between different resource types.
*   Authenticated user information must be displayed in the top-right corner, including the patron's name and library card number (e.g., "Jane Doe, Card: 21223") with an associated user profile icon for personalization and session confirmation.
*   The screen will have all the resource types available displayed, selectable cards:
    *   PC: When selected, must initiate the PC reservation workflow
    *   Conference Room: When selected, must advance to the reservation of a Conference room.
*   Each option card must be implemented as an interactive element with appropriate visual feedback (hover states, active states, touch response) to indicate interactivity and confirm selection.
*   A "LOGOUT" button must be prominently displayed below the reservation options; when activated, must terminate the user session and return to the welcome screen.
*   All text content, button labels, option headings, and descriptive text must be fully customizable by administrators to accommodate different organizational terminology and workflows.
*   If the patron remains inactive on this screen for a predetermined timeout period (configurable by administrators), the system must display a warning message before automatically logging out the user and returning to the welcome screen.

## iv. Select a PC Type and Workstation (Workstation Reservation)

*   The screen must display available PC types as distinct cards showing type name, icon, maximum session duration, use case description, and real-time availability count (e.g., "12 Available").
*   Each PC type must be configurable with display name, description, max session duration, intended use specifications, and sort order.
*   All text content, labels, and descriptions must be configurable by administrators.
*   The system must show real-time availability counts that refresh automatically at configurable intervals (default: 5-10 seconds).
*   Unavailable PC types must display in a disabled state with grayed-out styling and "Unavailable" status, with selection buttons non-functional.
*   When a patron selects an available PC type, the system must validate availability, record the selection, display a dropdown with available PCs. Once a PC is selected, that PC is assigned and a confirmation is provided in the next screen.
*   If a selected PC type becomes unavailable (race condition), the system must display an error message and return the patron to the selection screen with updated availability.
*   The screen must provide a "Back" button to return to the previous screen while preserving session information.
*   A prominent logout button must be displayed for easy session termination, especially critical for high-traffic kiosk environments.
*   The system must automatically log out inactive patrons after a configurable timeout (e.g., 2 minutes) with a warning prompt.
*   On institution-owned kiosks, the screen must operate in full-screen mode with no ability to exit the application or access external content.
*   The system must distinguish between remote access users and in-library kiosk users.
*   The system must support custom institutional logos, color schemes, font sizes, language selection (persisted from previous screens), and branding elements.
*   All interactive elements must be keyboard accessible with screen reader support, ARIA labels, and meet WCAG accessibility standards.
*   High contrast mode must be supported, with information conveyed through both visual and text indicators.
*   The header must display patron name/alias, card number, and current date/time.
*   The footer must display configurable assistance information and optional system branding

## v. Get Confirmation Details (PC Workflow)

1.  The screen must display a reservation details card containing patron name/alias, assigned computer label with PC type (e.g., "PC-07 (Standard PC)"), date in full format, and session time range showing start time, end time, and total duration in minutes.
2.  A configurable status message must indicate the computer is ready (e.g., "Standard PC is waiting for you!").
3.  Icons must accompany each detail line for visual clarity.
4.  If the computer has location/area information configured, it may optionally be displayed (e.g., "PC-07 - Computer Lab").
5.  Session start time must be the current time when assignment was made.
6.  Session end time must be calculated as start time + PC type's maximum duration limit.
7.  If the calculated end time extends beyond library closing hours, the system must adjust to closing time and display the modified duration.
8.  If the patron remains inactive for a configurable timeout period (e.g., 1 minute), the system must display a warning prompt, then automatically cancel the reservation and release the computer after an additional grace period (e.g., 30 seconds) if no response is received.

## vi. Reserve a Conference Room

*   The screen must display a "Select a Conference Room" heading and prompt the patron to choose a conference room from available sections.
*   Conference rooms must be grouped visually by section (e.g., "Children's Area," "East Section," "Study Room A"), each rendered as a distinct bordered region with a section label and color-coded background.
*   Each room must be represented by an icon and a room code label (e.g., "CR-01," "CR-03"), and be individually selectable.
*   When a patron selects a room, it must be visually highlighted (e.g., larger icon, distinct styling), and a confirmation bar must display the selected room code and section name (e.g., "Room selected: CR-03 East Section").
*   The screen must provide "Cancel" and "Confirm" action buttons to either discard or proceed with the room selection.
*   A navigation bar must include a Home button and a Back arrow to return to the previous screen while preserving session information.
*   A prominent "Logout" button must be displayed in the header for easy session termination.
*   The header must display the patron's name, card number, and current date/time.
*   The footer must display system branding and configurable assistance information (e.g., "Powered by TRACSYSTEMS | For assistance, please see a librarian").
*   The system must support institutional logo display and configurable color schemes/branding elements.

## vii. Get Confirmation Details (Conference Room Workflow)

*   The screen must display a reservation details card containing patron name/alias, assigned conference room with location (e.g., "CR-02 (East wing)"), date in full format, and session time range showing start time, end time, and total duration in minutes.
*   A configurable status message must indicate the conference room is ready (e.g., "Conference room - 07 is waiting for you!").
*   Icons must accompany each detail line for visual clarity.
*   Session start time must be the current time when assignment was made.
*   Session end time must be calculated as start time + conference room’s maximum duration limit.
*   If the calculated end time extends beyond library closing hours, the system must adjust to closing time and display the modified duration.
*   If the patron remains inactive for a configurable timeout period (e.g., 1 minute), the system must display a warning prompt, then automatically cancel the reservation and release the computer after an additional grace period (e.g., 30 seconds) if no response is received.

## viii. Reserve a 3D printer

*   The screen must display a "Select a 3D Printer" heading and prompt the patron to choose a 3D printer from available sections.
*   3D printers must be grouped visually by section (e.g., "Children's Area," "East Section," "Study Room A"), each rendered as a distinct bordered region with a section label and color-coded background.
*   Each printer must be represented by a printer icon and a device code label (e.g., "3DP-01," "3DP-04"), and be individually selectable.
*   Before any printer is selected, the confirmation bar must display "Printer selected:" with no value, and the "Confirm" button must appear in a disabled/grayed-out state to prevent submission without a selection.
*   The "Cancel" button must remain active at all times, allowing the patron to exit the selection flow.
*   Sections may contain varying numbers of printers (e.g., 2 in Children's Area, 3 in East Section, 2 in Study Room A), and the layout must accommodate variable counts per section.
*   A navigation bar must include a Home button and a Back arrow to return to the previous screen while preserving session information.
*   A prominent "Logout" button must be displayed in the header for easy session termination.
*   The header must display the patron's name, card number, and current date/time.
*   The footer must display system branding and configurable assistance information (e.g., "Powered by TRACSYSTEMS | For assistance, please see a librarian").

## vii. Get Confirmation Details (3D Printer Workflow)

1.  The screen must display a reservation details card containing patron name/alias, assigned 3D printer with location (e.g., "3D-03 (East wing)"), date in full format, and session time range showing start time, end time, and total duration in minutes.
2.  A configurable status message must indicate the conference room is ready (e.g., "3D printer - 03 is waiting for you!").
3.  Icons must accompany each detail line for visual clarity.
4.  Session start time must be the current time when assignment was made.
5.  Session end time must be calculated as start time + 3D printer’s maximum duration limit.
6.  If the calculated end time extends beyond library closing hours, the system must adjust to closing time and display the modified duration.
7.  If the patron remains inactive for a configurable timeout period (e.g., 1 minute), the system must display a warning prompt, then automatically cancel the reservation and release the computer after an additional grace period (e.g., 30 seconds) if no response is received.

## ix. Join a Waitlist

*   The screen must appear when no computers are available for the patron's selected PC type, date, and time after validation on the Schedule a Time screen.
*   The screen must display: a clear message explaining all computers are currently booked (e.g., "All \[PC Type\] computers are booked for \[selected date/time\]"), the patron's selected reservation parameters (PC type, date, time, duration), and an explanation of how the waitlist functions (e.g., "Join the waitlist to be notified if a spot becomes available").
*   The system must show current waitlist length for the selected time slot (e.g., "3 people are currently on the waitlist for this time").
*   A "Join Waitlist" button must: add the patron to the waitlist queue for the specific PC type/date/time combination, assign a position number based on enrollment timestamp (first-come, first-served), create a waitlist record with patron identifier and reservation parameters, send confirmation of waitlist enrollment via configured channels (email/SMS if enabled), and proceed to the waitlist status screen.
*   The system must enforce any waitlist limits (e.g., maximum 10 people per time slot) and display an error if the waitlist is full.
*   A "Try Different Time" button must return the patron to the Schedule a Time screen to select an alternative slot.
*   A "Cancel" button must return the patron to the main menu.
*   The system must automatically promote patrons from the waitlist to confirmed reservations when: an existing reservation is cancelled, a patron fails to check in within the grace period (releasing the computer), or additional computers become available.
*   Promotions must occur in waitlist position order (position 1 promoted first).
*   Promoted patrons must receive immediate notification via all configured channels with a configurable response window (e.g., "Confirm within 30 minutes or your spot will be offered to the next person").
*   If a promoted patron does not respond within the window, their waitlist position is forfeited, and the next person is promoted.
*   Waitlists must be specific to the exact date, time, and PC type combination selected.
*   Patrons may join multiple waitlists for different time slots simultaneously.

## x. View Waitlist

*   The screen must display all active waitlist entries for the current patron, showing for each entry: PC type, date and time range, current position in queue (e.g., "Position 2 of 5"), estimated wait description or notification instructions (e.g., "You'll receive a notification if a spot opens up").
*   Waitlist entries must be sorted by date/time with soonest first.
*   If the patron has no active waitlist entries, display a message: "You're not currently on any waitlists."
*   Waitlist positions must update in real-time or upon screen refresh as other patrons cancel or are promoted.
*   The system may optionally display estimated likelihood or expected notification timing if calculable from historical cancellation patterns.
*   Each waitlist entry must provide a "Leave Waitlist" or "Remove" action button that: prompts for confirmation before removing, removes the patron from that specific waitlist queue, updates positions for remaining patrons on that waitlist, and sends a removal confirmation notification.
*   A "Refresh Status" button may be provided to manually update position information.
*   A "Back" or "View Reservations" button must allow navigation to the patron's confirmed reservations screen.
*   The screen must be accessible from the main menu or patron account area.
*   When a patron is promoted from a waitlist to a confirmed reservation: the waitlist entry must be removed from this screen automatically, the new confirmed reservation must appear on the Existing Reservation Listing screen, and notification must be sent with the response deadline.
*   If the patron views this screen while a promotion is pending their response, it must display prominently with the remaining time to confirm (e.g., "A spot opened up! Confirm by \[time\] to secure your reservation.").

## xi. Existing Reservation Listing

*   The screen must display a list of all confirmed (not waitlisted) reservations for the current patron, showing for each: reservation status (upcoming, active, completed), assigned computer identifier and PC type, date and time range with duration, check-in status if applicable (e.g., "Check-in required by \[time\]"), and reservation creation timestamp.
*   Reservations must be sorted with upcoming reservations first, then active sessions, then recently completed.
*   If the patron has no reservations, display: "You have no upcoming reservations" with a "Make a Reservation" button linking to the PC Type selection screen.
*   The system must visually distinguish reservation states: upcoming (future start time), active (current session in progress), check-in warning (within grace period but not checked in), and completed/past.
*   Each status must have a distinct visual indicator (color, icon, or badge).
*   Upcoming reservations must provide a "Cancel" action button that: displays a confirmation prompt with cancellation policy (e.g., "Are you sure? Cancellations must be made at least 1 hour before start time."), validates the cancellation is allowed per policy rules (configurable cancellation deadline, e.g., 1 hour before start time), cancels the reservation and releases the computer if validation passes, removes the entry from the list or marks it as cancelled, sends cancellation confirmation notification, and displays an error if cancellation deadline has passed.
*   Active sessions must not be cancellable from this screen (must end session at the computer itself).
*   Completed reservations must display as read-only history with no action buttons.
*   The system must not allow modification of existing reservations (time/date changes) through this interface - patrons must cancel and create a new reservation.
*   A "View Waitlists" button must link to the View Waitlist screen to show active waitlist entries.
*   If a patron has many reservations, the system must paginate the display or limit to recent/upcoming entries (e.g., show last 30 days of history and all future reservations).
*   The system must enforce any policies regarding multiple concurrent reservations (e.g., maximum 3 active future reservations per patron).
*   If the limit is reached, attempting to create a new reservation must display an error message with instructions to cancel an existing reservation first.

# Module 2: Admin/Nerve Center

## i. Login Screen:

Login Authentication Screen Description:

*   Staff members must log in using valid username and password credentials to access the _TRAC_reserve administrative portal.
*   The form must contain the fields below:
    *   Username
    *   Password
*   The password field must mask input to maintain confidentiality.
*   Upon successful authentication, staff members must be granted access to system features and data based on their assigned role permissions (e.g., administrator with full access, or restricted staff access to specific modules).
*   After three consecutive unsuccessful login attempts, the system must lock the account and display a clear message instructing the user to contact the system administrator for assistance.
*   The system must validate credentials against the staff database and deny access to unauthorized users with an appropriate error message.
*   Access control must be enforced immediately upon login, ensuring staff can only view and modify information within their authorized scope.
*   All login attempts (successful and failed) must be logged for security audit purposes with timestamp and user identification.

## ii. Dashboard

**Dashboard Screen Description:**

*   The dashboard must serve as the primary landing page after successful staff authentication, providing a comprehensive real-time overview of computer resource management across the library system.
*   The dashboard must display the following key performance metrics in dedicated card widgets at the top of the screen:
    *   Active Sessions - Total number of computers currently in use
    *   Available Now - Total number of computers available for immediate use out of the total inventory
    *   Utilization Rate - System-wide average percentage of computer usage
    *   Offline/Maintenance - Total number of computers requiring attention or undergoing maintenance
*   Each metric card must include descriptive labels to provide context for the displayed values.
*   The system must present a "Branch Occupancy Heatmap" visualization showing real-time computer usage status across all library branches with the following features:
    *   Color-coded representation: Red for occupied, green for available, gray for offline computers
    *   Individual branch sections displaying branch name and occupancy count (e.g., "28 / 60 occupied")
    *   Visual grid layout representing individual computer stations o Clear legend identifying the color-coding scheme o Support for multiple computer types (adult, child, etc.) and zones (floors/sections/physical locations) o Distinction between standard and express PC types
*   The dashboard must include a "Peak Usage Hours" panel displaying:
    *   Predefined time slots with highest utilization (e.g., 10:00 AM - 12:00 PM, 2:00 PM - 4:00 PM, 6:00 PM - 8:00 PM)
    *   Corresponding utilization percentages for each time slot
    *   Color-coded indicators (red for highest usage, orange for moderate, blue for lower usage)
*   The system must provide a "Today's Statistics" summary panel showing:
    *   Total Sessions - Cumulative count of all sessions for the current day
    *   Avg. Session Time - Average duration of computer sessions o Queue Wait Time - Average waiting time for users in reservation queue
*   The dashboard must display a "Recent Activity" feed showing:
    *   User activity logs (e.g., session starts, reservations) o System alerts (e.g., computers going offline)
    *   Timestamps for each activity entry
    *   Computer identification (e.g., PC-05, PC-12, PC-23)
    *   Activity type indicators with distinct visual icons or colors
*   Staff must have the ability to filter dashboard data by specific branch or computer group based on their assigned permissions and role access levels.
*   All dashboard data must auto-refresh at regular intervals (configurable by administrator) to ensure real-time accuracy without requiring manual page reload.
*   The dashboard must be responsive and accessible, ensuring staff can monitor system status efficiently during high-traffic periods.
*   Administrators must have access to view all branches and system-wide statistics, while restricted staff members must only view data for branches and computer groups within their authorized scope.

## iii. Search for Patron

*   Staff must be able to search for existing patron accounts using multiple search criteria to quickly locate and access patron information.
*   The search interface must provide two distinct search methods:
    *   Personal Information search - using First Name, Last Name, and Alias fields
    *   Card Information search - using Card Number and Card ID fields
*   Staff must have the option to use either search method independently, allowing flexibility in how patrons are located based on available information.
*   The system must include filter controls with the following options:
    *   Group filter (e.g., "All Groups") to narrow search results by patron categories
    *   Results limit selector (e.g., "50 results") to control the number of displayed records
*   A "Reset" button must be prominently displayed to allow staff to clear all search criteria and start a new search.
*   Search fields must accept partial matches to facilitate searches when complete information is unavailable.
*   The system must display clear instructional text such as "Search by personal info or card details" and "Use search method" to guide staff through the search process.
*   Search results must return patron records that match the entered criteria, displaying relevant identifying information for staff to select the correct patron.
*   The search functionality must be accessible only to staff members with appropriate patron management permissions based on their role.
*   The system must provide branch and group filters at the top of the screen, allowing staff to scope their search to specific library branches or patron groups based on their access privileges.
*   All search operations must execute efficiently to minimize wait time, with results appearing within 2-3 seconds of query submission.

## iv. Modify Patron Details

*   Staff must be able to update existing patron account information through a comprehensive modification form after selecting a patron from the search results.
*   The screen must include a "Select Patron" dropdown at the top, displaying the patron's ID number and name (e.g., "107 - John Doe") to confirm the correct account is being modified.
*   The form must be organized into the following distinct sections with clear section headers:
    *   **Personal Information Section:**
        *   First Name field - editable text field for updating patron's first name
        *   Last Name field - editable text field for updating patron's last name
        *   Alias field - editable text field for updating patron's alias or preferred name
    *   **Card Information Section:**
        *   Card Number field - displays patron's card number (may be non-editable or restricted based on permissions)
        *   Card ID / External ID field - displays or allows editing of the patron's external system identifier
    *   **Contact Information Section:**
        *   Email Address field - editable field for updating patron's email
        *   Phone Number field - editable field for updating patron's contact number
    *   **Access Privileges Section:**
        *   User Group dropdown - allows changing patron's group assignment (e.g., Public, Student, Faculty)
        *   Minutes Allowed Today field - configurable limit for daily computer usage time
        *   Sessions Allowed Today field - configurable limit for number of daily sessions
        *   Account Status dropdown - allows changing status (e.g., Active, Suspended, Expired, Inactive)
*   The system must display a "Session History Summary" panel showing:
    *   Total Sessions - lifetime count of all patron sessions
    *   Sessions Today - count of sessions for current day
    *   Minutes Completed Today - total minutes used in current day
*   A "Reset Changes" button must be available to revert all modifications back to original values before saving.
*   Action buttons must be provided at the bottom of the form:
    *   "Cancel" button - discards all changes and returns to previous screen
    *   "Save Changes" button - commits all modifications to the patron record
*   The system must display a confirmation message "Ready to save the changes? Review all modifications before proceeding" before committing updates to the database.
*   All changes must be validated in real-time, with appropriate error messages displayed for invalid entries (e.g., invalid email format, duplicate card numbers).
*   The system must maintain an audit log of all modifications, recording the staff member who made changes, timestamp, and fields modified.
*   Only staff members with appropriate modification permissions should be able to edit patron records, with administrators having full access and restricted staff having limited field access.
*   The system must prevent modification of archived or deleted patron accounts with appropriate error messaging.

## v. Create Patron

*   Staff must be able to register new library patrons through a comprehensive registration form that collects all required patron information.
*   The form must be organized into the following distinct sections with clear section headers:
    *   **Personal Information Section:**
        *   First Name field (required) - marked with asterisk to indicate mandatory field
        *   Last Name field (required) - marked with asterisk to indicate mandatory field
        *   Alias field (optional) - for preferred name or nickname
    *   **Card Information Section:**
        *   Card Number field (required) - with option to manually enter or use "Generate" button to auto-create unique card number
        *   External ID (SIP2) field - for integration with library system identifiers
    *   **Contact Information Section:**
        *   Email Address field (optional) - for patron communication
        *   Phone Number field (optional) - for patron contact
    *   **Access Privileges Section:**
        *   User Group dropdown (required) - assigns patron to appropriate category (e.g., Public, Student, Faculty, Staff)
        *   Minutes Allowed Today field - sets daily computer usage time limit (can be set to "Unlimited")
        *   Sessions Allowed Today field - sets daily session limit (can be set to "Unlimited")
*   The system must display a "Duplicate Detection" warning banner informing staff: "The system will automatically check for duplicate patrons based on name and card number. If potential duplicates are found, you will be prompted to review them before proceeding."
*   A "Reset Form" button must be prominently displayed in the top-right corner to clear all entered data and restart the registration process.
*   Action buttons must be provided at the bottom of the form:
    *   "Clear Form" button - clears all field entries while remaining on the registration screen
    *   "Create Patron" button - validates and submits the new patron account for creation
*   The system must display a confirmation message "Ready to create the new patron account? Review all information before proceeding" before final submission.
*   All required fields must be validated before allowing form submission, with clear error indicators and messages for missing or invalid data.
*   The "Generate" button for Card Number must create a unique, non-duplicate card number following the library's card numbering convention.
*   Upon successful patron creation, the system must:
    *   Generate a unique patron ID o Create the patron record in the database
    *   Display a success confirmation with the new patron's ID and card number
    *   Provide options to print a patron card or receipt
*   The system must check for potential duplicate patrons based on name similarity and existing card numbers before final submission, prompting staff to review and confirm if matches are found.
*   Only staff members with patron creation permissions should be able to access this form and create new patron accounts.

## vi. Create Visitor

*   Staff must be able to quickly create temporary visitor accounts for non-members who require limited, time-bound access to library resources.
*   The form must be organized into the following distinct sections:
    *   Visitor Information Section:
        *   Name / Alias field (required) - for visitor's name or preferred identifier
        *   ID Number field (optional) - for recording visitor's driver's license, government ID, or other identification
    *   Contact Information Section:
        *   Email field (optional) - for visitor communication if provided
        *   Phone field (optional) - for visitor contact if provided
    *   Pass Configuration Section:
        *   Card Number field - displays "Auto-generated" by default with optional "Generate" button to preview or regenerate
        *   Expires In dropdown - sets visitor pass duration (e.g., 24 hours/1 day, 3 days, 7 days, custom)
        *   Visitor Group dropdown - assigns appropriate restricted access group (e.g., "visitors (Filtered Internet)")
        *   Minutes Allowed field - sets total computer time limit for visitor (e.g., 60 minutes)
        *   Notes field (optional) - for recording special notes, restrictions, or visit purpose
*   The system must display an informational banner titled "Visitor Details" explaining: "This will create a temporary visitor that expires after the selected duration. The system will automatically deactivate expired visitors. Visitors cannot be used for reservations."
*   A "Reset Form" button must be available in the top-right corner to clear all entered information.
*   Action buttons must be provided at the bottom:
    *   "Clear Form" button - clears all field entries
    *   "Create Visitor" button - validates and creates the temporary visitor account
*   The system must display a confirmation message "Ready to create the visitor account? Review all information before proceeding" before final submission.
*   Visitor accounts must be automatically assigned:
    *   A unique, system-generated card number
    *   Limited access privileges with filtered internet or restricted resources
    *   An automatic expiration date/time based on the selected duration
    *   A visitor-specific user group with pre-configured limitations
*   Upon successful creation, the system must:
    *   Generate a visitor pass with credentials (login ID and password/PIN)
    *   Display the visitor's access credentials clearly for staff to communicate to the visitor
    *   Provide option to print a visitor pass or receipt
*   The system must automatically deactivate visitor accounts upon expiration without requiring manual staff intervention.
*   Expired visitor accounts must not be able to log in or make new reservations, but their session history should be retained for reporting purposes.
*   The system must track which staff member created each visitor account for audit and accountability purposes.

## vii. Batch Visitors

*   Staff must be able to create multiple temporary visitor accounts simultaneously through a bulk registration interface, streamlining the process for group visits, events, or tours.
*   The batch creation form must include the following configuration fields in the "Basic Configuration" section:
    *   Quantity field - numeric input specifying how many visitors passes to create (e.g., 20)
    *   Logon ID Prefix field - text prefix for all generated login IDs (e.g., "pass")
    *   Total Logon ID Length field - numeric value setting complete length of login ID including prefix
    *   User Group dropdown - assigns all visitors to specified group (e.g., "visitors (Filtered Internet)")
    *   Password Prefix field - text prefix for all generated passwords (e.g., "trac")
    *   Total Password Length field - numeric value setting complete length of password including prefix
    *   "Make all passwords identical? (same as prefix)" checkbox - option to use the same password for all passes
    *   "Print passwords on visitor passes?" checkbox - option to include passwords on printed passes
*   The system must display a "Batch Creation Notice" banner explaining: "This will create \[X\] temporary visitor passes. Each pass will have a unique ID starting with '\[prefix\]' and a password starting with '\[prefix\]'. The passes will be ready to print immediately after creation."
*   A "Reset Form" button must be prominently available to clear all configuration settings.
*   Action buttons must be provided at the bottom:
    *   "Cancel / Reset" button - cancels the batch operation and clears the form
    *   "Create Visitors" button - executes the bulk creation process
*   The system must display a confirmation message "Ready to create \[X\] visitor passes? Passes will be generated and ready for printing" before executing the batch creation.
*   All generated visitor accounts must:
    *   Have unique, sequential login IDs following the specified prefix and length pattern
    *   Have unique passwords (unless "identical passwords" option is selected) following the specified prefix and length pattern
    *   Be assigned to the selected visitor user group with appropriate access restrictions o Have the same expiration duration (configurable default, e.g., 24 hours from creation)
    *   Share the same access privileges and time limits
*   Upon successful batch creation, the system must:
    *   Generate all visitor accounts as a single transaction
    *   Display a summary of created passes with their credentials
    *   Provide immediate option to print all visitor passes in a batch
    *   Log the batch creation with staff member ID, timestamp, and quantity created
*   The system must validate all configuration settings before allowing batch creation:
    *   Quantity must be within acceptable limits (e.g., 1-100 visitors per batch)
    *   Prefix + generated numbers must not exceed total length specified
    *   Configuration must not create duplicate login IDs with existing accounts
*   Staff must have appropriate batch visitor creation permissions to access and use this functionality.
*   All batch-created visitor accounts must be associated with the currently selected branch and group context.
*   The system must support printing visitor passes in various formats (individual cards, sheet labels, receipt roll) based on library's printing equipment.

## viii. Receipt Visitors

*   Staff must be able to generate visitor receipts or passes with credentials for one or more temporary visitor accounts through a customizable receipt generation interface.
*   The system must display "Generated Examples" at the top showing sample credentials that will be created: o Logon Example format (e.g., "vis8348") o Password Example format (e.g., "2383")
*   The receipt generation form must include the following configuration fields in the "Basic Configuration" section: o Logon ID Prefix field - text prefix for generated login IDs (e.g., "VIS") o Password Prefix field - text prefix or pattern for generated passwords (e.g., "I") o User Group dropdown - assigns visitor type (e.g., "visitors (Filtered Internet)") o First Name field - optional field to personalize visitor pass with first name o Last Name field - optional field to personalize visitor pass with last name o Quantity field - number of visitor receipts to generate (typically 1 for individual receipts) o Total Logon ID Length field - complete length of login ID including prefix o Total Password Length field - complete length of password including prefix o "Make all passwords identical? (same as prefix)" checkbox - option for uniform passwords across multiple receipts o "Print password on visitor pass?" checkbox - option to include password on printed receipt
*   A "Reset Form" button must be available to clear all configuration and start fresh.
*   Action buttons must be provided at the bottom:
    *   "Cancel / Reset" button - cancels receipt generation and clears the form
    *   "Create Visitors Receipts" button - generates and prepares receipts for printing
*   The system must display a confirmation message "Ready to create \[X\] visitor receipt(s)? Receipts will be generated and ready for printing" before executing the generation.
*   Generated visitor receipts must include:
    *   Visitor's name (if provided)
    *   Login ID / username
    *   Password (if "print password" option is selected)
    *   Expiration date/time o Access limitations or rules (e.g., "Filtered Internet", "60 minutes allowed")
    *   Library branch information
    *   Date and time of issue
    *   Staff member who issued the pass (optional)
*   Upon successful generation, the system must: o Create or update the visitor account(s) in the system
    *   Generate printable receipt(s) in library's standard format
    *   Open print dialog or send to designated receipt printer
    *   Log the receipt generation transaction
*   The receipt generation must support both: o Creating new visitor accounts with receipts o Reprinting receipts for existing visitor accounts
*   All generated visitor accounts must have:
    *   Temporary status with automatic expiration
    *   Limited access privileges based on selected visitor group
    *   Appropriate time and session limits o Filtered or restricted resource access
*   The system must validate that generated credentials do not conflict with existing patron or visitor accounts.
*   Staff must have appropriate permissions to generate visitor receipts and create temporary visitor accounts.
*   The receipt format must be configurable by administrators to match library's printing equipment (thermal receipt printers, label printers, or standard paper).
*   All visitor receipt generations must be associated with the currently selected branch and maintain audit trail for accountability.

## ix. SignUp Global Settings:

Administrators must be able to configure system-wide preferences and policies governing computer reservations, timeouts, and visitor accounts across all library branches.

*   "Refresh" and "Save Changes" buttons must be available in the top-right corner for reloading current settings or committing modifications.
*   The system must prompt for confirmation before saving changes that will affect all active and future reservations.
*   **Reservations Section:**
    *   LAN Logons - radio options for "LAN accounts only" or "Common guest accounts"
    *   Scheduled Reservations parameters: - Number of days in advance patrons may book (dropdown, e.g., 7 days) - Minimum minutes between booking and first available slot (dropdown, e.g., 2 minutes) - Maximum pending reservations per patron (dropdown, e.g., 2)
    *   "Auto delete Username from SignUp Transactions after 24 hours" checkbox for privacy compliance
*   **Cancellation & Timeouts Section:**
    *   Timeout parameters with numeric increment/decrement controls: - Unclaimed Scheduled Session Timeout (e.g., 15 minutes) - Unclaimed Queued Session Timeout (e.g., 7 minutes) - Inactivity Timeout (e.g., 90 minutes) - Lock Computer Timeout (e.g., 5 minutes) - Logon Timeout (e.g., 120 seconds)
    *   Reservation warning thresholds: - Time Low warning display threshold (e.g., 10 minutes left) - Time Critical warning display threshold (e.g., 5 minutes left)
*   Visitor Accounts Section:
    *   Number of days visitor accounts remain active (numeric field with controls)
    *   Default user group for visitor accounts (dropdown, e.g., "visitors")
*   All configuration changes must be validated before saving with real-time error messaging for invalid values.
*   The system must validate that numeric values are within acceptable ranges and logically consistent (e.g., critical warning must be less than low warning).
*   Upon successful save, the system must display confirmation, apply settings to future sessions immediately, and log the change with administrator ID and timestamp.
*   Active sessions must continue using settings that were in effect when started; new settings apply only to subsequent sessions.
*   If navigating away with unsaved changes, the system must prompt: "You have unsaved changes. Are you sure you want to leave?"
*   The system must maintain a configuration history audit log recording all changes to global settings.
*   All global settings must be stored centrally and synchronized across all library branches in real-time.

## x. Branches

*   Administrators must be able to view, create, edit, and delete library branch configurations through a centralized branch management interface.
*   The screen must display all existing library branches in a card-based layout, with each branch card showing:
    *   Branch name (e.g., "Central Library", "Eastside Branch", "North Valley Branch")
    *   Computer inventory count with icon (e.g., "60 Computers", "25 Computers")
    *   Operating hours with clock icon (e.g., "9:00 AM - 9:00 PM", "10:00 AM - 6:00 PM")
    *   Time zone setting with globe icon (e.g., "GMT-5 (EST)")
*   Each branch card must include a three-dot menu button (⋯) in the top-right corner providing access to:
    *   "Edit Branch" - opens branch editing form for updating branch details
    *   "Delete" - removes branch from system (with confirmation prompt and validation that no active sessions exist)
*   The "Edit Branch" function must allow administrators to modify:
    *   Branch name
    *   Number of computers/inventories
    *   Operating hours (opening and closing times)
    *   Time zone settings
    *   Physical address and contact information (if applicable)
*   The screen must include an "Add Branch" or "Create New Branch" button (typically at top-right or within the card layout) to create new library locations.
*   When creating or editing branches, the system must validate:
    *   Branch name is unique and not blank
    *   Operating hours are logically consistent (opening time before closing time)
    *   Time zone is properly selected
    *   Computer inventory is a positive number
*   The delete function must include safeguards: o Display confirmation dialog: "Are you sure you want to delete \[Branch Name\]? This action cannot be undone." o Prevent deletion if branch has active computer sessions, pending reservations, or associated patron accounts o Display appropriate error message if deletion is blocked
*   Upon successful branch creation, modification, or deletion, the system must:
    *   Display success confirmation message
    *   Refresh the branch list to reflect changes
    *   Log the action with administrator ID, timestamp, and changes made
*   The system must maintain referential integrity, ensuring that computer assignments, patron accounts, and reservation data remain associated with correct branches.
*   Only administrators with branch management permissions should be able to create, edit, or delete branches.
*   All branch configuration changes must be synchronized across the system immediately to ensure staff at all locations see current information.
*   The system must maintain an audit log of all branch configuration changes for compliance and troubleshooting purposes.

## xi. Resource Groups

*   Administrators must be able to view, create, edit, and delete computer groups that organize PCs by physical location within a branch (e.g., "West - 1st floor", "East - 2nd floor") with location-specific availability properties and session parameters.
*   Computer groups must be displayed in card format showing:
    *   Group name with location identifier (e.g., "West Wing - 1st Floor", "East Section - 2nd Floor")
    *   Total computers in physical group (e.g., "15 computers", "20 computers")
    *   Location-specific settings such as default session duration, availability hours, or access restrictions
*   Each card must include "Edit Group" button and delete icon for group management.
*   The "Edit Group" function must allow modification of:
    *   Group name and physical location description
    *   Computer assignments to this location group
    *   Location-specific availability properties (operating hours, maintenance schedules)
    *   Default session parameters for computers in this physical group o Access restrictions based on user groups or patron types
*   The system must validate that group names are unique within the branch, and provide confirmation prompts before deletion.
*   Delete operations must be blocked if computers in the group have active sessions, with option to reassign computers to another group before deletion.
*   The system must support grouping computers by various physical location criteria:
    *   Floor level (1st floor, 2nd floor, basement)
    *   Wing or section (West Wing, East Wing, North Section)
    *   Room or area (Study Room A, Children's Area, Reference Section)
    *   Zone designation as defined by the library
*   All configuration changes must display success confirmation, refresh the display, log the action with administrator ID and timestamp, and synchronize across the system immediately.
*   Only administrators with computer group management permissions can create, edit, or delete computer groups.

Changes to group availability properties must apply to all computers within that group, with active sessions continuing under original settings and new settings applying to subsequent sessions.

## xii. Resource Types

*   Administrators must be able to view, create, edit, and delete computer types that categorize library PCs (e.g., Standard PCs, Express Stations, High Performance) with distinct configurations and default session durations.
*   The screen must be divided into two main sections: "Computer Group Editor" and "Real-Time Client Status".
*   Computer types must be displayed in card format showing:
    *   Type name with icon (e.g., "Standard PCs", "Express Stations", "High Performance")
    *   Total computers of this type (e.g., "40 computers", "10 computers")
    *   Default session duration (e.g., "Default: 120 mins", "Default: 15 mins", "Default: 240 mins")
*   Each card must include "Edit Group" button and delete icon for computer type management.
*   The "Edit Group" function must allow modification of:
    *   Computer type name and description
    *   Default session duration (minutes)
    *   Computer assignments to this type
    *   Access restrictions and user group permissions
*   The system must validate that computer type names are unique, session durations are positive numbers, and provide confirmation prompts before deletion.
*   Delete operations must be blocked if computers of this type have active sessions, with option to reassign computers before deletion.
*   The system must display live status of all computers showing:
    *   Computer ID/name, status (available, in use, offline, maintenance, reserved)
    *   Current user and session time remaining (if occupied)
    *   Computer type and branch location
*   Status must auto-refresh at regular intervals and use color coding: green (available), red (occupied), gray (offline/maintenance), yellow (reserved).
*   Administrators must be able to filter/sort by branch, computer type, or status, and perform quick actions like force logout or mark as offline.
*   All configuration changes must display success confirmation, refresh the display, log the action with administrator ID and timestamp, and synchronize across the system immediately.

## xiii. Branch Hours & Schedule

*   Administrators and authorized librarians must be able to configure regular operating hours and manage holiday/special closure schedules for each library branch through a branch selector dropdown.
*   The screen must be divided into two main sections: "Operating Hours" and "Holidays & Special Closures".
*   The system must display a weekly schedule grid for Monday through Sunday with:
    *   Editable "Open" and "Close" time fields with AM/PM designation (e.g., "09:00 am" to "09:00 pm")
    *   "Closed" checkbox to mark days when the branch is close.
*   A "Save Schedule" button must commit all operating hours changes.
*   The system must validate that opening time is before closing time and immediately affect reservation availability and session management for future dates.
*   The system must display a list of configured holidays showing:
    *   Holiday name (e.g., "Christmas Day", "New Year's Day")
    *   Date in YYYY-MM-DD format (e.g., "2025-12-25")
    *   "Remove" button for each entry
*   An "Add Holiday" button must allow creation of new holiday entries requiring holiday name, date or date range, and closure type (full closure, modified hours, or special schedule).
*   The system must automatically block PC reservations during configured holiday closures.
*   Upon saving schedule changes or removing holidays, the system must:
    *   Display confirmation prompts and success messages
    *   Update reservation availability system-wide immediately
    *   Log changes with staff member ID and timestamp
    *   Synchronize across all system components in real-time
*   Only administrators and librarians with schedule management permissions can modify branch schedules.
*   The system must maintain an audit log of all schedule modifications for compliance and historical reference.

## xiv. Scheduled Reservations

*   Administrators and library staff must be able to view, manage, and modify all scheduled PC reservations and waitlists across the library system.
*   Filter controls must be provided at the top allowing staff to narrow displayed reservations by:
    *   Branch location (e.g., "Main Branch")
    *   Computer group or library section (e.g., "Main Library")
    *   Date range (today, this week, custom date range)
    *   Computer type (Adult PC, Teen PC, Express Station, etc.)
    *   Reservation status (upcoming, active, completed, cancelled)
*   The reservations list must display in a tabular format with the following columns:
    *   Username or Card # - patron identifier making the reservation
    *   Start Time - date and time when reservation begins (e.g., "October 21, 2025 6:50 PM")
    *   Requested Duration - length of reserved session (e.g., "60 Minutes")
    *   Computer Type - category of computer reserved (e.g., "Adult PC", "Teen PC")
    *   Computer - specific computer name or ID assigned (e.g., "V-PHAROS-CLIENT")
    *   Actions - available operations (e.g., "Cancel" button)
*   The "Cancel" action must:
    *   Display confirmation prompt: "Are you sure you want to cancel this reservation for \[Username\]?"
    *   Cancel the reservation and free the computer slot upon confirmation
    *   Log the cancellation with staff member ID, timestamp, and reason
*   The system must provide additional reservation management actions:
    *   Edit/Modify - change reservation time, duration, or assigned computer
    *   No-Show - mark unclaimed reservations when patron doesn't arrive
    *   Manual Create - allow staff to create reservations on behalf of patrons
    *   View Details - display complete reservation information including patron contact details
*   Staff must be able to search/filter reservations by:
    *   Patron name, username, or card number
    *   Specific computer or computer type
    *   Date range or specific date
    *   Reservation status
*   The system must display reservation counts or summary statistics showing:
    *   Total scheduled reservations for selected filters
    *   Breakdown by computer type o Peak reservation times
*   The interface must clearly distinguish between:
    *   Past reservations (completed sessions)
    *   Current/active reservations (sessions in progress)
    *   Future/upcoming reservations (scheduled but not started)
*   Staff must be able to perform bulk actions on multiple selected reservations (e.g., bulk cancel for emergency closures or system maintenance).

## xv. Waitlists

*   Administrators and library staff must be able to view and manage patron waitlists for PC access when all computers of a requested type are currently occupied.
*   Filter controls must be provided allowing staff to view waitlists by:
    *   Branch location
    *   Computer type (Adult PC, Teen PC, Express Station, High Performance, etc.)
    *   Computer group or zone
    *   Wait time (ascending/descending)
*   For waitlist management, the system must:
    *   Display patrons waiting for specific computer type
    *   Show waitlist position and estimated wait time
    *   Allow staff to manually assign computers to waiting patrons
    *   Automatically notify patrons when their requested computer type becomes available
*   The system must automatically calculate and display estimated wait times based on:
    *   Current active session durations remaining
    *   Average session lengths for the computer type o Number of patrons ahead in queue
    *   Number of available computers of requested type
*   Staff must be able to perform the following waitlist actions:
    *   Assign Computer - manually assign an available computer to a waiting patron (overriding automatic assignment if needed)
    *   Remove from Queue - remove patron from waitlist with reason (patron left, no longer needs computer, etc.)
    *   Move Up/Down - adjust patron's position in queue if needed for special circumstances
    *   Add to Waitlist - manually add patrons to waitlist on their behalf
*   The waitlist must support patron preferences for:
    *   Specific computer types only
    *   Any available computer (if patron is flexible)
    *   Specific computer groups or locations within the branch
*   The system must display waitlist summary statistics showing:
    *   Total patrons currently waiting
    *   Average wait time by computer type
    *   Longest current wait time o Number of patrons who abandoned queue (timeout without claiming)
*   The waitlist interface must update in real-time as:
    *   Patrons join or leave the queue
    *   Computers become available
    *   Session’s end and patrons are notified
*   Staff must be able to temporarily suspend the waitlist (e.g., during system maintenance or closing time) with all queued patrons receiving notification.
*   Only staff with appropriate waitlist management permissions can manually modify queue positions or override automatic assignments.

**xvi. System Configuration**

*   Administrators must be able to configure core application settings, user permissions, database connections, security policies, and technical administration options that govern system-wide operations.
*   The system configuration interface must be accessible only to staff with administrator-level permissions, as changes affect critical system functionality and security.
*   The configuration screen must be organized into distinct sections for different administrative areas:

**User Permissions & Role Management:**

*   Define user roles (Administrator, Librarian, Staff, Read-Only) with specific permission sets
*   Assign or modify staff member roles and access levels
*   Configure branch-specific access restrictions for staff members
*   Set permissions for patron management, reservation management, system configuration, and reporting functions

**Database Configuration:**

*   Configure database connection settings (server, port, database name)
*   Test database connectivity
*   Set backup schedules and retention policies
*   Configure data synchronization settings for multi-branch deployments

**Security Policies:**

*   Set password requirements (minimum length, complexity, expiration)
*   Configure session timeout durations for staff and patron logins
*   Set maximum failed login attempts before account lockout o Configure multi-factor authentication requirements
*   Define IP whitelist/blacklist for system access

**System Preferences:**

*   Set default system language and regional settings
*   Configure date/time formats and time zone
*   Set system-wide notification preferences (email, SMS)
*   Configure logging levels (error, warning, info, debug)
*   Set data retention and archival policies

**Integration Settings:**

*   Configure connections to external library systems (ILS, SIP2)
*   Set API endpoints and authentication credentials for third-party integrations
*   Configure email server (SMTP) settings for system notifications
*   Set SMS gateway configuration for patron notifications

**Technical Administration:**

*   View system status and health metrics
*   Access system logs and error reports o Configure automatic backup schedules
*   Set maintenance windows for system updates
*   Manage system cache and performance optimization settings
*   Each configuration section must include validation to ensure:
    *   Required fields are populated
    *   Values are within acceptable ranges or formats
    *   Changes don't conflict with existing configurations
    *   Database connections are valid before saving
*   A "Test Connection" or "Validate" button must be available for settings requiring external connectivity (database, email, API) to verify configuration before saving.
*   "Save Changes" and "Cancel" buttons must be prominently displayed, with unsaved changes warning if navigating away.
*   Upon saving configuration changes, the system must:
    *   Display confirmation message indicating successful save
    *   Apply changes immediately or prompt for system restart if required
    *   Log the configuration change with administrator ID, timestamp, and modified settings
    *   Create automatic backup of previous configuration for rollback capability
*   The system must provide "Reset to Default" options for individual sections to restore factory settings if configuration errors occur.
*   Critical security settings (password policies, session timeouts, authentication methods) must require additional confirmation before changes are applied.
*   All configuration changes must be logged in a detailed audit trail showing:
    *   Administrator who made the change
    *   Timestamp of modification
    *   Previous and new values for changed settings
    *   Reason for change (if provided)
*   The system must support exporting current configuration as backup file and importing configuration from backup for disaster recovery or multi-site deployment.
*   Configuration changes requiring system restart or affecting active users must display clear warnings before being applied.
*   Only administrators with full system configuration permissions can access and modify these settings; no other staff roles should have access to this screen.

# Module 3: PC/Workstation Access

## i. Welcome Screen:

*   The welcome screen must display clear visual status indicators using color-coded frames/borders that are visible from 30-50 feet away to help patrons identify computer availability at a glance.
*   The system must use a standardized color scheme where Blue indicates available for walk-up use and Orange indicates unavailable (out of order, offline, disabled, or section closed).
*   The color scheme must be customizable by administrators but standardized across all customers to ensure consistent support and troubleshooting; customers cannot configure color meanings independently.
*   The screen must display the following computer information clearly:
    *   Label: Customer-facing name (distinct from the actual hostname)
    *   Available session duration (e.g., "60 minutes")
    *   Description: Geographical location identifier (e.g., "computer lab")
    *   Hostname: Unique database key serving as internal identifier
    *   Current time with time zone
*   The welcome screen must provide special login shortcuts for librarians and administrators to facilitate quick access for staff members.
*   The system must offer language selection options (Spanish for now) to accommodate patrons.
*   Zoom and sizing controls must be available for accessibility purposes, with default zoom settings optimized for 4K screens and user-adjustable sizing to meet vision accessibility needs.
*   The system must display clear error messaging when a computer is not properly configured in the system database.
*   Staff must be able to remotely enable or disable computers with visual confirmation of status changes reflected on the welcome screen in real-time.
*   The logo has to be customizable.

## ii. Policy Screen:

*   The policy screen must present the Library Computer Use Policy with fully customizable text content that administrators can configure through the admin portal.
*   All policy content must support rich text formatting, allowing administrators to cut and paste formatted content directly from the admin portal.
*   The button labels ("Cancel" and "I Accept") must be configurable to accommodate different organizational terminology and language preferences.
*   The system must include an optional footer section positioned between the action buttons and the scrolling policy text area for additional informational content.
*   The footer section must support typed-out links (non-clickable) to reference the latest policy version online, providing informational text only without browser access before login.
*   The system must support an optional requirement to force users to scroll through the entire policy text before the "I Accept" button becomes active, ensuring policy acknowledgment.
*   Policy text must adhere to character limits as dictated by the credential provider constraints (Microsoft, Mac, etc.) to ensure compatibility across authentication systems.
*   Users must have the option to cancel the login process by selecting the "Cancel" button, which returns them to the previous screen or exits the login workflow.
*   Upon selecting "I Accept," users must be advanced to the authentication screen to proceed with credential verification.

## iii. Login Screen:

*   Patrons must log in using valid library credentials consisting of a username/identifier and password to access library computers.
*   The form must contain configurable field labels to accommodate different organizational terminology:
    *   Username field label must be customizable (e.g., "ID", "Library Barcode", "Barcode", "Card Number", "Username")
    *   Password field label must be customizable
    *   Placeholder/hint text (background text in input fields) must be configurable for both fields
*   The password field must mask input characters to maintain confidentiality and security.
*   The system must display a "Secure Connection" indicator prominently to assure patrons that their credentials are being transmitted securely.
*   Upon successful authentication, patrons must be granted access to the library computer for the allocated session duration (e.g., 60 minutes).
*   Users must have the option to navigate back to the previous screen via the "Back" button or exit the login workflow entirely via the "Exit" button.
*   The login interface must be responsive and accessible, supporting the same zoom and sizing controls available on the welcome screen for patrons with vision accessibility needs.

## iv. Time Tracker Display (PC Access)

*   The timer must display remaining session time in MM:SS format with a "Session Options" button (not "Log Out") that opens the session management dialog with options to extend time, lock the computer, save work, or end the session.
*   The interface must be expandable and collapsible - when minimized, show compact view with time remaining and quick access; when expanded, show full interface with detailed messaging and session options.
*   The system must include a progress bar that starts FULL at session beginning and shrinks down to empty as time elapses (not counting from zero), implemented wider and clearer than typical implementations.
*   The progress bar must use color-coded progression: green (full time/above halfway), blue (halfway to low threshold), yellow (low threshold reached), and red (critical threshold reached), with configurable thresholds (typical: yellow at 10 minutes, red at 5 minutes).
*   The timer display must flash to draw attention at specific intervals: 10 seconds when transitioning to blue, 30 seconds when transitioning to yellow, 1 minute when transitioning to red, and continuously for the last 2 minutes of the session.
*   If the patron clicks or interacts with the timer display during a flashing alert, the flashing must stop immediately, and the system must log this engagement as proof that the patron was warned about time limits.
*   The timer window must have the highest Z-index priority to ensure it appears above all content including full-screen videos, modal dialogs, and maximized applications.
*   When the timer reaches 00:00, the system must display a final warning message and automatically initiate the logout sequence, triggering the Optional Work Saving prompt if configured.
*   The timer must continue counting down accurately even if the display is minimized or applications are running in full-screen mode.

## v. Session Extension Wizard (PC Access)

**Purpose**: Allow patrons to request additional session time based on availability and configured extension policies, reducing staff interactions and user frustration.

**Access and Extension Tiers**

*   The wizard must be accessible from the "Session Options" button or automatically triggered when the session reaches a configurable pre-expiration threshold (e.g., 5 minutes remaining).
*   The system must support three configurable extension tiers per patron type/user group: Simple extension (typically 20-30 minutes), Standard extension (typically 40-60 minutes), and Long/Full extension (complete a new session equal to original allocation).

**Utilization-Based Availability**

*   Extension availability must be determined dynamically based on current library computer utilization: at 90%+ utilization, no extensions are available; at 80-89% utilization, only Simple and Standard extensions are available; below 80% utilization, all extension tiers including Long/Full are available.
*   The wizard must display available extension options as selectable buttons or cards showing duration, with unavailable options grayed out and displaying the reason (e.g., "Not available due to high demand").
*   The wizard may display current utilization status if configured (e.g., "12 of 15 computers currently in use") to provide transparency.

**Extension Processing and Limits**

*   When a patron selects an extension tier, the system must: validate that the extension is still available (re-checking utilization), prompt for confirmation, apply the extension time to the current session timer upon confirmation, and log the extension grant with timestamp and tier.
*   The system must enforce configurable limits on extensions per session (e.g., maximum 2 extensions) and per day (e.g., maximum 4 hours total per patron per day), displaying appropriate error messages if limits are exceeded.
*   If no extensions are available, the wizard must display alternative options: save work and log out, join a waitlist for a future time slot (if enabled), or contact library staff.

## vi. Optional Work Saving (PC Access)

**Purpose**: Prompt patrons to save their work before session termination to prevent accidental data loss.

**Prompt Trigger and Display**

*   The work saving prompt must appear automatically when: the session timer reaches 00:00 and auto-logout is initiated, the patron clicks "End Session & Logout" from Session Options, or an administrator remotely terminates the session.
*   The prompt must display a clear warning message with a configurable grace period (typically 2-3 minutes) during which the patron can save work, showing a countdown timer within the prompt.

**Action Options and Confirmation**

*   The prompt must offer: "I've Saved My Work - Log Out Now" to immediately proceed with logout, "I Need More Time" to return to the Session Extension Wizard (if extensions are still available), and optionally "Cancel" to return to the session if initiated manually (not available for expired sessions).
*   This prompt serves as the required confirmation dialog for all logout actions to prevent accidental data loss.
*   If the patron confirms they have saved work and logs out, the system must: terminate all user processes, log the patron out, clear temporary session data, update computer status to "available", and return to the Welcome Screen.

**Forced Logout and Session Recovery**

*   If the grace period expires without patron action, the system must: display a final warning, force-close all applications (potentially resulting in unsaved work loss), execute the logout sequence, and log the forced logout event.
*   For patron types where saving to local drives is restricted (e.g., guest accounts, deep freeze environments), the prompt messaging should emphasize cloud storage or USB drive options if available.
*   The system must integrate with session persistence and recovery: if a machine reboots or crashes during an active session, the session record must be maintained on the server, the computer must be reserved for that patron preventing new logins, and remaining session time must be tracked and logged appropriately even if the machine never reconnects.

Sign-off Note: Steven approves the current version of this BRD with the understanding that further updates will be made prior to commencement of full development effort. A finalized version will be issued and signed later this week.

TRACSYSTEMS, Inc.

4425 Plano Pkwy #301 Carrollton, TX 75010

Sign: \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_  
Print Name: Steven English  
Title: IT Director  
Date: February 18, 2026