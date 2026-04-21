Create a standardized `plan.md` template for this repository so every new skill or automation implementation plan follows the same structure and decision points.

## Objective

Define one canonical `plan.md` template that will be used for every future skill or automation under the `specs/` workspace.

This template must convert a completed `spec.md` into an implementation plan that clearly decides:

- folder name
- category
- prompt filename
- metadata block
- README sections
- validation rules
- tier classification (Tier 1, Tier 2, Tier 3, or Tier 4)

The goal is to make implementation planning consistent, predictable, and aligned with the repository roadmap.

---

## Required Output

Create a reusable markdown template file for `plan.md`.

Choose one of these implementation options:

1. Create a file at:
```text
specs/_templates/plan.md
2. If a templates folder already exists for spec workflow files, place it there instead.
Use option 1 unless there is already a better-established templates location in the repository.

Template Requirements

The plan.md template must contain the following sections in this exact order.

Implementation Plan
1. Name
Skill or automation name
Must align with:
folder name
prompt file name
shortcut name
2. Source Spec
Reference the corresponding spec.md
Include placeholder for spec path

Example:

specs/<number>-<skill-name>/spec.md
3. Folder Name Decision

Define the target folder name for the generated skill.

Requirements:

must use kebab-case
must match skill identity
must remain stable once chosen

Include placeholder:

<folder-name>
4. Category Decision

Define the category for the skill or automation.

Allowed examples:

coding-execution
repo-understanding
change-management
tooling
authoring
debugging
planning
testing
review
documentation
context
ci
workspace
system

Include placeholder:

<category>
5. Tier Decision

Classify the item into one of the roadmap tiers:

Tier 1 — highest impact
Tier 2 — strong multipliers
Tier 3 — advanced differentiators
Tier 4 — experimental or system-level optimization

Include:

selected tier
short justification for why that tier applies

Use placeholder:

<tier>
<tier rationale>
6. Prompt Filename Decision

Define the matching prompt file name.

Required format:

.github/prompts/<skill-name>.prompt.md

State that:

prompt file name must align with skill name
prompt file must align with shortcut name
prompt file must align with folder name where possible

Include placeholder:

<prompt-file-path>
7. Metadata Block

Generate the metadata block that the final skill should use.

Include a YAML example with placeholders:

name: <skill-name>
category: <category>
tier: <tier>
platforms:
  - vscode
  - github-copilot
  - azure-devops
shortcut: /<skill-name>
supports:
  - prompt-file
  - chat-invocation
  - manual-workflow
limitations:
  - <limitation 1>
  - <limitation 2>
  - <limitation 3>

Also require that:

metadata must appear in the final skill
naming must stay consistent across all generated files
8. Required Generated Files

List the files that implementation must produce:

SKILL.md
README.md
.github/prompts/<skill-name>.prompt.md

Optional future-state note:

other supporting artifacts may be added later, but these are mandatory
9. README Section Plan

Define the README structure that the generated skill should include.

Required sections:

title
purpose
when to use
supported platforms
shortcut or invocation
inputs
outputs
limitations
examples
related files or dependencies

Also require:

README must match the actual skill behavior
README must stay aligned with SKILL.md and prompt file
10. Validation Rules

Define how implementation will be validated.

Required checks:

folder exists
SKILL.md exists
README.md exists
matching prompt file exists
metadata exists
shortcut exists
limitations exist
supported platforms are declared
naming is consistent
README matches the skill intent
prompt file matches the skill intent
11. Platform Planning Notes

Include explicit planning for:

VS Code
Copilot Chat usage
prompt invocation
active editor and workspace context
GitHub Copilot
prompt-driven workflow support
GitHub-friendly integration where relevant
Azure DevOps / Azure Repos
Azure terminology support
Azure-compatible workflow language
alternatives to GitHub-specific assumptions
12. Risks and Assumptions

Include placeholders for:

implementation risks
ambiguity in the skill scope
platform-specific differences
dependency assumptions
execution assumptions

Use placeholders:

<risk>
<assumption>
13. Notes

Optional planning notes for authors or maintainers.

Template Quality Rules

The template must:

be clean markdown
be reusable
be implementation-focused
avoid filler
make decisions explicit
use placeholders where content must be filled in

Use placeholder formats such as:

<skill-name>
<folder-name>
<category>
<tier>
<prompt-file-path>
Additional Requirements

Add a short note near the top of the template stating:

every plan in this repo must follow this template
every plan must define folder, category, tier, prompt file, metadata, README structure, and validation rules
every plan must preserve GitHub, Azure DevOps, and VS Code compatibility requirements
Constraints
Do NOT modify existing plan.md files
Do NOT restructure the repository
Only add the standard template file
Do NOT create or modify spec or task templates in this step
Final Step

After creating the template:

verify the file exists
verify all required sections are present
verify the template can be reused for both skills and automations

Output the created file path and confirm completion