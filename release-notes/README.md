# release-notes

This folder contains a GitHub Copilot skill for drafting release notes and changelog entries from real repository changes.

## What the skill does

The `release-notes` skill collects change context from commits, diffs, version ranges, or user-provided summaries and turns that material into a concise release summary.

Its goal is to produce notes that are:

- accurate to the actual work completed
- easy to scan
- suitable for GitHub releases, changelogs, or internal updates

## When to use it

Use this skill when you need to:

- write release notes for a version or milestone
- summarize recent work for a project update
- convert technical changes into publishable release copy
- draft a changelog entry from commit history or diffs

## What makes it useful

Release notes often fail for one of two reasons: they are too vague to help users, or they are too technical to communicate value. This skill is designed to keep the output grounded in actual source changes while still reading like something you would publish.

## Why this README exists

`SKILL.md` is the machine-readable instruction set used by Copilot. This README explains the same skill in plain language for people browsing the repository.