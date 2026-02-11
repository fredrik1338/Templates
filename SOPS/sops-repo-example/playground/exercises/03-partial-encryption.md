# Exercise 3: Partial Encryption

Learn to encrypt only sensitive fields while keeping structure readable.

## Why Partial Encryption?

Full encryption hides everything:
```yaml
app: ENC[AES256_GCM,data:xxx]
server: ENC[AES256_GCM,data:xxx]
database: ENC[AES256_GCM,data:xxx]
```

Partial encryption keeps structure visible:
```yaml
app:
  name: my-application        # Readable
  version: 1.0.0              # Readable
database:
  host: db.example.com        # Readable
  password: ENC[AES256_GCM,data:xxx]  # Encrypted
```

## Task 1: Using encrypted_regex

The `.sops.yaml` in this playground already has a rule for `app-config.yaml`:

```yaml
- path_regex: samples/app-config\.yaml$
  encrypted_regex: ^(password|secret|key|token)$
  age: YOUR_PUBLIC_KEY_HERE
```

Encrypt the config file:

```bash
cd playground
sops -e samples/app-config.yaml > samples/app-config.enc.yaml
```

View the result:

```bash
cat samples/app-config.enc.yaml
```

**Expected**: Only `password` and `key` fields are encrypted. Everything else is readable.

## Task 2: Custom Regex Patterns

Try different patterns on the command line:

```bash
# Encrypt only 'password' fields
sops --encrypt --encrypted-regex '^password$' samples/database.yaml > samples/db-passwords-only.enc.yaml

# View result
cat samples/db-passwords-only.enc.yaml

# Encrypt password and username
sops --encrypt --encrypted-regex '^(password|username)$' samples/database.yaml > samples/db-creds.enc.yaml

# View result
cat samples/db-creds.enc.yaml
```

## Task 3: Encrypt by Key Suffix

Encrypt any key ending with `_key` or `_secret`:

```bash
sops --encrypt --encrypted-regex '_(key|secret)$' samples/api-keys.json > samples/api-keys.enc.json

cat samples/api-keys.enc.json
```

## Task 4: Unencrypted Regex (Inverse)

Instead of specifying what TO encrypt, specify what NOT to encrypt:

```bash
# Keep only 'host' and 'port' fields unencrypted
sops --encrypt --unencrypted-regex '^(host|port|name|database)$' samples/database.yaml > samples/db-inverse.enc.yaml

cat samples/db-inverse.enc.yaml
```

## Task 5: Edit Partially Encrypted File

```bash
# Edit - only encrypted fields will be decrypted for editing
sops samples/app-config.enc.yaml

# Add a new field called "api_secret" - it should be auto-encrypted
# Add a field called "timeout" - it should remain unencrypted
```

## Common Patterns

| Pattern | Matches |
|---------|---------|
| `^password$` | Exactly "password" |
| `^(password\|secret)$` | "password" or "secret" |
| `_key$` | Ends with "_key" |
| `^(data\|stringData)$` | Kubernetes Secret fields |
| `^(password\|secret\|key\|token\|credential)` | Common sensitive field names |

## Verification

1. Can you encrypt only password fields in a file?
2. What regex would encrypt fields ending with `_token`?
3. How do you specify encryption rules in `.sops.yaml` vs command line?

## Clean Up

```bash
rm -f samples/*.enc.yaml samples/*.enc.json
```

## Next Exercise

Continue to [Exercise 4: Multiple Recipients](04-multiple-recipients.md)
