# VS Code Copilot Skills

This repository is a small collection of custom GitHub Copilot skill folders for use in VS Code. Each skill lives in its own subdirectory and includes a `SKILL.md` file that defines the machine-readable behavior Copilot uses, plus supporting documentation for humans.

## Repository layout

- skill folders live at the top level of the repository
- each skill folder contains its own `SKILL.md`
- some skill folders also include a local `README.md` with a plain-language explanation of what the skill does

## Available skills

### [git-autopilot](git-autopilot)

Automates a structured git commit workflow inside VS Code chat sessions. The skill analyzes repository changes, generates a Conventional Commits message, stages files when needed, asks for confirmation, then commits and pushes.

Links:

- Skill folder: [git-autopilot](git-autopilot)
- Skill definition: [git-autopilot/SKILL.md](git-autopilot/SKILL.md)
- Documentation: [git-autopilot/README.md](git-autopilot/README.md)

## What these skills are for

These folders are intended to make repeated development workflows easier to invoke through Copilot. Instead of rewriting instructions each time, a skill packages:

- when the workflow should be used
- how the workflow should be executed
- any formatting or behavioral rules it should follow
- edge cases and safety checks it should handle

## Adding more skills

To expand this repository, add another top-level folder with at least a `SKILL.md` file. If the skill needs human-facing documentation, add a `README.md` alongside it and link that folder from this root README.
