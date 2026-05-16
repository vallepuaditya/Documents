# SYSTEM CONTEXT

## Core Concepts
- Locations contain Areas
- Areas contain Resources
- Resources belong to Categories and Types

## Reservation Lifecycle
Requested → Reserved → Active → Completed → Expired

## Waitlist Logic
Priority:
1. ADA users
2. Manual admin priority
3. Earliest request

## Session Monitoring
Background job runs every minute:
- validates active sessions
- checks kiosk login
- checks timeout
- auto-reassigns resources

## Security
- All portals routed through secure encrypted workflows
- Portal URI changes propagate instantly