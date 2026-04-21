# specify-skill

## Objective

Define a new skill or automation specification and create a `spec.md` file under a new numbered folder in `specs/`.

## Input Expectations

Provide the following input before execution:

- Skill or automation name in kebab-case
- Problem statement
- Intended workflow summary
- Trigger phrases
- Expected shortcut (example: `/bug-fix-investigator`)
- Known limitations
- Optional preferred tier and category

## Execution Steps

1. Inspect the `specs/` directory and identify the next available numeric prefix.
2. Create a new folder using this format: `specs/<NNN>-<skill-name>/`.
3. Create `specs/<NNN>-<skill-name>/spec.md`.
4. Populate `spec.md` with these required sections:
   - Title (skill or automation name)
   - Problem statement
   - Intended workflow
   - Trigger phrases
   - Supported platforms:
     - VS Code
     - GitHub Copilot
     - Azure DevOps / Azure Repos
   - Expected shortcut name
   - High-level behavior description
   - Limitations
5. Validate naming consistency across folder name, title, and shortcut.
6. Validate cross-platform support language is explicit and not GitHub-only.

## Output Requirements

Return:

- Created folder path
- Created `spec.md` path
- Final `spec.md` content
- Validation notes for naming consistency and platform coverage

## Constraints

- Do not modify existing skills or existing skill folders.
- Do not move or restructure repository directories.
- Do not overwrite existing spec folders.
- Use platform-neutral terminology unless platform-specific differences must be stated.
