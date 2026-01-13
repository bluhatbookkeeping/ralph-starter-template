#!/bin/bash
# Ralph Starter - Session Setup Script

echo "🔧 Installing Claude Code..."
npm install -g @anthropic-ai/claude-code

echo ""
echo "✅ Claude Code installed!"
echo ""
echo "Starting Claude with project context..."
echo ""

claude -p "Read CLAUDE.md to understand the project. Read prd.json for story status. Read progress.txt for recent learnings. Read scripts/ralph/ideate.md so you know how to brainstorm when asked. Tell me the next incomplete story and ask what I'd like to work on. If I say 'ideate' or 'brainstorm', use the ideation framework."
