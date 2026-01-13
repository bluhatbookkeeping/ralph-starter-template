#!/bin/bash

# Ralph - Autonomous AI Development Loop
# Runs Claude Code repeatedly until all PRD stories are complete

set -e

PROJECT_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
PRD_FILE="$PROJECT_ROOT/prd.json"
PROMPT_FILE="$PROJECT_ROOT/scripts/ralph/prompt.md"
PROGRESS_FILE="$PROJECT_ROOT/progress.txt"

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}  Ralph - Autonomous Development Loop  ${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""

# Check required files exist
if [ ! -f "$PRD_FILE" ]; then
    echo -e "${RED}Error: prd.json not found at $PRD_FILE${NC}"
    exit 1
fi

if [ ! -f "$PROMPT_FILE" ]; then
    echo -e "${RED}Error: prompt.md not found at $PROMPT_FILE${NC}"
    exit 1
fi

# Initialize progress file if it doesn't exist
if [ ! -f "$PROGRESS_FILE" ]; then
    echo "# Development Progress Log" > "$PROGRESS_FILE"
    echo "# This file tracks learnings across Claude sessions" >> "$PROGRESS_FILE"
    echo "" >> "$PROGRESS_FILE"
fi

iteration=0
max_iterations=${MAX_ITERATIONS:-100}  # Safety limit

while [ $iteration -lt $max_iterations ]; do
    iteration=$((iteration + 1))

    echo -e "${YELLOW}--- Iteration $iteration ---${NC}"

    # Count incomplete stories
    incomplete=$(jq '[.stories[] | select(.passes == false)] | length' "$PRD_FILE")
    total=$(jq '.stories | length' "$PRD_FILE")
    complete=$((total - incomplete))

    echo "Progress: $complete/$total stories complete"

    # Check if all stories are done
    if [ "$incomplete" -eq 0 ]; then
        echo -e "${GREEN}========================================${NC}"
        echo -e "${GREEN}  ALL STORIES COMPLETE!  ${NC}"
        echo -e "${GREEN}========================================${NC}"
        exit 0
    fi

    # Get next story to work on
    next_story=$(jq -r '[.stories[] | select(.passes == false)][0].id' "$PRD_FILE")
    next_title=$(jq -r '[.stories[] | select(.passes == false)][0].title' "$PRD_FILE")

    echo -e "Next story: ${YELLOW}$next_story${NC} - $next_title"
    echo ""

    # Run Claude with the prompt
    echo "Starting Claude Code session..."

    cd "$PROJECT_ROOT"

    # Run Claude with the ralph prompt
    if claude --print --dangerously-skip-permissions -p "$(cat "$PROMPT_FILE")"; then
        echo -e "${GREEN}Claude session completed successfully${NC}"
    else
        echo -e "${RED}Claude session exited with error${NC}"
        echo "Pausing for 10 seconds before retry..."
        sleep 10
    fi

    # Brief pause between iterations
    echo ""
    echo "Waiting 5 seconds before next iteration..."
    sleep 5

done

echo -e "${RED}Reached maximum iterations ($max_iterations). Stopping.${NC}"
exit 1
