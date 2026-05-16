Meeting Summary

The team walked Steven through the current data architecture (Locations as the base table, with Resource Categories, Resource Types, and Resources built on top) and reviewed user-side screens. The group aligned on follow-up calls for tomorrow and later in the week to review the remaining user kiosk screens.

Screens Reviewed Today

You can access the screens we walked through here:

https://uat.seanergy.ai/tracsystems-admin/login

Username: admin
Password: admin1234

Please feel free to share any additional suggestions on these screens over email — we'll action them as soon as we receive them.

Discussion Points

Data Model & Tables

Location table is the base table; every data record has a foreign key relation back to it.
Resource hierarchy walkthrough: Resource Categories (e.g., PC, 3D printer) → Resource Types → Resources.
Renaming/moving Areas → Locations.
Adding a portal name column to the user_auth_logs table.

Screens & UI Changes

Screen redesign for user tiers.
Show user type in an inline view below rather than a pop-up.
Provide edit and remove options inside that view.
Convert Resource screens and Location screens to data grids.
New screen required for Resource Category.

Schedules

Two types of schedules to support: operational hours and reservation hours.

Sort Logic (for confirmation)

The sort logic currently being applied is a multi-level sort, performed in this order (please find the attached screenshot for reference):

Primary sort: Region column — all rows are first grouped/sorted by Region (e.g., all "East" rows come before all "West" rows).
Secondary sort: Rep column — within each Region group, rows are then sorted by Rep (e.g., within "East", all "Garcia" rows come before all "Smith" rows).

The first sort was applied on Region and then second sort was applied on Rep — their order is determined entirely by the Region → Rep grouping.
Could you confirm this matches the sort behaviour you expect? 

Next Calls

Follow-up call confirmed for tomorrow to discuss Constructs and Reports.
Additional session needed Thursday or Friday morning to walk through the remaining user kiosk screens (the same way today's screens were reviewed). Steven is tentatively free Thursday/Friday morning pending confirmation.

Seanergy Action Items:

Implement new screen for Resource Category
Convert Resource screens to data grids
Convert Location screens to data grids
Move Areas tab to be under Locations from Resources in sidebar
Update user type display from pop-up to inline view-below, with edit and remove options
Implement screen redesign for user tiers - to be shared by tomorrow
Implement multi-relation between User and User Types (Needs Clarification — confirm the exact relationship type (e.g., many-to-many) and intended behavior)
Add portal name column to user_auth_logs table (Needs Clarification — confirm expected values/source for this column)
Support two schedule types: operational hours and reservation hours

Steven Action Items: 

Confirm the 'sort logic' described above (Example: Region as primary, Rep as secondary)
Provide the list of columns to view (for the screens/views being redesigned) - Users and Resources.
Confirm availability for Thursday or Friday morning for the user kiosk screens review
Share any additional suggestions on the reviewed screens over email