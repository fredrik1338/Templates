# SOPS Secrets Management

Repository for managing encrypted secrets using [SOPS](https://github.com/getsops/sops) (Secrets OPerationS).

---

> **Never commit unencrypted secrets.** All sensitive values must be encrypted with SOPS before committing to this repository.

---

## Structure

```
sops-repo-example/
├── getting-started/     # Installation and first steps
├── configuration/       # SOPS configuration and key management
├── examples/            # Example encrypted files and usage patterns
├── ways-of-working/     # Team practices and workflows
├── playground/          # Hands-on exercises to learn SOPS
├── VERSION              # Current version
└── CHANGELOG.md         # Version history
```

## Folders

### `getting-started/`

Installation guides and your first encrypted secret.

### `configuration/`

How to configure SOPS: `.sops.yaml` rules, key management, and provider setup.

### `examples/`

Practical examples of encrypted files and common use cases.

### `ways-of-working/`

Team workflows: secret rotation, access control, code review practices.

### `playground/`

Hands-on environment with sample files and step-by-step exercises. Use this to practice SOPS commands before applying them to your own repositories.

## Quick Reference

```bash
# Encrypt a file
sops -e secrets.yaml > secrets.enc.yaml

# Decrypt a file
sops -d secrets.enc.yaml

# Edit encrypted file in-place
sops secrets.enc.yaml

# Encrypt specific keys only (leaves structure visible)
sops --encrypt --encrypted-regex '^(password|secret|key)$' config.yaml
```

## Versioning

This repository uses [Semantic Versioning](https://semver.org/):

- **MAJOR**: Breaking changes to encryption configuration or key rotation
- **MINOR**: New secret files or configuration updates
- **PATCH**: Small fixes, documentation updates

When making changes:
1. Update the relevant files
2. Add an entry to `CHANGELOG.md`
3. Bump the version in `VERSION`

## Prerequisites

- SOPS installed ([installation guide](getting-started/installation.md))
- Access to encryption keys (age, GPG, or cloud KMS)
- Configured `.sops.yaml` in repository root
