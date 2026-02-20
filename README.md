# agent-skills

Personal collection of `SKILL.md`.

## Sync scripts and `INSTALL.md` automation

`scripts/sync-to-claude.sh` and `scripts/sync-to-codex.sh` both:

1. Sync every directory under `skills/` into the target local skills directory.
2. Discover every `skills/*/INSTALL.md` file in this repo.
3. Invoke the matching coding-agent CLI with a prompt that points to each `INSTALL.md` so the agent can execute installation steps.

Defaults:

- Claude sync target: `${HOME}/.claude/skills` (override with `CLAUDE_SKILLS_DIR`)
- Codex sync target: `${HOME}/.codex/skills` (override with `CODEX_SKILLS_DIR`)
- Claude CLI command: `claude -p` (override with `CLAUDE_CLI_BIN` and `CLAUDE_CLI_PROMPT_FLAG`)
- Codex CLI command: `codex exec` (override with `CODEX_CLI_BIN` and `CODEX_CLI_SUBCOMMAND`)
