Create a standardized `tasks.md` template for this repository so every new skill or automation can be implemented through a repeatable, spec-driven execution checklist.

The template must align with the repository’s spec workflow, scaffold expectations, prompt shortcut requirements, and cross-platform support rules described in `requirements.md`.

## Objective

Define one canonical `tasks.md` template that will be used for every future skill or automation under the `specs/` workspace.

This template must break implementation into concrete, verifiable steps such as:

- create folder
- create `SKILL.md`
- create `README.md`
- create `.github/prompts/<name>.prompt.md`
- update root `README.md`
- validate metadata
- validate shortcut alignment
- validate platform limitations

It must also reinforce how this repo is wired together through the spec workflow:

1. `/specify-skill <skill idea>`
2. `/plan-skill`
3. `/tasks-skill`
4. `/implement-skill-from-spec`
5. `/skill-audit`

---

## Required Output

Create a reusable markdown template file for `tasks.md`.

Choose one of these implementation options:

1. Create the file at:
```text
specs/templates/tasks.md
2. If a spec templates folder already exists, place it there instead.
Use option 1 unless a better-established template location already exists in the repository.

Template Requirements

The tasks.md template must contain the following sections in this exact order.

Implementation Tasks
1. Name
Skill or automation name
Must align with:
spec folder
target folder
prompt file
shortcut name

Include placeholder:

<skill-name>
2. Source Artifacts

Reference the source planning documents that this task list depends on:

spec.md
plan.md

Use placeholders such as:

specs/<number>-<skill-name>/spec.md
specs/<number>-<skill-name>/plan.md

Also include a short note stating that tasks.md must be generated only after spec.md and plan.md exist.

3. Workflow Context

State that this task file is part of the repository’s spec workflow:

/specify-skill <skill idea>
/plan-skill
/tasks-skill
/implement-skill-from-spec
/skill-audit

Also state that the purpose of tasks.md is to convert the plan into an ordered implementation checklist.

4. Required Output Artifacts

List the required output files that implementation must produce:

<skill-folder>/SKILL.md
<skill-folder>/README.md
.github/prompts/<skill-name>.prompt.md

Also require:

root README index update
metadata inclusion
shortcut definition
limitations section
5. Task Checklist

Create a markdown checkbox checklist with placeholders.

The checklist must include, at minimum, tasks for:

Repository and Folder Setup
create target skill folder
verify folder naming matches plan
verify prompt file naming matches plan
Skill File Creation
create SKILL.md
add metadata block
add supported platforms
add shortcut definition
add limitations
align behavior with spec
README Creation
create README.md
document purpose
document supported platforms
document shortcut usage
document limitations
document usage examples
Prompt File Creation
create .github/prompts/<skill-name>.prompt.md
align prompt with skill intent
align shortcut with skill name
ensure prompt is ready for VS Code Copilot Chat
Index and Documentation Updates
update root README.md
add or update catalog entry
ensure links point to correct files
Validation
validate metadata completeness
validate shortcut alignment
validate platform declarations
validate platform limitations
validate naming consistency
validate README and SKILL alignment
validate prompt and SKILL alignment
Final Review
run skill-audit
confirm required files exist
confirm artifact set is complete

Use markdown checkbox syntax throughout.

6. Validation Gate

Add a section stating that implementation must be blocked from completion unless all of the following exist:

SKILL.md
README.md
matching prompt file
shortcut name
supported platforms
limitations
tier
category
root README index entry

This section must explicitly state that a spec-generated skill is incomplete until all required artifacts are present.

7. Platform Validation Requirements

Add subsections for:

VS Code

Validate:

Copilot Chat usability
prompt invocation support
workspace-aware wording
GitHub Copilot

Validate:

prompt-driven usage
GitHub-hosted workflow compatibility where relevant
Azure DevOps / Azure Repos

Validate:

Azure-compatible terminology
Azure workflow support where relevant
explicit alternatives when GitHub-specific examples are used

Also include a note that the safe design is:

authoring/runtime surface: VS Code + GitHub repo
generated workflow compatibility: GitHub + Azure DevOps
8. Scaffold Integration Requirements

Add a section stating that skill-scaffold must become spec-aware.

It must eventually be able to:

read from spec.md
read from plan.md
read from tasks.md
generate skill artifacts from those documents

Also state that this creates the intended pipeline:

idea
requirements
spec
plan
tasks
skill files
9. Related Prompt File Requirements

Document that the following prompt files are part of the expected spec workflow ecosystem:

.github/prompts/specify-skill.prompt.md
.github/prompts/plan-skill.prompt.md
.github/prompts/tasks-skill.prompt.md
.github/prompts/implement-skill-from-spec.prompt.md
.github/prompts/generate-requirements.prompt.md
.github/prompts/skill-audit.prompt.md

Do not require these to be generated in this step, but require the template to recognize them as upstream or downstream dependencies.

10. Example Task Flow

Include a concise example showing how the workflow applies to a skill like bug-fix-investigator:

/specify-skill creates spec.md
/plan-skill creates plan.md
/tasks-skill creates tasks.md
/implement-skill-from-spec generates:
bug-fix-investigator/SKILL.md
bug-fix-investigator/README.md
.github/prompts/bug-fix-investigator.prompt.md
/skill-audit validates output

Use placeholders or a short example block, not a long essay.

11. Notes

Optional notes for maintainers or authors.

Template Quality Rules

The template must:

be clean markdown
be reusable
be implementation-focused
use clear placeholders
avoid filler
be checklist-driven
make validation explicit
reinforce spec workflow order

Use placeholder formats such as:

<skill-name>
<skill-folder>
<prompt-file-path>
Additional Requirements

Add a short note near the top of the template stating:

every tasks.md in this repo must follow this template
every task list must support GitHub, Azure DevOps, and VS Code requirements
every task list must include artifact creation, validation, and prompt shortcut alignment
every task list must assume the current repo layout remains flat
Constraints
Do NOT modify existing tasks.md files
Do NOT restructure the repository
Only add the standard template file
Do NOT create or modify spec or plan templates in this step
Final Step

After creating the template:

verify the file exists
verify all required sections are present
verify the checklist includes creation, validation, and alignment tasks
verify the template supports both skills and advanced automations

Output the created file path and confirm completion