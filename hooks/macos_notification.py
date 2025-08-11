#!/usr/bin/env python3

import subprocess
import sys
import json
import time
import os

def send_notification(title, message, sound="Funk"):
    """Send a macOS notification using terminal-notifier"""
    try:
        # Create unique group ID using timestamp to prevent suppression
        group_id = f"claude-code-{int(time.time())}"
        
        cmd = ['terminal-notifier', 
               '-title', title, 
               '-message', message,
               '-group', group_id,
               '-sound', sound]
        
        print(f"DEBUG: Running terminal-notifier with group {group_id}", file=sys.stderr)
        result = subprocess.run(cmd, check=True, capture_output=True, text=True)
        print(f"DEBUG: Notification sent successfully", file=sys.stderr)
    except subprocess.CalledProcessError as e:
        print(f"Failed to send notification: {e}", file=sys.stderr)
        print(f"Make sure terminal-notifier is installed: brew install terminal-notifier", file=sys.stderr)
    except Exception as e:
        print(f"Error sending notification: {e}", file=sys.stderr)

def main():
    input_data = json.load(sys.stdin)
    tool_name = input_data.get("tool_name")
    cwd = input_data.get("cwd", "")
    
    # Extract project name from the working directory path
    project_name = os.path.basename(cwd) if cwd else "Unknown Project"
    
    # Create notification title and message based on tool name
    if tool_name == 'Bash':
        title = f"[{project_name}] Command Executed"
        message = "Terminal command completed"
    elif tool_name == 'Edit':
        title = f"[{project_name}] File Modified"
        message = "File has been edited"
    elif tool_name == 'Write':
        title = f"[{project_name}] File Created"
        message = "New file has been written"
    elif tool_name == 'Read':
        title = f"[{project_name}] File Accessed"
        message = "File has been read"
    elif tool_name == 'Grep':
        title = f"[{project_name}] Search Complete"
        message = "Text search finished"
    elif tool_name == 'Glob':
        title = f"[{project_name}] Pattern Match"
        message = "File pattern search completed"
    elif tool_name == 'WebFetch':
        title = f"[{project_name}] Web Request"
        message = "Web content fetched"
    elif tool_name == 'Task':
        title = f"[{project_name}] Task Complete"
        message = "Background task finished"
    else:
        title = f"[{project_name}] Claude Code Complete"
        message = "Operation finished"
    
    send_notification(title, message)

if __name__ == "__main__":
    main()