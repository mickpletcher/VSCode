Create a complete `requirements.md` file for this repository.

The purpose of `requirements.md` is to define the full requirements specification for:

1. the existing skills already present in the repository
2. all planned future skills
3. all planned advanced automations
4. platform compatibility rules
5. prompt shortcut requirements
6. scaffold and validation requirements

The output must be a single markdown file named `requirements.md`.

Do not output commentary.
Do not explain what you are doing.
Do not summarize.
Output only the final markdown content.

## Primary objective

Build a requirements specification for a VS Code Copilot automation repository that is evolving from a static skills library into a lightweight automation system inside VS Code.

The requirements file must cover:

- current repo skills
- future upgrades
- advanced automations
- prompt shortcuts
- GitHub compatibility
- Azure DevOps and Azure Repos compatibility
- VS Code support
- metadata
- validation rules
- scaffold generation requirements

## Current and future scope to include

The file must cover both current and planned items.

### Existing skills already in the repository

Include requirements coverage for:
- `git-autopilot`
- `skill-scaffold`
- `release-notes`
- `pr-summary`

### Tier 1 highest-impact future skills and automations

Include requirements for:
- `context-builder`
- `bug-fix-investigator`
- `repo-onboarding`
- `issue-to-plan`
- `test-generator`
- `refactor-planner`
- `multi-file-change-orchestrator`
- `diff-aware-regenerator`
- `test-failure-loop`
- `security-scan-light`

### Tier 2 strong multipliers

Include requirements for:
- `fix-build-pipeline`
- `ci-troubleshoot`
- `feature-scaffold`
- `repo-bootstrap`
- `code-review-hardening`
- `api-contract-enforcer`
- `dependency-impact-analyzer`
- `performance-hotspot-detector`
- `documentation-sync`
- `documentation-from-code`
- `changelog-maintainer`
- `migration-guide`
- `workspace-task-optimizer`
- `config-validator`
- `log-intelligence`

### Tier 3 advanced differentiators

Include requirements for:
- `feature-impact-analyzer`
- `task-sequencer`
- `codebase-consistency-enforcer`
- `dead-code-detector`
- `repo-memory`

### Tier 4 system-level optimization and experimental

Include requirements for:
- `copilot-feedback-loop`
- `prompt-optimizer`
- `skill-audit`
- `skill-evolution-scanner`

## Requirements file structure

Generate the markdown file with these sections in this order.

# Requirements Specification

## 1. Purpose

Define the purpose of the repository and the role of `requirements.md`.

## 2. Strategic Objective

Explain that the repository is intended to become:
- a VS Code Copilot acceleration layer
- a cross-platform automation framework
- a lightweight automation system inside VS Code

## 3. Supported Platforms

State that all skills and automations must support:

- VS Code
- GitHub Copilot
- Azure DevOps / Azure Repos

If something cannot support one of these, the limitation must be explicitly documented.

## 4. Core Design Principles

Include requirements that:
- avoid GitHub-only assumptions
- prefer platform-neutral terminology
- require Azure equivalents where needed
- require VS Code usability
- require prompt-based invocation
- require safe and structured outputs
- require clear limitations

## 5. Required Artifacts Per Skill or Automation

State that every skill or automation must include:

- `SKILL.md`
- `README.md`
- `.github/prompts/<skill-name>.prompt.md`
- metadata block
- limitations section
- shortcut definition

## 6. Required Metadata Schema

Provide a YAML example like this:

```yaml
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