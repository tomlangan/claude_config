#!/bin/bash

# Read JSON input from stdin
input=$(cat)

# Extract model display name and transcript path
model_name=$(echo "$input" | jq -r '.model.display_name')
transcript_path=$(echo "$input" | jq -r '.transcript_path')

# Get current working directory from JSON
cwd=$(echo "$input" | jq -r '.workspace.current_dir')

# Change to the working directory to check git status
cd "$cwd" 2>/dev/null || cd "$(pwd)"

# Count unstaged and untracked files
unstaged_count=0
if git rev-parse --git-dir > /dev/null 2>&1; then
    # Count unstaged files (modified, deleted, but not added to index)
    unstaged=$(git diff --name-only | wc -l | tr -d ' ')
    # Count untracked files
    untracked=$(git ls-files --others --exclude-standard | wc -l | tr -d ' ')
    unstaged_count=$((unstaged + untracked))
fi

# Estimate context usage from transcript
context_info="N/A"
context_color="128;128;128"  # Gray for unknown

if [[ -f "$transcript_path" && -r "$transcript_path" ]]; then
    # Get rough character count from transcript
    char_count=$(wc -c < "$transcript_path" 2>/dev/null || echo "0")
    
    # Estimate tokens (rough approximation: ~4 characters per token)
    estimated_tokens=$((char_count / 4))
    
    # Model-specific context limits (approximate)
    case "$model_name" in
        *"Sonnet"*|*"sonnet"*)
            max_tokens=200000
            ;;
        *"Haiku"*|*"haiku"*)
            max_tokens=200000
            ;;
        *"Opus"*|*"opus"*)
            max_tokens=200000
            ;;
        *)
            max_tokens=200000  # Default assumption
            ;;
    esac
    
    # Calculate remaining tokens
    remaining_tokens=$((max_tokens - estimated_tokens))
    
    # Format remaining tokens (K for thousands)
    if [[ $remaining_tokens -gt 1000 ]]; then
        remaining_k=$((remaining_tokens / 1000))
        context_info="${remaining_k}K"
    else
        context_info="$remaining_tokens"
    fi
    
    # Color based on remaining context (Red < 20K, Yellow < 50K, Green >= 50K)
    if [[ $remaining_tokens -lt 20000 ]]; then
        context_color="255;0;0"    # Red - low context
    elif [[ $remaining_tokens -lt 50000 ]]; then
        context_color="255;255;0"  # Yellow - medium context
    else
        context_color="34;139;34"  # Forest Green - plenty of context (softer)
    fi
fi

# Format output with colors using printf
# Orange for model name (RGB: 255,165,0)
# Forest Green for file count (RGB: 34,139,34) - softer green
# Dynamic color for context remaining
printf "\033[38;2;255;165;0m%s\033[0m | \033[38;2;34;139;34m%d files\033[0m | \033[38;2;%sm~%s left\033[0m" "$model_name" "$unstaged_count" "$context_color" "$context_info"