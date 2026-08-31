# Global agent instructions

These instructions apply to all agent work unless a more specific instruction overrides them.

## Markdown formatting

Do not hard-wrap prose in Markdown at a fixed column width. This rule applies to all Markdown content, including GitHub issues, pull request descriptions, and Markdown files of any kind. The only exception is when editing an existing Markdown file whose prose is already hard-wrapped at a fixed width; in that case, preserve the file's existing wrapping style.

## Git worktrees

When creating a Git worktree, prefer placing it under the current repository's `.wt/` directory. Do not create worktrees in `/tmp`.

## Sub-agent model selection

When starting a sub-agent, use the same model tier and reasoning effort as the current agent. Do not independently choose a higher or lower model tier or reasoning effort. You must get explicit user confirmation before changing either setting, including when a task is simple enough that lowering both settings would be sufficient.

## Git commit messages

Focus commit messages on what changed and why, rather than how the change was implemented. Avoid chronological or step-by-step accounts. Include critical decisions and tradeoffs when they help explain the change, but omit obvious decisions.

Wrap commit messages at 72 characters. For multi-line commit messages, prefer committing from standard input with a heredoc:

```sh
git commit -F - <<'EOF'
feat: add user profile endpoint

<commit body>
EOF
```
