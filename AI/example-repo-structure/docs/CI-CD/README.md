# CI/CD Documentation

## Workflow Overview

| Workflow | Trigger | Purpose |
|----------|---------|---------|
| **CI** (`ci.yml`) | Pull requests to main | Lint, type-check, test, security scan |
| **Deploy Dev** (`deploy-dev.yml`) | Push to main (auto) | Build & deploy to dev environment |
| **Prepare Release** (`prepare-release.yml`) | Manual | Bump version, generate changelog, create PR |
| **Deploy QA** (`deploy-qa.yml`) | Manual | Deploy a version to QA for validation |
| **Deploy Production** (`deploy-prod.yml`) | Manual | Full release pipeline with security gates |
| **Detect Changes** (`detect-changes.yml`) | Called by other workflows | Path-based change detection |
| **Security Scan** (`security-scan.yml`) | Called by other workflows | Dependency audit, secret scan, filesystem scan |

## Deployment Flow

```
Feature branch
    │
    ▼
Pull Request ──→ CI (lint, test, security) ──→ Merge to main
                                                    │
                                                    ▼
                                              Deploy Dev (auto)
                                                    │
                                                    ▼
                                           Prepare Release (manual)
                                              │  - bump version
                                              │  - generate changelog
                                              │  - create PR
                                              ▼
                                           Merge release PR
                                                    │
                                    ┌───────────────┤
                                    ▼               ▼
                              Deploy QA        Deploy Prod
                              (manual)         (manual)
                                │                   │
                                ▼                   ▼
                           QA validation      Security gates
                                              Image scanning
                                              SBOM generation
                                              Deploy + health check
                                              GitHub Release
```

## Environments

| Environment | Deployment | Approval | Purpose |
|-------------|------------|----------|---------|
| **Dev** | Automatic on push to main | None | Development & testing |
| **QA** | Manual workflow trigger | Workflow trigger = approval | Pre-production validation |
| **Production** | Manual workflow trigger | Workflow trigger = approval | Live |

## Security Gates (Production)

1. Version validation (semver format, no duplicate tags)
2. Dependency audit (`npm audit` — blocks on HIGH)
3. Secret scanning (gitleaks — blocks on any secret)
4. Filesystem scan (Trivy — blocks on HIGH/CRITICAL)
5. Container image scan (Trivy — blocks on HIGH/CRITICAL)
6. SBOM generation (CycloneDX — for supply chain visibility)

## Rollback

[Document rollback procedures here when implemented. Consider:]
- Traffic shift to previous revision (fastest)
- Redeploy with previous image version
- Database rollback (if migration involved)
