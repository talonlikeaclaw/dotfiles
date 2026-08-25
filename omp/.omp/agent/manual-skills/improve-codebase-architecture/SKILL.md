---
name: improve-codebase-architecture
description: Manually launch the architecture-deepening workflow.
hide: true
argument-hint: "[scope-or-goal]"
---

# Improve Codebase Architecture manual launcher

This workflow is manual-only. It explores a repository, produces an HTML report, and drives a refactoring decision; do not start it unless the user explicitly invokes `/skill:improve-codebase-architecture`.

After invocation, read and follow the canonical upstream skill:

```text
~/.omp/agent/skill-sources/mattpocock-skills/skills/engineering/improve-codebase-architecture/SKILL.md
```

OMP adaptation: when that workflow says to call the `codebase-design` Skill tool, read `skill://codebase-design-manual` before continuing. Use the user's argument as the initial scope or goal.
