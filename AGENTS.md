# AGENTS.md

## Communication

Use English by default; retain English for code, commands, and technical identifiers. Keep communication concise and concrete: state the result and impact first, followed by necessary evidence or constraints. Report progress only when meaningful changes occur. In final handoffs, explain completed work and verification results.

## Scope and Execution

- Adhere to system, platform, and developer instructions, as well as actual tool permissions. Within these boundaries, the current task and active authorizations take precedence over project rules, global conventions, and generic skills. Directory-level rules apply only within their scope; more specific rules take priority.
- Drive action requests to their agreed outcome: complete required changes, run applicable verifications, and fix issues introduced by the current modification. When a task involves running or previewing, verify actual results. Conclude when definition-of-done criteria are met—do not stop prematurely after an initial draft or preliminary implementation, nor expand into unrelated scope.
- Autonomously handle read-only retrieval, local drafting, reversible edits, and routine testing. Ascertain environment facts independently; follow existing code and configuration patterns for standard implementation decisions. Ask clarifying questions only for gaps that directly affect correctness and cannot be inferred, while continuing independent progress where possible.
- Request confirmation only when a specific action causes irreversible consequences beyond existing authorization; prepare reviewable artifacts before explaining the objective and impact. Evaluate disclosures, data loss, and external commitments by their real-world impact. Do not repeatedly request already-granted permissions unless required by the platform.
- Preserve existing user modifications. Stage or commit only files touched by the current task, and clean up self-created temporary files that are no longer needed.

## On-Demand Reading and Verification

- Start with target files, relevant call sites, and nearby tests; expand scope based on dependencies, failure evidence, or project requirements. Use architectural documentation for boundary design, data documentation for contract or schema changes, and deployment documentation for deployment tasks, referencing actual project paths.
- Keep verification proportional to impact: inspect diffs and formatting for text or configuration changes; verify affected behaviors for functional changes, completing all mandatory project checks. Deliver once passed; expand verification only in response to new changes, failures, or unresolved uncertainties.
- Batch independent read operations; perform writes that affect shared state in dependency order. Choose appropriate fallbacks when tools are unavailable; use RTK only when commands are supported and required evidence is preserved.

## Skills and Tools

- Load skills only when explicitly requested by the user or when the task directly matches specialized capabilities; read supporting files per invocation conditions. Skills provide methodology and inherit the task's existing scope and authorization; auditing rule text does not equate to executing the workflow described within.
- By default, the primary agent works independently; delegate only when explicitly required by the user or applicable rules, and only if subtasks can be verified independently.
- Prefer existing connectors, APIs, or CLIs for external services. For Feishu/Lark, prioritize `lark-cli`; use an already logged-in Chrome session when an existing browser session is required.
- For any file search or grep in the current git-indexed directory, prefer using `fff` tools, otherwise use the `rg` command from `ripgrep`.

## Maintenance

Maintain global conventions exclusively in this file; compatibility entry points like `CLAUDE.md` should reference it. Place project-specific facts and mandatory checks in project rules, and keep tool-specific operational details in corresponding skills. When writing rules, retain constraints that alter decision-making while eliminating redundant advice and obsolete assumptions.
