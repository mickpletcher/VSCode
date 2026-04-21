# context-builder

## Problem Statement

Skill output quality drops when execution starts without enough workspace context, references, or recent change history.

## Intended Workflow

1. Gather open files and likely related files.
2. Resolve imports and references.
3. Include relevant recent git changes.
4. Attach current errors or logs when available.

## Supported Platforms

- VS Code
- GitHub Copilot
- Azure DevOps / Azure Repos

## Expected Shortcut

`/context-builder`

## High-Level Behavior

This skill acts as a context enrichment layer that builds a compact, reusable context packet for downstream planning, coding, testing, and debugging workflows.
