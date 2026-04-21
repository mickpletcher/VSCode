# implement-skill-from-spec

## Objective

Implement a skill or automation from spec artifacts by generating final repository files with aligned naming, shortcuts, and platform coverage.

## Input Expectations

Provide:

- Path to `specs/<NNN>-<skill-name>/spec.md`
- Path to `specs/<NNN>-<skill-name>/plan.md`
- Path to `specs/<NNN>-<skill-name>/tasks.md`

## Execution Steps

1. Read `spec.md`, `plan.md`, and `tasks.md`.
2. Resolve canonical skill name and shortcut.
3. Create the target skill folder if it does not exist.
4. Generate or update these files:
   - `<skill-folder>/SKILL.md`
   - `<skill-folder>/README.md`
   - `.github/prompts/<skill-name>.prompt.md`
5. Ensure all generated files align on:
   - Skill name
   - Shortcut
   - Purpose
   - Trigger phrases
   - Limitations
6. Enforce platform compatibility coverage for:
   - VS Code
   - GitHub Copilot
   - Azure DevOps / Azure Repos
7. Add explicit limitations where behavior differs by platform.
8. Update root `README.md` index only if the new skill must be listed.
9. Validate final alignment across `SKILL.md`, `README.md`, and prompt file.

## Output Requirements

Return:

- Created or updated file list
- Final shortcut and trigger phrase set
- Platform compatibility summary
- Limitations summary
- README index update status

## Constraints

- Do not move or restructure existing repository folders.
- Do not overwrite unrelated content.
- Do not leave naming mismatches across generated files.
- Use platform-neutral terminology unless differences must be explicit.
