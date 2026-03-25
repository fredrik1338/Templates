# =============================================================================
# Cloud SQL Module — Managed PostgreSQL
# =============================================================================
#
# Provisions a managed PostgreSQL instance with configurable:
#   - Instance tier (size)
#   - High availability (ZONAL vs REGIONAL)
#   - Automated backups
#   - Point-in-Time Recovery (PITR)
#   - Deletion protection
#   - SSL enforcement
#
# Inputs:
#   - project_id, region, instance_tier, availability
#   - deletion_protection, point_in_time_recovery
#   - require_ssl, backup_enabled
#
# Outputs:
#   - connection_name  (for app connection)
#   - instance_name    (for monitoring)
#   - database_name
# =============================================================================

# resource "cloud_sql_instance" "main" {
#   name             = "${var.project_id}-db"
#   database_version = "POSTGRES_15"
#   region           = var.region
#   tier             = var.instance_tier
#
#   settings {
#     availability_type = var.availability
#     deletion_protection = var.deletion_protection
#
#     backup_configuration {
#       enabled                        = var.backup_enabled
#       point_in_time_recovery_enabled = var.point_in_time_recovery
#     }
#
#     ip_configuration {
#       require_ssl = var.require_ssl
#     }
#   }
# }
#
# resource "cloud_sql_database" "app" {
#   name     = "app"
#   instance = cloud_sql_instance.main.name
# }
