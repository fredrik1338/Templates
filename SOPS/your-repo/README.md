# Setting Up SOPS in Your Repository

This folder contains guides and examples for implementing SOPS secrets management in your own projects.

## Prerequisites

Before setting up your repository:
1. Complete the [playground exercises](../playground/) to understand SOPS basics
2. Have SOPS and age [installed](../installation/)

## Contents

### `configuration/`

How to configure SOPS for your repository:
- [sops-yaml-config.md](configuration/sops-yaml-config.md) - Writing `.sops.yaml` creation rules
- [key-management.md](configuration/key-management.md) - Managing encryption keys and access

### `examples/`

Real-world usage patterns:
- [kubernetes-secrets.md](examples/kubernetes-secrets.md) - Managing Kubernetes secrets with SOPS
- [secrets.enc.yaml](examples/secrets.enc.yaml) - Example encrypted file structure

### `ways-of-working/`

Team practices for secrets management:
- [secret-rotation.md](ways-of-working/secret-rotation.md) - How and when to rotate secrets
- [access-control.md](ways-of-working/access-control.md) - Managing who can access what
- [code-review.md](ways-of-working/code-review.md) - Reviewing changes to secrets

## Quick Setup Checklist

1. **Create `.sops.yaml`** in your repository root (see [configuration guide](configuration/sops-yaml-config.md))
2. **Collect public keys** from all team members who need access
3. **Set up directory structure** for secrets (e.g., `secrets/dev/`, `secrets/prod/`)
4. **Add to `.gitignore`**:
   ```
   # Never commit these
   *.key
   *.decrypted.*
   .env
   ```
5. **Document your team's workflows** based on [ways of working](ways-of-working/)
