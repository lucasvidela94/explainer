---
name: explainer
description: >
  Explain a PR, change or concept at the right level: STE100 text,
  diagram or interactive HTML. Use when user says explain this,
  what changed, help me understand, turn into diagram or page.
---

# Explainer

No setup required. Works global or project-scoped, from any directory, with or without a repo.

An **explainer** is a throwaway artifact that climbs the understanding ladder: controlled text, diagram, interactive page. Each level costs more than the previous one; start low, level up only on request.

## Steps

1. **Fix facts.** Run `explain.sh` resolved from this skill's directory (global or project, not from your cwd): `<skill-dir>/scripts/explain.sh <target> --level <level>`. A relative `--out` resolves from your invocation cwd. Work only in the printed directory. Store the real material there as `facts.md`: diff, code, or concept description. Never invent paths: the printed directory is the only valid location. Never write outputs inside the skill directory. Done when every claim in the artifact traces to that source; unverified stays out.

2. **Pick level.** Default `text` when the user names no level (cheap first). Upgrade only on signal: `diagram` when the request names flows, relations, protocols, sequences, or architecture; `html` when it names explore, interactive, page, or share. If the signal is genuinely ambiguous, default `text`, state the assumption in one line, and offer the next level after presenting. Done when the level answers the request without paying for the next one.

3. **Generate.** Follow the level reference: [STE100](references/STE100.md), [DIAGRAM](references/DIAGRAM.md), or [HTML](references/HTML.md). Done when the artifact exists in the run directory and covers every fact from step 1.

4. **Verify and open.** Re-read the artifact against `facts.md`: no new claims, no needless jargon, no node or scene without a source. Then open the final result non-blocking so the agent never hangs: `(nohup xdg-open <file> >/dev/null 2>&1 &)` on Linux, `(open <file> >/dev/null 2>&1 &)` on macOS, `(start "" <file>)` on Windows. Never wait for the viewer. If the opener fails (headless/SSH), fall back to the absolute path. Done when everything shown traces to facts and the artifact opens correctly. Present the content inline for `text`/`diagram`, return the absolute directory path always.

## Rules

- Cheap first: never level up while the current level answers the request.
- Default temp: each run lives in a fresh directory under system temp (`$TMPDIR`, `/tmp` fallback, `%TEMP%` on Windows; override with `EXPLAINER_BASE`). OpenCode users can set `EXPLAINER_BASE=/tmp/opencode` to skip the permission prompt. Level up by reusing the same dir with `--out last`.
- Local only when the user asks to keep/share/commit: then use `--out .scratch/explainers/<slug>/`. This is the only case that writes inside the repo.
