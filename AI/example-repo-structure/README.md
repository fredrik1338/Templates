# Example Repository Structure

This folder contains the recommended folder structure for a project using the AI.md template.

## Structure

```
example-repo-structure/
├── .github/
│   ├── actions/
│   │   └── cloud-auth/       # Reusable cloud authentication action
│   └── workflows/
│       ├── ci.yml             # PR quality gate (lint, test, security)
│       ├── detect-changes.yml # Reusable change detection
│       ├── security-scan.yml  # Reusable security scanning
│       ├── deploy-dev.yml     # Auto-deploy to dev on push to main
│       ├── prepare-release.yml# Version bump + changelog PR
│       ├── deploy-qa.yml      # Manual deploy to QA
│       └── deploy-prod.yml    # Manual production release
├── docs/
│   ├── CI-CD/                 # CI/CD documentation
│   └── infrastructure/        # Infrastructure documentation
├── frontend/                  # Frontend code
├── backend/                   # Backend code
├── infrastructure/
│   ├── environments/
│   │   ├── dev/               # Dev — auto-deployed, scales to zero
│   │   ├── qa/                # QA — manual deploy, mirrors prod
│   │   └── prod/              # Prod — manual deploy, HA, protected
│   └── modules/               # Shared IaC modules
│       ├── cloud-sql/         # Database
│       ├── cloud-run/         # Container hosting
│       ├── service-iam/       # IAM & service accounts
│       ├── monitoring/        # Alerts & dashboards
│       └── cicd-auth/         # Workload Identity Federation
├── MCP/                       # MCP instructions and configurations
└── plans/                     # Feature plans
    └── implemented/           # Completed plans
```

## Usage

When setting up a new project:

1. Copy the contents of this folder to your project root
2. Copy `AI.md` to your project root
3. Update `AI.md` with project-specific information
4. Uncomment and customize infrastructure files for your cloud provider
5. Uncomment and customize workflow files for your CI/CD needs
6. Add a `VERSION` file (e.g., `0.1.0`) and a `CHANGELOG.md`

## Notes

- The `AI.md` file should be placed at the project root, **not** inside this folder
- The `docs/` structure should mirror your code structure
- Infrastructure and workflow files are commented pseudocode — uncomment and adapt
- Add `.gitkeep` files to empty folders to preserve them in git
