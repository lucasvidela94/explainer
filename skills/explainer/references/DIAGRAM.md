# Diagram

Un diagrama Mermaid en `out/diagram.mmd`: flowchart para flujos, sequence para protocolos, state para lifecycles. Un nodo por hecho, una flecha por causalidad real.

Verifica renderizando: `npx -y @mermaid-js/mermaid-cli -i out/diagram.mmd -o out/diagram.svg` o pegandolo en el visor del editor. Termina cuando el SVG abre y cada nodo traza a `out/facts.md`.
