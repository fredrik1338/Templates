# =============================================================================
# QA Environment
# =============================================================================
#
# Purpose:  Quality assurance and pre-production validation.
#           Manually deployed via workflow. Mirrors prod configuration
#           at lower scale.
# Cost:     Moderate — always-on but smaller instances.
# Security: Deletion protection OFF, PITR optional.
#
# Usage:
#   tofu init
#   tofu plan -var-file=qa.tfvars
#   tofu apply -var-file=qa.tfvars
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
#   instance_tier       = "db-medium"       # Moderate tier
#   availability        = "ZONAL"           # Single zone (save cost)
#   deletion_protection = false
#   point_in_time_recovery = false           # Enable if needed for testing
# }

# --- Application ---
# module "app" {
#   source = "../../modules/cloud-run"
#
#   project_id    = var.project_id
#   region        = var.region
#   min_instances = 1                        # Always-on for testing
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
