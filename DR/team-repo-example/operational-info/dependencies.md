# Service Dependencies

> **Last Updated:** YYYY-MM-DD

## Overview

Dependencies for [TEAM NAME]'s services.

---

## Upstream Dependencies (What We Depend On)

| Service | Owner | Criticality | Failure Impact |
|---------|-------|-------------|----------------|
| [Service] | [Team] | Critical/High/Medium | [Impact description] |

---

## Downstream Dependencies (What Depends On Us)

| Service | Owner | How They Use Us |
|---------|-------|-----------------|
| [Service] | [Team] | [Usage description] |

---

## External Dependencies

| Provider | Service | Status Page |
|----------|---------|-------------|
| [Provider] | [Service] | [URL] |

---

## Kill Chain

Critical failure path:

```
[Dependency] Down → [Our Service] Down → [Downstream] Affected
```

**Mitigation:** [Strategy]
