# Claude Code Configuration Collection

A curated collection of sub agents, custom slash commands, hooks, and settings for enhancing your Claude Code experience. This repository contains powerful configurations designed to supercharge your development workflow with Claude.

## Overview

This repository provides a comprehensive Claude Code setup that includes:
- **Sub Agents**: Specialized AI agents for code simplification, security auditing, performance optimization, and bug hunting
- **Custom Slash Commands**: Streamlined Git workflows and final audit procedures
- **Hooks**: macOS notifications for real-time feedback on Claude's actions
- **Settings**: Optimized permissions and configurations for common development tasks

## Features

### 🤖 Sub Agents

Sub agents are specialized AI assistants that Claude Code can delegate tasks to. Each operates in its own context window and can be configured with specific tools and behaviors.

#### Code Simplifier (`agents/code-simplifier.md`)
Refactors and optimizes existing code for simplicity, clarity, and maintainability. Excels at:
- Removing unnecessary complexity and over-engineering
- Eliminating dead code and duplication
- Simplifying verbose AI-generated code
- Making code more maintainable and easier to understand

#### Edge Case Bug Hunter (`agents/edge-case-bug-hunter.md`)
Thoroughly analyzes code for potential bugs, edge cases, and failure scenarios including:
- Reviewing newly written functions
- Analyzing complex state management logic
- Auditing error handling
- Performing comprehensive bug sweeps before deployment

#### Performance Optimizer (`agents/performance-optimizer.md`)
Analyzes code for performance bottlenecks and implements optimizations:
- Identifying algorithmic inefficiencies
- Database optimization opportunities
- Caching strategies
- Resource management improvements

#### Security Auditor (`agents/security-auditor.md`)
Performs comprehensive security analysis on web applications and APIs:
- Reviewing code for vulnerabilities
- Analyzing authentication/authorization implementations
- Assessing attack surfaces
- Evaluating data protection measures

### 📝 Custom Slash Commands

Custom slash commands allow you to define frequently-used prompts as Markdown files that Claude Code can execute.

#### Commit Command (`commands/commit.md`)
Intelligent Git commit workflow that:
- Analyzes diffs and stages changes
- Updates task documentation
- Creates meaningful commit messages
- Supports dry-run mode for testing

#### Final Audit (`commands/final-audit.md`)
Comprehensive project audit that checks:
- Code quality and consistency
- Test coverage
- Documentation completeness
- Security vulnerabilities

### 🔔 Hooks

#### macOS Notification Hook (`hooks/macos_notification.py`)
Provides real-time notifications for Claude's actions:
- Terminal command completions
- File modifications and creations
- Search operations
- Task completions

Requires `terminal-notifier`:
```bash
brew install terminal-notifier
```

### ⚙️ Settings

The `settings.json` file includes:
- **Permissions**: Pre-approved commands for common Git and file operations
- **Hook Configuration**: Integration points for the notification system
- **Status Line**: Custom status line showing model info, file counts, and context usage

## Installation

1. Clone this repository:
```bash
git clone https://github.com/yourusername/claude_config.git
cd claude_config
```

2. Copy configurations to your Claude directory:
```bash
# For user-level (available across all projects)
cp -r agents ~/.claude/agents/
cp -r commands ~/.claude/commands/
cp -r hooks ~/.claude/hooks/

# For project-level (specific to current project)
cp -r agents .claude/agents/
cp -r commands .claude/commands/

# Copy status line script
cp statusline-command.sh ~/.claude/

# Make scripts executable
chmod +x ~/.claude/hooks/macos_notification.py
chmod +x ~/.claude/statusline-command.sh
```

3. Merge settings with your existing Claude configuration:
```bash
# Back up your current settings
cp ~/.claude/settings.json ~/.claude/settings.json.backup

# Manually merge the settings or replace entirely
cp settings.json ~/.claude/settings.json
```

4. Install dependencies (ONLY NECESSARY FOR MAC OS NOTIFICATIONS)
```bash
# For macOS notifications
brew install terminal-notifier

# Python dependencies (if using uv)
uv pip install -r requirements.txt
```

## License

MIT License - See LICENSE file for details

## Support

For issues, questions, or suggestions, please open an issue on GitHub.

For Claude Code specific help:
- Documentation: https://docs.anthropic.com/en/docs/claude-code
- Built-in help: Use `/help` in Claude Code

---

**Note**: This configuration is designed for macOS. Windows and Linux users may need to modify hooks and certain settings for their platforms.