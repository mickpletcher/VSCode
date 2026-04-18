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

### [pr-summary](pr-summary)

Summarizes a pull request or diff into a reviewer-friendly overview with key changes, risks, and testing notes.

- Folder: [pr-summary](pr-summary)
- Skill file: [pr-summary/SKILL.md](pr-summary/SKILL.md)
- Docs: [pr-summary/README.md](pr-summary/README.md)

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

## Skillpack Script

The repository includes a packaging script at [scripts/skillpack.sh](scripts/skillpack.sh). It builds a distributable bundle under `dist/skillpack`, copies every top-level skill directory that contains a `SKILL.md`, includes the root README and license, writes a manifest, and creates a `dist/skillpack.tar.gz` archive.

Run it from the repository root with:

```bash
./scripts/skillpack.sh
```

Or provide a custom output directory:

```bash
./scripts/skillpack.sh /path/to/output/skillpack
```

Validate the repository without building an archive:

```bash
./scripts/skillpack.sh --validate
```

Generate a JSON manifest instead of the default text manifest:

```bash
./scripts/skillpack.sh --manifest=json
```

The JSON manifest includes bundle metadata and per-skill records with the skill name, description, packaged paths, archive path, and skill count.

## GitHub Actions

The repository now includes [/.github/workflows/build-skillpack.yml](.github/workflows/build-skillpack.yml). The workflow validates the catalog, builds the skillpack with a JSON manifest, uploads the bundle as a workflow artifact, and attaches the archive to published releases.

It runs on:

- pushes to `main`
- pull requests
- published releases
- manual workflow dispatch

The repository also includes [/.github/workflows/create-release-tag.yml](.github/workflows/create-release-tag.yml). That workflow can be run manually to create a semantic version tag and GitHub release from a target branch or commit. Publishing the release then triggers the build workflow, which attaches the generated skillpack archive.

## Next Additions

Natural future additions for this repository would be skills for changelog maintenance, repository bootstrap, issue triage, or repository release preparation.
