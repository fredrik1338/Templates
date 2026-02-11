# Examples

Practical examples of SOPS usage patterns.

## Documents

- `secrets.enc.yaml` - Example encrypted secrets file
- `kubernetes-secrets.md` - Using SOPS with Kubernetes

## File Naming Convention

We use the following naming patterns:

| Pattern | Description |
|---------|-------------|
| `*.enc.yaml` | Encrypted files (safe to commit) |
| `*.decrypted.yaml` | Decrypted files (in .gitignore) |
| `.sops.yaml` | SOPS configuration |

## Common Use Cases

### Application Configuration

```bash
# Decrypt to stdout for app startup
sops -d config/secrets.enc.yaml

# Or set environment variables
export $(sops -d --output-type dotenv secrets.enc.yaml | xargs)
```

### CI/CD Pipelines

```bash
# Decrypt during deployment
sops -d secrets/prod/secrets.enc.yaml > /tmp/secrets.yaml
kubectl apply -f /tmp/secrets.yaml
rm /tmp/secrets.yaml
```

### Local Development

```bash
# Create local .env from encrypted secrets
sops -d --output-type dotenv secrets.enc.yaml > .env
```
