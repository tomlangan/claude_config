---
allowed-tools: Bash(git add:*), Bash(git status:*), Bash(git diff:*), Bash(git commit:*), Bash(~/.claude/go-to-git-root.sh:*)
description: Stage all changes and commit with an inferred Conventional Commit message (no push).
---

# Quick Commit

## Steps

0. **Ensure we're at the git repository root**
```bash
source ~/.claude/go-to-git-root.sh
```

1. **Stage all changes**
   ```bash
   git add -A
   ```

2. **Collect staged file list and diff**
   ```bash
   git status --porcelain
   git diff --staged --name-only
   git diff --staged
   ```

3. **Infer commit type & scope**
   - `test/`, `*.spec.*`, `*.test.*` → `test`
   - Fix keywords in diff (`fix`, `bug`, `null`, `exception`, `crash`, `NPE`, `edge`) → `fix`
   - Perf keywords (`optimiz`, `perf`, `cache`, `latency`, `throughput`) → `perf`
   - Purely structural rename/extraction/cleanup → `refactor`
   - Otherwise → `feat` if behavior changes detected, else `chore`
   - Scope: derive from top-level directory/package name; omit if unclear.

4. **Generate commit message**
   - Format: `:emoji: type(scope?): subject`
   - Emoji map:
     - feat → ✨
     - fix → 🐛
     - refactor → ♻️
     - perf → ⚡
     - chore → 🧑‍💻
     - test → ✅
   - Subject: imperative, ≤72 chars, no trailing period.
   - Body: optional 1–3 bullets summarizing “why” and key changes.
   - No co-author footer.

5. **Commit**
   ```bash
   git commit -m "<subject line>" -m "<body if any>"
   ```

6. **Output**
   - Show commit header and number of files committed.
