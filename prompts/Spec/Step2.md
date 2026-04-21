Create a set of GitHub Copilot prompt files to implement a spec-driven workflow inside this repository.

## Objective

Add reusable prompt shortcuts under `.github/prompts/` that allow users to:

- define a new skill or automation (spec)
- plan its implementation
- break it into tasks
- generate the actual skill files
- generate requirements documentation

These prompt files will act as command-style workflows inside VS Code Copilot Chat.

---

## Required Files

Create the following files:
.github/prompts/specify-skill.prompt.md
.github/prompts/plan-skill.prompt.md
.github/prompts/tasks-skill.prompt.md
.github/prompts/implement-skill-from-spec.prompt.md
.github/prompts/generate-requirements.prompt.md


If the `.github/prompts/` folder does not exist, create it.

---

## General Rules for All Prompt Files

Each prompt file must:

- Be written as an instruction to Copilot
- Be immediately usable in Copilot Chat
- Be task-focused and procedural
- Avoid vague language
- Assume the repository supports:
  - VS Code
  - GitHub Copilot
  - Azure DevOps / Azure Repos
- Use platform-neutral terminology unless explicitly needed
- Produce structured, implementation-ready output

---

## Prompt 1: specify-skill.prompt.md

Purpose: Define a new skill or automation specification.

Must instruct Copilot to:

- create a `spec.md` in a new numbered folder under `specs/`
- define:
  - problem
  - workflow
  - trigger phrases
  - supported platforms
  - shortcut name
  - limitations
- ensure naming consistency
- ensure cross-platform support

---

## Prompt 2: plan-skill.prompt.md

Purpose: Convert a spec into an implementation plan.

Must instruct Copilot to:

- read an existing `spec.md`
- generate `plan.md`
- define:
  - skill name
  - category
  - tier (1–4)
  - required files
  - prompt file name
  - metadata structure
  - platform considerations
  - risks

---

## Prompt 3: tasks-skill.prompt.md

Purpose: Break a plan into executable steps.

Must instruct Copilot to:

- read `plan.md`
- generate `tasks.md`
- create a checklist using markdown checkboxes
- include steps for:
  - folder creation
  - SKILL.md
  - README.md
  - prompt file
  - shortcut definition
  - metadata
  - limitations
  - validation

---

## Prompt 4: implement-skill-from-spec.prompt.md

Purpose: Generate actual skill files from spec artifacts.

Must instruct Copilot to:

- read:
  - spec.md
  - plan.md
  - tasks.md
- generate:
  - skill folder
  - SKILL.md
  - README.md
  - `.github/prompts/<skill-name>.prompt.md`
- enforce:
  - naming consistency
  - shortcut alignment
  - platform compatibility
  - limitations section
- update root README index if needed

---

## Prompt 5: generate-requirements.prompt.md

Purpose: Generate a full requirements specification.

Must instruct Copilot to:

- generate a complete `requirements.md`
- include:
  - existing skills
  - future skills
  - automation tiers
  - platform rules
  - shortcut requirements
  - validation rules
- ensure:
  - GitHub + Azure DevOps compatibility
  - VS Code usability
  - structured output

---

## File Content Requirements

Each prompt file must include:

- title at top matching the command name
- clear objective section
- input expectations
- step-by-step execution instructions
- output requirements
- constraints (what NOT to do)

---

## Constraints

- Do NOT modify existing skills
- Do NOT restructure the repository
- Do NOT remove any files
- Only add the prompt files

---

## Final Step

After creation:

- verify all 5 prompt files exist
- verify each file contains usable instructions
- ensure naming consistency across files

Output the list of created files and confirm completion