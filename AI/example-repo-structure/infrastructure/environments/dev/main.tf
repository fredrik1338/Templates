# =============================================================================
# Development Environment
# =============================================================================
#
# Purpose:  Development and testing. Auto-deployed on push to main.
# Cost:     Minimal — scales to zero, small instance sizes.
# Security: Deletion protection OFF, PITR disabled.
#
# Usage:
#   tofu init
#   tofu plan -var-file=dev.tfvars
#   tofu apply -var-file=dev.tfvars
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
#   project_id          = var.project_id
#   region              = var.region
#   instance_tier       = "db-small"        # Smallest tier
#   availability        = "ZONAL"           # Single zone (no HA)
#   deletion_protection = false
#   point_in_time_recovery = false
# }

# --- Application ---
# module "app" {
#   source = "../../modules/cloud-run"
#
#   project_id    = var.project_id
#   region        = var.region
#   min_instances = 0                        # Scale to zero
#   max_instances = 3
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
