#!/bin/bash

# Find todo-related markdown files in current directory and subdirectories
# Used by Claude Code for task management file discovery

# Get the project root (where we should search from)
PROJECT_ROOT=$(git rev-parse --show-toplevel 2>/dev/null || pwd)

# Change to project root and find todo files
cd "$PROJECT_ROOT" && find . -maxdepth 3 -iregex '.*\(todo\|to-do\|backlog\|completed\)\.md' | sort || true