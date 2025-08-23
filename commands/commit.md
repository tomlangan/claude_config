---
allowed-tools: Bash(git status:*), Bash(git diff:*), Bash(git add:*), Bash(git commit:*), Bash(git log:*), Bash(git branch:*), Bash(ls:*), Bash(cat:*), Bash(date:*), Bash(~/.claude/go-to-git-root.sh:*), Bash(~/.claude/find-todo-files.sh:*)
description: Validate the task docs, summarize actual work strictly from git evidence (optionally show context hints), delegate to sub-agents for doc edits and commit message, stage ONLY task/feature docs, then commit. No push. No arguments.
---

# Commit (Docs-First, Evidence-Backed, Sub‑agent Assisted)

> Zero-argument, deterministic workflow. Use only facts from `git` for decisions; chat/PR context is advisory. **Do not push.**  
> Sub‑agents: use **doc-writer** PROACTIVELY for doc edits (task + feature docs); use **commit-message-builder** MUST BE USED to craft the commit message.

## 1) Validate the Docs System (STOP on failure)
First, ensure we're working from the git repository root:
```bash
source ~/.claude/go-to-git-root.sh
```

Required task files (exact paths relative to project root):
- `docs/tasks/todo.md`
- `docs/tasks/backlog.md`
- `docs/tasks/completed.md`

Scan for conflicting variants (case/typos), e.g.: `TODO.md`, `to-do.md`, `backlogs.md`, `completed.MD`, or task files at other roots (`/docs/todo.md`, `/todo.md`).

Run (from project root):
```bash
ls -la docs || true
ls -la docs/tasks || true
~/.claude/find-todo-files.sh
```

**If any required task file is missing OR conflicting variants exist:**
- Output **Validation: missing/conflicts** with a bullet list of issues.
- **STOP** (no edits, no staging, no commit).

> Note: Feature docs (under `docs/features/`) are optional and may be created/updated if justified by evidence.

---

## 2) Summarize Actual Work Done (facts only)
Collect signals:
```bash
git branch --show-current
git status --porcelain
git diff --name-only
git diff --staged
git log --oneline -5
```

### 2a) Context Hints (optional, non-authoritative)
List helpful hints from chat/PR context if present, clearly labeled.

### 2b) Evidence Matrix (authoritative)
Produce a **Change Summary (evidence-backed)** where each bullet cites files/hunks from git outputs.  
If you must infer intent beyond raw diff, place under **Assumptions**.

---

## 3) Update Documentation in Place (via sub-agent)
Delegate to **doc-writer** (PROACTIVELY) with the evidence and desired targets:
- Allowed in this workflow:  
  - Task docs: `docs/tasks/todo.md`, `docs/tasks/backlog.md`, `docs/tasks/completed.md`  
  - Feature docs: any `docs/features/*.md` (create if justified by evidence)
- Minimal diffs, preserve headings/format/style.
- In `completed.md`, append as `YYYY-MM-DD — <short description> [<leading commit hash(es) if relevant>]` using `date +%F`.

Apply the patches returned by **doc-writer**.

If **no doc changes are produced**, output **No doc changes to commit** and **STOP**.

---

## 4) Stage All Changes (Docs + Code)
Stage changes under the allowed doc paths:
```bash
git add -A
```
(Stage all changes — docs and any code/files ready to commit.)

---

## 5) Compose a Single Commit Message (via sub-agent)
Delegate to **commit-message-builder** (MUST BE USED) with the staged diff to craft the message:
- If staged files are all docs, enforce type `docs` and an appropriate scope (e.g., `tasks`, `features`, or `docs`).
- Must follow Conventional Commits; include emoji; no footers/signatures.

Use the returned `SUBJECT` and (optional) `BODY` verbatim.

---

## 6) Commit (no push)
```bash
git commit -m "<subject>" -m "<optional body>"
git log --oneline -1
```

---

## Output Checklist
- **Validation**: OK | missing/conflicts (if conflicts, stopped)
- **Context Hints**: (optional list)
- **Change Summary (evidence-backed)**: bullets tied to files/hunks
- **Assumptions**: (if any)
- **Doc Edits**: bullets per file touched
- **Commit**: exact subject (and body if any)

## Guardrails
- Evidence comes from `git` outputs; context is advisory only.
- If validation fails → **STOP**.
- If no doc edits → **STOP**.
- Only modify/stage task docs and feature docs in this workflow.
- Do not run tests here.
- Do not push.
