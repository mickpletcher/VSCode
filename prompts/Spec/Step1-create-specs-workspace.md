Create a new `specs/` workspace in this repository to support spec-driven development.

## Objective

Add a structured `specs/` directory for defining new skills and automations using spec, plan, and task documents.

This must NOT modify or restructure any existing skill folders.

The current flat skill catalog must remain unchanged.

---

## Required Folder Structure

Create the following directory layout:
specs/
001-bug-fix-investigator/
spec.md
plan.md
tasks.md
002-context-builder/
spec.md
plan.md
tasks.md


---

## File Creation Requirements

Create all folders and files listed above.

Each file must contain a minimal but valid placeholder template so it is not empty.

---

## spec.md Template

Each `spec.md` must include:

- Title (skill name)
- Problem statement
- Intended workflow
- Supported platforms:
  - VS Code
  - GitHub Copilot
  - Azure DevOps / Azure Repos
- Expected shortcut name (e.g. `/bug-fix-investigator`)
- High-level description of behavior

---

## plan.md Template

Each `plan.md` must include:

- Skill name
- Target folder name
- Category (leave placeholder)
- Tier (leave placeholder)
- Files to be generated:
  - SKILL.md
  - README.md
  - .github/prompts/<skill>.prompt.md
- Platform compatibility notes
- Risks and assumptions

---

## tasks.md Template

Each `tasks.md` must include a checklist:

- create skill folder
- create SKILL.md
- create README.md
- create prompt file under `.github/prompts/`
- define shortcut
- add metadata block
- define limitations
- update root README index
- validate platform compatibility

Use markdown checkbox format.

---

## Naming Rules

- All spec folders must use this format: `<NNN>-<skill-name>` (e.g. `001-bug-fix-investigator`)
- The numeric prefix must be zero-padded to three digits
- The numeric prefix must be the next available number in the `specs/` directory
- The skill name portion must be lowercase kebab-case
- Folder names must match skill names exactly
- File names must be:
  - spec.md
  - plan.md
  - tasks.md

---

## Constraints

- Do NOT modify existing folders
- Do NOT move any existing skills
- Do NOT change repository structure outside of adding `specs/`
- Do NOT delete or overwrite any files

---

## Final Step

After creating everything:

- Verify directory structure is correct
- Verify all files exist
- Ensure all files contain placeholder content

Output the created file tree and confirm completion