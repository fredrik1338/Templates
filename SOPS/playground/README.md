# Playground

A hands-on environment to practice SOPS commands before applying them to your own repositories.

## Prerequisites

Before starting, ensure you have:
- SOPS installed ([installation guide](../installation/installation.md))
- age installed ([installation guide](../installation/installation.md#install-age-recommended-key-provider))

## Quick Setup

### 1. Generate a Local Key

```bash
# Create a key just for this playground
age-keygen -o playground.key

# Note your public key (starts with age1...)
grep "public key" playground.key
```

### 2. Configure SOPS to Use Your Key

```bash
# Set the environment variable to use your playground key
export SOPS_AGE_KEY_FILE=$(pwd)/playground.key
```

### 3. Update .sops.yaml with Your Public Key

Edit `.sops.yaml` in this directory and replace `YOUR_PUBLIC_KEY_HERE` with your actual public key.

## Exercises

Work through these exercises in order:

1. [Exercise 1: Basic Encryption](exercises/01-basic-encryption.md)
2. [Exercise 2: Editing Encrypted Files](exercises/02-editing-files.md)
3. [Exercise 3: Partial Encryption](exercises/03-partial-encryption.md)
4. [Exercise 4: Multiple Recipients](exercises/04-multiple-recipients.md)

## Sample Files

The `samples/` directory contains files for practice:

| File | Purpose |
|------|---------|
| `app-config.yaml` | Basic application configuration |
| `database.yaml` | Database credentials |
| `api-keys.json` | JSON format example |
| `.env.example` | Environment file format |

## Directory Structure

```
playground/
├── README.md           # This file
├── .sops.yaml          # Local SOPS config (edit with your key)
├── exercises/          # Step-by-step exercises
│   ├── 01-basic-encryption.md
│   ├── 02-editing-files.md
│   ├── 03-partial-encryption.md
│   └── 04-multiple-recipients.md
└── samples/            # Files to practice with
    ├── app-config.yaml
    ├── database.yaml
    ├── api-keys.json
    └── .env.example
```

## Clean Up

When done practicing:

```bash
# Remove encrypted files you created
rm -f samples/*.enc.yaml samples/*.enc.json

# Remove your playground key (optional)
rm -f playground.key
```

## Next Steps

Once comfortable with SOPS, see [your-repo](../your-repo/) for guides on setting up secrets management in your own projects:

- [Configuration](../your-repo/configuration/) - `.sops.yaml` rules and key management
- [Examples](../your-repo/examples/) - Real-world usage patterns
- [Ways of working](../your-repo/ways-of-working/) - Team practices and workflows
