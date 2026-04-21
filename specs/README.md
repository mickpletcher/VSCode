# Specs Workspace

This workspace supports spec-driven development for new skills and automations.

## Goals

- Define what will be built before implementation starts.
- Keep planning and execution artifacts in one place.
- Preserve the existing flat skill catalog structure.

## Folder Layout

- `templates/`: Reusable templates for spec, plan, and task documents.
- `backlog/`: Proposed work that is not started.
- `in-progress/`: Active work items currently being executed.
- `done/`: Completed work with final status.

## Standard Flow

1. Create a new folder in `backlog/` named `<yyyy-mm-dd>-<initiative-name>`.
2. Copy templates into that folder:
   - `01-spec.md`
   - `02-plan.md`
   - `03-tasks.md`
3. Move the folder to `in-progress/` when execution starts.
4. Move the folder to `done/` when complete.

## Naming Convention

Use lowercase kebab-case for initiative folder names.

Example: `2026-04-20-bug-fix-investigator`

## Scope Guardrails

- Do not modify existing skill folders as part of specs workspace setup.
- Do not restructure the current flat skill catalog from this workspace.
- Use this workspace for planning and tracking only.
