#!/bin/bash
# This script should be sourced, not executed
# Usage: source ~/.claude/go-to-git-root.sh
cd "$(git rev-parse --show-toplevel)"