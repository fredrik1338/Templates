# SOPS Secrets Management

Learn and implement encrypted secrets management using [SOPS](https://github.com/getsops/sops) (Secrets OPerationS).

---

> **Never commit unencrypted secrets.** All sensitive values must be encrypted with SOPS before committing.

---

## Getting Started

### 1. Install the tools

Follow the [installation guide](installation/installation.md) to install SOPS and age.

### 2. Learn SOPS in the playground

The [playground](playground/) provides hands-on exercises to learn SOPS commands in a safe environment. Work through the exercises before applying SOPS to your own repositories.

### 3. Set up your own repository

Once comfortable with SOPS, use the [your-repo](your-repo/) folder as a reference for setting up secrets management in your own projects.

## Structure

```
SOPS/
├── installation/        # Install SOPS and age
├── playground/          # START HERE - Learn SOPS hands-on
├── your-repo/           # Reference for setting up your own repo
│   ├── configuration/   # .sops.yaml rules and key management
│   ├── examples/        # Example encrypted files and patterns
│   └── ways-of-working/ # Team practices and workflows
├── VERSION              # Current version
└── CHANGELOG.md         # Version history
```

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
