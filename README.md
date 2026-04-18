# VS Code Copilot Skills

A small catalog of reusable GitHub Copilot skills for VS Code. Each skill in this repository packages a repeatable workflow as:

- a machine-readable [SKILL.md](git-autopilot/SKILL.md)
- a human-readable local README
- a top-level folder that can be browsed directly from GitHub

The goal is straightforward: keep useful workflows packaged, documented, and easy to extend.

## Skill Catalog

### [git-autopilot](git-autopilot)

Automates the path from git status to commit and push, with Conventional Commits guidance and guardrails for common git problems.

- Folder: [git-autopilot](git-autopilot)
- Skill file: [git-autopilot/SKILL.md](git-autopilot/SKILL.md)
- Docs: [git-autopilot/README.md](git-autopilot/README.md)

### [skill-scaffold](skill-scaffold)

Creates new skill folders with valid frontmatter, supporting documentation, and an updated root index entry so the repository can scale cleanly.

- Folder: [skill-scaffold](skill-scaffold)
- Skill file: [skill-scaffold/SKILL.md](skill-scaffold/SKILL.md)
- Docs: [skill-scaffold/README.md](skill-scaffold/README.md)

### [release-notes](release-notes)

Drafts release notes and changelog entries from real repository changes so updates are publishable, concise, and tied to actual work.

- Folder: [release-notes](release-notes)
- Skill file: [release-notes/SKILL.md](release-notes/SKILL.md)
- Docs: [release-notes/README.md](release-notes/README.md)

## Repository Structure

- each skill lives in its own top-level directory
- each skill directory should contain a `SKILL.md`
- each skill directory should contain a `README.md`
- the root README acts as the public catalog and should be updated when new skills are added

## Design Rules

- keep each skill focused on one repeatable workflow
- use strong trigger phrases in each `description` field
- write supporting READMEs for humans, not just Copilot
- prefer procedural instructions and explicit edge cases over vague guidance

## Next Additions

Natural future additions for this repository would be skills for changelog maintenance, repository bootstrap, issue triage, or pull request summarization.
