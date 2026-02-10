# Service Dependencies

> **Last Updated:** YYYY-MM-DD
> **Owner:** [Team/Person]

## Overview

This document maps the dependencies for [TEAM NAME]'s services, showing what we depend on (upstream) and what depends on us (downstream).

---

## Dependency Diagram

```
                    ┌─────────────────┐
                    │  External APIs  │
                    │  (Payment, etc) │
                    └────────┬────────┘
                             │
         ┌───────────────────┼───────────────────┐
         │                   │                   │
         ▼                   ▼                   ▼
┌─────────────────┐ ┌─────────────────┐ ┌─────────────────┐
│   Auth Service  │ │  [OUR SERVICE]  │ │  Notification   │
│   (Team: IAM)   │ │                 │ │  (Team: Comms)  │
└─────────────────┘ └────────┬────────┘ └─────────────────┘
                             │
              ┌──────────────┼──────────────┐
              │              │              │
              ▼              ▼              ▼
      ┌──────────────┐ ┌──────────────┐ ┌──────────────┐
      │  Frontend    │ │  Mobile App  │ │  Partner API │
      │  (Team: Web) │ │ (Team: Mobile)│ │ (External)   │
      └──────────────┘ └──────────────┘ └──────────────┘
```

---

## Upstream Dependencies (What We Depend On)

Services our team requires to function.

| Service | Owner Team | Criticality | Failure Impact | Contact |
|---------|------------|-------------|----------------|---------|
| Auth Service | IAM Team | Critical | Complete outage - no user auth | #iam-support |
| PostgreSQL (Cloud SQL) | Platform | Critical | Complete outage - no data access | #platform-support |
| Redis Cache | Platform | High | Degraded performance, increased latency | #platform-support |
| Payment Gateway | External (Stripe) | High | Cannot process payments | support@stripe.com |
| Email Service | Comms Team | Medium | Delayed notifications | #comms-team |
| [Service] | [Team] | [Crit/High/Med/Low] | [Impact] | [Contact] |

### External Dependencies

| Provider | Service | Status Page | Support Contact |
|----------|---------|-------------|-----------------|
| GCP | Cloud SQL, Cloud Run | status.cloud.google.com | GCP Support |
| Stripe | Payment processing | status.stripe.com | support@stripe.com |
| [Provider] | [Service] | [URL] | [Contact] |

---

## Downstream Dependencies (What Depends On Us)

Services that depend on our team's services.

| Service | Owner Team | How They Use Us | Impact If We Fail |
|---------|------------|-----------------|-------------------|
| Frontend | Web Team | API calls for user data | UI shows errors, users cannot access data |
| Mobile App | Mobile Team | API calls for user data | App functionality broken |
| Analytics | Data Team | Event stream consumption | Missing data in reports |
| Partner API | External | REST API integration | Partner systems fail |
| [Service] | [Team] | [Usage] | [Impact] |

---

## Kill Chain Analysis

Critical failure paths that could cause complete service outage:

### Path 1: Database Failure
```
Cloud SQL Down → Our Service Down → Frontend/Mobile Down → Users Affected
```
**Mitigation:** Regional HA, automated failover, read replicas

### Path 2: Authentication Failure
```
Auth Service Down → Cannot Validate Tokens → All API Calls Fail → Users Affected
```
**Mitigation:** Token caching, graceful degradation for read operations

### Path 3: [Custom Path]
```
[Failure] → [Cascade] → [Impact]
```
**Mitigation:** [Strategy]

---

## Dependency Health Monitoring

| Dependency | Health Check | Alert Threshold | Dashboard |
|------------|--------------|-----------------|-----------|
| Database | Connection pool, query latency | >100ms p99 | [Link] |
| Auth Service | `/health` endpoint | 3 failures | [Link] |
| Redis | `PING` response | >10ms | [Link] |
| [Dependency] | [Check] | [Threshold] | [Link] |
