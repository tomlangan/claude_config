# Claude Navigation Policy

## Git Root Navigation

**NEVER use**: `cd "$(git rev-parse --show-toplevel)"`

**ALWAYS use**: `~/.claude/go-to-git-root.sh`

This policy ensures:
- Consistent navigation behavior across all Claude sessions
- Avoids permission issues that may arise with direct git commands
- Provides a controlled, tested navigation method

## Implementation

When Claude needs to navigate to git root:
1. Use `~/.claude/go-to-git-root.sh` 
2. This script handles the navigation safely and consistently
3. No permission prompts required for this approved tool

## Enforcement

This policy is:
- Documented in project CLAUDE.md files
- Enforced through Claude's tool approval system
- Applied automatically without user confirmation needed