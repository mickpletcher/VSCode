# Copilot Instructions

## Repository Purpose

This repository is a catalog of reusable GitHub Copilot skills for VS Code. Each skill is a structured, prompt-invocable automation that works across VS Code, GitHub Copilot, and Azure DevOps / Azure Repos.

## Authoritative Reference

`requirements.md` at the root is the single source of truth. Every skill and automation must satisfy those requirements before it is considered complete.

## Workflow: How to Build a Skill

All new skills follow a four-step spec-driven workflow using the prompts in `.github/prompts/`:

1. **Specify** — Run `specify-skill.prompt.md` to create `specs/<NNN>-<skill-name>/spec.md`
2. **Plan** — Run `plan-skill.prompt.md` to create `specs/<NNN>-<skill-name>/plan.md`
3. **Task** — Run `tasks-skill.prompt.md` to create `specs/<NNN>-<skill-name>/tasks.md`
4. **Implement** — Run `implement-skill-from-spec.prompt.md` to generate the final skill artifacts

Do not skip steps. Do not implement a skill without a corresponding spec.

## Spec Lifecycle

Specs live in `specs/` and move through these states:

- `specs/backlog/` — proposed, not started
- `specs/in-progress/` — actively being executed
- `specs/done/` — complete

Folder naming: `<yyyy-mm-dd>-<skill-name>` in lowercase kebab-case.

## Required Skill Artifacts

Every skill must produce these three files, kept in sync at all times:

- `<skill-folder>/SKILL.md`
- `<skill-folder>/README.md`
- `.github/prompts/<skill-name>.prompt.md`

A skill with naming or content mismatches across these three files is considered broken.

## Platform Requirements

All skills must support:

- VS Code (primary surface, GitHub Copilot Chat)
- GitHub Copilot (prompt files, manual workflow triggers)
- Azure DevOps / Azure Repos

Use platform-neutral terminology. Do not assume GitHub as the only platform. If a skill cannot fully support a platform, document the limitation in `README.md` under `## Platform Limitations` and in `SKILL.md` frontmatter under `limitations:`.

## Naming Rules

- Skill folders: lowercase kebab-case
- Shortcut triggers: `/skill-name` format
- Folder name, SKILL.md title, README.md title, and prompt file name must all match

## What Not to Do

- Do not modify existing skill folders when creating a new spec
- Do not restructure the flat skill catalog
- Do not overwrite existing specs
- Do not leave placeholder or incomplete content in committed files
- Do not use GitHub-only terminology in platform-neutral skills
