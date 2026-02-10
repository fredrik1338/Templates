# Team Disaster Recovery Repository

This repository contains disaster recovery documentation for [TEAM NAME]. It is structured to support both internal team operations and cross-team coordination during incidents.

## Repository Structure

```
team-repo-example/
├── README.md                 # This file
├── restore-procedures/       # Team-internal restoration guides
└── operational-info/         # Information for external stakeholders
```

## Folders

### `restore-procedures/`

**Audience:** Team members responsible for restoring services

Contains step-by-step guides for recovering team-owned services. These procedures assume familiarity with the team's systems and access to relevant credentials/tools.

Examples:
- Service restart procedures
- Database restore runbooks
- Configuration recovery steps
- Failover procedures

### `operational-info/`

**Audience:** Other teams, incident commanders, on-call responders

Contains information that stakeholders outside the team may need during an incident or for planning purposes.

Examples:
- **Dependencies & Kill-chain:** What services depend on us, and what we depend on
- **Contacts:** Team members, escalation paths, and communication channels
- **On-call & Support Schedules:** Who to contact and when
- **SLAs & Recovery Objectives:** RPO/RTO targets for critical services

## Usage

1. Clone this template for your team
2. Replace `[TEAM NAME]` with your team's name
3. Populate both folders with your team's documentation
4. Keep documentation up-to-date as systems evolve
5. Review quarterly to ensure accuracy

## Questions?

Contact the Platform/SRE team for guidance on disaster recovery best practices.
