# AI Agent Instructions

This document contains all instructions for AI agents working with this repository. It is the single source of truth for agent behavior, limitations, and guidelines.

---

## How to Use This Document

This document is structured into tiers:

| Tier | When to Read |
|------|--------------|
| **Always Read** | Must be read at the start of every session. Contains critical rules and context. |
| **Main Topics** | Read when working on that specific area (e.g., read Frontend when doing frontend work). |
| **Sub-topics** | Read when there is a specific need within a main topic. |

**Navigation:**
- [Always Read](#always-read) - Start here, every time
- [Main Topics](#main-topics)
  - [Frontend](#frontend)
  - [Backend](#backend)
  - [Infrastructure](#infrastructure)
  - [CI/CD Workflows](#cicd-workflows)
  - [MCP](#mcp)

---

# Always Read

**This entire section must be read at the start of every session.**

---

## 1. Repository Overview

[PROJECT NAME] - [Brief description of what the project does]

**Tech Stack:**
- Frontend: [To be defined]
- Backend: [To be defined]
- Infrastructure: [To be defined]
- CI/CD: GitHub Actions

**High-Level Architecture:**

[To be documented as the project evolves. See `docs/` for detailed architecture documentation.]

---

## 2. Git Workflow & Commit Conventions

### Branch Rules

- **Always start on a new branch** when beginning new work
- **Always run `git pull --rebase`** when picking up work on an existing branch or resuming after a pause
- **Never push directly to main/master** - only push to feature branches

### Commit Rules

- **The human must always be the commit author** - this is required for accountability. Agents cannot be held accountable, humans can
- Use conventional commit format: `type: description`
  - Types: `feat`, `fix`, `refactor`, `docs`, `chore`, `test`
- Keep commits atomic and focused

### Workflow

1. Create a new branch from main
2. Make changes and commit
3. Push to the branch
4. Human creates PR and reviews
5. Human merges to main

---

## 3. Security Guidelines

### Secrets Handling

- **Never commit secrets** (passwords, API keys, tokens, credentials)
- Use environment variables or SOPS for secrets management
- If you accidentally encounter a secret, alert the human immediately

### Agent Permissions

- Do not access external services without explicit human approval
- Do not make network requests unless required for the task and approved
- Do not modify authentication/authorization logic without human review

### Security Concerns

- If you identify a potential security vulnerability, **stop and alert the human**
- Do not attempt to fix security issues without human oversight

### Dependency Security

- Dependency scanning is handled in CI/CD (see [CI/CD Workflows](#cicd-workflows))
- Do not add dependencies with known vulnerabilities

---

## 4. Dependencies & Package Management

### General Rules

- Do not add dependencies without considering necessity
- Prefer well-maintained, widely-used packages
- Check for security vulnerabilities before adding

### Component-Specific Rules

Detailed dependency rules are defined in each main topic:

- **Frontend dependencies:** See [Frontend > Dependencies](#frontend-dependencies)
- **Backend dependencies:** See [Backend > Dependencies](#backend-dependencies)
- **Infrastructure dependencies:** See [Infrastructure > Dependencies](#infrastructure-dependencies)

---

## 5. Documentation Requirements

### Documentation Structure

| Type | Location |
|------|----------|
| Human-centered documentation | `docs/` folder |
| Agent instructions | This file (`AI.md`) |

### docs/ Folder Structure

The `docs/` folder mirrors the code structure:
- `docs/frontend/` - Frontend documentation
- `docs/backend/` - Backend documentation
- `docs/infrastructure/` - Infrastructure documentation
- `docs/CI-CD/` - CI/CD documentation

### Agent Responsibilities

- When making changes, update relevant documentation in `docs/`
- When receiving new instructions from the human, update this `AI.md` file
- Always maintain traceability between code and documentation

---

## 6. Error Handling & Logging

### General Rules

- **Never log PII** (Personally Identifiable Information)
- **Never log secrets** (passwords, tokens, keys)
- Use appropriate log levels

### Component-Specific Rules

Detailed error handling and logging patterns are defined in each main topic:

- **Frontend:** See [Frontend > Error Handling & Logging](#frontend-error-handling--logging)
- **Backend:** See [Backend > Error Handling & Logging](#backend-error-handling--logging)
- **Infrastructure:** See [Infrastructure > Error Handling & Logging](#infrastructure-error-handling--logging)

---

## 7. Architecture & Design Patterns

### Overview

[High-level architecture overview to be added as the project develops]

See `docs/` for detailed architecture documentation.

### Agent Responsibilities

- **When new design patterns are introduced or major changes are made, document them in the component's respective `docs/` folder**
- Keep architecture documentation up to date
- If architectural decisions are unclear, ask the human

---

## 8. Communication with Human / Asking for Help

### When to Ask

- **When in doubt** - always ask
- **When documentation is lacking** - ask and then document the answer
- **When instructions cannot be found** - ask the human
- **When requirements are unclear** - do not start work until requirements are sufficiently explained
- **When encountering security concerns** - always check with human
- **When making breaking changes** - always check with human first

### After Receiving Instructions

- Update `AI.md` with new agent instructions
- Update `docs/` with human-relevant documentation
- Confirm understanding before proceeding

### How to Ask

- Be specific about what is unclear
- Provide context about what you've already checked
- Suggest options if you have them

---

## 9. File & Folder Structure Conventions

### Repository Structure

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

### Component-Specific Conventions

File naming and folder structure within components are documented in each main topic:

- **Frontend:** See [Frontend > File Structure](#frontend-file-structure)
- **Backend:** See [Backend > File Structure](#backend-file-structure)
- **Infrastructure:** See [Infrastructure > File Structure](#infrastructure-file-structure)

---

## 10. Deployment Process

### Overview

- Deployments are handled via **GitHub Actions**
- Full deployment documentation is in `docs/CI-CD/`

### Agent Limitations

- **Agent cannot trigger deployments**
- Agent can modify workflow files (with human review)
- Human approves and triggers all deployments

### Environments

- Development, Demo, Staging, Production
- See [Infrastructure](#infrastructure) for environment-specific details

---

## 11. Code Review Guidelines

### Rules

- **Human always performs code review** - no exceptions
- **Agent is never allowed to push to main/master**
- Agent can push to feature branches

### Process

1. Agent pushes changes to feature branch
2. Human decides when to create PR
3. Human reviews the changes
4. Human merges manually

---

## 12. Versioning & Releases

### Version Scheme

Use [Semantic Versioning](https://semver.org/):
- **MAJOR**: Breaking changes
- **MINOR**: New features (backwards compatible)
- **PATCH**: Bug fixes (backwards compatible)

### Changelog

- A `CHANGELOG.md` must exist and be updated for every change
- Group changes into categories:
  - **Features** - New functionality
  - **Bug Fixes** - Fixed issues
  - **Changes** - Modified existing functionality
  - **Chores** - Maintenance tasks
  - Additional categories as needed

### Release Process

- Releases are handled via CI/CD (see `docs/CI-CD/`)
- Human approves/triggers releases
- Automation handles the rest

---

## 13. Testing

### General Approach

Testing requirements and practices are defined per component. See:

- **Frontend testing:** [Frontend > Testing](#frontend-testing)
- **Backend testing:** [Backend > Testing](#backend-testing)
- **Infrastructure testing:** [Infrastructure > Testing](#infrastructure-testing)

### End-to-End Testing

E2E tests that span multiple components are documented here:

[To be defined as E2E tests are implemented]

---

## 14. Troubleshooting

### Project-Wide Issues

[Document any project-wide common issues here]

### Component-Specific Issues

See each main topic for component-specific troubleshooting:

- **Frontend:** [Frontend > Troubleshooting](#frontend-troubleshooting)
- **Backend:** [Backend > Troubleshooting](#backend-troubleshooting)
- **Infrastructure:** [Infrastructure > Troubleshooting](#infrastructure-troubleshooting)
- **CI/CD:** [CI/CD > Troubleshooting](#cicd-troubleshooting)

---

## 15. Agent Capabilities & Limitations

### General Capabilities

- Read and write code
- Run commands in terminal
- Search and navigate codebase
- Create and modify files
- Push to feature branches

### General Limitations

- Cannot push to main/master
- Cannot trigger deployments
- Cannot approve PRs or merge
- Cannot make security decisions without human approval
- Cannot add external service integrations without approval

### Updating Limitations

Changes to agent limitations should be made in this section. If the human provides new limitations or capabilities, update this section accordingly.

---

## 16. Planning Practice

### The plans/ Folder

All feature plans are stored in the `plans/` folder:

```
plans/
├── feature-name.md       # Active plans
├── another-feature.md
└── implemented/          # Completed plans
    └── old-feature.md
```

### Workflow

1. **Before starting new work**, ask the human: "Would you like me to create a plan first?"
2. If yes, create a plan file in `plans/` with:
   - Feature description
   - Requirements
   - Implementation steps
   - Open questions
3. Get human approval on the plan before starting implementation
4. **Update the plan** as work progresses
5. Only move to `implemented/` when **fully complete**

### Plan Updates

- Partially completed plans stay in `plans/` and are updated in place
- Mark completed sections/steps in the plan
- Add notes about any deviations from the original plan

---

# Main Topics

Read the relevant main topic when working on that area.

---

## Frontend

[To be implemented]

### Frontend Code Style & Conventions

[Define frontend coding standards, naming conventions, formatting rules]

### Frontend Dependencies

[Define preferred packages, how to add dependencies, version requirements]

### Frontend Testing

[Define testing requirements, frameworks, coverage expectations]

### Frontend Error Handling & Logging

[Define error handling patterns, logging practices]

### Frontend File Structure

[Define folder organization, file naming conventions]

### Frontend Performance

[To be added when relevant]

### Frontend Troubleshooting

[Document common issues and solutions]

---

## Backend

[To be implemented]

### Backend Code Style & Conventions

[Define backend coding standards, naming conventions, formatting rules]

### Backend Dependencies

[Define preferred packages, how to add dependencies, version requirements]

### Backend Testing

[Define testing requirements, frameworks, coverage expectations]

### Backend Error Handling & Logging

[Define error handling patterns, logging practices]

### Backend File Structure

[Define folder organization, file naming conventions]

### Backend Performance

[To be added when relevant]

### Backend Troubleshooting

[Document common issues and solutions]

---

## Infrastructure

Infrastructure code is organized by environment:

```
infrastructure/
├── dev/          # Development environment
├── demo/         # Demo environment
├── staging/      # Staging environment
└── production/   # Production environment
```

### Infrastructure Code Style & Conventions

[Define IaC standards, naming conventions, formatting rules]

### Infrastructure Dependencies

[Define required tools, versions, providers]

### Infrastructure Testing

[Define testing requirements for infrastructure code]

### Infrastructure Error Handling & Logging

[Define monitoring, alerting, logging practices]

### Infrastructure File Structure

[Define folder organization per environment]

### Infrastructure Environment Setup

[Development environment setup instructions - added when implemented]

### Infrastructure Troubleshooting

[Document common issues and solutions]

---

## CI/CD Workflows

CI/CD is implemented using **GitHub Actions**.

Full documentation: `docs/CI-CD/`

### CI/CD Code Style & Conventions

[Define workflow file standards, naming conventions]

### CI/CD Dependencies

[Define required actions, tools, versions]

### CI/CD Testing

[Define workflow testing practices]

### CI/CD Troubleshooting

[Document common pipeline issues and solutions]

---

## MCP

Model Context Protocol (MCP) instructions and configurations.

**When working with MCP, always read this section.**

### MCP Overview

[Describe MCP usage in this project]

### MCP Configuration

MCP configurations are stored in the `MCP/` folder.

### MCP Limitations

[Define what the agent can and cannot do with MCP]

### MCP Instructions

[Step-by-step instructions for MCP-related tasks]

---

# Document History

| Date | Change | Author |
|------|--------|--------|
| [DATE] | Initial draft | [Human/Agent] |
