# git-autopilot

Automates the full git commit and push workflow inside GitHub Copilot Chat. Takes the working tree from its current state to a clean commit on the remote without requiring manual git commands.

---

## What it does

The skill inspects the repository state, reads the actual diff, generates a Conventional Commits message, presents it for confirmation, then stages, commits, and pushes. Every step is gated — it does not commit without confirmation and does not force through unsafe git operations.

Full sequence:

1. Run `git status` to identify staged, modified, and untracked files.
2. Run `git diff --staged` (or `git diff` if nothing is staged) to read what changed.
3. Stage files — either all changes or only the files the user specified.
4. Generate a Conventional Commits message derived from the actual diff content.
5. Present the proposed message for confirmation before committing.
6. Run `git commit`.
7. Resolve the target branch from user input, argument, or tracked upstream.
8. Run `git push` to the resolved target branch.

---

## Trigger phrases

Invoke this skill by asking Copilot to:

- commit my changes
- save my work
- generate a commit message
- push to GitHub / push to origin
- push to feature/my-branch
- push to a different branch
- sync with remote
- stage and commit these files
- publish my changes

The skill also accepts an optional argument to narrow the scope to specific files or folders, or to target a specific branch.

---

## Commit message format

All messages follow the Conventional Commits standard:

```
type(scope): short description

[optional body]
```

Supported types: `feat`, `fix`, `docs`, `refactor`, `perf`, `test`, `chore`, `ci`, `style`

Rules:
- Lowercase, no period, 72 characters or less
- Imperative mood ("add feature" not "added feature")
- Scope is the affected module or component — omit if the change is broad
- Body only when the change is non-obvious or has side effects reviewers need

---

## Supported platforms

| Platform | Support |
|---|---|
| VS Code | Full support via GitHub Copilot Chat |
| GitHub Copilot | Full support via prompt file invocation |
| Azure DevOps / Azure Repos | Full support. Works with any git remote. |

---

## Inputs

- Current working tree state (read automatically via `git status` and `git diff`)
- Optional: specific files or folders to stage
- Optional: target branch name to push to (defaults to tracked upstream)

---

## Outputs

- A staged, committed, and pushed change set on the resolved target branch
- A Conventional Commits message grounded in the actual diff
- Confirmation prompt before the commit runs
- Clear report of the branch pushed to

---

## Edge cases

| Situation | Behavior |
|---|---|
| Nothing to commit | Reports clean state and exits without committing |
| Merge conflicts present | Stops immediately and tells the user to resolve conflicts first |
| Detached HEAD | Warns the user and does not commit until on a named branch |
| No upstream set | Runs `git push --set-upstream origin <branch>` |
| Push rejected | Reports the rejection and recommends `git pull --rebase`. Does not force push. |
| Too many unrelated changes | Flags this and recommends splitting into focused commits |
| Target branch does not exist | Confirms with the user before creating the remote branch |
| Target branch diverged | Reports divergence and does not force push. Recommends pull or rebase. |
| Push rejected by branch protection | Reports the rejection and defers to the user |

---

## Limitations

- Does not force push under any circumstances.
- Does not resolve merge conflicts. Stops and defers to the user.
- Cannot operate in a detached HEAD state. Requires a named branch.
- Does not sign commits (`--gpg-sign`). If signing is required, the user must configure it separately.
- Cannot bypass branch protection rules. If the target branch is protected, the push will be rejected and the user must resolve it through the platform UI or admin settings.

---

## Files

- [SKILL.md](SKILL.md) — machine-readable skill definition and workflow instructions
- [README.md](README.md) — this document

---

[Back to skill catalog](../README.md)
