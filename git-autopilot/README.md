# git-autopilot

This repository contains a VS Code Copilot skill that automates the standard git commit workflow inside chat-driven sessions.

## What the skill does

The skill defined in `SKILL.md` is named `git-commit-sync`. It is designed to handle the full sequence involved in saving and syncing work to a Git remote:

- inspects staged, unstaged, and untracked changes
- reviews the diff to understand what changed
- stages files when needed
- generates a Conventional Commits message
- asks for confirmation before committing
- creates the commit
- pushes the commit to the tracked remote branch

In short, it turns a request like "commit my changes" or "push this to GitHub" into a structured git workflow instead of a single blind command.

## When to use it

According to the skill description, this skill should be used when the user asks to:

- commit changes
- generate or rewrite a commit message
- push, sync, or publish changes to GitHub
- stage and commit specific files or folders

It also accepts an optional argument hint so the user can narrow the action to specific files or directories.

## Commit message behavior

The skill standardizes commit messages using the Conventional Commits format:

```text
type(scope): short description

[optional body]
```

It supports common commit types such as `feat`, `fix`, `docs`, `refactor`, `perf`, `test`, `chore`, `ci`, and `style`.

The guidance in the skill emphasizes that commit messages should:

- describe the behavior change, not just the files touched
- stay concise and imperative
- use a scope when it improves clarity
- include a body only when extra reviewer context is needed

## Workflow encoded in the skill

The skill documents a step-by-step process:

1. Check repository state with `git status`.
2. Review staged or unstaged diffs.
3. Stage either all changes or only user-specified files.
4. Generate a Conventional Commits message from the actual diff.
5. Present the proposed message for user confirmation.
6. Run `git commit`.
7. Run `git push`.

This makes the skill useful as an operational guide as well as an automation prompt.

## Safety and edge cases

The skill is not just a happy-path script. It also defines how to respond when:

- there is nothing to commit
- merge conflicts are present
- the repository is in a detached `HEAD` state
- the branch has no upstream configured
- the push is rejected because the remote has newer changes
- the working tree contains too many unrelated changes for a single clean commit

That means the skill is intended to behave conservatively and report blockers instead of forcing through unsafe git operations.

## Files

- [SKILL.md](SKILL.md) — machine-readable instruction file Copilot uses to trigger and run this workflow
- [README.md](README.md) — this document

---

[Back to skill catalog](../README.md)
