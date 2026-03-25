# =============================================================================
# Cloud Run Module — Container Hosting
# =============================================================================
#
# Deploys containerized services with configurable:
#   - Auto-scaling (min/max instances)
#   - Health checks
#   - Environment variables & secrets
#   - Custom domains
#
# Inputs:
#   - project_id, region
#   - min_instances, max_instances
#   - services (map of service name → image)
#
# Outputs:
#   - service_urls   (map of service name → URL)
#   - service_names  (list for monitoring)
# =============================================================================

# resource "cloud_run_service" "services" {
#   for_each = var.services
#
#   name     = each.key
#   location = var.region
#
#   template {
#     spec {
#       containers {
#         image = each.value.image
#       }
#     }
#
#     metadata {
#       annotations = {
#         "autoscaling.knative.dev/minScale" = var.min_instances
#         "autoscaling.knative.dev/maxScale" = var.max_instances
#       }
#     }
#   }
# }
