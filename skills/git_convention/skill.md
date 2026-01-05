---
name: git-convention
description: Enforce git commit message conventions. This skill MUST be invoked whenever you perform a git commit or generate commit messages.
---

# Git Commit Message Convention

Follow these rules when generating git commit messages.

## Format

All commit messages must be in English and follow this format:

1.  **Header**: The first line should contain the change type (feat/fix/chore/build/ci...) and a summary.
2.  **Body**: The second line must be empty.
3.  **Details**: Subsequent lines should use a numbered list to describe specific changes.

## Example

```
feat: add new feature for display control

1. Add DisplayController class
2. Update configuration parsing logic
3. Add unit tests for new functionality
```

## Command Line Usage

When performing the commit via command line, you MUST use a single `-m` flag with an open quote to create a multi-line message. Press `Enter` to create new lines (including the required empty line after the header) and close the quote at the end.

```bash
git commit -m "feat: add new feature for display control

1. Add DisplayController class
2. Update configuration parsing logic"
```

## When to Use

- When the user asks to commit changes.
- When generating a commit message for a pull request or commit.

## Constraints

- **DO NOT** execute `git push` automatically after committing. Wait for explicit user instruction to push.
