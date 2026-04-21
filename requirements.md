# Requirements Specification

---

## 1. Purpose

This file defines the full requirements specification for the VS Code Copilot Skills repository. It covers existing skills, all planned future skills and automations, platform compatibility rules, prompt shortcut requirements, metadata schema, scaffold generation requirements, and validation rules.

`requirements.md` is the authoritative reference for what every skill and automation in this repository must do and how it must be structured. Any new skill or automation must satisfy these requirements before it is considered complete.

---

## 2. Strategic Objective

This repository is intended to become:

- a **VS Code Copilot acceleration layer** that improves daily development workflows through structured, repeatable automations
- a **cross-platform automation framework** that works consistently across VS Code, GitHub, and Azure DevOps without platform-specific assumptions
- a **lightweight automation system inside VS Code** that covers the full development cycle: understanding a codebase, planning work, implementing safely, testing, reviewing, and shipping

The repository is evolving from a static collection of prompt templates into a system of structured workflows that are invocable through short trigger phrases without leaving the editor.

---

## 3. Supported Platforms

All skills and automations must support the following three platforms. Support is required unless a documented limitation exists.

| Platform | Description |
| --- | --- |
| **VS Code** | Primary surface. All skills must work via GitHub Copilot Chat inside VS Code. |
| **GitHub Copilot** | Skills must be invocable through Copilot chat, prompt files, or manual workflow triggers on GitHub. |
| **Azure DevOps / Azure Repos** | Skills must be usable in Azure DevOps contexts including pipelines, work items, and Azure Repos. |

### Limitation Policy

If a skill cannot fully support one of the three platforms above:

- The limitation must be documented in the skill's `README.md` under a `## Platform Limitations` heading
- The limitation must be listed in the skill's `SKILL.md` frontmatter under `limitations:`
- A workaround or partial alternative must be provided where possible

---

## 4. Core Design Principles

### 4.1 Platform Neutrality

- Do not assume GitHub as the only source control platform
- Use platform-neutral terminology by default: "repository" not "GitHub repo", "work item or issue" not "GitHub issue", "pipeline or workflow" not "GitHub Actions workflow", "pull request or merge request" not "GitHub pull request"
- Do not reference GitHub-only API endpoints, UI paths, or features unless the skill is explicitly marked GitHub-only
- Include Azure DevOps equivalents for any GitHub-specific concept where a direct equivalent exists
- Explicitly document where behavior differs between GitHub and Azure DevOps

### 4.2 Prompt-Based Invocation

- Every skill must be invocable through a natural language prompt
- Every skill must define at least one shortcut-style trigger phrase
- Trigger phrases must be short enough to use without friction
- Trigger phrases must produce consistent behavior across all supported platforms

### 4.3 Safe and Structured Outputs

- Skills that modify files must produce diffs or previews before applying changes where possible
- Skills that generate code must follow the conventions of the target repository, not apply external defaults
- Skills that diagnose problems must separate root causes from cascading symptoms
- Skills that plan work must produce actionable, sequenced steps, not vague recommendations

### 4.4 Explicit Limitations

- Every skill must document what it cannot do
- If a skill requires manual steps, those steps must be stated
- If a skill has known gaps, those gaps must be listed in `README.md` and `SKILL.md`

### 4.5 File Alignment

- `SKILL.md`, `README.md`, and `.github/prompts/<skill-name>.prompt.md` must stay in sync
- A skill with a README that does not match its `SKILL.md` is considered broken
- Metadata must be consistent across all three files

---

## 5. Required Artifacts Per Skill or Automation

Every skill or automation in this repository must include the following artifacts. No skill is considered complete without all of them.

| Artifact | Path | Requirement |
| --- | --- | --- |
| Skill definition | `<skill-name>/SKILL.md` | Required. Contains full skill logic, metadata, and instructions. |
| Documentation | `<skill-name>/README.md` | Required. Contains usage, trigger phrases, examples, and platform limitations. |
| Prompt file | `.github/prompts/<skill-name>.prompt.md` | Required. Enables invocation via Copilot chat and prompt picker. |
| Metadata block | Inside `SKILL.md` frontmatter | Required. See Section 6 for schema. |
| Limitations section | Inside `README.md` and `SKILL.md` | Required. Must document any platform gaps or manual steps. |
| Shortcut definition | Inside `README.md` trigger phrases section | Required. At least one short trigger phrase. |

---

## 6. Required Metadata Schema

Every skill must include a YAML frontmatter metadata block in `SKILL.md`. The block must conform to this schema:

```yaml
name: <skill-name>
category: <category>
tier: <1 | 2 | 3 | 4 | existing>
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
  - <limitation or "none">
```

Valid `category` values: `debugging`, `planning`, `testing`, `scaffolding`, `review`, `documentation`, `repo`, `context`, `ci`, `workspace`, `system`

Valid `tier` values: `1`, `2`, `3`, `4`, `existing`

If a platform is not supported, remove it from the `platforms` list and document the reason in `limitations`.

---

## 7. Skill and Automation Requirements

### 7.1 Existing Skills

#### `git-autopilot`

- **Status**: Existing
- **Tier**: Existing
- **Category**: `repo`
- **Purpose**: Automates common git workflows through natural language prompts
- **Required platforms**: VS Code, GitHub Copilot, Azure Repos
- **Shortcut required**: Yes
- **Prompt file required**: Yes
- **Alignment check**: `SKILL.md`, `README.md`, and `.prompt.md` must be in sync
- **Limitations**: Must document any git operations that behave differently between GitHub and Azure Repos

#### `skill-scaffold`

- **Status**: Existing, requires upgrade
- **Tier**: Existing (Tier 1 alignment required)
- **Category**: `scaffolding`
- **Purpose**: Generates the folder structure and base files for a new skill
- **Required platforms**: VS Code, GitHub Copilot, Azure DevOps
- **Shortcut required**: Yes
- **Prompt file required**: Yes
- **Upgrade requirements**:
  - Must generate `SKILL.md` with correct metadata schema (see Section 6)
  - Must generate `README.md` with trigger phrases, usage, examples, and platform limitations sections
  - Must generate `.github/prompts/<skill-name>.prompt.md`
  - Must generate a pre-filled `limitations` block in metadata
  - Must not require manual edits to make the scaffolded output valid

#### `release-notes`

- **Status**: Existing
- **Tier**: Existing (Tier 2 alignment)
- **Category**: `documentation`
- **Purpose**: Generates structured release notes from commits, merges, or diffs
- **Required platforms**: VS Code, GitHub Copilot, Azure DevOps
- **Shortcut required**: Yes
- **Prompt file required**: Yes
- **Limitations**: Must document differences in changelog format expectations between GitHub Releases and Azure DevOps release pipelines

#### `pr-summary`

- **Status**: Existing
- **Tier**: Existing (Tier 2 alignment)
- **Category**: `review`
- **Purpose**: Summarizes a pull request or merge request for reviewers
- **Required platforms**: VS Code, GitHub Copilot, Azure DevOps
- **Shortcut required**: Yes
- **Prompt file required**: Yes
- **Limitations**: Must use platform-neutral terminology. Must document any differences between GitHub pull request and Azure DevOps merge request handling.

---

### 7.2 Tier 1 — Highest Impact

#### `context-builder`

- **Status**: Planned
- **Tier**: 1
- **Category**: `context`
- **Purpose**: Context enrichment layer that improves all other skills. Gathers open files, related files, imports and references, recent git changes, and available errors or logs before execution begins.
- **Required platforms**: VS Code, GitHub Copilot, Azure DevOps
- **Shortcut required**: Yes — `/context`
- **Prompt file required**: Yes
- **Functional requirements**:
  - Must gather open editor files
  - Must identify and include related files via imports or references
  - Must pull recent git changes relevant to the working area
  - Must include available error output or logs when present
  - Must produce a compact, structured context packet for downstream skills
- **Limitations**: Context depth depends on workspace size and file indexing availability in VS Code

#### `bug-fix-investigator`

- **Status**: Planned
- **Tier**: 1
- **Category**: `debugging`
- **Purpose**: Repeatable debugging workflow from symptom to root cause to minimal fix
- **Required platforms**: VS Code, GitHub Copilot, Azure DevOps
- **Shortcut required**: Yes
- **Trigger phrases**: `fix this bug`, `investigate this error`, `find root cause`, `debug this issue`, `trace this failure`, `why is this breaking`
- **Prompt file required**: Yes
- **Functional requirements**:
  - Must accept error messages, stack traces, log snippets, or failing behavior descriptions as input
  - Must identify likely source files related to the failure
  - Must inspect related code paths
  - Must produce two or three ranked hypotheses for root cause
  - Must propose a minimal fix for the most likely cause
  - Must identify regression risk introduced by the proposed fix
  - Must suggest validation steps to confirm the fix works
- **Limitations**: Cannot execute code or run tests directly. Validation steps require manual or CI execution.

#### `repo-onboarding`

- **Status**: Planned
- **Tier**: 1
- **Category**: `repo`
- **Purpose**: Fast codebase understanding workflow for unfamiliar repositories
- **Required platforms**: VS Code, GitHub Copilot, Azure DevOps
- **Shortcut required**: Yes
- **Trigger phrases**: `explain this repo`, `help me understand this codebase`, `where do I start`, `map this project`, `onboard me to this repo`, `show architecture`
- **Prompt file required**: Yes
- **Functional requirements**:
  - Must inspect repository folder structure
  - Must identify entry points
  - Must locate config, build, test, and deployment files
  - Must summarize architecture at a high level
  - Must identify likely hot spots for contribution or debugging
  - Must tell the user where to start
- **Limitations**: Depth of analysis depends on codebase size and file availability in workspace context

#### `issue-to-plan`

- **Status**: Planned
- **Tier**: 1
- **Category**: `planning`
- **Purpose**: Converts issues, work items, or requirements into structured implementation plans
- **Required platforms**: VS Code, GitHub Copilot, Azure DevOps
- **Shortcut required**: Yes
- **Trigger phrases**: `implement this issue`, `turn this into a plan`, `break down this task`, `create implementation steps`, `plan this feature`, `work this ticket`
- **Prompt file required**: Yes
- **Functional requirements**:
  - Must accept issue text, work item description, or requirement as input
  - Must extract acceptance criteria
  - Must identify unclear assumptions and call them out explicitly
  - Must break work into ordered tasks
  - Must suggest file touch points
  - Must propose a branch name, commit sequence, and test plan
- **Limitations**: Must use platform-neutral terms. Must not assume GitHub Issues as the only input source. Must work with Azure DevOps work items.

#### `test-generator`

- **Status**: Planned
- **Tier**: 1
- **Category**: `testing`
- **Purpose**: Generates behavior-driven test coverage from changed code or a target file
- **Required platforms**: VS Code, GitHub Copilot, Azure DevOps
- **Shortcut required**: Yes
- **Trigger phrases**: `write tests`, `generate unit tests`, `add test coverage`, `create integration tests`, `test this function`, `test this class`
- **Prompt file required**: Yes
- **Functional requirements**:
  - Must inspect changed code or a specified target file
  - Must identify public behavior worth testing
  - Must propose unit versus integration test coverage split
  - Must generate happy path, edge case, and failure tests
  - Must not test private implementation details
  - Must identify required mocks, fixtures, and setup
- **Limitations**: Must not assume a specific test framework. Must detect and follow the conventions of the target repository.

#### `refactor-planner`

- **Status**: Planned
- **Tier**: 1
- **Category**: `planning`
- **Purpose**: Safe, structured refactoring workflow that prevents breaking working systems
- **Required platforms**: VS Code, GitHub Copilot, Azure DevOps
- **Shortcut required**: Yes
- **Trigger phrases**: `refactor this`, `clean this up`, `simplify this code`, `break this into smaller functions`, `improve maintainability`, `reduce duplication`
- **Prompt file required**: Yes
- **Functional requirements**:
  - Must inspect the current code area
  - Must define the refactor goal explicitly
  - Must separate behavior-preserving changes from behavior changes
  - Must propose safe sequencing for the refactor
  - Must identify all affected files
  - Must list tests required before the refactor begins
  - Must produce a stepwise execution plan
- **Limitations**: Does not apply changes automatically. Produces a plan for human or Copilot-assisted execution.

#### `multi-file-change-orchestrator`

- **Status**: Planned
- **Tier**: 1
- **Category**: `context`
- **Purpose**: Coordinates changes that span multiple files to prevent partial or inconsistent updates
- **Required platforms**: VS Code, GitHub Copilot, Azure DevOps
- **Shortcut required**: Yes
- **Prompt file required**: Yes
- **Functional requirements**:
  - Must detect all files impacted by a proposed change
  - Must generate a sequenced change plan
  - Must apply updates across files in dependency order
  - Must keep modules consistent after all changes are applied
- **Limitations**: Requires sufficient workspace context to detect all impacted files accurately

#### `diff-aware-regenerator`

- **Status**: Planned
- **Tier**: 1
- **Category**: `context`
- **Purpose**: Protects stable logic from destructive rewrites by regenerating only affected code sections
- **Required platforms**: VS Code, GitHub Copilot, Azure DevOps
- **Shortcut required**: Yes
- **Prompt file required**: Yes
- **Functional requirements**:
  - Must compare existing code against generated output before applying
  - Must highlight unintended changes
  - Must regenerate only the sections that need to change
  - Must leave stable, unrelated logic untouched
- **Limitations**: Diff accuracy depends on the quality of context provided to Copilot

#### `test-failure-loop`

- **Status**: Planned
- **Tier**: 1
- **Category**: `testing`
- **Purpose**: Iterative debugging workflow driven by failing test output
- **Required platforms**: VS Code, GitHub Copilot, Azure DevOps
- **Shortcut required**: Yes
- **Prompt file required**: Yes
- **Functional requirements**:
  - Must accept failing test output as input
  - Must identify probable failure causes from the output
  - Must propose a specific fix
  - Must support repeated evaluation and adjustment until tests pass
- **Limitations**: Cannot execute tests directly. Requires the user to run tests and provide updated output between iterations.

#### `security-scan-light`

- **Status**: Planned
- **Tier**: 1
- **Category**: `review`
- **Purpose**: Lightweight early-stage security check before formal review
- **Required platforms**: VS Code, GitHub Copilot, Azure DevOps
- **Shortcut required**: Yes
- **Prompt file required**: Yes
- **Functional requirements**:
  - Must scan for unsafe coding patterns
  - Must identify missing input validation
  - Must flag potential secrets or hardcoded credentials
  - Must suggest remediation steps for each finding
- **Limitations**: Not a replacement for a full security audit. Does not execute static analysis tools. Findings require human review.

---

### 7.3 Tier 2 — Strong Multipliers

#### `fix-build-pipeline`

- **Status**: Planned
- **Tier**: 2
- **Category**: `ci`
- **Purpose**: Diagnoses build or CI failures and isolates root cause from cascade noise
- **Required platforms**: VS Code, GitHub Copilot, Azure DevOps
- **Shortcut required**: Yes
- **Trigger phrases**: `fix this build`, `pipeline is failing`, `why did CI break`, `fix test run`, `fix workflow error`, `troubleshoot build`
- **Prompt file required**: Yes
- **Functional requirements**:
  - Must accept build or test failure output as input
  - Must isolate the first real error from cascade failures
  - Must map the failure to a source file or configuration
  - Must identify whether the root cause is code, dependency, environment, or CI configuration
  - Must suggest the smallest viable fix
  - Must provide rerun steps
- **Limitations**: Must support both GitHub Actions and Azure Pipelines output formats

#### `ci-troubleshoot`

- **Status**: Planned
- **Tier**: 2
- **Category**: `ci`
- **Purpose**: Diagnoses workflow-level CI failures where the problem is in pipeline configuration rather than code
- **Required platforms**: VS Code, GitHub Copilot, Azure DevOps
- **Shortcut required**: Yes
- **Prompt file required**: Yes
- **Limitations**: Must use platform-neutral terms. Must document differences between GitHub Actions and Azure Pipelines where behavior diverges.

#### `feature-scaffold`

- **Status**: Planned
- **Tier**: 2
- **Category**: `scaffolding`
- **Purpose**: Scaffolds application features across layers, distinct from `skill-scaffold` which scaffolds prompt skills
- **Required platforms**: VS Code, GitHub Copilot, Azure DevOps
- **Shortcut required**: Yes
- **Trigger phrases**: `scaffold this feature`, `add a new endpoint`, `create a new component`, `bootstrap this module`, `create the files for this feature`
- **Prompt file required**: Yes
- **Functional requirements**:
  - Must accept a feature description as input
  - Must identify affected application layers
  - Must scaffold required files and interfaces
  - Must stub handlers, models, services, UI, tests, or docs as appropriate
  - Must follow the naming and structure conventions of the target repository
- **Limitations**: Must inspect target repo conventions before scaffolding. Must not apply external defaults.

#### `repo-bootstrap`

- **Status**: Planned
- **Tier**: 2
- **Category**: `repo`
- **Purpose**: Sets up initial repository standards for a new or under-structured repo
- **Required platforms**: VS Code, GitHub Copilot, Azure DevOps
- **Shortcut required**: Yes
- **Prompt file required**: Yes
- **Functional requirements**:
  - Must generate README structure
  - Must generate editor config and ignore files
  - Must generate basic CI workflow
  - Must generate contribution documentation
- **Limitations**: Must not assume GitHub-only CI. Must support both GitHub Actions and Azure Pipelines output.

#### `code-review-hardening`

- **Status**: Planned
- **Tier**: 2
- **Category**: `review`
- **Purpose**: Risk-focused code review that goes beyond summaries to identify logic risk, security concerns, and missing tests
- **Required platforms**: VS Code, GitHub Copilot, Azure DevOps
- **Shortcut required**: Yes
- **Trigger phrases**: `review this code`, `look for bugs`, `find risks`, `review this diff`, `check for security issues`, `harden this PR`
- **Prompt file required**: Yes
- **Functional requirements**:
  - Must inspect a diff or set of changed files
  - Must identify logic risk
  - Must highlight security concerns
  - Must flag missing input validation
  - Must detect potential performance regression risk
  - Must identify missing test coverage
  - Must surface backward compatibility concerns

#### `api-contract-enforcer`

- **Status**: Planned
- **Tier**: 2
- **Category**: `review`
- **Purpose**: Keeps APIs consistent across controllers, DTOs, and clients
- **Required platforms**: VS Code, GitHub Copilot, Azure DevOps
- **Shortcut required**: Yes
- **Prompt file required**: Yes
- **Functional requirements**:
  - Must check consistency across controllers, DTOs, and clients
  - Must detect contract mismatches between layers
  - Must suggest corrections

#### `dependency-impact-analyzer`

- **Status**: Planned
- **Tier**: 2
- **Category**: `review`
- **Purpose**: Analyzes dependency changes and identifies impacted files and breaking risks
- **Required platforms**: VS Code, GitHub Copilot, Azure DevOps
- **Shortcut required**: Yes
- **Prompt file required**: Yes
- **Functional requirements**:
  - Must analyze dependency version changes
  - Must identify files impacted by the change
  - Must suggest required follow-up updates
  - Must flag potential breaking changes

#### `performance-hotspot-detector`

- **Status**: Planned
- **Tier**: 2
- **Category**: `review`
- **Purpose**: Identifies inefficient patterns without requiring a profiler
- **Required platforms**: VS Code, GitHub Copilot, Azure DevOps
- **Shortcut required**: Yes
- **Prompt file required**: Yes
- **Functional requirements**:
  - Must scan for nested loops
  - Must identify blocking calls
  - Must flag unnecessary allocations
  - Must detect inefficient patterns
  - Must suggest targeted optimizations

#### `documentation-sync`

- **Status**: Planned
- **Tier**: 2
- **Category**: `documentation`
- **Purpose**: Keeps documentation aligned with code changes
- **Required platforms**: VS Code, GitHub Copilot, Azure DevOps
- **Shortcut required**: Yes
- **Trigger phrases**: `update docs`, `sync docs with code`, `refresh README`, `document this feature`, `fix outdated docs`
- **Prompt file required**: Yes
- **Functional requirements**:
  - Must inspect changed code
  - Must identify documentation files likely impacted by those changes
  - Must draft README, usage, config, or migration updates
  - Must flag outdated examples
  - Must note where documentation is missing

#### `documentation-from-code`

- **Status**: Planned
- **Tier**: 2
- **Category**: `documentation`
- **Purpose**: Generates documentation directly from code when docs were never written or have drifted too far to sync
- **Required platforms**: VS Code, GitHub Copilot, Azure DevOps
- **Shortcut required**: Yes
- **Prompt file required**: Yes
- **Functional requirements**:
  - Must generate README updates from code
  - Must create API documentation from implementation
  - Must produce usage examples from actual code behavior

#### `changelog-maintainer`

- **Status**: Planned
- **Tier**: 2
- **Category**: `documentation`
- **Purpose**: Maintains structured changelog updates from commits or release notes
- **Required platforms**: VS Code, GitHub Copilot, Azure DevOps
- **Shortcut required**: Yes
- **Prompt file required**: Yes
- **Functional requirements**:
  - Must accept merged changes, commits, or release notes as input
  - Must generate a clean `CHANGELOG.md` entry with correct version and date
  - Must follow the existing changelog format of the target repository
- **Limitations**: Must document differences between GitHub Releases and Azure DevOps release pipeline changelog expectations

#### `migration-guide`

- **Status**: Planned
- **Tier**: 2
- **Category**: `documentation`
- **Purpose**: Creates upgrade paths for breaking or structural changes
- **Required platforms**: VS Code, GitHub Copilot, Azure DevOps
- **Shortcut required**: Yes
- **Prompt file required**: Yes
- **Functional requirements**:
  - Must accept a breaking or structural change description as input
  - Must produce a concise upgrade guide for users or maintainers
  - Must list required migration steps in order

#### `workspace-task-optimizer`

- **Status**: Planned
- **Tier**: 2
- **Category**: `workspace`
- **Purpose**: Standardizes VS Code tasks, debug configs, and workspace settings for a repository
- **Required platforms**: VS Code (primary), GitHub Copilot
- **Shortcut required**: Yes
- **Trigger phrases**: `set up vscode tasks`, `create launch config`, `add debug profile`, `optimize workspace`, `configure this repo for vscode`
- **Prompt file required**: Yes
- **Functional requirements**:
  - Must inspect existing repo scripts and tooling
  - Must suggest or generate `.vscode/tasks.json`
  - Must suggest or generate `.vscode/launch.json`
  - Must suggest workspace settings
  - Must standardize debug, build, lint, and test commands
- **Limitations**: VS Code-specific. Not applicable in Azure DevOps or GitHub browser contexts. Must document this limitation.

#### `config-validator`

- **Status**: Planned
- **Tier**: 2
- **Category**: `workspace`
- **Purpose**: Validates JSON, YAML, and environment-driven configuration before runtime failures occur
- **Required platforms**: VS Code, GitHub Copilot, Azure DevOps
- **Shortcut required**: Yes
- **Prompt file required**: Yes
- **Functional requirements**:
  - Must validate JSON configuration files
  - Must validate YAML configuration files
  - Must check for missing required keys
  - Must detect inconsistent or mismatched values
  - Must suggest corrections for each issue found

#### `log-intelligence`

- **Status**: Planned
- **Tier**: 2
- **Category**: `debugging`
- **Purpose**: Analyzes log output to identify root causes and recurring patterns
- **Required platforms**: VS Code, GitHub Copilot, Azure DevOps
- **Shortcut required**: Yes
- **Prompt file required**: Yes
- **Functional requirements**:
  - Must accept log output as input
  - Must group recurring log patterns
  - Must identify anomalies within the log
  - Must suggest likely root causes for identified patterns

---

### 7.4 Tier 3 — Advanced Differentiators

#### `feature-impact-analyzer`

- **Status**: Planned
- **Tier**: 3
- **Category**: `planning`
- **Purpose**: Evaluates what a proposed feature will affect before implementation begins
- **Required platforms**: VS Code, GitHub Copilot, Azure DevOps
- **Shortcut required**: Yes
- **Prompt file required**: Yes
- **Functional requirements**:
  - Must list impacted files and modules
  - Must highlight risks and dependencies
  - Must recommend test updates and migration concerns

#### `task-sequencer`

- **Status**: Planned
- **Tier**: 3
- **Category**: `planning`
- **Purpose**: Breaks vague requests into ordered execution steps for prompt-driven workflows
- **Required platforms**: VS Code, GitHub Copilot, Azure DevOps
- **Shortcut required**: Yes
- **Prompt file required**: Yes
- **Functional requirements**:
  - Must accept a vague or broad goal as input
  - Must produce an ordered list of execution steps
  - Must produce output that can be handed to other skills for execution

#### `codebase-consistency-enforcer`

- **Status**: Planned
- **Tier**: 3
- **Category**: `repo`
- **Purpose**: Enforces naming, structure, and layering standards across the repository
- **Required platforms**: VS Code, GitHub Copilot, Azure DevOps
- **Shortcut required**: Yes
- **Prompt file required**: Yes
- **Functional requirements**:
  - Must identify deviations from established naming patterns
  - Must identify deviations from established structural patterns
  - Must suggest specific alignment changes

#### `dead-code-detector`

- **Status**: Planned
- **Tier**: 3
- **Category**: `repo`
- **Purpose**: Finds unused code and recommends safe cleanup
- **Required platforms**: VS Code, GitHub Copilot, Azure DevOps
- **Shortcut required**: Yes
- **Prompt file required**: Yes
- **Functional requirements**:
  - Must identify unused methods
  - Must identify unused imports
  - Must identify unreachable code
  - Must recommend safe cleanup with enough context to avoid false positives

#### `repo-memory`

- **Status**: Planned
- **Tier**: 3
- **Category**: `system`
- **Purpose**: Maintains a persistent summary of architecture, decisions, and conventions to feed context into later prompts
- **Required platforms**: VS Code, GitHub Copilot
- **Shortcut required**: Yes
- **Prompt file required**: Yes
- **Functional requirements**:
  - Must maintain a persistent architecture summary
  - Must track important decisions and conventions
  - Must make stored context available to downstream skills
- **Limitations**: Persistence mechanism depends on VS Code extension capabilities at implementation time. Azure DevOps support is limited.

---

### 7.5 Tier 4 — System-Level and Experimental

#### `copilot-feedback-loop`

- **Status**: Planned (experimental)
- **Tier**: 4
- **Category**: `system`
- **Purpose**: Evaluates and scores Copilot output to improve future responses
- **Required platforms**: VS Code, GitHub Copilot
- **Shortcut required**: Yes
- **Prompt file required**: Yes
- **Functional requirements**:
  - Must evaluate Copilot output against the original intent
  - Must score response quality
  - Must identify weaknesses in the response
  - Must produce refined guidance for future prompts or skill instructions

#### `prompt-optimizer`

- **Status**: Planned (experimental)
- **Tier**: 4
- **Category**: `system`
- **Purpose**: Rewrites prompts for better clarity and precision before they reach the model
- **Required platforms**: VS Code, GitHub Copilot
- **Shortcut required**: Yes
- **Prompt file required**: Yes
- **Functional requirements**:
  - Must accept a prompt as input
  - Must rewrite it for better clarity and precision
  - Must standardize prompt quality across skills
  - Must improve response reliability without requiring manual tuning per invocation

#### `skill-audit`

- **Status**: Planned
- **Tier**: 4
- **Category**: `system`
- **Purpose**: Reviews the skill catalog for quality, consistency, and completeness
- **Required platforms**: VS Code, GitHub Copilot
- **Shortcut required**: Yes
- **Prompt file required**: Yes
- **Functional requirements**:
  - Must scan every `SKILL.md` in the repository
  - Must check for missing or malformed metadata
  - Must identify weak or missing trigger phrases
  - Must flag version inconsistencies
  - Must identify stale READMEs
  - Must report missing prompt files

#### `skill-evolution-scanner`

- **Status**: Planned
- **Tier**: 4
- **Category**: `system`
- **Purpose**: Recommends upgrades to existing skills based on current model capabilities and newer prompt patterns
- **Required platforms**: VS Code, GitHub Copilot
- **Shortcut required**: Yes
- **Prompt file required**: Yes
- **Functional requirements**:
  - Must scan every `SKILL.md` and related README in the repository
  - Must identify skills that were written for older model capabilities
  - Must recommend concrete upgrades based on current reasoning depth, tool availability, and newer prompt patterns

---

## 8. Scaffold Generation Requirements

`skill-scaffold` must generate all required artifacts for a new skill in a single operation. The following requirements apply to scaffolded output.

### 8.1 Generated Files

| File | Required content |
| --- | --- |
| `<skill-name>/SKILL.md` | Full metadata block (see Section 6), skill logic placeholder, limitations section |
| `<skill-name>/README.md` | Purpose, trigger phrases, usage examples, platform limitations section |
| `.github/prompts/<skill-name>.prompt.md` | Prompt mode header, invocation description, skill reference |

### 8.2 Metadata Pre-Fill

Scaffolded `SKILL.md` must pre-fill:

- `name` from the skill name argument
- `category` from an optional category argument or left as a placeholder
- `tier` from an optional tier argument or left as a placeholder
- `platforms` defaulting to all three supported platforms
- `shortcut` set to `/<skill-name>`
- `supports` defaulting to `prompt-file`, `chat-invocation`, `manual-workflow`
- `limitations` with at least one placeholder entry

### 8.3 Validation After Scaffold

After scaffolding, the output must be valid according to the requirements in Sections 5 and 6 without manual correction. A scaffolded skill with missing metadata, missing files, or misaligned content between `SKILL.md` and `README.md` is a scaffold failure.

---

## 9. Validation Rules

These rules define what a complete, valid skill looks like. Any skill failing one or more of these rules is considered incomplete.

| Rule | Requirement |
| --- | --- |
| V-01 | `SKILL.md` exists and contains a valid metadata block |
| V-02 | `README.md` exists and contains a trigger phrases section |
| V-03 | `.github/prompts/<skill-name>.prompt.md` exists |
| V-04 | At least one trigger phrase is defined and is short enough to use without friction |
| V-05 | Platform limitations are documented if any supported platform is not fully supported |
| V-06 | `SKILL.md`, `README.md`, and `.prompt.md` are in sync on purpose, shortcut, and limitations |
| V-07 | Skill does not use GitHub-only terminology without platform-neutral equivalents |
| V-08 | Metadata `platforms` list matches actual documented support |
| V-09 | Metadata `category` is a valid value from Section 6 |
| V-10 | Metadata `tier` is a valid value from Section 6 |

---

## 10. Repository Structure

### 10.1 Current Structure (Flat)

The repository currently uses a flat folder structure. Each skill occupies a top-level folder.

```text
<skill-name>/
  SKILL.md
  README.md
.github/
  prompts/
    <skill-name>.prompt.md
```

### 10.2 Future Structure (By Category)

When the skill count grows to the point that the flat layout creates real navigation friction, the repository may be reorganized into category-based subdirectories. This is future-state guidance only. No restructuring should happen before that threshold is reached.

Proposed future structure:

```text
skills/
  debugging/       # bug-fix-investigator, test-failure-loop, log-intelligence
  planning/        # issue-to-plan, refactor-planner, task-sequencer, feature-impact-analyzer
  testing/         # test-generator, test-failure-loop
  scaffolding/     # skill-scaffold, feature-scaffold, repo-bootstrap
  review/          # code-review-hardening, security-scan-light, api-contract-enforcer
  documentation/   # documentation-sync, documentation-from-code, changelog-maintainer
  repo/            # repo-onboarding, repo-memory, codebase-consistency-enforcer
  context/         # context-builder, diff-aware-regenerator, multi-file-change-orchestrator
  ci/              # fix-build-pipeline, ci-troubleshoot
  workspace/       # workspace-task-optimizer, config-validator
  system/          # copilot-feedback-loop, prompt-optimizer, skill-audit, skill-evolution-scanner
```

When restructuring happens, all of the following must be completed before the change is merged:

- All internal cross-references in `SKILL.md` and `README.md` files must be updated to reflect new paths
- The root `README.md` index must reflect the new directory structure
- `PackSkill.ps1` and any other tooling that assumes flat paths must be updated before the move

---

## 11. Maintenance Requirements

The following maintenance tasks are required to bring the repository into compliance with this specification.

| Task | Priority | Description |
| --- | --- | --- |
| Add shortcut invocation to all existing skills | High | Audit each `SKILL.md` for a trigger phrase or shortcut. Add one where missing. |
| Add prompt files for all existing skills | High | Generate `.github/prompts/<skill-name>.prompt.md` for any skill missing one. |
| Add metadata blocks to all existing skills | High | Add valid YAML frontmatter conforming to Section 6 to any `SKILL.md` missing it. |
| Add platform limitations sections | High | Add `## Platform Limitations` to any `README.md` that does not have one. |
| Align `SKILL.md`, `README.md`, and `.prompt.md` | Medium | Verify that purpose, shortcut, and limitations are consistent across all three files for every skill. |
| Upgrade `skill-scaffold` | High | Ensure scaffolded output satisfies all requirements in Sections 5, 6, and 8 without manual correction. |
