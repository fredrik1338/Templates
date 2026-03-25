# =============================================================================
# CI/CD Authentication Module — Workload Identity Federation
# =============================================================================
#
# Enables keyless authentication from CI/CD (e.g., GitHub Actions) to
# the cloud provider. No long-lived service account keys stored in CI.
#
# How it works:
#   1. CI/CD provider (GitHub) issues an OIDC token for the workflow run
#   2. Cloud provider verifies the token via a Workload Identity Pool
#   3. Token is exchanged for short-lived cloud credentials
#   4. Credentials are scoped to a specific service account
#
# Inputs:
#   - project_id
#   - github_org            (GitHub organization or user)
#   - github_repo           (repository name)
#   - service_account_email (what the CI/CD can act as)
#
# Outputs:
#   - workload_identity_provider  (full resource name, used in workflows)
#   - service_account_email
# =============================================================================

# resource "workload_identity_pool" "github" {
#   workload_identity_pool_id = "github-actions"
#   display_name              = "GitHub Actions"
# }
#
# resource "workload_identity_pool_provider" "github" {
#   workload_identity_pool_id          = workload_identity_pool.github.id
#   workload_identity_pool_provider_id = "github-provider"
#
#   attribute_mapping = {
#     "attribute.repository" = "assertion.repository"
#   }
#
#   oidc {
#     issuer_uri = "https://token.actions.githubusercontent.com"
#   }
#
#   attribute_condition = "assertion.repository == '${var.github_org}/${var.github_repo}'"
# }
#
# resource "service_account_iam_member" "wif" {
#   service_account_id = var.service_account_email
#   role               = "roles/iam.workloadIdentityUser"
#   member             = "principalSet://iam.googleapis.com/${workload_identity_pool.github.name}/attribute.repository/${var.github_org}/${var.github_repo}"
# }
