# HTML

Una pagina autocontenida: Tailwind por CDN para layout, Mermaid por CDN para diagramas donde la relacion es grafo (flujos, dependencias, secuencias), divs/SVG hechos a mano para lo editorial (antes/despues, colapsables). Cada afirmacion visual traza a `out/facts.md`.

Escribela en el temp del sistema (`$TMPDIR`, fallback `/tmp`, `%TEMP%` en Windows) como `explainer-<timestamp>.html` para no ensuciar el repo, abrila con `xdg-open` (Linux), `open` (macOS) o `start` (Windows) y pasa la ruta absoluta al usuario.

Termina cuando el archivo abre con doble click, todo lo interactivo funciona sin servidor y cada bloque tiene su antes/despues o su fuente a la vista.
