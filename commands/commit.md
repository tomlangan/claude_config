---
allowed-tools: Bash(git status:*), Bash(git diff:*), Bash(git add:*), Bash(git commit:*), Bash(git log:*), Bash(git rev-parse:*), Bash(git branch:*), Bash(ls:*), Bash(cat:*), Bash(pnpm test:*), Bash(npm run test:*), Bash(yarn test:*), Bash(pytest:*), Bash(go test:*), Bash(make test:*)
argument-hint: [all|docs-only|code-only|dry-run|test] [optional summary seed]
description: Analyze diffs, update docs/tasks/{todo,backlog,completed}.md, then stage & commit code+docs (no push, no Claude boilerplate)
model: sonnet
---

# Context (auto)
- Repo root: !`git rev-parse --show-toplevel || pwd`
- Branch: !`git branch --show-current`
- Status: !`git status --porcelain`
- Changed (unstaged vs HEAD): !`git diff --name-only`
- Changed (staged): !`git diff --name-only --staged`
- Recent commits: !`git log --oneline -10`
- Tasks dir: !`ls -1 docs/tasks 2>/dev/null || echo "__DOCS_TASKS_DIR_MISSING__"`
- todo.md: !`test -f docs/tasks/todo.md && (printf "\n---FILE:todo---\n" && cat docs/tasks/todo.md) || echo "__MISSING_todo__"`
- backlog.md: !`test -f docs/tasks/backlog.md && (printf "\n---FILE:backlog---\n" && cat docs/tasks/backlog.md) || echo "__MISSING_backlog__"`
- completed.md: !`test -f docs/tasks/completed.md && (printf "\n---FILE:completed---\n" && cat docs/tasks/completed.md) || echo "__MISSING_completed__"`

# Task

You will perform a **single atomic shipment**:
1) **Validate** the docs system
   - All three files must exist: `docs/tasks/todo.md`, `backlog.md`, `completed.md`.
   - If any are missing or conflicting variants exist (e.g., `TODO.md`, `to-do.md`), output **Validation: missing/conflicts** with details and **STOP** (no edits, no commit).

2) **Summarize actual work done**
   - Use `git status/diff/log` to infer what changed. You **may** use current chat context as hints but **must not invent** items absent from diffs/logs.
   - If assumptions are necessary, list them under **Assumptions**.

3) **Update documentation in place**
   - **todo.md**: Mark items completed and move them to `completed.md`. Add any new concrete tasks implied by diffs.
   - **backlog.md**: Add/adjust deferred/future items discovered.
   - **completed.md**: Append newly completed entries with `YYYY-MM-DD`, short description, and (if applicable) the leading commit hash(s).
   - Preserve headings/format; only touch justified sections.

4) **(Optional) Run tests**
   - If `$ARGUMENTS` contains `test`, run the project’s tests (pnpm/npm/yarn/pytest/go/make). If tests fail, print failures and **STOP** (no commit).

5) **Stage & commit (no push)**
   - **Default**: stage **all modified files** (code + docs).
   - If `$ARGUMENTS` has `docs-only`, stage only the three task files.
   - If `$ARGUMENTS` has `code-only`, stage everything **except** the three task files.
   - If `$ARGUMENTS` has `dry-run`, make no changes—show what you *would* stage and the exact commit message, then stop.
   - Compose a **single** Conventional Commit subject, imperative, ≤50 chars. Prefer:
     - `📝 docs(tasks): sync with latest changes` (if docs-only)
     - `✨ feat(<scope>): <summary>` / `🐛 fix(<scope>): <summary>` when code is included; add a 1–3 line body if helpful.
   - **Absolutely do not** add any assistant/model signatures, “Co-authored-by,” or boilerplate footer lines.
   - Execute with Bash and show `git log --oneline -1` at the end.

# Output format
- **Validation**: ok | missing | conflicts (with bullet list)
- **Change Summary**: bullets (facts from diff/log)
- **Doc Edits**: bullets per file
- **Commit**: show staged paths and the exact commit subject (and body if used)

# Implementation notes (follow precisely)
- Abort on missing/conflicts.
- Use today’s date for `completed.md` entries.
- Keep unrelated sections stable; do not reorder without necessity.
- For commit subject, if `$ARGUMENTS` includes a trailing phrase, you may use it as a seed but keep the final subject concise.
- Use Bash tool to run:
  - `git add -A` (default) OR selective `git add` per the mode
  - `git diff --name-only --staged`
  - `git commit -m "<subject>"` [and `-m "<wrapped body>"` if present]
  - finally `git log --oneline -1`
