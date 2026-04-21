# pr-summary

Turns a pull request diff or pending change set into a reviewer-friendly overview. Produces a structured summary with key changes, risks, and testing status grounded in the actual source material.

---

## What it does

The skill reads the strongest available change evidence, groups related work into meaningful themes, surfaces risks, and reports testing status. It focuses on behavioral impact rather than repeating raw file lists.

Full sequence:

1. Inspect the pull request diff, staged diff, branch diff, or commit history — whichever is the strongest available source.
2. Identify the main behavioral changes, refactors, documentation updates, and operational changes.
3. Group file-level changes into a small number of meaningful themes.
4. Surface migration concerns, backward compatibility risk, missing test coverage, or areas hard to verify.
5. Report testing status honestly — if tests were not run, say so directly.
6. Output a compact, structured summary ready to paste into a pull request description.

---

## Trigger phrases

Invoke this skill by asking Copilot to:

- write a PR summary
- draft a pull request description
- explain this change set for reviewers
- summarize this branch
- prepare reviewer notes from this diff
- generate PR context for a code review

An optional argument can scope the summary to a specific branch name or theme.

---

## Output format

Default output follows this structure:

```
## Summary
- ...

## Key changes
- ...

## Risks
- ...

## Testing
- ...
```

The skill adapts section headings if the repository has an established PR template, but keeps output compact and evidence-based.

---

## Supported platforms

| Platform | Support |
|---|---|
| VS Code | Full support via GitHub Copilot Chat |
| GitHub Copilot | Full support via prompt file invocation |
| Azure DevOps / Azure Repos | Full support. Works with Azure Repos pull requests and merge requests. |

---

## Inputs

The skill uses the strongest available source in this order:

1. Pull request diff
2. Staged or branch diff
3. Commit history for the branch
4. User-supplied implementation notes

---

## Outputs

- A structured pull request description ready to publish
- Key change themes grouped for reviewer clarity
- Explicit risk and testing notes
- Behavioral summary rather than a raw file list

---

## Edge cases

| Situation | Behavior |
|---|---|
| Large mixed diff | Groups summary by feature or subsystem rather than by file |
| Docs-only change | Keeps summary short, omits risk inflation |
| No tests run | States plainly that no tests were run — does not imply coverage |
| No diff available | Asks the user to provide source material before proceeding |

---

## Limitations

- Does not invent behavior that is not present in the diff or commit history.
- Cannot run tests or validate that described behavior is correct.
- Cannot access pull request comments or review threads. Summary is based on code changes only.
- If the diff is too large or the scope is mixed, the summary may recommend splitting the PR rather than summarizing the whole thing.

---

## Files

- [SKILL.md](SKILL.md) — machine-readable skill definition and workflow instructions
- [README.md](README.md) — this document

---

[Back to skill catalog](../README.md)
