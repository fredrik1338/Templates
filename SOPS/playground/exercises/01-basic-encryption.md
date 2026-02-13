# Exercise 1: Basic Encryption

Learn to encrypt, decrypt, and view files with SOPS.

## Setup

Make sure you've completed the [playground setup](../README.md#quick-setup):

```bash
cd playground

# Verify your key is configured
echo $SOPS_AGE_KEY_FILE

# Verify .sops.yaml has your public key
cat .sops.yaml | grep "age1"
```

## Task 1: Encrypt a File

Encrypt the database credentials file:

```bash
# Navigate to playground directory
cd playground

# Encrypt the file (creates new encrypted file)
sops -e samples/database.yaml > samples/database.enc.yaml

# View the encrypted result
cat samples/database.enc.yaml
```

**Expected result**: You should see encrypted values like `ENC[AES256_GCM,data:...,type:str]`

## Task 2: Decrypt a File

```bash
# Decrypt to stdout
sops -d samples/database.enc.yaml

# Decrypt to a file
sops -d samples/database.enc.yaml > samples/database.decrypted.yaml
```

**Expected result**: You should see the original plaintext values.

## Task 3: In-place Encryption

Instead of creating a new file, encrypt in place:

```bash
# Make a copy first
cp samples/database.yaml samples/test-inplace.yaml

# Encrypt in place (modifies the file)
sops -e -i samples/test-inplace.yaml

# View the encrypted file
cat samples/test-inplace.yaml

# Decrypt in place
sops -d -i samples/test-inplace.yaml

# View the decrypted file
cat samples/test-inplace.yaml
```

## Task 4: Extract Specific Values

```bash
# Extract a single value from encrypted file
sops -d --extract '["production"]["password"]' samples/database.enc.yaml

# Extract nested structure
sops -d --extract '["production"]' samples/database.enc.yaml
```

## Task 5: Different Output Formats

```bash
# Output as JSON
sops -d --output-type json samples/database.enc.yaml

# Output as dotenv (for environment variables)
sops -d --output-type dotenv samples/database.enc.yaml
```

## Verification

Check your understanding:

1. What flag encrypts a file? (`-e`)
2. What flag decrypts a file? (`-d`)
3. What flag modifies a file in place? (`-i`)
4. Where does SOPS store encryption metadata? (In the `sops:` section at the end of the file)

## Clean Up

```bash
rm -f samples/database.enc.yaml samples/database.decrypted.yaml samples/test-inplace.yaml
```

## Next Exercise

Continue to [Exercise 2: Editing Encrypted Files](02-editing-files.md)
