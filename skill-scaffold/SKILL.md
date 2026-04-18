---
name: skill-scaffold
version: 1.0.0
description: Creates a new GitHub Copilot skill folder with a valid SKILL.md, a human-readable README.md, and an index entry in the repository root README. Use this when asked to add a new skill, scaffold a Copilot skill, document a skill folder, or expand a skill catalog repository.
argument-hint: [optional: skill name and purpose]
---

# Skill Scaffold

This skill creates a new Copilot skill folder for a repository that stores reusable VS Code or GitHub Copilot skills.

## When to use this skill

Use this skill when the user asks to:
- add a new skill to the repository
- scaffold a `SKILL.md` file
- create a matching `README.md` for a skill folder
- expand the root skill index with links to a new skill

## What this skill produces

For each new skill, create:

- a top-level skill folder with a clear, slug-style name
- a valid `SKILL.md` file with YAML frontmatter
- a `README.md` that explains the skill in plain language
- an entry in the repository root `README.md`

## Workflow

### Step 1 - Determine the skill's purpose

Identify the repeated workflow the user wants to package. Prefer narrow, reusable workflows over broad instructions.

Examples:
- git commit and push workflow
- release note drafting
- changelog maintenance
- repository bootstrap tasks

### Step 2 - Choose a folder and skill name

Use a concise folder name in kebab case. The frontmatter `name` should match the skill identity closely and remain stable.

Good examples:
- `git-autopilot`
- `release-notes`
- `skill-scaffold`

### Step 3 - Write `SKILL.md`

Create a machine-readable skill definition with:

- `name`
- `version`
- `description`
- optional `argument-hint`
- a clear body covering purpose, triggers, workflow, output expectations, and edge cases

The `description` must contain the phrases users are likely to ask for. If the discovery terms are missing, Copilot is less likely to invoke the skill.

### Step 4 - Write the skill README

Add a human-readable `README.md` alongside the skill that explains:

- what the skill does
- when to use it
- key rules or output formats
- why the skill exists

### Step 5 - Update the root README

Add the new skill to the root repository index with links to:

- the skill folder
- the `SKILL.md` file
- the skill `README.md`

## Authoring rules

- prefer specific workflows over generic agent behavior
- keep instructions procedural and testable
- document blockers and edge cases explicitly
- keep names stable once published
- avoid vague descriptions such as "helps with development"

## Edge cases

- **Unclear scope**: ask whether the workflow should be a skill or general repository instructions.
- **Overlapping skills**: prefer a narrower new skill or update the existing one instead of creating duplicates.
- **Missing README entry**: do not leave the new skill undocumented at the repo root.
- **Weak description field**: improve the trigger phrases before considering the skill complete.