---
name: superpowers
description: Full Superpowers development workflow. Manually invoke with `/skill:superpowers <workflow> [context]`.
hide: true
argument-hint: "<workflow> [context]"
---

# Superpowers manual dispatcher

This skill is deliberately manual-only. The full Superpowers suite is workflow-heavy and must not alter an ordinary agent task unless the user explicitly invokes `/skill:superpowers`.

After invocation, select the requested workflow, then read its canonical instructions before acting:

- `brainstorming`
- `dispatching-parallel-agents`
- `executing-plans`
- `finishing-a-development-branch`
- `receiving-code-review`
- `requesting-code-review`
- `subagent-driven-development`
- `systematic-debugging`
- `test-driven-development`
- `using-git-worktrees`
- `using-superpowers`
- `verification-before-completion`
- `writing-plans`
- `writing-skills`

Read the selected workflow at:

```text
skill://superpowers/reference/skills/<workflow>/SKILL.md
```

For a broad request such as `full workflow`, read `using-superpowers` first, then follow its routing instructions. Do not load unrelated workflow files. If the argument does not name a workflow, ask the user which one to apply.
