# VS Code Copilot Skills

[![Build Skillpack](https://github.com/mickpletcher/VSCode/actions/workflows/build-skillpack.yml/badge.svg)](https://github.com/mickpletcher/VSCode/actions/workflows/build-skillpack.yml)
[![Create Release Tag](https://github.com/mickpletcher/VSCode/actions/workflows/create-release-tag.yml/badge.svg)](https://github.com/mickpletcher/VSCode/actions/workflows/create-release-tag.yml)
[![Latest Release](https://img.shields.io/github/v/release/mickpletcher/VSCode)](https://github.com/mickpletcher/VSCode/releases)
[![Download Skillpack](https://img.shields.io/badge/release%20artifact-skillpack.zip-1f883d)](https://github.com/mickpletcher/VSCode/releases/latest/download/skillpack.zip)
[![Download Manifest](https://img.shields.io/badge/release%20artifact-manifest.json-0a7ea4)](https://github.com/mickpletcher/VSCode/releases/latest/download/manifest.json)

A catalog of reusable GitHub Copilot skills for VS Code. Each skill packages a repeatable developer workflow as a machine-readable `SKILL.md`, a prompt file under `.github/prompts/`, and a human-readable `README.md`.

The repository is evolving from a static prompt collection into a spec-driven automation system that covers the full development cycle without leaving the editor.

---

## Skill Catalog

### [git-autopilot](git-autopilot)

Automates the path from `git status` to commit and push. Generates a Conventional Commits message from the actual diff, presents it for confirmation, then stages, commits, and pushes to the tracked remote. Handles edge cases including detached HEAD, merge conflicts, no upstream, and rejected pushes.

- Folder: [git-autopilot](git-autopilot)
- Skill file: [git-autopilot/SKILL.md](git-autopilot/SKILL.md)
- Docs: [git-autopilot/README.md](git-autopilot/README.md)
- Prompt: [.github/prompts/git-autopilot.prompt.md](.github/prompts/git-autopilot.prompt.md)

### [pr-summary](pr-summary)

Turns a pull request diff or branch diff into a reviewer-friendly overview. Produces a structured summary with key changes, risks, and testing status. Works from diffs, staged changes, commit history, or user-supplied notes.

- Folder: [pr-summary](pr-summary)
- Skill file: [pr-summary/SKILL.md](pr-summary/SKILL.md)
- Docs: [pr-summary/README.md](pr-summary/README.md)
- Prompt: [.github/prompts/pr-summary.prompt.md](.github/prompts/pr-summary.prompt.md)

### [release-notes](release-notes)

Drafts release notes and changelog entries from real repository changes. Converts commit history, diffs, or version ranges into a concise, publishable summary. Separates user-facing value from implementation detail and flags unknowns explicitly.

- Folder: [release-notes](release-notes)
- Skill file: [release-notes/SKILL.md](release-notes/SKILL.md)
- Docs: [release-notes/README.md](release-notes/README.md)
- Prompt: [.github/prompts/release-notes.prompt.md](.github/prompts/release-notes.prompt.md)

### [skill-scaffold](skill-scaffold)

Creates a new skill folder with a valid `SKILL.md`, a human-readable `README.md`, and an updated root index entry. Standardizes naming, frontmatter, documentation, and root index updates so the catalog stays coherent as it grows.

- Folder: [skill-scaffold](skill-scaffold)
- Skill file: [skill-scaffold/SKILL.md](skill-scaffold/SKILL.md)
- Docs: [skill-scaffold/README.md](skill-scaffold/README.md)
- Prompt: [.github/prompts/skill-scaffold.prompt.md](.github/prompts/skill-scaffold.prompt.md)

---

## Spec-Driven Workflow

New skills are built through a four-step process using reusable prompt files under `.github/prompts/`. Each step produces a document that feeds the next.

| Step | Prompt | Output |
|---|---|---|
| 1. Specify | `/specify-skill` | `specs/<NNN>-<skill-name>/spec.md` |
| 2. Plan | `/plan-skill` | `specs/<NNN>-<skill-name>/plan.md` |
| 3. Task | `/tasks-skill` | `specs/<NNN>-<skill-name>/tasks.md` |
| 4. Implement | `/implement-skill-from-spec` | `SKILL.md`, `README.md`, prompt file |

After implementation, run `/skill-audit` to validate that all required artifacts exist and are aligned. Use `/generate-requirements` to regenerate `requirements.md` when the skill roadmap changes.

Spec folders use the naming format `<NNN>-<skill-name>` (e.g. `003-changelog-manager`). The `specs/` workspace tracks lifecycle state through `backlog/`, `in-progress/`, and `done/` subfolders.

See [`requirements.md`](requirements.md) for the full specification: platform rules, metadata schema, artifact requirements, tier definitions, and the skill roadmap.

---

## Repository Structure

```
.
├── .github/
│   ├── copilot-instructions.md         # Copilot behavior entry point for this repo
│   ├── prompts/                        # Reusable workflow prompt files
│   │   ├── specify-skill.prompt.md     # Step 1: create spec.md
│   │   ├── plan-skill.prompt.md        # Step 2: create plan.md
│   │   ├── tasks-skill.prompt.md       # Step 3: create tasks.md
│   │   ├── implement-skill-from-spec.prompt.md  # Step 4: generate skill files
│   │   ├── generate-requirements.prompt.md      # Regenerate requirements.md
│   │   └── skill-audit.prompt.md       # Validate a completed skill
│   └── workflows/
│       ├── build-skillpack.yml         # Validate, build, and publish skillpack
│       └── create-release-tag.yml      # Manual release tag creation
├── git-autopilot/                      # Skill: git commit and push automation
├── pr-summary/                         # Skill: pull request summarization
├── release-notes/                      # Skill: release notes generation
├── skill-scaffold/                     # Skill: new skill folder creation
├── specs/                              # Spec-driven development workspace
│   ├── templates/                      # Reusable spec, plan, and tasks templates
│   ├── backlog/                        # Proposed work, not started
│   ├── in-progress/                    # Specs actively being executed
│   ├── done/                           # Completed specs
│   ├── 001-bug-fix-investigator/       # Spec in development
│   └── 002-context-builder/            # Spec in development
├── scripts/                            # Bash packaging and build scripts
├── prompts/Spec/                       # Step-by-step guides for spec system setup
├── PackSkill.ps1                       # PowerShell skill packaging utility
├── requirements.md                     # Authoritative requirements specification
└── README.md                           # This file
```

---

## Required Artifacts Per Skill

Every skill must include all three of these files, kept in sync at all times:

| File | Path | Purpose |
|---|---|---|
| Skill definition | `<skill-name>/SKILL.md` | Machine-readable logic, YAML metadata, and instructions |
| Documentation | `<skill-name>/README.md` | Human-readable usage, trigger phrases, limitations |
| Prompt file | `.github/prompts/<skill-name>.prompt.md` | Enables invocation via Copilot Chat prompt picker |

A skill is incomplete if any file is missing or if naming and content are inconsistent across the three.

---

## Platform Support

All skills target three platforms unless a documented limitation exists.

| Platform | Role |
|---|---|
| VS Code | Primary surface. All skills work via GitHub Copilot Chat. |
| GitHub Copilot | Skills are invocable through prompt files and Copilot chat. |
| Azure DevOps / Azure Repos | Skills use platform-neutral terminology and support Azure workflows. |

Skills that cannot fully support a platform must document the gap under `## Platform Limitations` in their `README.md` and under `limitations:` in their `SKILL.md` frontmatter.

---

## Design Rules

- Keep each skill focused on one repeatable workflow.
- Include a `version` field in each skill's frontmatter.
- Write `description` fields with the phrases users are likely to type. Weak trigger phrases reduce invocation accuracy.
- Document what each skill cannot do. Missing limitations is a defect, not an omission.
- Keep `SKILL.md`, `README.md`, and the prompt file in sync at all times.
- Use platform-neutral terminology unless a platform-specific difference must be explicit.
- Never create a skill without a corresponding spec in `specs/`.

---

## Packaging

**Bash** — `scripts/skillpack.sh` validates the skill catalog, builds a distributable bundle under `dist/skillpack/`, writes a `manifest.json`, and creates `dist/skillpack.zip`. See `scripts/README.md` for usage.

**PowerShell** — `PackSkill.ps1` packages one or more skill folders into `skill.zip` archives by discovering local file references in `SKILL.md` and staging them alongside it. Parameters: `-All`, `-SkillDir`, `-WhatIf`, `-SelfTest`.

---

## GitHub Actions

**[build-skillpack.yml](.github/workflows/build-skillpack.yml)** runs on pushes to `main`, pull requests, published releases, and manual dispatch. It validates the catalog, builds the skillpack with a JSON manifest, uploads the bundle as a workflow artifact, and attaches the archive to published releases.

**[create-release-tag.yml](.github/workflows/create-release-tag.yml)** is a manual workflow that creates a semantic version tag and GitHub release from a target branch or commit. Publishing the release triggers the build workflow, which attaches the generated skillpack archive.
