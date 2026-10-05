# Diagram

One Mermaid diagram in `out/diagram.mmd`: flowchart for flows, sequence for protocols, state for lifecycles. One node per fact, one edge per real causality. `out` is the run dir under system temp unless `--out` says otherwise.

Verify by rendering: `npx -y @mermaid-js/mermaid-cli -i out/diagram.mmd -o out/diagram.svg` or paste it into the editor viewer. Open `out/diagram.svg` with the system opener so it renders in an image viewer, and present the mermaid source inline. Done when the SVG opens and every node traces to `out/facts.md`.
