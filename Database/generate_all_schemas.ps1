# Auto-generate table schema documentation from column metadata
# This script is too large - splitting into smaller focused approach

# Just do the critical reservation-related tables first
$criticalTables = @('reservations', 'reservations_new', 'resources', 'resource_types', 'resource_categories', 
                    'locations', 'user_groups', 'user_types', 'user_tiers', 'lookup')

Write-Host "Focus: Generating schemas for $($criticalTables.Count) critical tables"
Write-Host "Run this as a test, then expand to all tables once verified"
