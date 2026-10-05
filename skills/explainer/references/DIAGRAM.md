# Diagram

One Mermaid diagram in `out/diagram.mmd`: flowchart for flows, sequence for protocols, state for lifecycles. One node per fact, one edge per real causality. `out` is the run dir under system temp unless `--out` says otherwise.

Render contract (must work on any machine, so follow the order and never skip the checks):

1. PNG first (universal viewer support): `npx -y @mermaid-js/mermaid-cli@12 -i out/diagram.mmd -o out/diagram.png`. Verify: file exists and is larger than 5 KB (`ls -l`). The major pin keeps renders reproducible; never float latest in a shared skill.
2. SVG second (browser zoom): same command with `-o out/diagram.svg`.
3. Open `out/diagram.png` non-blocking (`(nohup xdg-open out/diagram.png >/dev/null 2>&1 &)` Linux, `(open out/diagram.png >/dev/null 2>&1 &)` macOS, `(start "" out/diagram.png)` Windows), and present the mermaid source inline.
4. Fallback (render never fails the run): if `mmdc` is missing, offline, or the PNG verifies small/blank, still deliver `diagram.mmd` + the inline source and point to the editor Mermaid viewer or `https://mermaid.live`. A missing picture is a degraded result, not a failed explanation.

Done when the PNG opens with readable labels and every node traces to `out/facts.md`.
