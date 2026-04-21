# plan-skill

## Objective

Read an existing `spec.md` and produce an implementation-ready `plan.md` in the same spec folder.

## Input Expectations

Provide:

- Path to an existing `specs/<NNN>-<skill-name>/spec.md`
- Optional tier preference if not already in spec
- Optional category preference if not already in spec

## Execution Steps

1. Read the target `spec.md`.
2. Extract and normalize the skill or automation name.
3. Generate `specs/<NNN>-<skill-name>/plan.md`.
4. Include these required plan sections:
   - Skill name
   - Target folder name
   - Category (resolved or placeholder)
   - Tier (1-4, resolved or placeholder)
   - Required files:
     - `SKILL.md`
     - `README.md`
     - `.github/prompts/<skill-name>.prompt.md`
   - Prompt file name
   - Metadata structure summary
   - Platform compatibility notes
   - Risks and assumptions
5. Ensure naming consistency between spec, folder, and generated prompt file name.
6. Ensure platform considerations include VS Code, GitHub Copilot, and Azure DevOps / Azure Repos.

## Output Requirements

Return:

- Path to generated `plan.md`
- Complete `plan.md` content
- Extracted key decisions: tier, category, prompt file name, risks

## Constraints

- Do not modify any existing skill folders.
- Do not generate final skill artifacts in this step.
- Do not restructure repository directories.
- Do not use GitHub-only assumptions.
