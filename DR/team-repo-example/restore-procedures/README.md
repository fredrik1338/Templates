# Restore Procedures

This folder contains team-internal procedures for restoring services during an incident.

## Suggested Documents

- `service-name-restore.md` - Step-by-step restoration guide for each service
- `database-recovery.md` - Database backup restoration procedures
- `failover-runbook.md` - How to failover to secondary/DR environment
- `config-recovery.md` - How to restore configuration and secrets
- `verification-checklist.md` - Post-restore validation steps

## Template

Each restore procedure should include:

1. **Prerequisites** - Access, tools, and credentials needed
2. **Steps** - Numbered, actionable instructions
3. **Verification** - How to confirm the restore succeeded
4. **Rollback** - What to do if the restore fails
5. **Contacts** - Who to escalate to if issues arise
