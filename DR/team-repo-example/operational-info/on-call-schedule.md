# On-Call Schedule

> **Last Updated:** YYYY-MM-DD
> **Owner:** [Team/Person]
> **Rotation Tool:** PagerDuty / Opsgenie / [Other]

## Quick Reference

**Current On-Call:** [Link to PagerDuty/Opsgenie schedule]

**To Page On-Call:**
- Slack: `/pd trigger [team-service]`
- PagerDuty: [Direct link]
- Phone: [On-call phone number if applicable]

---

## Schedule Overview

### Primary On-Call

| Week | Primary | Secondary (Backup) |
|------|---------|-------------------|
| Feb 10 - Feb 16 | [Name] | [Name] |
| Feb 17 - Feb 23 | [Name] | [Name] |
| Feb 24 - Mar 2 | [Name] | [Name] |
| Mar 3 - Mar 9 | [Name] | [Name] |

*Full schedule available in [PagerDuty/Opsgenie]*

---

## Rotation Details

| Property | Value |
|----------|-------|
| Rotation Length | 1 week |
| Handoff Time | Monday 09:00 UTC |
| Handoff Meeting | Monday 09:00-09:30 #[team-channel] |
| Participants | [Number] engineers |

---

## On-Call Responsibilities

### During On-Call Shift

1. **Acknowledge alerts** within 15 minutes
2. **Assess severity** and escalate if needed
3. **Communicate status** in #[team-incidents]
4. **Resolve or escalate** per runbooks
5. **Document actions** in incident ticket

### Response SLAs

| Severity | Response Time | Resolution Target |
|----------|--------------|-------------------|
| SEV1 - Critical | 15 minutes | 1 hour |
| SEV2 - High | 1 hour | 4 hours |
| SEV3 - Medium | 4 hours | 24 hours |
| SEV4 - Low | Next business day | 1 week |

---

## Handoff Checklist

When handing off to the next on-call:

- [ ] Review open incidents/tickets
- [ ] Highlight any ongoing issues or concerns
- [ ] Confirm successor has access to all tools
- [ ] Update any stale runbooks encountered
- [ ] Brief on any scheduled maintenance/deployments

---

## Coverage Exceptions

### Holidays

On-call during holidays follows the regular rotation. Swap requests should be made at least 1 week in advance.

### Planned Absences

If you cannot cover your scheduled shift:
1. Find a swap in #[team-channel]
2. Update PagerDuty/Opsgenie schedule
3. Notify team lead

---

## Support Hours

| Type | Hours (UTC) | Coverage |
|------|-------------|----------|
| Business Hours | Mon-Fri 08:00-18:00 | Full team available |
| After Hours | Mon-Fri 18:00-08:00 | On-call only |
| Weekends | Sat-Sun all day | On-call only |
| Holidays | Per holiday calendar | On-call only |

---

## Compensation

- On-call stipend: [Amount] per week
- Incident response: [Policy for after-hours callouts]
- Time-in-lieu: [Policy for extended incidents]

*See HR policy [link] for full details.*
