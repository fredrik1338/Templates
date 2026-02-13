# Your First Encrypted Secret

This guide walks you through creating, editing, and decrypting your first SOPS-encrypted file.

## Prerequisites

- SOPS installed ([installation guide](installation.md))
- age key generated and configured
- `.sops.yaml` configured in repository (or use explicit key flags)

## Create a Secrets File

Create a plain YAML file with your secrets:

```yaml
# secrets.yaml (DO NOT COMMIT THIS FILE)
database:
  username: admin
  password: supersecret123
api:
  key: sk-abc123xyz
```

## Encrypt the File

```bash
# Using .sops.yaml configuration (recommended)
sops -e secrets.yaml > secrets.enc.yaml

# Or with explicit age recipient
sops -e --age age1xxxxxxxxx secrets.yaml > secrets.enc.yaml
```

The encrypted file looks like:

```yaml
database:
  username: ENC[AES256_GCM,data:xxxxxx,type:str]
  password: ENC[AES256_GCM,data:xxxxxx,type:str]
api:
  key: ENC[AES256_GCM,data:xxxxxx,type:str]
sops:
  age:
    - recipient: age1xxxxxxxxx
      enc: |
        -----BEGIN AGE ENCRYPTED FILE-----
        ...
        -----END AGE ENCRYPTED FILE-----
  lastmodified: "2024-01-15T10:30:00Z"
  version: 3.8.1
```

## Delete the Unencrypted File

```bash
rm secrets.yaml
```

## Edit Encrypted Files

SOPS can edit encrypted files directly:

```bash
sops secrets.enc.yaml
```

This:
1. Decrypts the file to a temp location
2. Opens your `$EDITOR`
3. Re-encrypts when you save and exit

## View Decrypted Contents

```bash
# Print to stdout
sops -d secrets.enc.yaml

# Save to file (be careful!)
sops -d secrets.enc.yaml > secrets.decrypted.yaml
```

## Use in Scripts

```bash
# Extract a single value
sops -d --extract '["database"]["password"]' secrets.enc.yaml

# Use with envsubst or similar
export DB_PASS=$(sops -d --extract '["database"]["password"]' secrets.enc.yaml)
```

## Common Errors

### "could not find common rules"

Your `.sops.yaml` doesn't match the file path. Check your creation rules.

### "could not decrypt data key"

You don't have access to the encryption key. Contact the key administrator.

### "file already encrypted"

You're trying to encrypt an already-encrypted file. Use `sops` (edit mode) instead.

## Next Steps

- [Learn SOPS](../playground/) - Work through the hands-on exercises
- [Set up your own repo](../your-repo/) - Configuration guides for your projects
