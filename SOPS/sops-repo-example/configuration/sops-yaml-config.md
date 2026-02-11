# Configuring .sops.yaml

The `.sops.yaml` file defines encryption rules for your repository.

## Basic Structure

```yaml
creation_rules:
  - path_regex: <pattern>
    age: <comma-separated public keys>
```

## Example Configuration

```yaml
creation_rules:
  # Production secrets - limited access
  - path_regex: secrets/prod/.*\.yaml$
    age: >-
      age1prodkey1...,
      age1prodkey2...

  # Development secrets - broader access
  - path_regex: secrets/dev/.*\.yaml$
    age: >-
      age1devkey1...,
      age1devkey2...,
      age1devkey3...

  # Default rule for any .enc.yaml file
  - path_regex: \.enc\.yaml$
    age: >-
      age1default...
```

## Path Matching

Rules are evaluated in order. First match wins.

```yaml
creation_rules:
  # Specific paths first
  - path_regex: secrets/production/database\.yaml$
    age: age1dbadmin...

  # Then broader patterns
  - path_regex: secrets/production/.*\.yaml$
    age: age1prodteam...

  # Default last
  - path_regex: .*\.yaml$
    age: age1everyone...
```

## Partial Encryption

Encrypt only specific keys using `encrypted_regex`:

```yaml
creation_rules:
  - path_regex: config/.*\.yaml$
    encrypted_regex: ^(password|secret|key|token|credential)$
    age: age1xxx...
```

This keeps structure visible while encrypting sensitive values:

```yaml
# Unencrypted keys remain readable
database:
  host: db.example.com
  port: 5432
  username: app_user
  password: ENC[AES256_GCM,data:xxx,type:str]  # Only this is encrypted
```

## Multiple Key Providers

SOPS supports multiple providers simultaneously:

```yaml
creation_rules:
  - path_regex: .*\.yaml$
    age: age1localkey...
    kms: arn:aws:kms:eu-west-1:123:key/abc-123
    gcp_kms: projects/myproject/locations/global/keyRings/myring/cryptoKeys/mykey
```

## Key Groups (Threshold)

Require multiple keys to decrypt:

```yaml
creation_rules:
  - path_regex: secrets/critical/.*
    key_groups:
      - age:
          - age1admin1...
          - age1admin2...
      - age:
          - age1backup...
    shamir_threshold: 2  # Need 2 of 3 key groups
```

## Environment-Specific Files

Organize by environment:

```
secrets/
├── dev/
│   └── secrets.yaml
├── staging/
│   └── secrets.yaml
└── prod/
    └── secrets.yaml
```

```yaml
creation_rules:
  - path_regex: secrets/prod/.*
    age: age1prodteam...
  - path_regex: secrets/staging/.*
    age: age1stagingteam...
  - path_regex: secrets/dev/.*
    age: age1devteam...
```

## Validate Configuration

```bash
# Test which rule matches a file
sops --verbose -e secrets/prod/db.yaml 2>&1 | grep "Using"
```

## Common Mistakes

1. **Rules in wrong order** - More specific rules must come before general ones
2. **Missing default rule** - Add a catch-all rule at the end
3. **Regex escaping** - Dots need escaping: `\.yaml$` not `.yaml$`
4. **Line breaks in keys** - Use `>-` for multi-line key lists

## Next Steps

- [Key management](key-management.md)
- [Examples](../examples/)
