# AI Agent Instructions

This guide helps AI assistants work effectively and consistently with this repository. It focuses on **rules, navigation, and task routing** — detailed reference material lives in the linked docs.

---

## Task Routing

Read the relevant docs **before** starting work:

| Task | Read First |
|------|-----------|
| Writing tests | `docs/TESTING.md` |
| Adding API endpoints | `docs/backend/DEVELOPMENT_PATTERNS.md` |
| Adding frontend components | `docs/frontend/DEVELOPMENT_PATTERNS.md` |
| Database schema changes | `docs/backend/DEVELOPMENT_PATTERNS.md` |
| Security | `docs/SECURITY.md` |
| Infrastructure changes | `docs/infrastructure/`, `infrastructure/README.md` |
| CI/CD & Deployment | `docs/CI-CD/` |
| MCP tools | `MCP/README.md` |

---

## Establishing New Practices

**IMPORTANT**: When you make additions that go outside the established practices in this document **OR** no practices exist for the task:

1. **Pause** before proceeding
2. **Ask the human** if new practices should be established
3. **Document the decision** if they want to add it
4. **Update this file** with the new practice

---

## Required Practices

### Security (CRITICAL)

- **Never commit secrets** (passwords, API keys, tokens, credentials)
- Use environment variables or SOPS for secrets management
- If you accidentally encounter a secret, alert the human immediately
- Do not access external services without explicit human approval
- Do not modify authentication/authorization logic without human review
- If you identify a potential security vulnerability, **stop and alert the human**
- Do not add dependencies with known vulnerabilities

### Branching Workflow (CRITICAL)

- **ALWAYS** start from `main` branch (unless explicitly asked otherwise)
- **ALWAYS** pull latest changes using rebase before starting new work
- **ALWAYS** create a new branch before making any code changes
- Commit changes to the branch as you work (not all at the end)
- Never commit directly to `main` branch
- A human will create the PR, review the code, and merge

**Starting New Work**:
```bash
git checkout main
git pull --rebase origin main
git checkout -b feat/add-new-feature
```

**If you encounter merge conflicts during rebase that you cannot confidently resolve, STOP and ask the human for help.**

**Branch Naming Conventions**:
- `feat/` - New features
- `fix/` - Bug fixes
- `docs/` - Documentation changes
- `refactor/` - Code refactoring
- `test/` - Adding or updating tests
- `chore/` - Maintenance tasks

### Git Commits

- **The human must always be the commit author** - this is required for accountability
- Use conventional commit format: `type: description`
  - Types: `feat`, `fix`, `refactor`, `docs`, `chore`, `test`
- Keep commits atomic and focused
- Commit incrementally as you make progress (not all at once)
- Run tests before committing
- Include a co-authorship footer:
  ```
  Co-Authored-By: <actual AI assistant identity>
  ```

### Testing (CRITICAL)

- **MUST** add tests for ALL new features and API endpoints
- **MUST** run tests before committing
- **MUST** flag test changes for human review

**Full guide**: `docs/TESTING.md`

### Code Style

- Follow existing code patterns in the file you're editing
- Use existing utilities before creating new ones

### Documentation

**Golden Rule**: All documentation intended for humans goes in `docs/` unless there's a specific reason to place it elsewhere.

**Decision Tree**:
```
Is this documentation for humans?
├─ YES → Is it a plan for a feature?
│  ├─ YES → plans/ (or plans/implemented/ if done)
│  └─ NO → Is it component-specific?
│     ├─ YES → docs/<component>/
│     └─ NO → docs/
└─ NO → Is it for AI assistants?
   └─ YES → AI.md
```

**AI Documentation Principle:**
- All information an AI needs should be in `AI.md` OR linked from `AI.md` to a human doc
- Never create AI-only documentation outside of `AI.md`

### Changelog

- A `CHANGELOG.md` must exist and be updated for every change
- Follow [Keep a Changelog](https://keepachangelog.com/) format
- Use [Semantic Versioning](https://semver.org/)

---

## Checklists

### Pre-Commit Checklist

- [ ] Tests added for new features
- [ ] All tests pass
- [ ] Security considerations checked
- [ ] No secrets committed
- [ ] Error messages don't leak information
- [ ] Test changes flagged for human review
- [ ] Documentation updated if needed

---

## Agent Capabilities & Limitations

### Capabilities

- Read and write code
- Run commands in terminal
- Search and navigate codebase
- Create and modify files
- Push to feature branches

### Limitations

- Cannot push to main/master
- Cannot trigger deployments
- Cannot approve PRs or merge
- Cannot make security decisions without human approval
- Cannot add external service integrations without approval

---

## When Unsure

1. **Testing questions** → `docs/TESTING.md`
2. **Code patterns** → `docs/<component>/DEVELOPMENT_PATTERNS.md`
3. **Security concerns** → Always flag for human review immediately
4. **Infrastructure** → `infrastructure/README.md`
5. **CI/CD** → `docs/CI-CD/`
6. **Missing practices** → Ask the human if new practices should be established

---

## Plans and Feature Development

**See**: `plans/README.md` for folder structure, naming conventions, and workflow.

- Completed plans go to `plans/implemented/`

---

## Repository Structure

```
project-root/
├── AI.md                 # Agent instructions (this file)
├── docs/                 # Human documentation (mirrors code structure)
│   ├── frontend/
│   ├── backend/
│   ├── infrastructure/
│   └── CI-CD/
├── plans/                # Feature plans
│   └── implemented/      # Completed plans
├── frontend/             # Frontend code
├── backend/              # Backend code
├── infrastructure/       # Infrastructure code
│   ├── dev/
│   ├── demo/
│   ├── staging/
│   └── production/
├── .github/              # GitHub configuration
│   └── workflows/        # CI/CD workflows
└── MCP/                  # MCP instructions and configurations
```

---

**Last Updated**: [DATE]
**Maintainer**: [TEAM NAME]
