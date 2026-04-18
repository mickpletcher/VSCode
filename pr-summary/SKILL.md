---
name: pr-summary
version: 1.0.0
description: Summarizes a pull request or pending code changes into a reviewer-friendly overview with highlights, risks, and testing notes. Use this when asked to write a PR summary, draft a pull request description, explain a change set, or prepare reviewer notes from a diff.
argument-hint: [optional: branch, file scope, or PR theme]
---

# Pull Request Summary

This skill turns a change set into a concise summary that helps reviewers understand intent, impact, and risk.

## When to use this skill

Use this skill when the user asks to:
- write a pull request summary
- draft a pull request description
- explain a pending change set for reviewers
- generate testing notes from a diff

## Preferred source material

Use the strongest available evidence in this order:

1. pull request diff
2. staged or branch diff
3. commit history for the branch
4. user-supplied implementation notes

Do not invent behavior that is not supported by the diff.

## Output structure

Default to a reviewer-friendly format:

```text
## Summary
- ...

## Key changes
- ...

## Risks
- ...

## Testing
- ...
```

Adjust sections if the repository has an established PR template, but keep the output compact and evidence-based.

## Workflow

### Step 1 - Review the diff

Inspect the relevant diff and identify the main behavioral changes, refactors, documentation updates, and operational changes.

### Step 2 - Group related work

Collapse file-by-file churn into a few meaningful themes. Reviewers care about the change model, not the raw file list.

### Step 3 - Call out risk honestly

Surface migration concerns, backward compatibility risk, missing test coverage, or areas that are hard to verify.

### Step 4 - Summarize testing status

If tests were run, state what was run. If tests were not run, say that directly.

## Authoring rules

- prefer behavioral summaries over implementation trivia
- keep each bullet concrete and self-contained
- include risk or testing gaps when present
- do not overstate confidence when verification is incomplete

## Edge cases

- **Large mixed diff**: group the summary by feature or subsystem.
- **Docs-only change**: keep the summary short and omit technical risk inflation.
- **No tests run**: state that plainly instead of implying coverage.