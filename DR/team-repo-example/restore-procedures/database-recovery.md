# Database Recovery Procedure

> **Last Updated:** YYYY-MM-DD
> **Owner:** [Team/Person]
> **Database:** [DATABASE_NAME]
> **Provider:** Cloud SQL / RDS / [Other]

## Overview

This document covers restoration of the team's primary database from backups.

---

## Recovery Options

| Method | RPO | RTO | When to Use |
|--------|-----|-----|-------------|
| Point-in-Time Recovery (PITR) | ~5 minutes | 1-2 hours | Recent data loss, corruption |
| Daily Backup Restore | 24 hours | 2-4 hours | Major corruption, need clean state |
| Cross-Region Replica | ~seconds | 15-30 min | Regional outage |

---

## Prerequisites

- [ ] `gcloud` CLI authenticated with appropriate permissions
- [ ] Access to GCP Console for project `[PROJECT_ID]`
- [ ] Database admin credentials (Secret Manager: `[SECRET_NAME]`)
- [ ] Approval from [Team Lead/On-call Manager] for production restores

---

## Option 1: Point-in-Time Recovery (PITR)

Use when: You need to recover to a specific point in time within the last 7 days.

### Step 1: Identify Target Recovery Time

Determine the exact timestamp to recover to (before the incident occurred).

```bash
# List recent operations/logs to identify when the issue started
gcloud sql operations list --instance=[INSTANCE_NAME] --limit=20
```

### Step 2: Create Recovery Instance

```bash
# Restore to a new instance at specific point in time
gcloud sql instances clone [SOURCE_INSTANCE] [RECOVERY_INSTANCE] \
  --point-in-time="YYYY-MM-DDTHH:MM:SS.000Z"
```

### Step 3: Verify Restored Data

```bash
# Connect to the recovery instance
gcloud sql connect [RECOVERY_INSTANCE] --user=[USERNAME] --database=[DATABASE]

# Run verification queries
SELECT COUNT(*) FROM [critical_table];
SELECT MAX(created_at) FROM [critical_table];
```

### Step 4: Switch Application to Recovered Database

1. Update connection string in Secret Manager
2. Restart application services
3. Verify application health

### Step 5: Cleanup

After confirming recovery is successful:
```bash
# Optional: Delete old corrupted instance after retention period
gcloud sql instances delete [OLD_INSTANCE] --async
```

---

## Option 2: Restore from Daily Backup

Use when: PITR is unavailable or you need a known-good state from a daily backup.

### Step 1: List Available Backups

```bash
gcloud sql backups list --instance=[INSTANCE_NAME]
```

### Step 2: Restore Backup to New Instance

```bash
gcloud sql instances restore-backup [INSTANCE_NAME] \
  --restore-instance=[NEW_INSTANCE_NAME] \
  --backup-id=[BACKUP_ID]
```

### Step 3: Verify and Switch

Follow Steps 3-5 from Option 1.

---

## Post-Recovery Checklist

- [ ] Verify row counts on critical tables
- [ ] Confirm latest transaction timestamps are as expected
- [ ] Run application health checks
- [ ] Verify downstream services can connect
- [ ] Update monitoring dashboards
- [ ] Document incident timeline and actions taken
- [ ] Schedule post-incident review

---

## Contacts

| Role | Name | Contact |
|------|------|---------|
| Database Owner | [Name] | [Slack/Phone] |
| DBA On-call | [Rotation] | [PagerDuty/Slack] |
| Platform Team | [Name] | #platform-support |
