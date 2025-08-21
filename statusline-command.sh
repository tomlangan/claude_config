#!/bin/bash

# Read JSON input from stdin
input=$(cat)

# Extract model display name
model_name=$(echo "$input" | jq -r '.model.display_name')

# Get current working directory from JSON
cwd=$(echo "$input" | jq -r '.workspace.current_dir')

# Get just the folder name for display
folder_name=$(basename "$cwd")

# Change to the working directory to check git status
cd "$cwd" 2>/dev/null || cd "$(pwd)"

# Initialize git file counts
new_files=0
modified_files=0
deleted_files=0
untracked_files=0

if git rev-parse --git-dir > /dev/null 2>&1; then
    # Get git status in porcelain format for precise parsing
    git_status=$(git status --porcelain 2>/dev/null)
    
    # Count different types of changes
    while IFS= read -r line; do
        if [[ -n "$line" ]]; then
            # First character is staged status, second is unstaged status
            staged_status="${line:0:1}"
            unstaged_status="${line:1:1}"
            
            # Count based on status codes
            case "$staged_status$unstaged_status" in
                "A "*|"AM") new_files=$((new_files + 1)) ;;        # Added (new)
                "M "*|"MM"|" M") modified_files=$((modified_files + 1)) ;; # Modified
                "D "*|" D") deleted_files=$((deleted_files + 1)) ;;  # Deleted
                "??") untracked_files=$((untracked_files + 1)) ;;   # Untracked
                "R "*|"RM") modified_files=$((modified_files + 1)) ;; # Renamed (count as modified)
                "C "*|"CM") modified_files=$((modified_files + 1)) ;; # Copied (count as modified)
            esac
        fi
    done <<< "$git_status"
fi

# Build git status string
git_parts=()
if [[ $new_files -gt 0 ]]; then
    git_parts+=("${new_files}N")
fi
if [[ $modified_files -gt 0 ]]; then
    git_parts+=("${modified_files}M")
fi
if [[ $deleted_files -gt 0 ]]; then
    git_parts+=("${deleted_files}D")
fi
if [[ $untracked_files -gt 0 ]]; then
    git_parts+=("${untracked_files}U")
fi

# Join git parts with spaces, or show "clean" if no changes
if [[ ${#git_parts[@]} -eq 0 ]]; then
    git_info="clean"
else
    git_info=$(IFS=' '; echo "${git_parts[*]}")
fi

# Get transcript path for context window calculation
transcript_path=$(echo "$input" | jq -r '.transcript_path')
context_percentage="?"

# Calculate context window percentage if transcript exists
if [[ -f "$transcript_path" ]]; then
    # Get file size in bytes
    file_size=$(stat -f%z "$transcript_path" 2>/dev/null || stat -c%s "$transcript_path" 2>/dev/null || echo "0")
    
    # Estimate context window usage (rough approximation: 200k chars = ~160k tokens = ~80% of 200k context)
    # Using conservative estimate: 1 char ≈ 0.8 tokens, 200k context window
    if [[ $file_size -gt 0 ]]; then
        # Convert bytes to approximate tokens, then to percentage of 200k context window
        estimated_tokens=$((file_size * 80 / 100))  # rough chars to tokens conversion
        context_percentage=$((estimated_tokens * 100 / 200000))  # percentage of 200k context
        if [[ $context_percentage -gt 100 ]]; then
            context_percentage=100
        fi
    else
        context_percentage=0
    fi
fi

# Format output with muted colors similar to the screenshot style
# Using color 103 (muted purple-gray) as shown in the screenshot
printf "\x1b[38;5;103m> %s | %s | %s | %s%% ctx\x1b[0m" "$model_name" "$folder_name" "$git_info" "$context_percentage"