# SOPS with Kubernetes

Patterns for using SOPS-encrypted secrets with Kubernetes.

## Option 1: Decrypt During Deployment

Simple approach: decrypt and apply in CI/CD.

```bash
# Decrypt and apply
sops -d secrets/k8s-secrets.enc.yaml | kubectl apply -f -

# Or with temporary file
sops -d secrets/k8s-secrets.enc.yaml > /tmp/secrets.yaml
kubectl apply -f /tmp/secrets.yaml
rm /tmp/secrets.yaml
```

### Encrypted Kubernetes Secret

```yaml
# k8s-secrets.enc.yaml (before encryption)
apiVersion: v1
kind: Secret
metadata:
  name: app-secrets
  namespace: default
type: Opaque
stringData:
  DATABASE_PASSWORD: mysecretpassword
  API_KEY: sk-abc123
```

Encrypt with:
```bash
sops -e k8s-secrets.yaml > k8s-secrets.enc.yaml
```

## Option 2: SOPS Secrets Operator

Use [sops-secrets-operator](https://github.com/isindir/sops-secrets-operator) for GitOps workflows.

### Install Operator

```bash
helm repo add sops-secrets-operator https://isindir.github.io/sops-secrets-operator/
helm install sops-secrets-operator sops-secrets-operator/sops-secrets-operator
```

### Create SopsSecret Resource

```yaml
# sops-secret.enc.yaml
apiVersion: isindir.github.com/v1alpha3
kind: SopsSecret
metadata:
  name: app-secrets
spec:
  secretTemplates:
    - name: app-secrets
      stringData:
        DATABASE_PASSWORD: ENC[AES256_GCM,data:xxx,type:str]
        API_KEY: ENC[AES256_GCM,data:xxx,type:str]
sops:
  # ... SOPS metadata
```

The operator decrypts and creates regular Kubernetes Secrets.

## Option 3: Helm Secrets Plugin

Use [helm-secrets](https://github.com/jkroepke/helm-secrets) for Helm charts.

### Install

```bash
helm plugin install https://github.com/jkroepke/helm-secrets
```

### Usage

```bash
# Create encrypted values file
sops -e values-secrets.yaml > values-secrets.enc.yaml

# Install with decryption
helm secrets install myapp ./chart -f values-secrets.enc.yaml
```

### Values File Structure

```yaml
# values-secrets.enc.yaml (before encryption)
secrets:
  database:
    password: mysecretpassword
  api:
    key: sk-abc123
```

## Option 4: Flux + SOPS

For GitOps with [Flux](https://fluxcd.io/):

### Configure Flux Decryption

```yaml
# flux-system/gotk-sync.yaml
apiVersion: kustomize.toolkit.fluxcd.io/v1
kind: Kustomization
metadata:
  name: cluster
  namespace: flux-system
spec:
  decryption:
    provider: sops
    secretRef:
      name: sops-age
```

### Create Decryption Secret

```bash
# Create age key secret for Flux
kubectl create secret generic sops-age \
  --namespace=flux-system \
  --from-file=age.agekey=<(echo "AGE-SECRET-KEY-1...")
```

## CI/CD Pipeline Example

### GitHub Actions

```yaml
# .github/workflows/deploy.yaml
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Install SOPS
        run: |
          curl -LO https://github.com/getsops/sops/releases/download/v3.8.1/sops-v3.8.1.linux.amd64
          chmod +x sops-v3.8.1.linux.amd64
          sudo mv sops-v3.8.1.linux.amd64 /usr/local/bin/sops

      - name: Decrypt and Deploy
        env:
          SOPS_AGE_KEY: ${{ secrets.SOPS_AGE_KEY }}
        run: |
          sops -d secrets/k8s-secrets.enc.yaml | kubectl apply -f -
```

### GitLab CI

```yaml
# .gitlab-ci.yml
deploy:
  script:
    - sops -d secrets/k8s-secrets.enc.yaml | kubectl apply -f -
  variables:
    SOPS_AGE_KEY: $SOPS_AGE_KEY  # Set in GitLab CI/CD variables
```

## Best Practices

1. **Never decrypt to disk in CI/CD** - pipe directly to kubectl
2. **Use namespaced secrets** - don't use default namespace
3. **Separate secrets per environment** - different files for dev/staging/prod
4. **Audit secret access** - use cloud KMS for audit trails
5. **Rotate secrets regularly** - see [secret rotation guide](../ways-of-working/secret-rotation.md)
