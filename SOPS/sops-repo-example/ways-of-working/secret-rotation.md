# Secret Rotation

Procedures for rotating secrets and encryption keys.

## Rotation Schedule

| Secret Type | Rotation Frequency | Trigger |
|-------------|-------------------|---------|
| API keys | Quarterly | Scheduled |
| Database passwords | Quarterly | Scheduled |
| Service account tokens | Annually | Scheduled |
| Encryption keys | Annually | Scheduled |
| All secrets | Immediately | Team member departure |
| Compromised secrets | Immediately | Security incident |

## Routine Rotation

### Step 1: Generate New Secret

Generate new credentials in the source system (AWS, database, API provider, etc.).

### Step 2: Update Encrypted File

```bash
# Edit the encrypted file
sops secrets/prod/secrets.enc.yaml

# Update the value in your editor
# Save and exit
```

### Step 3: Deploy New Secret

Follow your deployment process to update running applications.

### Step 4: Verify

Confirm the application works with the new secret.

### Step 5: Revoke Old Secret

Disable or delete the old credential in the source system.

### Step 6: Document

Add entry to CHANGELOG.md:

```markdown
## [1.2.0] - 2024-01-15

### Changed
- Rotated database password (quarterly rotation)
```

## Emergency Rotation

Use this procedure when a secret may have been compromised.

### Immediate Actions

1. **Revoke the compromised secret immediately** in the source system
2. Generate new secret
3. Update encrypted file
4. Deploy to all environments
5. Verify functionality

### Post-Incident

1. Document the incident
2. Review access logs
3. Determine scope of exposure
4. Notify stakeholders if required

## Key Rotation

Rotating SOPS encryption keys (not the secrets themselves).

### When to Rotate Keys

- Team member with access leaves
- Key may have been exposed
- Annual rotation policy

### Procedure

1. Generate new key:
   ```bash
   age-keygen -o newkey.txt
   ```

2. Update `.sops.yaml` with new key

3. Re-encrypt all files:
   ```bash
   # Update keys for all encrypted files
   find . -name "*.enc.yaml" -exec sops updatekeys {} \;
   ```

4. Commit changes:
   ```bash
   git add .sops.yaml *.enc.yaml
   git commit -m "Rotate encryption keys"
   ```

5. Securely delete old key

## Adding Recipients Without Re-encrypting Secrets

When adding a new team member, you don't need to re-generate secrets:

```bash
# Add new key to .sops.yaml, then:
sops updatekeys secrets.enc.yaml
```

This adds the new recipient without changing the encrypted values.

## Automation

### Pre-commit Hook

Add a reminder for regular rotation:

```bash
#!/bin/bash
# .git/hooks/pre-commit

# Check if secrets are due for rotation
last_rotation=$(git log -1 --format=%cd --date=short -- "*.enc.yaml")
days_since=$(( ($(date +%s) - $(date -d "$last_rotation" +%s)) / 86400 ))

if [ $days_since -gt 90 ]; then
  echo "Warning: Secrets haven't been rotated in $days_since days"
fi
```

### Calendar Reminders

Set quarterly calendar reminders for:
- [ ] Q1 rotation (January)
- [ ] Q2 rotation (April)
- [ ] Q3 rotation (July)
- [ ] Q4 rotation (October)

## Rotation Checklist

- [ ] New credential generated in source system
- [ ] Encrypted file updated with new value
- [ ] Changes committed and pushed
- [ ] PR reviewed and merged
- [ ] Deployed to all environments
- [ ] Application verified working
- [ ] Old credential revoked
- [ ] CHANGELOG updated
- [ ] Version bumped
