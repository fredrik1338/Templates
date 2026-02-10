# Recovery Targets & SLOs

> **Last Updated:** YYYY-MM-DD

## Definitions

| Metric | Definition |
|--------|------------|
| **RPO** | Maximum acceptable data loss (time) |
| **RTO** | Maximum acceptable time to restore service |

---

## Service Targets

| Service | Availability | RPO | RTO |
|---------|--------------|-----|-----|
| [Service Name] | 99.9% | 5 min | 1 hour |

---

## Data Recovery

| Data Type | Backup Method | Retention |
|-----------|---------------|-----------|
| Database | PITR / Daily backup | 30 days |
| File Storage | Versioning | 90 days |

---

## Incident Severity

| Severity | Criteria | Response Time |
|----------|----------|---------------|
| SEV1 | Complete outage | 15 min |
| SEV2 | Partial outage | 1 hour |
| SEV3 | Degraded performance | 4 hours |
