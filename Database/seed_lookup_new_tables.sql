-- Seed lookup values for new tables
-- sk is auto-incremented by lookup_sk_seq, so it is omitted from INSERTs

-- ============================================
-- access_portals
-- ============================================
INSERT INTO lookup (type, code, value, display_order, is_active, created_by) VALUES
('portal_status_sk', 'PSS', 'active',            1, true, -1),
('portal_status_sk', 'PSS', 'inactive',          2, true, -1),
('portal_status_sk', 'PSS', 'config_incomplete', 3, true, -1),
('portal_status_sk', 'PSS', 'decommissioned',    4, true, -1);

-- ============================================
-- identity_providers
-- ============================================
INSERT INTO lookup (type, code, value, display_order, is_active, created_by) VALUES
('identity_provider_type_sk',   'IPT', 'local',  1, true, -1),
('identity_provider_type_sk',   'IPT', 'ldap',   2, true, -1),
('identity_provider_type_sk',   'IPT', 'sip2',   3, true, -1),
('identity_provider_type_sk',   'IPT', 'oauth',  4, true, -1),
('identity_provider_type_sk',   'IPT', 'saml',   5, true, -1);

INSERT INTO lookup (type, code, value, display_order, is_active, created_by) VALUES
('identity_provider_status_sk', 'IPS', 'active',   1, true, -1),
('identity_provider_status_sk', 'IPS', 'inactive', 2, true, -1),
('identity_provider_status_sk', 'IPS', 'error',    3, true, -1);

-- ============================================
-- location_segments
-- ============================================
INSERT INTO lookup (type, code, value, display_order, is_active, created_by) VALUES
('connection_mode_sk', 'CMO', 'local_only',     1, true, -1),
('connection_mode_sk', 'CMO', 'local_then_any', 2, true, -1),
('connection_mode_sk', 'CMO', 'any_available',  3, true, -1);

-- ============================================
-- pools
-- ============================================
INSERT INTO lookup (type, code, value, display_order, is_active, created_by) VALUES
('pool_status_sk', 'PLS', 'Active',   1, true, -1),
('pool_status_sk', 'PLS', 'Inactive', 2, true, -1);

-- ============================================
-- segment_servers
-- ============================================
INSERT INTO lookup (type, code, value, display_order, is_active, created_by) VALUES
('server_role_sk', 'SRO', 'Main',      1, true, -1),
('server_role_sk', 'SRO', 'Secondary', 2, true, -1);

-- ============================================
-- segments
-- ============================================
INSERT INTO lookup (type, code, value, display_order, is_active, created_by) VALUES
('segment_type_sk', 'SGT', 'Communication', 1, true, -1),
('segment_type_sk', 'SGT', 'Authentication', 2, true, -1),
('segment_type_sk', 'SGT', 'Both',           3, true, -1);

INSERT INTO lookup (type, code, value, display_order, is_active, created_by) VALUES
('server_preference_mode_sk', 'SPM', 'Prefer Main',  1, true, -1),
('server_preference_mode_sk', 'SPM', 'Combination',  2, true, -1),
('server_preference_mode_sk', 'SPM', 'Any',          3, true, -1),
('server_preference_mode_sk', 'SPM', 'Load Balance', 4, true, -1);

INSERT INTO lookup (type, code, value, display_order, is_active, created_by) VALUES
('failover_mode_sk', 'FMO', 'Latency',     1, true, -1),
('failover_mode_sk', 'FMO', 'Round Robin', 2, true, -1),
('failover_mode_sk', 'FMO', 'Random',      3, true, -1);

INSERT INTO lookup (type, code, value, display_order, is_active, created_by) VALUES
('segment_status_sk', 'SST', 'Active',   1, true, -1),
('segment_status_sk', 'SST', 'Inactive', 2, true, -1);

-- ============================================
-- servers
-- ============================================
INSERT INTO lookup (type, code, value, display_order, is_active, created_by) VALUES
('server_type_sk', 'SVT', 'Application',    1, true, -1),
('server_type_sk', 'SVT', 'Database',       2, true, -1),
('server_type_sk', 'SVT', 'Authentication', 3, true, -1),
('server_type_sk', 'SVT', 'Web',            4, true, -1);

INSERT INTO lookup (type, code, value, display_order, is_active, created_by) VALUES
('server_status_sk', 'SES', 'Active',      1, true, -1),
('server_status_sk', 'SES', 'Inactive',    2, true, -1),
('server_status_sk', 'SES', 'Maintenance', 3, true, -1),
('server_status_sk', 'SES', 'Offline',     4, true, -1);

INSERT INTO lookup (type, code, value, display_order, is_active, created_by) VALUES
('health_check_status_sk', 'HCS', 'Online',    1, true, -1),
('health_check_status_sk', 'HCS', 'Offline',   2, true, -1),
('health_check_status_sk', 'HCS', 'Degraded',  3, true, -1),
('health_check_status_sk', 'HCS', 'Unknown',   4, true, -1);

-- ============================================
-- workflows
-- ============================================
INSERT INTO lookup (type, code, value, display_order, is_active, created_by) VALUES
('detection_method_sk', 'DTM', 'Regex',  1, true, -1),
('detection_method_sk', 'DTM', 'Prefix', 2, true, -1),
('detection_method_sk', 'DTM', 'Exact',  3, true, -1);

INSERT INTO lookup (type, code, value, display_order, is_active, created_by) VALUES
('account_creation_mode_sk', 'ACM', 'Auto Create',            1, true, -1),
('account_creation_mode_sk', 'ACM', 'Deny Access',            2, true, -1),
('account_creation_mode_sk', 'ACM', 'Allow Without Account', 3, true, -1);

INSERT INTO lookup (type, code, value, display_order, is_active, created_by) VALUES
('workflow_status_sk', 'WFS', 'Active',   1, true, -1),
('workflow_status_sk', 'WFS', 'Inactive', 2, true, -1),
('workflow_status_sk', 'WFS', 'Testing',  3, true, -1);
