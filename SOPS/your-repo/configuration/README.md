# Configuration

SOPS configuration and key management documentation.

## Documents

- `sops-yaml-config.md` - How to configure `.sops.yaml` creation rules
- `key-management.md` - Managing encryption keys and access

## Quick Overview

SOPS uses a `.sops.yaml` file in your repository root to define:

- Which files should be encrypted
- Which keys can decrypt them
- Which parts of files to encrypt (encrypted_regex)

Example:

```yaml
creation_rules:
  - path_regex: secrets/.*\.yaml$
    age: >-
      age1abc...,
      age1def...
```
