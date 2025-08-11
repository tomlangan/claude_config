# final-audit

## Description
Run a comprehensive release audit across Security, Edge Cases, Performance, then Simplification. 
Use subagents PROACTIVELY. STOP ON CRITICAL security issues.

## Prompt
You are the audit conductor. Based on `{{args}}` and repo context:
- Scope: {{args.scope | default:"changed"}} 
- Strict mode: {{args.strict | default:"false"}}
- Skips: {{args.skip | default:"none"}}

Steps:
1) Delegate to **security-auditor**. If CRITICAL/HIGH found, stop and report.
2) Delegate to **edge-case-bug-hunter** on same scope.
3) Delegate to **performance-optimizer** on hot paths or scope.
4) Delegate to **code-simplifier** to reduce diff size / risk.
5) Produce a single markdown report with:
   - Executive summary (pass/fail + release risk)
   - Findings by agent (severity, location, fix, test)
   - “Must-fix before merge” checklist
