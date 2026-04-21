Create a standardized `spec.md` template for this repository so every new skill or automation spec follows the same structure and rules.

## Objective

Define one canonical `spec.md` template that will be used for every future skill or automation under the `specs/` workspace.

This template must align with the repository’s roadmap and requirements around:

- GitHub compatibility
- Azure DevOps / Azure Repos compatibility
- VS Code usability
- prompt shortcut requirements
- limitations
- structured outputs

The goal is consistency.

---

## Required Output

Create a reusable markdown template file for `spec.md`.

Choose one of these implementation options:

1. Create a file at:
```text
specs/_templates/spec.md
2. If a templates folder already exists for spec workflow files, place it there instead.
Use option 1 unless there is already a better-established templates location in the repository.

Template Requirements

The spec.md template must contain the following sections in this exact order.

Specification
1. Name
Skill or automation name
Must align with future folder name, prompt file name, and shortcut name
2. Problem

Define:

what problem this skill solves
why it matters
what gap it addresses in the developer workflow
3. User Workflow

Describe:

how the user invokes it
what context the user provides
how the workflow should progress from input to output
4. Trigger Phrases

List realistic phrases that should help Copilot identify or invoke the skill.

Examples:

fix this bug
explain this repo
write tests
5. Supported Platforms

Must explicitly list:

VS Code
GitHub Copilot
Azure DevOps / Azure Repos
6. Shortcut Name

Define the expected shortcut format:

/<skill-name>

Also state that the shortcut must align with:

skill name
prompt file name
folder name
7. GitHub Compatibility

Describe how the skill is expected to work with:

GitHub repositories
pull requests
workflows or actions when relevant

Require platform-neutral wording by default.

8. Azure DevOps Compatibility

Describe how the skill is expected to work with:

Azure Repos
Azure DevOps Pull Requests
Work Items
Pipelines when relevant

Require Azure equivalents wherever GitHub concepts differ.

9. VS Code Usability

Describe how the skill should function inside VS Code:

prompt-driven usage
Copilot Chat compatibility
active editor context
workspace awareness
10. Prompt Shortcut Requirement

State that the skill must have a matching prompt file:

.github/prompts/<skill-name>.prompt.md

Also require:

shortcut alignment
prompt alignment with skill intent
readiness for VS Code Copilot Chat invocation
11. Limitations

This section must be required.

Subdivide into:

Context Limitations

Examples:

requires selected code
requires repository context
requires logs or failing tests
Platform Limitations

Examples:

differs between GitHub and Azure
certain workflow examples vary by platform
Scope Limitations

Examples:

not intended for repo-wide migrations
requires human review for destructive changes
Execution Limitations

Examples:

may require multi-step execution
may recommend rather than directly apply changes
12. Required Outputs

Define what the skill is expected to produce.

Examples:

summary
findings
impacted files
recommended actions
risks
validation steps
next steps
13. Notes

Optional implementation or authoring notes.

Template Quality Rules

The template must:

be clean markdown
be reusable
be implementation-focused
avoid filler text
make it obvious what needs to be filled in
include placeholder guidance, not vague prose

Use bracket or angle-bracket placeholders where appropriate, such as:

<skill-name>
<problem statement>
<trigger phrase>
Additional Requirements

Add a short note near the top of the template stating:

every spec in this repo must follow this template
every spec must support GitHub, Azure DevOps, and VS Code, or explicitly document limitations
every spec must define a shortcut and a matching prompt file requirement
Constraints
Do NOT modify existing spec.md files
Do NOT restructure the repository
Only add the standard template file
Do NOT create plan or task templates in this step
Final Step

After creating the template:

verify the file exists
verify all required sections are present
verify the template is reusable for both skills and automations

Output the created file path and confirm completion