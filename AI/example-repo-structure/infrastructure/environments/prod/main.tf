# =============================================================================
# Production Environment
# =============================================================================
#
# Purpose:  Live customer-facing environment.
#           Manually deployed via release workflow with security gates.
# Cost:     Higher — HA, auto-scaling, backups, monitoring.
# Security: Deletion protection ON, PITR enabled, SSL required.
#
# Usage:
#   tofu init
#   tofu plan -var-file=prod.tfvars
#   tofu apply -var-file=prod.tfvars
# =============================================================================

# --- Provider Configuration ---
# provider "<cloud>" {
#   project = var.project_id
#   region  = var.region
# }

# --- Database ---
# module "database" {
#   source = "../../modules/cloud-sql"
#
#   project_id             = var.project_id
#   region                 = var.region
#   instance_tier          = "db-large"       # Production tier
#   availability           = "REGIONAL"       # High availability (multi-zone)
#   deletion_protection    = true
#   point_in_time_recovery = true             # 7-14 day recovery window
#   require_ssl            = true
#   backup_enabled         = true
# }

# --- Application ---
# module "app" {
#   source = "../../modules/cloud-run"
#
#   project_id    = var.project_id
#   region        = var.region
#   min_instances = 1                         # Always-on
#   max_instances = 10                        # Auto-scale under load
#   services = {
#     backend  = { image = var.backend_image }
#     frontend = { image = var.frontend_image }
#   }
# }

# --- IAM ---
# module "iam" {
#   source     = "../../modules/service-iam"
#   project_id = var.project_id
# }

# --- Monitoring ---
# module "monitoring" {
#   source     = "../../modules/monitoring"
#   project_id = var.project_id
#   services   = module.app.service_names
#   database   = module.database.instance_name
#   alert_email = var.alert_email
# }
