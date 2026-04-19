# skill-scaffold

This folder contains a GitHub Copilot skill for creating additional skill folders in this repository.

## What the skill does

The skill defined in `SKILL.md` is named `skill-scaffold`. It packages the repetitive work involved in adding a new skill to a skill-catalog repository.

Its intended output is a complete, documented skill entry that includes:

- a new top-level folder
- a valid `SKILL.md`
- explicit per-skill version metadata in frontmatter
- a human-readable `README.md`
- an update to the root repository `README.md`

## When to use it

Use this skill when the user wants to:

- add another Copilot skill
- scaffold a skill from a workflow idea
- document a newly created skill
- keep the repository index in sync with new skill folders

## Why it is useful

Without a scaffold, new skills are easy to add inconsistently. This skill standardizes naming, frontmatter, documentation, and root-index updates so the repository stays coherent as it grows.

## What it emphasizes

The skill focuses on four things:

- discoverable descriptions in `SKILL.md`
- stable per-skill version metadata
- narrow, reusable workflow scope
- plain-language documentation for humans
- keeping the root README updated with links

## Files

- [SKILL.md](SKILL.md) — machine-readable instruction file Copilot uses to trigger and run this workflow
- [README.md](README.md) — this document

---

[Back to skill catalog](../README.md)
