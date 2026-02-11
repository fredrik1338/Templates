# Key Management

Best practices for managing SOPS encryption keys.

## Key Types

### age Keys (Recommended for Teams)

Simple, modern, and no infrastructure required.

```bash
# Generate key
age-keygen -o key.txt

# Output:
# Public key: age1ql3z7hjy54pw3hyww5ayyfg7zqgvc7w3j2elw8zmrj2kg5sfn9aqmcac8p
```

**Pros**: Simple, fast, no external dependencies
**Cons**: Manual key distribution

### GPG Keys

Good if team already uses GPG.

```bash
# List available keys
gpg --list-keys

# Use fingerprint in .sops.yaml
pgp: "ABCD1234..."
```

### Cloud KMS

Best for production and CI/CD:

- **AWS KMS**: `arn:aws:kms:region:account:key/id`
- **GCP KMS**: `projects/p/locations/l/keyRings/r/cryptoKeys/k`
- **Azure Key Vault**: `https://vault.vault.azure.net/keys/key/version`

**Pros**: Centralized access control, audit logs, key rotation
**Cons**: Requires cloud infrastructure

## Key Distribution

### For age Keys

1. Each team member generates their own key pair
2. Share only the **public key** with the admin
3. Admin adds public keys to `.sops.yaml`
4. Commit updated `.sops.yaml`

```bash
# Team member generates key
age-keygen -o ~/.config/sops/age/keys.txt

# Share public key (safe to share)
cat ~/.config/sops/age/keys.txt | grep "public key"
# Output: # public key: age1abc...
```

### Key Storage Location

SOPS looks for age keys in:

1. `SOPS_AGE_KEY` environment variable
2. `SOPS_AGE_KEY_FILE` environment variable
3. `~/.config/sops/age/keys.txt` (default)

## Adding a New Team Member

1. New member generates age key:
   ```bash
   age-keygen -o ~/.config/sops/age/keys.txt
   ```

2. Member shares public key with admin

3. Admin adds key to `.sops.yaml`:
   ```yaml
   creation_rules:
     - path_regex: .*\.yaml$
       age: >-
         age1existingkey...,
         age1newmemberkey...
   ```

4. **Re-encrypt all existing files** (critical step):
   ```bash
   # For each encrypted file
   sops updatekeys secrets.enc.yaml
   ```

5. Commit changes

## Removing a Team Member

1. Remove their public key from `.sops.yaml`

2. **Rotate all secrets** - the removed member may have decrypted copies

3. Re-encrypt all files:
   ```bash
   sops updatekeys secrets.enc.yaml
   ```

4. Commit changes

## Rotating Keys

### When to Rotate

- Team member leaves
- Key compromise suspected
- Regular rotation policy (e.g., annually)

### How to Rotate

1. Generate new key(s)
2. Update `.sops.yaml` with new keys
3. Re-encrypt all files:
   ```bash
   find . -name "*.enc.yaml" -exec sops updatekeys {} \;
   ```
4. Securely delete old keys

## CI/CD Access

### Using Environment Variables

```bash
# In CI/CD, set:
export SOPS_AGE_KEY="AGE-SECRET-KEY-1XXXXX..."
```

### Using Cloud KMS

Grant CI/CD service account access to KMS key:

```yaml
# .sops.yaml
creation_rules:
  - path_regex: .*
    kms: arn:aws:kms:eu-west-1:123:key/abc
    age: age1localdevkey...  # Local dev access
```

## Security Checklist

- [ ] Private keys never committed to repository
- [ ] Private keys never shared via chat/email
- [ ] Separate keys for dev/staging/prod
- [ ] CI/CD uses cloud KMS or secure key injection
- [ ] Key access reviewed quarterly
- [ ] Offboarding process includes key rotation
- [ ] Backup of admin keys in secure location

## Emergency Access

Designate at least two admins with access to all keys:

```yaml
creation_rules:
  - path_regex: .*
    key_groups:
      - age:
          - age1admin1...
          - age1admin2...
      - age:
          - age1teamkey...
```

## Next Steps

- [Ways of working](../ways-of-working/)
- [Secret rotation procedures](../ways-of-working/secret-rotation.md)
