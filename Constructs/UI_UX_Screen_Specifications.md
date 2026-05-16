# Admin Portal UI/UX Screen Specifications

## Purpose
This document provides comprehensive UI/UX specifications for the Access Portals, Workflows, and Segments admin sections. These descriptions are designed for AI-assisted mockup generation and client presentation.

## Deliverables Overview

### Portals
- **Endpoint Management**: Create access portals specifically for Kiosks or PC Access stations
- **MVP Portal Sync**: Link portals to specific locations; updates to URI or location reflect across all connected workstations instantly
- **Secure Routing**: Route all portal requests through encrypted workflows, ensuring the "Secure Connection" UI indicator remains valid

### Workflows
- **Auth Handling**: Create workflows for authentication, field mappings, and integration routing
- **MVP Reverse Lookup**: Configure rules to match incoming patron IDs against external databases (like SIP2) instantly
- **Step Validation**: Workflow updates include a "Test Mode" to verify integration routing before going live

### Segments
- **Network Routing**: Define access segments that control how servers and workstations connect
- **MVP Logic**: Implement "Route Behavior" rules that prioritize traffic for active sessions over background system updates
- **Safety Check**: Enforce a "No Dependencies" rule preventing segment deletion if active workstations are still assigned

---

## 1. ACCESS PORTALS MANAGEMENT

### Screen 1.1: Portals List/Grid View

**Location:** Admin Portal > Constructs > Access Portals

**Layout Structure:**
```
┌─────────────────────────────────────────────────────────────────┐
│ [← Back to Constructs]     ACCESS PORTALS      [+ Add Portal]   │
├─────────────────────────────────────────────────────────────────┤
│ Search: [_________________________] 🔍  [Filter ▼] [Export ▼]  │
├─────────────────────────────────────────────────────────────────┤
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │ Portal Name ▲ │ Path │ Location/Pool │ Status │ Actions     │ │
│ ├─────────────────────────────────────────────────────────────┤ │
│ │ Main Portal   │/main │ All Branches  │ 🟢 Active│ [⚙️][📋][🗑]│ │
│ │ Branch A      │/branchA│ Downtown Loc │ 🟢 Active│ [⚙️][📋][🗑]│ │
│ │ Mobile Portal │/mobile │ Mobile Pool  │ 🟡 Config│ [⚙️][📋][🗑]│ │
│ │ Test Portal   │/test   │ Test Location│ 🔴 Inactive│[⚙️][📋][🗑]│ │
│ └─────────────────────────────────────────────────────────────┘ │
│ Showing 4 of 12 portals         [1][2][3] Next >               │
└─────────────────────────────────────────────────────────────────┘
```

**UI Elements:**

**Header Section:**
- **Title:** "ACCESS PORTALS" (H1, bold, 24px)
- **Breadcrumb:** "Admin > Constructs > Access Portals"
- **Add Portal Button:** Primary action button, blue/brand color, top-right
  - Icon: Plus (+) symbol
  - Text: "Add Portal"
  - Action: Opens Portal Creation Modal

**Toolbar:**
- **Search Bar:** Full-text search across portal names, paths, locations
  - Placeholder: "Search portals by name, path, or location..."
  - Real-time filtering as user types
  - Search icon on right side
  
- **Filter Dropdown:**
  - Options: All Status, Active Only, Inactive Only, Configuration Incomplete
  - Options: All Types, Location-Based, Pool-Based
  - Multi-select with checkboxes
  
- **Export Button:**
  - Options: Export to CSV, Export to PDF
  - Includes all visible columns

**Data Grid Columns:**

1. **Portal Name** (Sortable)
   - Display: Portal friendly name
   - Font: Medium weight, 16px
   - Click: Opens edit modal
   
2. **Path** (Sortable)
   - Display: URL pathname (e.g., /branchA)
   - Font: Monospace, 14px
   - Color: Distinct color (purple/blue)
   - Format: Always starts with "/"
   
3. **Location/Pool** (Sortable, Filterable)
   - Display: Associated location name OR pool name
   - Icon: 📍 for Location, 🏊 for Pool
   - Truncate long names with "..." and tooltip on hover
   
4. **Server/URI**
   - Display: Server hostname or URI
   - Font: Monospace, 12px
   - Truncate if too long
   
5. **Status** (Filterable)
   - Display: Status badge with icon + text
   - 🟢 Active: Green badge
   - 🟡 Configuration Incomplete: Yellow badge
   - 🔴 Inactive: Red badge
   - 🔒 Secure Connection: Green padlock indicator (if HTTPS enabled)
   
6. **Created Date** (Sortable)
   - Format: MM/DD/YYYY
   - Tooltip: Shows exact timestamp on hover
   
7. **Actions**
   - **Edit Icon (⚙️):** Opens edit modal
   - **View Details Icon (📋):** Opens detailed view
   - **Delete Icon (🗑️):** Opens confirmation dialog
   - Icons should be icon-only buttons with tooltips

**Row Behavior:**
- Hover: Light gray background highlight
- Click on name: Opens edit modal
- Row height: 48px minimum for touch-friendly interaction
- Alternating row colors for readability

**Pagination:**
- Bottom-right corner
- Shows: "Showing X-Y of Z portals"
- Page numbers with Previous/Next buttons
- Configurable items per page: 10, 25, 50, 100

**Empty State:**
```
┌─────────────────────────────────────────────────────────────────┐
│                         📱                                       │
│                   No Portals Created                             │
│        Create your first access portal to enable remote          │
│              reservations via web browsers                       │
│                                                                  │
│                   [+ Create First Portal]                        │
└─────────────────────────────────────────────────────────────────┘
```

---

### Screen 1.2: Create/Edit Portal Modal

**Trigger:** Click "+ Add Portal" or Edit icon on existing portal

**Modal Layout:**
```
┌─────────────────────────────────────────────────────────────────┐
│ ✕  CREATE ACCESS PORTAL                                         │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│ Portal Details                                                   │
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │ Portal Name *                                               │ │
│ │ [_______________________________________________]           │ │
│ │ Example: "Main Library Portal" or "Downtown Branch"        │ │
│ └─────────────────────────────────────────────────────────────┘ │
│                                                                  │
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │ URL Path *                    🔒 Secure Connection          │ │
│ │ [/][_____________________]    [ ✓ Enable HTTPS ]           │ │
│ │ ⚠️ Path must be unique. Cannot use: /admin, /api, /system  │ │
│ │ Preview: https://server.library.com/yourpath               │ │
│ └─────────────────────────────────────────────────────────────┘ │
│                                                                  │
│ Association *                                                    │
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │ ○ Assign to Location          ○ Assign to Pool             │ │
│ │                                                              │ │
│ │ [Select Location ▼__________________]                       │ │
│ │   📍 Downtown Branch                                        │ │
│ │   📍 North Branch                                           │ │
│ │   📍 East Branch                                            │ │
│ └─────────────────────────────────────────────────────────────┘ │
│                                                                  │
│ Server Configuration                                             │
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │ Server/URI *                                                │ │
│ │ [_______________________________________________]           │ │
│ │ Example: https://portal-server.library.com                 │ │
│ │                                                              │ │
│ │ Communication Segment                                        │ │
│ │ [Any Server - Communication ▼________________]             │ │
│ │ ℹ️ Inherited from Location settings                         │ │
│ └─────────────────────────────────────────────────────────────┘ │
│                                                                  │
│ Permissions & Access (Optional)                                  │
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │ Allowed User Types:    [ ✓ All ] or [ Customize ▼ ]       │ │
│ │ Allowed User Tiers:    [ ✓ All ] or [ Customize ▼ ]       │ │
│ │ Allowed User Groups:   [ ✓ All ] or [ Customize ▼ ]       │ │
│ │                                                              │ │
│ │ Portal Reservation Types:                                    │ │
│ │ [ ✓ ] Scheduled Reservations                               │ │
│ │ [ ✓ ] Walk-up Access                                       │ │
│ │ [ ✓ ] Waitlist                                             │ │
│ │ [   ] Block (Staff Only)                                   │ │
│ │ [   ] Maintenance (Staff Only)                             │ │
│ └─────────────────────────────────────────────────────────────┘ │
│                                                                  │
│ Status                                                           │
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │ [ ✓ ] Active (Portal accessible immediately)               │ │
│ │ [   ] Inactive (Save configuration but don't publish)      │ │
│ └─────────────────────────────────────────────────────────────┘ │
│                                                                  │
│               [Cancel]              [Save Portal]               │
└─────────────────────────────────────────────────────────────────┘
```

**Field Specifications:**

**1. Portal Name (Required)**
- **Type:** Text input
- **Validation:** 3-100 characters, alphanumeric + spaces
- **Placeholder:** "Enter a descriptive portal name"
- **Help Text:** "This name is for administrative identification only"

**2. URL Path (Required)**
- **Type:** Text input with prefix
- **Prefix:** "/" (locked, always shown)
- **Validation:** 
  - Unique across all portals
  - 3-50 characters
  - Lowercase letters, numbers, hyphens only
  - Cannot use reserved paths: /admin, /api, /system, /staff
  - Real-time uniqueness check with error message
- **Preview:** Shows full URL with server + path
- **Warning Icon:** If path conflicts detected

**3. Secure Connection Toggle**
- **Type:** Checkbox
- **Label:** "Enable HTTPS"
- **Icon:** 🔒 (padlock) when enabled
- **Default:** Checked (HTTPS enabled)
- **Help Text:** "Recommended for production portals"

**4. Association (Required - Radio Selection)**
- **Type:** Radio buttons with dependent dropdown
- **Options:**
  - ○ Assign to Location
  - ○ Assign to Pool
- **Dropdown Changes based on selection:**
  - If Location: Shows all active locations
  - If Pool: Shows all active pools
- **Visual:** Selected option highlighted with blue background
- **Icons:** 📍 for locations, 🏊 for pools

**5. Server/URI (Required)**
- **Type:** Text input (URL format)
- **Validation:** Valid URL format, must start with http:// or https://
- **Placeholder:** "https://portal-server.library.com"
- **Real-time validation:** Shows ✓ or ✗ icon

**6. Communication Segment**
- **Type:** Dropdown select
- **Options:** All communication segments from system
- **Default:** "Any Server - Communication"
- **Info Badge:** "ℹ️ Inherited from Location settings" (if applicable)

**7. Permissions Section (Expandable)**
- **Type:** Multi-select dropdowns
- **Default:** "All" selected for each category
- **Customize Option:** Opens multi-select checkboxes

**8. Portal Reservation Types**
- **Type:** Checkbox list
- **Visual:** Checkboxes with labels
- **Staff Only badges:** Gray badges on restricted types

**9. Status Toggle**
- **Type:** Checkbox
- **Active:** Portal immediately accessible
- **Inactive:** Saved but not published

**Buttons:**
- **Cancel:** Secondary button (gray), closes modal without saving
- **Save Portal:** Primary button (blue), validates and saves
  - Shows loading spinner during save
  - Shows success toast: "Portal created successfully!"

**Validation Behavior:**
- Required fields marked with red asterisk (*)
- Inline validation errors appear below fields in red
- Cannot save until all required fields valid
- Path uniqueness checked in real-time

---

### Screen 1.3: Portal Details View

**Trigger:** Click "View Details" icon from grid

**Layout:**
```
┌─────────────────────────────────────────────────────────────────┐
│ ✕  PORTAL DETAILS: Downtown Branch Portal                       │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │ 🟢 ACTIVE          Created: 01/15/2026    Modified: 02/10/26││
│ │                                                              │ │
│ │ Portal URL: https://library.com/downtown  [📋 Copy]         │ │
│ │ 🔒 Secure Connection Enabled                                │ │
│ └─────────────────────────────────────────────────────────────┘ │
│                                                                  │
│ Configuration                                                    │
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │ Portal Name:        Downtown Branch Portal                  │ │
│ │ Path:               /downtown                               │ │
│ │ Associated With:    📍 Downtown Branch (Location)           │ │
│ │ Server/URI:         https://portal-srv1.library.com         │ │
│ │ Communication Seg:  Downtown Communication Segment          │ │
│ └─────────────────────────────────────────────────────────────┘ │
│                                                                  │
│ Access & Permissions                                             │
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │ Allowed User Types:   Patrons, Guests, Students (3)        │ │
│ │ Allowed User Tiers:   All                                   │ │
│ │ Allowed User Groups:  Public, Student Group (2)            │ │
│ │                                                              │ │
│ │ Reservation Types:    ✓ Scheduled  ✓ Walk-up  ✓ Waitlist  │ │
│ └─────────────────────────────────────────────────────────────┘ │
│                                                                  │
│ Usage Statistics                                                 │
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │ Total Reservations:    1,247                                │ │
│ │ Active Sessions:       12                                   │ │
│ │ Last 30 Days:         ▁▂▃▅▇█▇▅▃▂▁ (Chart)                 │ │
│ └─────────────────────────────────────────────────────────────┘ │
│                                                                  │
│ Danger Zone                                                      │
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │ [🔴 Decommission Portal]  [🗑️ Delete Portal]               │ │
│ │ ⚠️ Decommissioning makes portal inaccessible but preserves │ │
│ │    existing reservations. Deletion is permanent.            │ │
│ └─────────────────────────────────────────────────────────────┘ │
│                                                                  │
│                          [Edit Portal] [Close]                  │
└─────────────────────────────────────────────────────────────────┘
```

---

### Screen 1.4: Portal Sync Status Dashboard

**Purpose:** MVP Portal Sync - Real-time updates across connected workstations

**Layout:**
```
┌─────────────────────────────────────────────────────────────────┐
│ PORTAL SYNC STATUS                     Last Updated: Just now ↻  │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│ Downtown Branch Portal (/downtown)                  🟢 Synced   │
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │ Connected Workstations: 8/8 synced                          │ │
│ │                                                              │ │
│ │ WS-001  ✓ Synced  2 min ago   [Force Sync]                 │ │
│ │ WS-002  ✓ Synced  2 min ago   [Force Sync]                 │ │
│ │ WS-003  ⚠️ Pending 5 min ago   [Force Sync]                 │ │
│ │ WS-004  ✓ Synced  2 min ago   [Force Sync]                 │ │
│ │                                                              │ │
│ │ [Sync All Workstations]                                     │ │
│ └─────────────────────────────────────────────────────────────┘ │
│                                                                  │
│ Recent Changes                                                   │
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │ • URI updated: https://new-server.com  - 2 min ago         │ │
│ │   Status: ✓ All workstations synced                        │ │
│ │                                                              │ │
│ │ • Location changed: North Branch → Downtown - 1 hour ago   │ │
│ │   Status: ✓ All workstations synced                        │ │
│ └─────────────────────────────────────────────────────────────┘ │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

---

## 2. WORKFLOWS MANAGEMENT

### Screen 2.1: Workflows List/Grid View

**Location:** Admin Portal > Constructs > Workflows

**Layout:**
```
┌─────────────────────────────────────────────────────────────────┐
│ [← Back to Constructs]     WORKFLOWS      [+ Add Workflow]      │
├─────────────────────────────────────────────────────────────────┤
│ Search: [_________________________] 🔍  [Filter ▼] [Test Mode] │
├─────────────────────────────────────────────────────────────────┤
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │ Name ▲ │ User Type│Identity Provider│Pattern│Status│Actions ││
│ ├─────────────────────────────────────────────────────────────┤ │
│ │ Library Card│Patron  │SIP2 ILS        │^[0-9] │✓Test│[⚙️][🧪]││
│ │ Student Auth│Student │LDAP University │^STU   │✓Test│[⚙️][🧪]││
│ │ Guest Access│Guest   │Local Database  │^G-    │✓Test│[⚙️][🧪]││
│ │ Staff Login │Staff   │LDAP Internal   │^STAFF │⚠️Warn│[⚙️][🧪]││
│ └─────────────────────────────────────────────────────────────┘ │
│ Showing 4 of 8 workflows         [1][2] Next >                  │
└─────────────────────────────────────────────────────────────────┘
```

**UI Elements:**

**Header:**
- **Title:** "WORKFLOWS" (H1)
- **Add Button:** "+ Add Workflow" (Primary button)
- **Test Mode Toggle:** Special button for testing workflows before deployment

**Data Grid Columns:**

1. **Workflow Name** (Sortable)
   - Font: Medium weight
   - Click: Opens edit modal

2. **User Type** (Filterable)
   - Display: User type category
   - Badge style with icon
   - Examples: 👤 Patron, 🎓 Student, 👥 Guest, 🔧 Staff

3. **Identity Provider** (Filterable)
   - Display: External system name
   - Examples: SIP2 ILS, LDAP University, Local Database
   - Icon prefix: 🔌

4. **Detection Pattern**
   - Display: Regex pattern (truncated)
   - Font: Monospace
   - Tooltip: Shows full pattern on hover
   - Examples: ^[0-9]{10}$, ^STU, ^G-

5. **Test Status**
   - ✓ Tested: Green checkmark
   - ⚠️ Warning: Yellow warning icon
   - ✗ Failed: Red X
   - ⏳ Not Tested: Gray dash
   - Tooltip: Shows last test date/result

6. **Actions**
   - **Edit (⚙️):** Opens edit modal
   - **Test (🧪):** Opens test mode panel
   - **Delete (🗑️):** Delete with confirmation

---

### Screen 2.2: Create/Edit Workflow Modal

**Layout:**
```
┌─────────────────────────────────────────────────────────────────┐
│ ✕  CREATE AUTHENTICATION WORKFLOW                               │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│ Basic Information                                                │
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │ Workflow Name *                                             │ │
│ │ [_______________________________________________]           │ │
│ │                                                              │ │
│ │ Description                                                  │ │
│ │ [_______________________________________________]           │ │
│ │ [_______________________________________________]           │ │
│ └─────────────────────────────────────────────────────────────┘ │
│                                                                  │
│ User Type Detection                                              │
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │ Detection Method: ○ Regex Pattern  ○ Prefix Match          │ │
│ │                                                              │ │
│ │ Pattern * (First match wins)                                │ │
│ │ [^][___________________________________________]            │ │
│ │ Example: ^[0-9]{10}$ for 10-digit library cards            │ │
│ │                                                              │ │
│ │ [🧪 Test Pattern]                                           │ │
│ │ Test Input: [_______________] → Result: ✓ Match / ✗ No Match│
│ │                                                              │ │
│ │ Priority Order: [___] (Lower = Higher Priority)            │ │
│ │ ℹ️ Patterns evaluated in order. First match wins.           │ │
│ └─────────────────────────────────────────────────────────────┘ │
│                                                                  │
│ User Type & Constraints                                          │
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │ User Type *        [Patron ▼_______________]               │ │
│ │                     Options: Patron, Student, Guest, Staff, │ │
│ │                              Temporary, Administrator       │ │
│ │                                                              │ │
│ │ User Tier Filter (Optional)  [Select ▼________]            │ │
│ │ User Group Filter (Optional) [Select ▼________]            │ │
│ └─────────────────────────────────────────────────────────────┘ │
│                                                                  │
│ Authentication Provider *                                        │
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │ Identity Provider  [SIP2 Library System ▼_________________]│ │
│ │                                                              │ │
│ │ ✓ Available Providers:                                      │ │
│ │   • Local Database Authentication                           │ │
│ │   • SIP2 Library System                                     │ │
│ │   • LDAP University Directory                               │ │
│ │   • LDAP Internal Staff Directory                           │ │
│ │                                                              │ │
│ │ 🔒 Credentials managed separately in System > Connections   │ │
│ └─────────────────────────────────────────────────────────────┘ │
│                                                                  │
│ Field Mapping & Integration (MVP Reverse Lookup)                │
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │ Reverse Lookup Enabled: [ ✓ ]                              │ │
│ │                                                              │ │
│ │ Permitted Lookup Fields:                                     │ │
│ │ [ ✓ ] Email Address                                         │ │
│ │ [ ✓ ] Phone Number                                          │ │
│ │ [ ✓ ] Library Card Number                                   │ │
│ │ [   ] First + Last Name                                     │ │
│ │                                                              │ │
│ │ Field Import Configuration:                                  │ │
│ │ ┌──────────────────────────────────────────────────────┐  │ │
│ │ │ External Field → System Field                        │  │ │
│ │ ├──────────────────────────────────────────────────────┤  │ │
│ │ │ patron_name    → Full Name         [Map]             │  │ │
│ │ │ patron_email   → Email             [Map]             │  │ │
│ │ │ patron_phone   → Phone             [Map]             │  │ │
│ │ │ patron_barcode → Library Card#     [Map]             │  │ │
│ │ │                  [+ Add Mapping]                      │  │ │
│ │ └──────────────────────────────────────────────────────┘  │ │
│ │                                                              │ │
│ │ Response Parsing (for SIP2/LDAP):                           │ │
│ │ Field Delimiter: [|▼] Prefix Pattern: [_________]          │ │
│ └─────────────────────────────────────────────────────────────┘ │
│                                                                  │
│ Account Creation Rules                                           │
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │ If account doesn't exist:                                   │ │
│ │                                                              │ │
│ │ ○ Auto-create account and allow login                       │ │
│ │ ○ Deny access (no account creation)                         │ │
│ │ ○ Allow login without creating account (MVP2)              │ │
│ │                                                              │ │
│ │ Default User Group: [Public ▼______________]               │ │
│ │ Default User Tier:  [Standard User ▼_______]               │ │
│ │                                                              │ │
│ │ Alias Generation Pattern:                                    │ │
│ │ [{FirstName:2}][{LastName:1}]-[{CardNumber:last4}]         │ │
│ │ Preview: "JoDo-5678" for John Doe, card #12345678          │ │
│ └─────────────────────────────────────────────────────────────┘ │
│                                                                  │
│ Error Handling                                                   │
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │ Authentication Failed:                                       │ │
│ │ Message: [Invalid credentials. Please try again.]          │ │
│ │                                                              │ │
│ │ User Not Found:                                             │ │
│ │ Message: [Account not found. Please see librarian.]        │ │
│ │                                                              │ │
│ │ Provider Unavailable (Falls back to offline mode):          │ │
│ │ [ ✓ ] Alert Staff                                           │ │
│ │ [ ✓ ] Allow Offline Authentication                          │ │
│ └─────────────────────────────────────────────────────────────┘ │
│                                                                  │
│           [Cancel]  [Save Draft]  [Test Workflow]  [Save]      │
└─────────────────────────────────────────────────────────────────┘
```

---

### Screen 2.3: Workflow Test Mode Panel

**Purpose:** Step Validation - Test integration routing before going live

**Layout:**
```
┌─────────────────────────────────────────────────────────────────┐
│ 🧪 TEST MODE: Library Card Workflow                             │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│ Test Authentication                                              │
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │ Test Credential:                                             │ │
│ │ [1234567890_____________________________]                   │ │
│ │                                                              │ │
│ │ PIN/Password:                                                │ │
│ │ [••••••••_________________________________]                 │ │
│ │                                                              │ │
│ │                     [▶ Run Test]                            │ │
│ └─────────────────────────────────────────────────────────────┘ │
│                                                                  │
│ Test Results                                                     │
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │ ✓ Pattern Match: SUCCESS                                    │ │
│ │   Input "1234567890" matched pattern ^[0-9]{10}$            │ │
│ │                                                              │ │
│ │ ✓ Identity Provider: CONNECTED                              │ │
│ │   SIP2 Library System responding (42ms)                     │ │
│ │                                                              │ │
│ │ ✓ Authentication: SUCCESS                                   │ │
│ │   User authenticated successfully                           │ │
│ │                                                              │ │
│ │ ✓ Field Mapping: SUCCESS                                    │ │
│ │   Retrieved: Name, Email, Phone, Card Number                │ │
│ │   ┌──────────────────────────────────────────┐             │ │
│ │   │ patron_name: "John Doe"                  │             │ │
│ │   │ patron_email: "jdoe@library.com"         │             │ │
│ │   │ patron_phone: "555-0100"                 │             │ │
│ │   │ patron_barcode: "1234567890"             │             │ │
│ │   └──────────────────────────────────────────┘             │ │
│ │                                                              │ │
│ │ ✓ Account Lookup: FOUND                                     │ │
│ │   Existing account: JoDo-7890                               │ │
│ │                                                              │ │
│ │ Overall Status: ✓ WORKFLOW VALID                            │ │
│ │                                                              │ │
│ │ Response Time: 156ms                                        │ │
│ │ Timestamp: 2026-05-15 13:05:42                              │ │
│ └─────────────────────────────────────────────────────────────┘ │
│                                                                  │
│ Test History                                                     │
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │ Test #1 - 13:05:42 - ✓ Success - 156ms                     │ │
│ │ Test #2 - 13:03:21 - ✗ Failed  - Provider timeout          │ │
│ │ Test #3 - 12:58:15 - ✓ Success - 142ms                     │ │
│ └─────────────────────────────────────────────────────────────┘ │
│                                                                  │
│                   [Close Test Mode] [Save Workflow]             │
└─────────────────────────────────────────────────────────────────┘
```

---

## 3. SEGMENTS MANAGEMENT

### Screen 3.1: Segments List/Grid View

**Location:** Admin Portal > Constructs > Segments

**Layout:**
```
┌─────────────────────────────────────────────────────────────────┐
│ [← Back to Constructs]     SEGMENTS      [+ Add Segment]        │
├─────────────────────────────────────────────────────────────────┤
│ Search: [_________________________] 🔍  [Filter ▼] [Diagnostics]│
├─────────────────────────────────────────────────────────────────┤
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │ Name ▲ │ Type   │ Servers │ Locations │ Status │ Actions   ││
│ ├─────────────────────────────────────────────────────────────┤ │
│ │ Downtown│🔵Auth  │ 3/3 ✓  │ 5        │🟢Active│[⚙️][📊][🗑]││
│ │ Campus  │🔷Both  │ 2/2 ✓  │ 3        │🟢Active│[⚙️][📊][🗑]││
│ │ Mobile  │🔶Comm  │ 1/2 ⚠️ │ 8        │🟡Warn  │[⚙️][📊][🗑]││
│ │ Any Svr │🔷Both  │ All ✓  │ All      │🔒System│[📊]      ││
│ └─────────────────────────────────────────────────────────────┘ │
│ Showing 4 of 6 segments         [1][2] Next >                   │
└─────────────────────────────────────────────────────────────────┘
```

**UI Elements:**

**Data Grid Columns:**

1. **Segment Name** (Sortable)
   - Font: Medium weight
   - System segments shown with 🔒 icon

2. **Type** (Filterable)
   - 🔵 Authentication: Blue badge
   - 🔶 Communication: Orange badge
   - 🔷 Both: Purple badge

3. **Servers** (Status Indicator)
   - Format: "X/Y ✓" (online/total)
   - ✓ All online: Green
   - ⚠️ Some offline: Yellow
   - ✗ All offline: Red
   - Click: Opens server details

4. **Assigned Locations** (Count)
   - Number of locations using this segment
   - Click: Shows location list

5. **Status**
   - 🟢 Active: All servers responsive
   - 🟡 Warning: Some servers offline
   - 🔴 Error: Critical issues
   - 🔒 System: Pre-defined, cannot delete

6. **Actions**
   - **Edit (⚙️)**
   - **Diagnostics (📊):** Opens health dashboard
   - **Delete (🗑️):** With safety check

**Safety Check Dialog for Delete:**
```
┌─────────────────────────────────────────────────────────────────┐
│ ⚠️  CANNOT DELETE SEGMENT                                       │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│ This segment cannot be deleted because:                          │
│                                                                  │
│ 🔗 Active Dependencies:                                         │
│    • 8 workstations currently assigned                          │
│    • 3 locations using this segment                             │
│    • 12 active user sessions                                    │
│                                                                  │
│ To delete this segment:                                          │
│ 1. Reassign all workstations to different segment               │
│ 2. Update location assignments                                  │
│ 3. Wait for active sessions to complete                         │
│                                                                  │
│                          [View Dependencies]  [Close]            │
└─────────────────────────────────────────────────────────────────┘
```

---

### Screen 3.2: Create/Edit Segment Modal

**Layout:**
```
┌─────────────────────────────────────────────────────────────────┐
│ ✕  CREATE SEGMENT                                               │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│ Segment Details                                                  │
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │ Segment Name *                                              │ │
│ │ [_______________________________________________]           │ │
│ │                                                              │ │
│ │ Segment Type * (Multi-select)                               │ │
│ │ [ ✓ ] Communication (Workstation connectivity)              │ │
│ │ [ ✓ ] Authentication (External auth routing)                │ │
│ └─────────────────────────────────────────────────────────────┘ │
│                                                                  │
│ Server Configuration                                             │
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │ Main Servers *                                              │ │
│ │ ┌──────────────────────────────────────────────────────┐  │ │
│ │ │ [Select Server ▼________________] [+ Add]            │  │ │
│ │ │                                                        │  │ │
│ │ │ Selected Servers:                                      │  │ │
│ │ │ 1. 🟢 srv1.library.com        [↑][↓][✕]             │  │ │
│ │ │ 2. 🟢 srv2.library.com        [↑][↓][✕]             │  │ │
│ │ │ 3. 🟢 srv3.library.com        [↑][↓][✕]             │  │ │
│ │ │                                                        │  │ │
│ │ │ [🔍 Test Connectivity]                                │  │ │
│ │ └──────────────────────────────────────────────────────┘  │ │
│ │                                                              │ │
│ │ Secondary Servers (Optional)                                 │ │
│ │ [Same as main servers ▼] or [Configure separately]         │ │
│ └─────────────────────────────────────────────────────────────┘ │
│                                                                  │
│ Route Behavior (MVP Logic)                                       │
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │ Traffic Prioritization:                                      │ │
│ │ [ ✓ ] Prioritize active sessions over background updates   │ │
│ │ [ ✓ ] Enable intelligent load balancing                     │ │
│ │                                                              │ │
│ │ Server Preference Mode: [Prefer Main Server 1 ▼__________] │ │
│ │ Options:                                                     │ │
│ │   • Prefer Main Server 1, 2, 3 (Sequential)                │ │
│ │   • Load Balance (Distribute evenly)                        │ │
│ │   • Any Available (No preference)                           │ │
│ │   • Latency-Based (Fastest response)                        │ │
│ │   • Round Robin (Rotate systematically)                     │ │
│ │                                                              │ │
│ │ Failover Configuration:                                      │ │
│ │ Failback Interval: [___60__] seconds                       │ │
│ │ Latency Threshold: [__1000_] ms (trigger failover)         │ │
│ │ Retry Attempts: [___3___] times before marking offline      │ │
│ └─────────────────────────────────────────────────────────────┘ │
│                                                                  │
│ Authentication Settings (If Auth type selected)                  │
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │ [ ] Relay all authentication through main servers           │ │
│ │                                                              │ │
│ │ Supported Protocols:                                         │ │
│ │ [ ✓ ] LDAP                                                  │ │
│ │ [ ✓ ] SIP2                                                  │ │
│ │ [ ✓ ] Database                                              │ │
│ │ [   ] Custom Protocol                                       │ │
│ └─────────────────────────────────────────────────────────────┘ │
│                                                                  │
│              [Cancel]  [Test Configuration]  [Save Segment]     │
└─────────────────────────────────────────────────────────────────┘
```

---

### Screen 3.3: Network Routing Diagnostics Dashboard

**Purpose:** Real-time monitoring of segment health and routing

**Layout:**
```
┌─────────────────────────────────────────────────────────────────┐
│ 📊 SEGMENT DIAGNOSTICS: Downtown Segment                        │
├─────────────────────────────────────────────────────────────────┤
│ Last Updated: Just now ↻                                         │
│                                                                  │
│ Server Health                                                    │
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │ srv1.library.com (Main)                         🟢 ONLINE   │ │
│ │ ├─ Latency: 12ms                                            │ │
│ │ ├─ Load: 45% (18/40 connections)                            │ │
│ │ ├─ Uptime: 99.8% (30 days)                                  │ │
│ │ └─ Last Failover: None                                      │ │
│ │                                                              │ │
│ │ srv2.library.com (Secondary)                    🟢 ONLINE   │ │
│ │ ├─ Latency: 18ms                                            │ │
│ │ ├─ Load: 32% (12/40 connections)                            │ │
│ │ ├─ Uptime: 98.5% (30 days)                                  │ │
│ │ └─ Last Failover: 2 hours ago (srv1 maintenance)            │ │
│ │                                                              │ │
│ │ srv3.library.com (Backup)                       🟡 SLOW     │ │
│ │ ├─ Latency: 1,250ms ⚠️ Exceeds threshold                   │ │
│ │ ├─ Load: 5% (2/40 connections)                              │ │
│ │ ├─ Uptime: 92.1% (30 days)                                  │ │
│ │ └─ Alert: High latency detected at 12:45 PM                 │ │
│ └─────────────────────────────────────────────────────────────┘ │
│                                                                  │
│ Active Connections                                               │
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │ Total Active: 32 workstations                               │ │
│ │                                                              │ │
│ │ Distribution:                                                │ │
│ │ srv1: ████████████░░░░░░░░░░ 18 (56%)                      │ │
│ │ srv2: ███████░░░░░░░░░░░░░░░ 12 (38%)                      │ │
│ │ srv3: █░░░░░░░░░░░░░░░░░░░░░  2 (6%)                       │ │
│ │                                                              │ │
│ │ [View Connection Details]                                   │ │
│ └─────────────────────────────────────────────────────────────┘ │
│                                                                  │
│ Traffic Priority Status                                          │
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │ ✓ Active Sessions: PRIORITIZED                              │ │
│ │   32 active user sessions receiving priority bandwidth      │ │
│ │                                                              │ │
│ │ ⏸️ Background Updates: QUEUED                                │ │
│ │   5 system updates waiting for low-traffic window           │ │
│ │   Next update window: 11:00 PM - 2:00 AM                   │ │
│ └─────────────────────────────────────────────────────────────┘ │
│                                                                  │
│ Recent Events (Last 24 hours)                                    │
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │ 12:45 PM  ⚠️ srv3 latency spike (1,250ms)                   │ │
│ │ 10:30 AM  ✓ srv2 failover successful (12 sessions moved)   │ │
│ │ 09:15 AM  ✓ srv1 maintenance completed                      │ │
│ │ 08:00 AM  ℹ️ srv1 scheduled maintenance started              │ │
│ └─────────────────────────────────────────────────────────────┘ │
│                                                                  │
│                   [Export Report]  [Configure Alerts]  [Close]  │
└─────────────────────────────────────────────────────────────────┘
```

---

## Visual Design Guidelines for AI Generation

### Color Scheme
- **Primary Blue:** #1976D2 (buttons, links, active states)
- **Success Green:** #4CAF50 (✓ indicators, online status)
- **Warning Yellow:** #FFC107 (⚠️ warnings, pending states)
- **Error Red:** #F44336 (✗ errors, offline status)
- **Neutral Gray:** #757575 (secondary text, disabled elements)
- **Background:** #FAFAFA (page background)
- **Cards/Modals:** #FFFFFF (white)

### Typography
- **Headers:** Inter/Roboto, Bold, 24-32px
- **Body:** Inter/Roboto, Regular, 14-16px
- **Labels:** Inter/Roboto, Medium, 12-14px
- **Monospace (codes/paths):** Fira Code/Consolas, 12-14px

### Spacing
- **Grid padding:** 16-24px
- **Card margins:** 16px
- **Button padding:** 12px 24px
- **Input height:** 40px
- **Modal width:** 700-900px

### Interactive Elements
- **Buttons:** Rounded corners (4px), shadow on hover
- **Inputs:** Border on focus, validation colors
- **Tables:** Row hover effect, sortable column headers
- **Modals:** Overlay with 0.5 opacity black backdrop

### Iconography
- Use consistent icon set (Material Design or similar)
- 20-24px icon size for actions
- Status icons with color coding

### Accessibility
- WCAG 2.1 AA compliance
- Keyboard navigation support
- Screen reader compatible
- High contrast mode support
- Focus indicators visible

### Responsive Behavior
- Desktop: Full feature set, multi-column layouts
- Tablet: Adapted layouts, touch-optimized
- Mobile: Simplified views, essential features prioritized

---

## Implementation Notes

### Technical Requirements
- Real-time updates via WebSocket or polling
- Form validation: Client-side + server-side
- Data persistence: Auto-save drafts
- Error handling: Graceful degradation
- Loading states: Skeleton screens + spinners
- Toast notifications: Success/error feedback

### Performance Considerations
- Lazy loading for large data grids
- Virtual scrolling for 100+ items
- Debounced search inputs
- Cached server status checks
- Optimistic UI updates

### Security
- HTTPS enforcement for portals
- Input sanitization for regex patterns
- SQL injection prevention
- XSS protection
- CSRF tokens on forms
- Role-based access control

---

## Client Presentation Checklist

- [ ] All screens include clear status indicators
- [ ] Error states and validation messages defined
- [ ] Test modes available before production deployment
- [ ] Real-time sync status visible for portals
- [ ] Safety checks prevent destructive actions
- [ ] Traffic prioritization clearly indicated
- [ ] Comprehensive diagnostics for troubleshooting
- [ ] Intuitive workflows minimize training needs
- [ ] Accessible design meets compliance standards
- [ ] Responsive layouts support all devices
