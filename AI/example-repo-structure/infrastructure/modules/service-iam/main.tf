# =============================================================================
# Service IAM Module — Service Accounts & Permissions
# =============================================================================
#
# Creates service accounts with least-privilege IAM roles:
#   - App service account (database access, secret access)
#   - CI/CD service account (deploy, image push)
#
# Principle: Each service gets only the permissions it needs.
#
# Inputs:
#   - project_id
#
# Outputs:
#   - app_service_account_email
#   - cicd_service_account_email
# =============================================================================

# resource "service_account" "app" {
#   account_id   = "app-runtime"
#   display_name = "Application Runtime"
# }
#
# resource "iam_binding" "app_sql" {
#   role    = "roles/cloudsql.client"
#   members = ["serviceAccount:${service_account.app.email}"]
# }
#
# resource "service_account" "cicd" {
#   account_id   = "cicd-deployer"
#   display_name = "CI/CD Deployer"
# }
#
# resource "iam_binding" "cicd_deploy" {
#   role    = "roles/run.developer"
#   members = ["serviceAccount:${service_account.cicd.email}"]
# }
