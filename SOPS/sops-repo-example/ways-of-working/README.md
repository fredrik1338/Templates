# Ways of Working

Team practices and workflows for secrets management.

## Documents

- `secret-rotation.md` - How and when to rotate secrets
- `access-control.md` - Managing who can access what
- `code-review.md` - Reviewing changes to secrets

## Core Principles

1. **Least privilege** - Only grant access to secrets that are needed
2. **Separation of environments** - Dev, staging, and prod have separate keys
3. **Audit trail** - All changes go through pull requests
4. **Regular rotation** - Secrets are rotated on a schedule
5. **No plaintext** - Secrets are never stored unencrypted in the repository

## Quick Reference

| Action | Procedure |
|--------|-----------|
| Add new secret | Create PR with encrypted file |
| Update secret | Edit with `sops` command, create PR |
| Add team member | Add their public key, run `sops updatekeys` |
| Remove team member | Remove key, rotate secrets, run `sops updatekeys` |
| Incident response | Follow [rotation procedure](secret-rotation.md#emergency-rotation) |
