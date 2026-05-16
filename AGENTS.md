# AGENTS.md

## Project Overview
Enterprise Library Reservation & Resource Management System.

## Tech Stack
- Backend: Python + PostgreSQL Functions
- Frontend: React + TypeScript
- Auth: LDAP, SIP2, Internal Auth
- DB: PostgreSQL

## Important Documentation
- Database Design: /docs/database
- Reservation Workflows: /docs/workflows
- API Contracts: /docs/api
- Business Rules: /docs/business-rules
- UI Standards: /docs/ui

## Coding Rules
- Business logic must stay in PostgreSQL functions
- Controllers only call DB procedures
- Use normalized tables
- All resources support waitlists
- Every reservation action must be auditable

## AI Instructions
Before answering:
1. Search related markdown files
2. Read workflow + business rules together
3. Validate against database structure
4. Never invent statuses or fields