# Exercise 4: Multiple Recipients

Learn to encrypt files for multiple people and manage access.

## Concept

Each "recipient" has a public key. When you encrypt a file with multiple recipients, anyone with a matching private key can decrypt it.

## Task 1: Generate a Second Key

Simulate a team member by creating another key:

```bash
cd playground

# Generate a second key
age-keygen -o teammate.key

# Note both public keys
echo "Your key:"
grep "public key" playground.key

echo "Teammate key:"
grep "public key" teammate.key
```

## Task 2: Encrypt for Multiple Recipients

Using command line:

```bash
# Get your public keys
YOUR_KEY=$(grep "public key" playground.key | cut -d: -f2 | tr -d ' ')
TEAMMATE_KEY=$(grep "public key" teammate.key | cut -d: -f2 | tr -d ' ')

# Encrypt for both recipients
sops --encrypt \
  --age "$YOUR_KEY,$TEAMMATE_KEY" \
  samples/database.yaml > samples/database-shared.enc.yaml

# View the recipients in the encrypted file
grep -A 20 "^sops:" samples/database-shared.enc.yaml
```

You should see two `recipient:` entries in the SOPS metadata.

## Task 3: Decrypt with Different Keys

```bash
# Decrypt with your key
SOPS_AGE_KEY_FILE=playground.key sops -d samples/database-shared.enc.yaml

# Decrypt with teammate's key
SOPS_AGE_KEY_FILE=teammate.key sops -d samples/database-shared.enc.yaml
```

Both should work and produce the same output.

## Task 4: Update Recipients

Add or remove recipients from an existing encrypted file:

```bash
# Create a third key
age-keygen -o newperson.key
NEWPERSON_KEY=$(grep "public key" newperson.key | cut -d: -f2 | tr -d ' ')

# Backup the original .sops.yaml so we can restore it later
cp .sops.yaml .sops.yaml.backup

# Update .sops.yaml with all three keys
cat > .sops.yaml << EOF
creation_rules:
  - path_regex: .*
    age: >-
      $YOUR_KEY,
      $TEAMMATE_KEY,
      $NEWPERSON_KEY
EOF

# Use sops updatekeys to add the new recipient
SOPS_AGE_KEY_FILE=playground.key sops updatekeys samples/database-shared.enc.yaml

# Verify new person can decrypt
SOPS_AGE_KEY_FILE=newperson.key sops -d samples/database-shared.enc.yaml
```

## Task 5: Remove a Recipient

Simulate offboarding:

```bash
# Update .sops.yaml to remove teammate
cat > .sops.yaml << EOF
creation_rules:
  - path_regex: .*
    age: >-
      $YOUR_KEY,
      $NEWPERSON_KEY
EOF

# Update the file's recipients
SOPS_AGE_KEY_FILE=playground.key sops updatekeys samples/database-shared.enc.yaml

# Teammate can NO LONGER decrypt
SOPS_AGE_KEY_FILE=teammate.key sops -d samples/database-shared.enc.yaml
# This should fail!

# You and newperson can still decrypt
SOPS_AGE_KEY_FILE=playground.key sops -d samples/database-shared.enc.yaml
SOPS_AGE_KEY_FILE=newperson.key sops -d samples/database-shared.enc.yaml
```

## Task 6: View Current Recipients

```bash
# See who can decrypt a file
sops filestatus samples/database-shared.enc.yaml

# Or inspect the sops metadata
sops -d --output-type json samples/database-shared.enc.yaml 2>/dev/null | jq '.sops.age'
```

## Real-World Application

In your own repository:

1. **Collect public keys** from all team members
2. **Organize by access level** in `.sops.yaml`:
   ```yaml
   creation_rules:
     - path_regex: secrets/prod/.*
       age: admin1,admin2,cicd
     - path_regex: secrets/dev/.*
       age: admin1,admin2,dev1,dev2,dev3,cicd
   ```
3. **When someone joins**: Add their key, run `sops updatekeys` on relevant files
4. **When someone leaves**: Remove their key, run `sops updatekeys`, rotate secrets

## Verification

1. How do you encrypt a file for multiple recipients?
2. How do you add a new recipient to an existing encrypted file?
3. Why should you rotate secrets when removing a recipient?

## Clean Up

```bash
# Restore the original .sops.yaml
mv .sops.yaml.backup .sops.yaml

# Remove generated files
rm -f samples/*.enc.yaml teammate.key newperson.key
```

## Congratulations!

You've completed all exercises. You now know how to:
- Encrypt and decrypt files
- Edit encrypted files directly
- Use partial encryption for readability
- Manage multiple recipients

Next steps:
- See [your-repo](../../your-repo/) for guides on setting up your own repository
- Read the [ways of working](../../your-repo/ways-of-working/) for team practices
