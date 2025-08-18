#!/bin/bash

# API report generation script for PuckLog
# Used by Claude Code for generating reports via local API

# Default to localhost:8000 if no host specified
HOST=${1:-"localhost:8000"}

# Shift to get remaining arguments for the curl command
shift

# Execute curl with POST to /api/report endpoint
# Pass through all remaining arguments to curl
curl -X POST "http://${HOST}/api/report" "$@"