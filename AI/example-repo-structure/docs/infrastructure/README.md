# Infrastructure Documentation

## Architecture

[Add architecture overview and diagrams here when implemented]

## Environments

| Environment | Project | Purpose | HA | Scaling |
|-------------|---------|---------|-----|---------|
| **Dev** | `<project>-dev` | Development & testing | No | Scales to zero |
| **QA** | `<project>-qa` | Pre-production validation | No | Low, always-on |
| **Production** | `<project>-prod` | Live | Yes (multi-zone) | Auto-scaling |

## Modules

| Module | Purpose |
|--------|---------|
| `cloud-sql` | Managed PostgreSQL with HA, backups, PITR |
| `cloud-run` | Container hosting with auto-scaling |
| `service-iam` | Service accounts & least-privilege IAM |
| `monitoring` | Alerts, uptime checks, dashboards |
| `cicd-auth` | Workload Identity Federation for CI/CD |

## Getting Started

See `infrastructure/README.md` for setup instructions.

## State Management

- Remote state stored in cloud storage (one bucket per environment)
- Versioning enabled for disaster recovery
- Never store state locally or in git
