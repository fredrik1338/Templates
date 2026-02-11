# Access Control

Managing who can access which secrets.

## Access Levels

| Level | Access | Typical Role |
|-------|--------|--------------|
| None | No access to secrets | External contributors |
| Development | Dev secrets only | Developers |
| Staging | Dev + staging secrets | Senior developers, QA |
| Production | All secrets | Ops, senior engineers |
| Admin | All secrets + key management | Team leads, security |

## Implementing Access Levels

Use separate keys and `.sops.yaml` rules:

```yaml
creation_rules:
  # Production - restricted access
  - path_regex: secrets/prod/.*
    age: >-
      age1admin1...,
      age1admin2...,
      age1cicd...

  # Staging - broader access
  - path_regex: secrets/staging/.*
    age: >-
      age1admin1...,
      age1admin2...,
      age1senior1...,
      age1senior2...,
      age1cicd...

  # Development - team-wide access
  - path_regex: secrets/dev/.*
    age: >-
      age1admin1...,
      age1admin2...,
      age1senior1...,
      age1senior2...,
      age1dev1...,
      age1dev2...,
      age1dev3...,
      age1cicd...
```

## Directory Structure

```
secrets/
├── dev/
│   └── secrets.enc.yaml      # All developers
├── staging/
│   └── secrets.enc.yaml      # Seniors + ops
└── prod/
    └── secrets.enc.yaml      # Ops only
```

## Onboarding Process

### New Team Member

1. **Generate key pair**
   ```bash
   age-keygen -o ~/.config/sops/age/keys.txt
   ```

2. **Share public key** with admin via secure channel

3. **Admin adds key** to appropriate rules in `.sops.yaml`

4. **Admin re-encrypts** files for new recipient:
   ```bash
   sops updatekeys secrets/dev/secrets.enc.yaml
   ```

5. **Test access**
   ```bash
   sops -d secrets/dev/secrets.enc.yaml
   ```

## Offboarding Process

### Team Member Leaving

1. **Remove key** from all rules in `.sops.yaml`

2. **Re-encrypt all files** they had access to:
   ```bash
   find secrets/ -name "*.enc.yaml" -exec sops updatekeys {} \;
   ```

3. **Rotate all secrets** they could decrypt (critical step!)

4. **Commit changes**

5. **Document** in CHANGELOG.md

## Access Review

Perform quarterly access reviews:

### Review Checklist

- [ ] List all keys in `.sops.yaml`
- [ ] Verify each key belongs to active team member
- [ ] Confirm access levels are appropriate
- [ ] Remove any orphaned keys
- [ ] Document review in team records

### Generating Access Report

```bash
# List all age recipients
grep -E "^[[:space:]]*age1" .sops.yaml | sort -u

# Count keys per rule
grep -A 100 "path_regex:" .sops.yaml | grep "age1" | wc -l
```

## Cloud KMS Access Control

For cloud KMS, use IAM policies:

### AWS KMS

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "kms:Decrypt"
      ],
      "Resource": "arn:aws:kms:region:account:key/prod-key-id",
      "Condition": {
        "StringEquals": {
          "aws:PrincipalTag/team": "platform"
        }
      }
    }
  ]
}
```

### GCP KMS

```bash
gcloud kms keys add-iam-policy-binding prod-key \
  --location global \
  --keyring secrets \
  --member "group:platform-team@company.com" \
  --role "roles/cloudkms.cryptoKeyDecrypter"
```

## Emergency Access

Ensure business continuity with break-glass procedures:

1. **Admin backup keys** stored in secure vault (1Password, HashiCorp Vault, etc.)
2. **Documented recovery procedure** for lost keys
3. **At least two admins** with full access
4. **Regular testing** of recovery procedure

## Audit Trail

All changes to secrets are tracked via git history:

```bash
# View history of a secrets file
git log --follow secrets/prod/secrets.enc.yaml

# See who changed what
git blame secrets/prod/secrets.enc.yaml
```

For production, consider cloud KMS for enhanced audit logging.
