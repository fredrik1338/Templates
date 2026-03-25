# Infrastructure

Infrastructure-as-Code (IaC) for all environments. Uses [OpenTofu](https://opentofu.org/) (or Terraform).

## Structure

```
infrastructure/
├── environments/
│   ├── dev/              # Development — auto-deployed, low cost
│   │   ├── main.tf       # Environment root module
│   │   ├── variables.tf  # Variable definitions
│   │   ├── outputs.tf    # Output values
│   │   ├── backend.tf    # Remote state configuration
│   │   └── dev.tfvars    # Environment-specific values (no secrets)
│   ├── qa/               # QA/Staging — manual deploy, mirrors prod config
│   │   └── (same structure)
│   └── prod/             # Production — manual deploy, HA, deletion protection
│       └── (same structure)
└── modules/              # Shared reusable modules
    ├── cloud-sql/        # Database (PostgreSQL)
    ├── cloud-run/        # Application hosting (containers)
    ├── service-iam/      # Service accounts & permissions
    ├── monitoring/       # Alerts & dashboards
    └── cicd-auth/        # CI/CD authentication (e.g., Workload Identity Federation)
```

## Environments

| Environment | Auto-deploy | Scaling | HA | Deletion Protection |
|-------------|-------------|---------|-----|---------------------|
| **dev** | Yes (push to main) | Scales to zero | No | No |
| **qa** | No (manual trigger) | Low, always-on | No | No |
| **prod** | No (manual trigger) | Auto-scaling | Yes | Yes |

## Getting Started

1. Install OpenTofu (or Terraform)
2. Configure cloud provider authentication
3. Initialize: `tofu init` (in the target environment directory)
4. Plan: `tofu plan -var-file=<env>.tfvars`
5. Apply: `tofu apply -var-file=<env>.tfvars`

## Secrets

- **Never commit secrets** to `.tfvars` files
- Use a `tofu.auto.tfvars` file (gitignored) for local secrets
- Provide a `tofu.auto.tfvars.example` as a template
- In CI/CD, inject secrets via environment variables or a secrets manager

## Remote State

Each environment stores state in a remote backend (e.g., cloud storage bucket) with versioning enabled for disaster recovery.
