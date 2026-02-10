# Post-Restore Verification Checklist

> **Last Updated:** YYYY-MM-DD

Use this checklist after any restore operation.

---

## Infrastructure

- [ ] All pods/containers running
- [ ] No crash loops or restarts
- [ ] Load balancer health checks passing

## Application

- [ ] Health endpoint responding
- [ ] No elevated error rates
- [ ] Logs show normal operation

## Database

- [ ] Connections successful
- [ ] Query latency normal
- [ ] Critical data verified

## Dependencies

- [ ] Upstream services reachable
- [ ] Downstream services notified

---

## Sign-off

| Role | Verified |
|------|----------|
| Incident Responder | [ ] |
| Service Owner | [ ] |
