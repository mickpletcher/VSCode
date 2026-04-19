# scripts

This folder contains build and packaging utilities for the VS Code Copilot Skills repository.

## skillpack.sh

The primary script in this directory. It packages every skill in the repository into a distributable archive.

### What it does

- validates that each top-level skill folder contains a `SKILL.md`
- copies qualifying skill directories into a staging area under `dist/skillpack`
- includes the root `README.md` and `LICENSE`
- writes a manifest file listing packaged contents, versions, and SHA-256 hashes
- produces a `dist/skillpack.tar.gz` archive

### Usage

Run from the repository root:

```bash
./scripts/skillpack.sh
```

Write to a custom output directory:

```bash
./scripts/skillpack.sh /path/to/output/skillpack
```

Validate skill folders without building an archive:

```bash
./scripts/skillpack.sh --validate
```

Generate a JSON manifest instead of the default text manifest:

```bash
./scripts/skillpack.sh --manifest=json
```

### Manifest output

The JSON manifest includes:

- bundle metadata (name, build timestamp)
- SHA-256 hashes for top-level packaged files
- per-skill records with name, version, description, packaged paths, and file hashes

### CI integration

This script is called by the GitHub Actions workflow at `.github/workflows/build-skillpack.yml`. The workflow runs validation and packaging on every push to `main`, on pull requests, and on published releases. The resulting archive is uploaded as a workflow artifact and attached to releases.
