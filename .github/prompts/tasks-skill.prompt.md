# tasks-skill

## Objective

Convert an existing `plan.md` into an actionable `tasks.md` checklist for implementation.

## Input Expectations

Provide:

- Path to an existing `specs/<NNN>-<skill-name>/plan.md`
- Optional task sequencing preferences

## Execution Steps

1. Read the target `plan.md`.
2. Derive all required implementation tasks.
3. Create `specs/<NNN>-<skill-name>/tasks.md`.
4. Use markdown checkbox format for every task.
5. Include required checklist items for:
   - Folder creation
   - `SKILL.md` creation
   - `README.md` creation
   - Prompt file creation under `.github/prompts/`
   - Shortcut definition
   - Metadata block addition
   - Limitations definition
   - Validation execution
6. Add any additional tasks required by platform compatibility or repo conventions.
7. Order tasks so they can be executed top-down without ambiguity.

## Output Requirements

Return:

- Path to generated `tasks.md`
- Final checklist content
- Any added validation tasks beyond the minimum required set

## Constraints

- Do not modify existing skill folders.
- Do not generate implementation files in this step.
- Do not remove required checklist items.
- Keep task phrasing explicit and executable.
