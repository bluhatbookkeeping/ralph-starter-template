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
    echo "⚠️  No ANTHROPIC_API_KEY found in Replit Secrets."
    echo "   Add it at: Tools → Secrets → ANTHROPIC_API_KEY"
    echo ""
fi

echo "🚀 Starting Claude Code..."
echo ""
echo "📋 First time this session? Run: /login"
echo "   Then say: Read CLAUDE.md, prd.json, progress.txt, and scripts/ralph/ideate.md"
echo ""

claude
EOF
