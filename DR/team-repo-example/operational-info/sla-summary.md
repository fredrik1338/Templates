# Service Level Objectives (SLOs) & Recovery Targets

> **Last Updated:** YYYY-MM-DD
> **Owner:** [Team/Person]

## Overview

This document defines the availability targets and recovery objectives for [TEAM NAME]'s services.

---

## Service Tier Definitions

| Tier | Description | Availability Target | Examples |
|------|-------------|---------------------|----------|
| Tier 1 | Business-critical, customer-facing | 99.9% (8.7h downtime/year) | Core API, Authentication |
| Tier 2 | Important, some customer impact | 99.5% (43.8h downtime/year) | Reporting, Search |
| Tier 3 | Internal tools, limited impact | 99.0% (87.6h downtime/year) | Admin dashboards |

---

## Recovery Objectives

| Metric | Definition |
|--------|------------|
| **RPO** (Recovery Point Objective) | Maximum acceptable data loss measured in time |
| **RTO** (Recovery Time Objective) | Maximum acceptable time to restore service |

---

## Service SLOs

### [Primary Service Name]

| Metric | Target | Current | Status |
|--------|--------|---------|--------|
| Availability | 99.9% | 99.95% | :white_check_mark: |
| Latency (p50) | <100ms | 45ms | :white_check_mark: |
| Latency (p99) | <500ms | 320ms | :white_check_mark: |
| Error Rate | <0.1% | 0.05% | :white_check_mark: |

| Recovery Objective | Target | Method |
|-------------------|--------|--------|
| RPO | 5 minutes | Point-in-Time Recovery (PITR) |
| RTO | 1 hour | Automated failover + restore procedures |

**Monitoring Dashboard:** [Link]

---

### [Secondary Service Name]

| Metric | Target | Current | Status |
|--------|--------|---------|--------|
| Availability | 99.5% | 99.7% | :white_check_mark: |
| Latency (p50) | <200ms | 120ms | :white_check_mark: |
| Latency (p99) | <1s | 650ms | :white_check_mark: |
| Error Rate | <0.5% | 0.2% | :white_check_mark: |

| Recovery Objective | Target | Method |
|-------------------|--------|--------|
| RPO | 24 hours | Daily backups |
| RTO | 4 hours | Manual restore from backup |

**Monitoring Dashboard:** [Link]

---

## Data Recovery Summary

| Data Type | Storage | Backup Frequency | Retention | RPO | RTO |
|-----------|---------|------------------|-----------|-----|-----|
| User data (PostgreSQL) | Cloud SQL | Continuous (PITR) | 30 days | 5 min | 1 hour |
| User uploads (GCS) | Cloud Storage | Real-time (versioning) | 90 days | 0 | 15 min |
| Application logs | Cloud Logging | N/A | 30 days | N/A | N/A |
| Metrics | Cloud Monitoring | N/A | 1 year | N/A | N/A |

---

## Maintenance Windows

Regular maintenance that may impact availability:

| Window | Time (UTC) | Frequency | Expected Impact |
|--------|------------|-----------|-----------------|
| Database maintenance | Sun 02:00-04:00 | Monthly | Brief connection drops |
| Deployment window | Tue/Thu 14:00-16:00 | As needed | Rolling restart, no downtime |
| Infrastructure updates | Sun 04:00-06:00 | Quarterly | Potential brief outage |

---

## Incident Classification

| Severity | Criteria | Response Time | Resolution Target |
|----------|----------|---------------|-------------------|
| SEV1 | Complete outage, all users affected | 15 min | 1 hour |
| SEV2 | Partial outage, major feature unavailable | 1 hour | 4 hours |
| SEV3 | Degraded performance, workaround available | 4 hours | 24 hours |
| SEV4 | Minor issue, minimal user impact | 1 business day | 1 week |

---

## SLO Review Cadence

- **Weekly:** Review SLO dashboards in team standup
- **Monthly:** Detailed SLO report to stakeholders
- **Quarterly:** SLO target review and adjustment

---

## Contacts

For questions about SLOs or recovery objectives:
- **Team Lead:** [Name] (@slack-handle)
- **SRE/Platform:** #platform-support
