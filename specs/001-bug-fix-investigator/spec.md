# bug-fix-investigator

## Problem Statement

Diagnosing bugs is inconsistent and often starts without enough context, causing slow root cause analysis and risky fixes.

## Intended Workflow

1. Collect error details or failing behavior.
2. Identify likely source files and related code paths.
3. Form likely root cause hypotheses.
4. Propose a minimal fix and validation steps.

## Supported Platforms

- VS Code
- GitHub Copilot
- Azure DevOps / Azure Repos

## Expected Shortcut

`/bug-fix-investigator`

## High-Level Behavior

This skill provides a repeatable debugging flow from symptom to probable root cause, then proposes a minimal corrective change with regression-aware validation guidance.
