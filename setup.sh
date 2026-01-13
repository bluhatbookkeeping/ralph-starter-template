cat > setup.sh << 'EOF'
#!/bin/bash
# Service Voice - Session Setup Script

echo "🔧 Installing Claude Code..."
npm install -g @anthropic-ai/claude-code

echo ""
echo "✅ Claude Code installed!"
echo ""

# Check for API key
if [ -z "$ANTHROPIC_API_KEY" ]; then
    echo "⚠️  No ANTHROPIC_API_KEY found in environment."
    echo "   Either:"
    echo "   1. Add it to Replit Secrets (recommended), or"
    echo "   2. Run: claude /login"
    echo ""
    exit 1
fi

echo "🔑 API key found. Starting Claude with project context..."
echo ""

claude --resume -p "Read CLAUDE.md to understand the project. Read prd.json for story status. Read progress.txt for recent learnings. Read scripts/ralph/ideate.md so you know how to brainstorm when asked. Tell me the next incomplete story and ask what I'd like to work on. If I say 'ideate' or 'brainstorm', use the ideation framework."
EOF
