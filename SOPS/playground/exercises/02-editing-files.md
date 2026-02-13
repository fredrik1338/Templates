# Exercise 2: Editing Encrypted Files

Learn to edit encrypted files directly without manual decrypt/encrypt cycles.

## Setup

Ensure you have an encrypted file to work with:

```bash
cd playground
sops -e samples/database.yaml > samples/database.enc.yaml
```

## Task 1: Edit Encrypted File

SOPS can open encrypted files in your editor:

```bash
# Edit the encrypted file (uses $EDITOR)
sops samples/database.enc.yaml
```

This will:
1. Decrypt the file to a temporary location
2. Open your default editor
3. Re-encrypt when you save and exit

**Try it**: Change the development password from `dev_password_789` to `new_dev_password`.

## Task 2: Set Your Preferred Editor

```bash
# Use nano
EDITOR=nano sops samples/database.enc.yaml

# Use vim
EDITOR=vim sops samples/database.enc.yaml

# Use VS Code (waits for close)
EDITOR="code --wait" sops samples/database.enc.yaml
```

## Task 3: Add New Fields

Open the encrypted file and add a new section:

```bash
sops samples/database.enc.yaml
```

Add this to the file:

```yaml
testing:
  host: test-db.example.com
  port: 5432
  database: test_db
  username: test_user
  password: test_password_000
```

Save and exit. The new fields will be automatically encrypted.

## Task 4: Verify Changes

```bash
# View the encrypted file
cat samples/database.enc.yaml

# Decrypt to verify your changes
sops -d samples/database.enc.yaml
```

## Task 5: View Diff of Encrypted File

SOPS can show diffs in decrypted form:

```bash
# Make another change
sops samples/database.enc.yaml
# Change something and save

# View git diff (if in a git repo)
# SOPS integrates with git diff
git diff samples/database.enc.yaml
```

## Common Mistakes

### "File is already encrypted"

This happens when you try to encrypt an already-encrypted file:

```bash
# Wrong - file is already encrypted
sops -e samples/database.enc.yaml

# Right - just edit it
sops samples/database.enc.yaml
```

### Editor exits without saving

If you exit without saving, the file remains unchanged.

### Syntax errors

If you introduce YAML syntax errors, SOPS will warn you and offer to re-edit.

## Verification

1. Can you add a new secret to an encrypted file?
2. Do you know how to set your preferred editor?
3. What happens if you try to encrypt an already-encrypted file?

## Clean Up

```bash
rm -f samples/database.enc.yaml
```

## Next Exercise

Continue to [Exercise 3: Partial Encryption](03-partial-encryption.md)
