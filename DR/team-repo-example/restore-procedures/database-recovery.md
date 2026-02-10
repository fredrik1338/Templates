# Database Recovery Procedure

> **Last Updated:** YYYY-MM-DD
> **Database:** [DATABASE_NAME]

## Overview

Restoration of the team's database from backups.

---

## Recovery Options

| Method | RPO | RTO | When to Use |
|--------|-----|-----|-------------|
| Point-in-Time Recovery | ~5 min | 1-2 hours | Recent data loss |
| Daily Backup | 24 hours | 2-4 hours | Major corruption |

---

## Prerequisites

- [ ] Cloud CLI authenticated
- [ ] Database admin credentials available
- [ ] Approval for production restores

---

## Point-in-Time Recovery (PITR)

### Step 1: Identify Target Recovery Time

```bash
# List recent operations to find when the issue started
gcloud sql operations list --instance=[INSTANCE_NAME] --limit=10
```

### Step 2: Create Recovery Instance

```bash
gcloud sql instances clone [SOURCE_INSTANCE] [RECOVERY_INSTANCE] \
  --point-in-time="YYYY-MM-DDTHH:MM:SS.000Z"
```

### Step 3: Verify Restored Data

```bash
# Connect and verify
gcloud sql connect [RECOVERY_INSTANCE] --user=[USERNAME]

# Check critical data
SELECT COUNT(*) FROM [table];
```

### Step 4: Switch Application

1. Update connection string in Secret Manager
2. Restart application services
3. Verify application health

---

## Post-Recovery Checklist

- [ ] Verify row counts on critical tables
- [ ] Run application health checks
- [ ] Document incident timeline
