# HTML

One self-contained page: Tailwind via CDN for layout, Mermaid via CDN for graph relations (flows, dependencies, sequences), hand-made divs/SVG for editorial blocks (before/after, collapsibles). Every visual claim traces to `out/facts.md`.

Write it to system temp (`$TMPDIR`, `/tmp` fallback, `%TEMP%` on Windows, `EXPLAINER_BASE` override) as `explainer-<timestamp>/index.html` so the repo stays clean, open it non-blocking (`(nohup xdg-open index.html >/dev/null 2>&1 &)` Linux, `(open index.html >/dev/null 2>&1 &)` macOS, `(start "" index.html)` Windows), and hand the absolute path to the user. Never wait for the browser. Reuse the same dir to level up. Use `.scratch/explainers/<slug>/` only when the user asks to keep/share.

Done when the file opens with a double click, everything interactive works with no server, and every block shows its before/after or its source.
