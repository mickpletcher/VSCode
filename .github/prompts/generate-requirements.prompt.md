# generate-requirements

## Objective

Generate a complete `requirements.md` specification for this repository with implementation-ready structure and validation criteria.

## Input Expectations

Provide:

- Repository context including existing skills and planned skills
- Current future roadmap context if available
- Any required compliance or platform rules

## Execution Steps

1. Analyze existing repository skill folders and current planning documents.
2. Generate or refresh `requirements.md`.
3. Ensure the document includes:
   - Existing skills
   - Planned future skills
   - Tiered automation roadmap
   - Platform compatibility rules
   - Prompt shortcut requirements
   - Metadata and artifact requirements
   - Scaffold generation requirements
   - Validation rules
4. Ensure platform requirements cover:
   - GitHub
   - Azure DevOps / Azure Repos
   - VS Code usability
5. Ensure all requirements are concrete, testable, and structured for implementation.
6. Validate terminology is platform-neutral by default.

## Output Requirements

Return:

- Path to generated `requirements.md`
- Final document content
- Coverage checklist confirming all required sections are present

## Constraints

- Do not modify existing skill behavior as part of requirements generation.
- Do not restructure the repository.
- Do not remove unrelated files.
- Avoid vague statements. Use procedural and verifiable language.
