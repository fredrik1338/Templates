# [SERVICE NAME] Restore Procedure

> **Last Updated:** YYYY-MM-DD
> **Estimated Recovery Time:** X minutes

## Overview

Brief description of the service and what this procedure restores.

---

## Prerequisites

- [ ] Access to [cloud console/cluster]
- [ ] Required credentials available
- [ ] Monitoring dashboard accessible

---

## Procedure

### Step 1: Assess the Situation

```bash
# Check current service status
[command to check status]
```

**Expected output:** [What healthy vs unhealthy looks like]

### Step 2: [Action Name]

[Detailed instructions]

```bash
# Command to execute
[command]
```

### Step 3: Verify Recovery

```bash
# Health check
curl -f https://[service-url]/health
```

See [verification-checklist.md](./verification-checklist.md) for complete verification.

---

## Rollback

If the restore fails:

1. [Rollback step]
2. Escalate per [contacts.md](../operational-info/contacts.md)

---

## Troubleshooting

| Symptom | Resolution |
|---------|------------|
| [Common issue] | [How to fix] |
