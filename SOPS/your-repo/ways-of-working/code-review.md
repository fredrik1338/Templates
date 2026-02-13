# Code Review for Secrets

Guidelines for reviewing pull requests that modify secrets.

## Review Checklist

### For New Secrets

- [ ] Secret is encrypted (check for SOPS metadata block)
- [ ] File matches a `.sops.yaml` rule
- [ ] Appropriate access level (prod secrets have restricted keys)
- [ ] No plaintext secrets in commit history
- [ ] Naming follows conventions
- [ ] CHANGELOG.md updated

### For Secret Updates

- [ ] Changes are encrypted
- [ ] No accidental decryption of other values
- [ ] Reason for change documented in PR description
- [ ] CHANGELOG.md updated

### For Key Changes

- [ ] All affected files re-encrypted with `sops updatekeys`
- [ ] Removed keys trigger secret rotation
- [ ] New keys verified to belong to actual team members
- [ ] Access level appropriate for the person

## What to Look For

### Properly Encrypted File

```yaml
# Good - values are encrypted
database:
  password: ENC[AES256_GCM,data:xxxxx,type:str]
sops:
  age:
    - recipient: age1...
      enc: |
        -----BEGIN AGE ENCRYPTED FILE-----
```

### Accidentally Committed Plaintext

```yaml
# BAD - plaintext password!
database:
  password: mysecretpassword123
```

### Partial Encryption Issues

When using `encrypted_regex`, verify sensitive fields are encrypted:

```yaml
# Check that sensitive fields are encrypted
api:
  url: https://api.example.com           # OK - not sensitive
  key: sk-live-abc123                    # BAD - should be encrypted!
  key: ENC[AES256_GCM,data:xxx,type:str] # Good
```

## Common Mistakes to Catch

1. **Committing decrypted files**
   - Check for `*.decrypted.yaml` files
   - Should be in `.gitignore`

2. **Wrong encryption keys**
   - Prod secrets encrypted with dev keys
   - Verify `sops:` metadata section

3. **Missing SOPS metadata**
   - File not actually encrypted
   - Missing `sops:` block at end of file

4. **Secrets in wrong location**
   - Dev secrets in prod folder
   - Secrets outside `secrets/` directory

5. **Unencrypted environment files**
   - `.env` files with secrets
   - Should use SOPS or be in `.gitignore`

## Automated Checks

### Pre-commit Hook

```bash
#!/bin/bash
# .git/hooks/pre-commit

# Check for potential plaintext secrets
if git diff --cached --name-only | xargs grep -l -E "(password|secret|api_key|token)\s*[:=]\s*['\"]?[a-zA-Z0-9]" 2>/dev/null; then
  echo "Error: Possible plaintext secrets detected"
  exit 1
fi

# Verify SOPS files have metadata
for file in $(git diff --cached --name-only | grep "\.enc\.yaml$"); do
  if ! grep -q "^sops:" "$file"; then
    echo "Error: $file missing SOPS metadata - is it encrypted?"
    exit 1
  fi
done
```

### CI Pipeline Check

```yaml
# .github/workflows/secrets-check.yaml
name: Secrets Check
on: [pull_request]

jobs:
  check:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Check for plaintext secrets
        run: |
          # Fail if any .enc.yaml file is missing sops metadata
          for f in $(find . -name "*.enc.yaml"); do
            if ! grep -q "^sops:" "$f"; then
              echo "ERROR: $f is not encrypted!"
              exit 1
            fi
          done

      - name: Verify .sops.yaml rules
        run: |
          # Check all .enc.yaml files match a rule
          sops -e --config .sops.yaml test.yaml 2>&1 || true
```

## PR Description Template

```markdown
## Secret Changes

### What changed
- [ ] New secret added
- [ ] Existing secret updated
- [ ] Secret removed
- [ ] Encryption keys changed

### Reason
[Describe why this change is needed]

### Checklist
- [ ] Secret is encrypted
- [ ] Verified decryption works locally
- [ ] CHANGELOG.md updated
- [ ] No plaintext in commit history
```

## Handling Mistakes

### If Plaintext Was Committed

1. **Immediately rotate the secret** in the source system
2. **Remove from history** (requires force push):
   ```bash
   git filter-branch --force --index-filter \
     "git rm --cached --ignore-unmatch path/to/file" \
     --prune-empty --tag-name-filter cat -- --all
   git push --force
   ```
3. **Document the incident**
4. **Review and improve** pre-commit hooks
