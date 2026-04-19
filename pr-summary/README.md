# pr-summary

This folder contains a GitHub Copilot skill for turning a diff or pull request into a reviewer-friendly summary.

## What the skill does

The `pr-summary` skill reads a pull request diff, branch diff, staged changes, or commit history and turns that material into a compact explanation of what changed, what matters, and what reviewers should pay attention to.

It is designed to help produce:

- pull request descriptions
- review summaries
- change overviews
- testing and risk notes

## When to use it

Use this skill when you need to:

- prepare a pull request description from code changes
- summarize a branch before opening a PR
- explain a diff to reviewers in plain language
- produce testing and risk notes alongside a change set

## Why it is useful

Good PR summaries reduce review time and make intent legible. This skill focuses on behavior, risk, and verification status instead of repeating raw file changes.

## Files

- [SKILL.md](SKILL.md) — machine-readable instruction file Copilot uses to trigger and run this workflow
- [README.md](README.md) — this document

---

[Back to skill catalog](../README.md)
