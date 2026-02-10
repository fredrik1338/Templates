# [SERVICE NAME] Restore Procedure

> **Last Updated:** YYYY-MM-DD
> **Owner:** [Team/Person]
> **Estimated Recovery Time:** X minutes

## Overview

Brief description of the service and what this procedure restores.

---

## Prerequisites

### Access Required
- [ ] GCP/AWS console access to project `[PROJECT_ID]`
- [ ] Database credentials (stored in Secret Manager: `[SECRET_NAME]`)
- [ ] VPN connection to production network
- [ ] kubectl access to cluster `[CLUSTER_NAME]`

### Tools Required
- `gcloud` CLI authenticated
- `kubectl` configured
- Access to [monitoring dashboard URL]

---

## Procedure

### Step 1: Assess the Situation

```bash
# Check current service status
kubectl get pods -n [namespace] -l app=[service-name]

# Check recent logs
kubectl logs -n [namespace] -l app=[service-name] --tail=100
```

**Expected output:** [Describe what healthy vs unhealthy looks like]

### Step 2: [Action Name]

[Detailed instructions for this step]

```bash
# Example command
gcloud run services update [service-name] --region=[region] --image=[image]
```

### Step 3: [Action Name]

[Detailed instructions for this step]

### Step 4: Verify Recovery

See [verification-checklist.md](./verification-checklist.md) for complete verification steps.

Quick health check:
```bash
curl -f https://[service-url]/health
```

---

## Rollback

If the restore fails or causes issues:

1. [Rollback step 1]
2. [Rollback step 2]
3. Escalate to [contact/team]

---

## Troubleshooting

| Symptom | Possible Cause | Resolution |
|---------|---------------|------------|
| Service won't start | Missing environment variables | Check Secret Manager, redeploy with correct config |
| Database connection refused | Network/firewall issue | Verify VPC peering, check Cloud SQL proxy |
| Health check failing | Dependency unavailable | Check upstream services in [dependencies.md](../operational-info/dependencies.md) |

---

## Escalation

If this procedure does not resolve the issue within [X minutes]:

1. **Primary:** [Name] - [Phone/Slack]
2. **Secondary:** [Name] - [Phone/Slack]
3. **Management:** [Name] - [Phone/Slack]
