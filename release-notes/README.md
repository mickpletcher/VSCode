# release-notes

Drafts release notes and changelog entries from real repository changes. Converts commit history, diffs, or version ranges into a concise, publishable summary that separates user-facing value from implementation detail.

---

## What it does

The skill collects the available change context, groups related work, and produces structured release notes that are accurate to the actual work completed. It does not invent features or fixes that are not supported by the source material.

Full sequence:

1. Identify the source of truth — tagged version range, commit history, merged diffs, or user-provided change list.
2. Group related changes before writing. Collapses individual commits into meaningful themes.
3. Separate what changed for users or maintainers from what changed internally.
4. Draft concise, scannable bullets with clear verbs.
5. Flag anything that may affect compatibility, configuration, rollout, or migration in a notes section.

---

## Trigger phrases

Invoke this skill by asking Copilot to:

- write release notes for this version
- summarize recent changes
- prepare a changelog entry
- update the changelog
- publish a release summary
- turn these commits into release notes

An optional argument can scope the notes to a specific version, date range, or feature area.

---

## Output format

Default output follows this structure:

```
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

Headings adjust when the project uses different categories, but the output stays scannable and avoids vague bullets.

---

## Supported platforms

| Platform | Support |
|---|---|
| VS Code | Full support via GitHub Copilot Chat |
| GitHub Copilot | Full support via prompt file invocation and GitHub release workflow |
| Azure DevOps / Azure Repos | Full support. Works with Azure Repos commit history and work item context. |

---

## Inputs

The skill uses the strongest available source in this order:

1. Tagged or known version range
2. Commit history for the relevant period
3. Staged or merged diffs
4. User-provided list of completed changes

---

## Outputs

- Structured release notes ready to publish to GitHub releases, a changelog file, or an internal update
- User-facing value grouped by impact, not by file or commit
- Explicit notes for compatibility, migration, or configuration changes

---

## Edge cases

| Situation | Behavior |
|---|---|
| Mixed unrelated work | Recommends splitting notes by feature set or release boundary |
| Sparse commit messages | Relies more heavily on the diff and notes uncertainty where present |
| Internal-only change set | Produces a maintainer-focused summary rather than user-facing release copy |
| Incomplete source material | States what is missing rather than filling gaps with assumptions |

---

## Limitations

- Does not claim features or fixes not supported by the diff or history.
- Cannot access closed issues or work items without user-provided context.
- Does not write marketing copy. Output is accurate and direct, not promotional.
- If the commit history is too sparse to reconstruct intent, the skill will say so and ask for clarification.

---

## Files

- [SKILL.md](SKILL.md) — machine-readable skill definition and workflow instructions
- [README.md](README.md) — this document

---

[Back to skill catalog](../README.md)
