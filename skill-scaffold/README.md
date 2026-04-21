# skill-scaffold

Creates a new GitHub Copilot skill folder with all required artifacts in the correct structure. Standardizes naming, frontmatter, documentation, and root index updates so every skill in the catalog is consistent.

---

## What it does

The skill packages the repetitive setup work involved in adding a new skill. Instead of manually creating files and trying to match the existing conventions, this skill produces a complete, valid, documented skill entry from a workflow idea.

Full sequence:

1. Identify the workflow the user wants to package as a skill.
2. Choose a concise kebab-case folder name and stable skill identity.
3. Create the top-level skill folder.
4. Generate `SKILL.md` with valid YAML frontmatter, a clear description with strong trigger phrases, the workflow steps, output expectations, and edge cases.
5. Generate `README.md` with a human-readable usage guide, trigger phrases, supported platforms, inputs, outputs, and limitations.
6. Update the root `README.md` to add the new skill to the catalog index with links to the folder, `SKILL.md`, `README.md`, and prompt file.

---

## Trigger phrases

Invoke this skill by asking Copilot to:

- add a new skill
- scaffold a Copilot skill
- create a skill folder
- bootstrap a skill
- document a skill folder
- expand the skill catalog

An optional argument can specify the skill name and purpose upfront.

---

## Supported platforms

| Platform | Support |
|---|---|
| VS Code | Full support via GitHub Copilot Chat |
| GitHub Copilot | Full support via prompt file invocation |
| Azure DevOps / Azure Repos | Full support. Produced skills work across all three platforms. |

---

## Inputs

- Workflow idea or skill name
- Optional: trigger phrases, known limitations, preferred category or tier

---

## Outputs

- `<skill-name>/` top-level folder
- `<skill-name>/SKILL.md` with valid YAML frontmatter and full workflow instructions
- `<skill-name>/README.md` with human-readable documentation
- Updated root `README.md` with a catalog entry and links

---

## What the generated SKILL.md must include

| Field | Requirement |
|---|---|
| `name` | Matches the folder name exactly |
| `version` | Semantic version starting at `1.0.0` |
| `description` | Contains the trigger phrases users are likely to type |
| `argument-hint` | Optional. Describes what the user can pass as an argument. |
| Body | Purpose, when to use, workflow steps, output expectations, edge cases |

---

## Edge cases

| Situation | Behavior |
|---|---|
| Unclear workflow scope | Asks whether the workflow should be a skill or general repo instructions before proceeding |
| Overlapping existing skill | Recommends narrowing the new skill or updating the existing one rather than creating a duplicate |
| Weak description field | Improves trigger phrases before treating the skill as complete |
| Missing root README update | Flags this as a blocking issue — no skill is complete without a catalog entry |

---

## Limitations

- Does not implement the skill logic. It creates the scaffold and structure. The workflow content in `SKILL.md` must be written by the user or another prompt.
- Does not move or restructure existing skill folders.
- Does not create skills that are vague or overlap significantly with existing ones without explicit user confirmation.
- The scaffold does not automatically satisfy spec requirements. For spec-driven skills, use the `/specify-skill` workflow instead and run `/skill-audit` to validate.

---

## Files

- [SKILL.md](SKILL.md) — machine-readable skill definition and workflow instructions
- [README.md](README.md) — this document

---

[Back to skill catalog](../README.md)
