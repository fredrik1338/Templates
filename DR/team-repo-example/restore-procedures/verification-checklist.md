# Post-Restore Verification Checklist

> **Last Updated:** YYYY-MM-DD
> **Owner:** [Team/Person]

Use this checklist after any restore operation to confirm services are fully recovered.

---

## Quick Health Checks

### Infrastructure

- [ ] All pods/containers running and healthy
  ```bash
  kubectl get pods -n [namespace] -l app=[service-name]
  ```

- [ ] No recent restarts or crash loops
  ```bash
  kubectl get pods -n [namespace] -o wide | grep -v "Running"
  ```

- [ ] Load balancer health checks passing
  ```bash
  gcloud compute backend-services get-health [BACKEND_SERVICE] --global
  ```

### Application

- [ ] Health endpoint responding
  ```bash
  curl -f https://[service-url]/health
  ```

- [ ] Application logs show normal startup
  ```bash
  kubectl logs -n [namespace] -l app=[service-name] --tail=50
  ```

- [ ] No elevated error rates in monitoring
  - Dashboard: [Link to Grafana/CloudWatch dashboard]

### Database

- [ ] Database connections successful
- [ ] Query latency within normal range
- [ ] Row counts match expected values (for critical tables)

---

## Functional Verification

### Critical User Journeys

Test each critical path manually or via automated tests:

| Journey | Test Steps | Expected Result | Status |
|---------|------------|-----------------|--------|
| User login | Navigate to /login, enter credentials | Successful authentication | [ ] |
| [Journey 2] | [Steps] | [Expected] | [ ] |
| [Journey 3] | [Steps] | [Expected] | [ ] |

### API Endpoints

| Endpoint | Method | Expected Status | Status |
|----------|--------|-----------------|--------|
| `/health` | GET | 200 | [ ] |
| `/api/v1/[resource]` | GET | 200 | [ ] |
| `/api/v1/[resource]` | POST | 201 | [ ] |

---

## Dependency Verification

Confirm connectivity to all dependencies:

| Dependency | Verification Command | Status |
|------------|---------------------|--------|
| Database | `pg_isready -h [host] -p 5432` | [ ] |
| Cache (Redis) | `redis-cli -h [host] ping` | [ ] |
| External API | `curl -f https://[api-url]/health` | [ ] |
| Message Queue | Check consumer lag in monitoring | [ ] |

---

## Monitoring & Alerting

- [ ] Metrics flowing to monitoring system
- [ ] Alerts are active (not silenced/paused)
- [ ] On-call has been notified of recovery completion

---

## Sign-off

| Role | Name | Timestamp | Signature |
|------|------|-----------|-----------|
| Incident Commander | | | [ ] Verified |
| Service Owner | | | [ ] Verified |
| On-call Engineer | | | [ ] Verified |

---

## Notes

[Space for any observations or follow-up items identified during verification]
