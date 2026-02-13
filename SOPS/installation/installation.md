# Installing SOPS

## Package Managers

### macOS (Homebrew)

```bash
brew install sops
```

### Linux (apt)

```bash
# Download the latest release
curl -LO https://github.com/getsops/sops/releases/download/v3.8.1/sops-v3.8.1.linux.amd64
chmod +x sops-v3.8.1.linux.amd64
sudo mv sops-v3.8.1.linux.amd64 /usr/local/bin/sops
```

### Windows (Chocolatey)

```powershell
choco install sops
```

### Windows (Scoop)

```powershell
scoop install sops
```

## Verify Installation

```bash
sops --version
```

## Install age (Recommended Key Provider)

SOPS works with multiple key providers. We recommend [age](https://github.com/FiloSottile/age) for simplicity.

### macOS

```bash
brew install age
```

### Linux

```bash
# Ubuntu/Debian
sudo apt install age

# Or download binary
curl -LO https://github.com/FiloSottile/age/releases/download/v1.1.1/age-v1.1.1-linux-amd64.tar.gz
tar xzf age-v1.1.1-linux-amd64.tar.gz
sudo mv age/age* /usr/local/bin/
```

### Windows

```powershell
scoop install age
# or
choco install age.portable
```

## Generate Your Key (First Time Only)

```bash
# Generate a new age key pair
age-keygen -o ~/.config/sops/age/keys.txt

# Note your public key (starts with age1...)
cat ~/.config/sops/age/keys.txt | grep "public key"
```

Share your **public key** with the team admin to be added to the `.sops.yaml` configuration.

**Never share your private key.**

## Next Steps

- [Verify your setup](first-secret.md) - Quick test that everything works
- [Learn SOPS](../playground/) - Hands-on exercises in the playground
