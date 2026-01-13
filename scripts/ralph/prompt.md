# Ralph Development Session

You are working in autonomous mode. Your job is to complete ONE user story from the PRD, then exit so the next iteration can begin.

## Your Workflow

### Step 1: Read Context Files
1. Read `CLAUDE.md` to understand the project
2. Read `prd.json` to find the next incomplete story
3. Read `progress.txt` to see learnings from previous sessions

### Step 2: Identify Next Story
Find the first story in `prd.json` where `"passes": false`. This is your task for this session.

### Step 3: Implement the Story
1. Read the story's acceptance criteria carefully
2. Implement each criterion one by one
3. Follow existing code patterns in the codebase
4. Keep changes minimal and focused on this one story

### Step 4: Test Your Changes
1. Run `npm run build` to verify TypeScript compiles
2. If the story involves UI, describe what should be manually tested
3. If tests exist, run `npm test`

### Step 5: Mark Story Complete
If all acceptance criteria pass:
1. Update `prd.json` - set `"passes": true` for this story
2. Add any notes about the implementation to the story's `"notes"` field

### Step 6: Update Progress Log
Append to `progress.txt`:
```
=== [STORY_ID] Completed: [DATE] ===
Summary: [What you implemented]
Files changed: [List of files]
Learnings: [Any patterns, gotchas, or insights for future sessions]
```

### Step 7: Commit Changes
Create a git commit with message format:
```
[STORY_ID] Story title

- Implemented [brief description]
- Files: [list key files changed]
```

### Step 8: Exit
After committing, your session is complete. The ralph.sh loop will start the next iteration.

## Important Rules

1. **ONE STORY PER SESSION** - Only work on the single next incomplete story
2. **ALWAYS RUN BUILD** - Every story must end with `npm run build` passing
3. **UPDATE prd.json** - Mark the story as complete before committing
4. **UPDATE progress.txt** - Document learnings for future sessions
5. **COMMIT YOUR WORK** - Always commit before the session ends
6. **DON'T SKIP AHEAD** - Complete stories in order (lowest incomplete ID first)

## If You Get Stuck

If you cannot complete a story:
1. Do NOT mark it as `passes: true`
2. Add detailed notes to the story's `"notes"` field explaining what's blocking
3. Add to `progress.txt` what you tried and what failed
4. Commit any partial progress
5. Exit - the next session may have fresh context to solve it
