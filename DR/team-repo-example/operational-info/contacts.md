# Team Contacts & Escalation

> **Last Updated:** YYYY-MM-DD
> **Owner:** [Team/Person]

## Team Overview

**Team Name:** [TEAM NAME]
**Primary Slack Channel:** #[team-channel]
**Email Distribution:** [team]@company.com

---

## Team Members

| Name | Role | Slack | Phone | Email | Timezone |
|------|------|-------|-------|-------|----------|
| [Name] | Team Lead | @handle | +1-XXX-XXX-XXXX | email@company.com | UTC+1 |
| [Name] | Senior Engineer | @handle | +1-XXX-XXX-XXXX | email@company.com | UTC-5 |
| [Name] | Engineer | @handle | +1-XXX-XXX-XXXX | email@company.com | UTC+0 |
| [Name] | Engineer | @handle | +1-XXX-XXX-XXXX | email@company.com | UTC+8 |

---

## Escalation Path

### Severity 1 (Critical Outage)
Complete service outage affecting all users.

1. **On-call Engineer** - See [on-call-schedule.md](./on-call-schedule.md)
   - PagerDuty: [Link]
   - Response SLA: 15 minutes

2. **Team Lead** (if no response in 15 min)
   - [Name]: [Phone]

3. **Engineering Manager** (if no response in 30 min)
   - [Name]: [Phone]

4. **VP Engineering** (major incident, business impact)
   - [Name]: [Phone]

### Severity 2 (Partial Outage)
Service degraded, some users affected.

1. **On-call Engineer** - via Slack #[team-alerts]
   - Response SLA: 1 hour

2. **Team Lead** (if not resolved in 2 hours)
   - Slack: @[handle]

### Severity 3 (Minor Issue)
Minor issue, workaround available.

1. **Team Slack Channel** - #[team-channel]
   - Response SLA: Next business day

---

## External Contacts

### Platform/Infrastructure Team
- **Slack:** #platform-support
- **PagerDuty:** [Link to escalate]
- **On-call:** See platform team's on-call schedule

### Security Team
- **Slack:** #security-incidents
- **Email:** security@company.com
- **Urgent:** [Security on-call phone]

### Vendor Support

| Vendor | Service | Support Portal | Phone | Account ID |
|--------|---------|----------------|-------|------------|
| GCP | Cloud Platform | console.cloud.google.com/support | - | [Account] |
| Stripe | Payments | dashboard.stripe.com | - | [Account] |
| [Vendor] | [Service] | [URL] | [Phone] | [Account] |

---

## Communication Channels

| Channel | Purpose | Who Should Join |
|---------|---------|-----------------|
| #[team-name] | General team discussion | Team members |
| #[team-name]-alerts | Automated alerts | Team + on-call |
| #[team-name]-incidents | Active incident coordination | Incident responders |
| [email-list]@company.com | External communications | Team members |

---

## Incident Bridge

For active incidents, use:
- **Video:** [Zoom/Meet link]
- **Phone Bridge:** [Dial-in number], PIN: [XXXXX]
