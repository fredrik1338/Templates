# Team Disaster Recovery Repository

Disaster recovery documentation for [TEAM NAME].

---

> **Every team member is responsible for keeping the latest version of this repository cloned locally on their PC at all times.** During an incident, network access to remote repositories may be unavailable.

---

## Structure

```
team-repo-example/
├── restore-procedures/    # Team-internal restoration guides
├── operational-info/      # Information for external stakeholders
├── VERSION                # Current version
└── CHANGELOG.md           # Version history
```

## Folders

### `restore-procedures/`

Step-by-step guides for recovering team-owned services. For team members.

### `operational-info/`

Information others may need: dependencies, contacts, on-call, SLOs.

## Versioning

This repository uses [Semantic Versioning](https://semver.org/):

- **MAJOR** (1.0.0 → 2.0.0): Breaking changes to procedures (e.g., completely new recovery process)
- **MINOR** (1.0.0 → 1.1.0): New procedures or significant updates
- **PATCH** (1.0.0 → 1.0.1): Small fixes, clarifications, contact updates

When making changes:
1. Update the relevant documentation
2. Add an entry to `CHANGELOG.md`
3. Bump the version in `VERSION`

## Usage

1. Clone this template for your team
2. Replace `[PLACEHOLDERS]` with your information
3. Keep documentation up-to-date
4. Pull latest changes regularly
