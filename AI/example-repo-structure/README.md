# Example Repository Structure

This folder contains the recommended folder structure for a project using the AI.md template.

## Structure

```
example-repo-structure/
├── .github/
│   └── workflows/        # CI/CD workflows (GitHub Actions)
├── docs/                 # Human documentation
├── frontend/             # Frontend code
├── backend/              # Backend code
├── infrastructure/       # Infrastructure code
├── MCP/                  # MCP instructions and configurations
└── plans/                # Feature plans
    └── implemented/      # Completed plans
```

## Usage

When setting up a new project:

1. Copy the contents of this folder to your project root
2. Copy `AI.md` to your project root
3. Update `AI.md` with project-specific information
4. Add environment subfolders to `infrastructure/` as needed (dev, demo, staging, production)

## Notes

- The `AI.md` file should be placed at the project root, **not** inside this folder
- The `docs/` structure should mirror your code structure
- Add `.gitkeep` files to empty folders to preserve them in git
