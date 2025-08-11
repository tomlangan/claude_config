---
allowed-tools: Bash(ls:*), Bash(mkdir:*), Bash(date:*)
description: Initialize a new feature doc under docs/features/ using safe defaults. No args. Infers slug from branch name or creates a timestamp slug. Does not push.
---

# Init Feature Doc

> Create `docs/features/<slug>.md` with a minimal, consistent template.  
> This command is zero-argument and token‑aware: it infers a sensible slug from the branch name; if unavailable, uses `feature-<YYYYMMDD-HHMMSS>`.

## Steps
1. **Determine slug**
   - Try branch name: `!git branch --show-current` → sanitize to kebab-case.
   - If empty or `main/master`, fallback: `feature-$(date +%Y%m%d-%H%M%S)`.

2. **Ensure directory exists**
   ```bash
   mkdir -p docs/features
   ls -la docs/features || true
   ```

3. **Create file if missing**
   - Path: `docs/features/<slug>.md`
   - If the file already exists, output a note and **STOP** (no overwrite).

4. **Write minimal template**
   Content to write:
   ```markdown
   ---
   title: <Feature Title>
   slug: <slug>
   status: draft
   owner: <your-name>
   last_updated: <YYYY-MM-DD>
   risk_level: <low|med|high>
   ---

   ## 1. Problem & Goals
   ## 2. Existing Behavior → Gaps
   ## 3. Proposed Behavior
   ## 4. Integration Points
   ## 5. Data & Migrations
   ## 6. API/Contracts
   ## 7. Feature Flags & Rollout
   ## 8. Security/Privacy
   ## 9. Observability
   ## 10. Risks & Mitigations
   ## 11. Test Plan
   ## 12. Release Plan
   ## 13. Open Questions
   ```

5. **Output**
   - Print the created path and next steps (edit the file, then run the commit workflow).

## Guardrails
- Do not overwrite existing files.
- Do not stage or commit; this command only creates the file.
- Do not push.
