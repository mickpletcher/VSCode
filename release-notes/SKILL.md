---
name: release-notes
description: Drafts release notes or changelog entries from git history, staged diffs, or completed work items. Use this when asked to write release notes, summarize a release, prepare a changelog entry, or turn recent changes into a publishable update summary.
argument-hint: [optional: version, date range, or scope]
---

# Release Notes

This skill turns recent repository work into release notes that are readable by humans and grounded in actual changes.

## When to use this skill

Use this skill when the user asks to:
- write release notes for a version or milestone
- summarize recent changes for GitHub or internal distribution
- prepare a changelog entry before publishing
- convert commit history or diffs into a structured update summary

## Inputs to review

Prefer the strongest available source of truth:

1. tagged or known version range
2. commit history for the relevant period
3. staged or merged diffs
4. user-provided list of completed changes

If the source material is incomplete or ambiguous, say so explicitly instead of inventing details.

## Output structure

Default to a concise, publishable structure:

```text
# Release notes

## Highlights
- ...

## Improvements
- ...

## Fixes
- ...

## Notes
- ...
```

Adjust the headings when the project needs different categories, but keep the content scannable.

## Workflow

### Step 1 - Gather change context

Inspect commits, diffs, pull request summaries, or staged changes. Group related changes before writing.

### Step 2 - Separate user-facing value from implementation detail

Describe what changed for users or maintainers, not just what files moved. Keep internal refactors out of the highlights unless they matter operationally.

### Step 3 - Draft the summary

Write concise bullets with clear verbs. Prefer statements such as:

- added a reusable skill scaffold for future catalog growth
- improved the repository landing page for GitHub visitors

Avoid vague bullets such as:

- updated files
- made changes

### Step 4 - Flag unknowns

If a change might affect compatibility, rollout, migration, or configuration, call that out in a notes section.

## Authoring rules

- do not claim features or fixes that are not supported by the diff or history
- prefer user-facing impact over implementation jargon
- keep bullets parallel and concise
- avoid repeating commit messages verbatim when they are too technical

## Edge cases

- **Mixed unrelated work**: recommend splitting release notes by feature set or release boundary.
- **Sparse commit messages**: rely more heavily on the diff and mention uncertainty where needed.
- **Internal-only change set**: produce a maintainer-focused summary instead of pretending it is a user feature release.