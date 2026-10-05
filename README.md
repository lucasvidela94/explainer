# explainer

![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)

Explain any PR, change or concept at the right level: controlled text, diagram or interactive HTML. Disposable artifacts for understanding LLM outputs.

Explicá un PR, cambio o concepto en el nivel justo: texto controlado, diagrama o página interactiva. Artefactos descartables para entender lo que generan los LLMs.

```bash
npx skills add lucasvidela94/explainer -a opencode -s explainer
```

**Usalo cuando digas:**

- "Explicame este PR"
- "Qué cambió acá y por qué"
- "Ayudame a entender este código"
- "Pasalo a diagrama / a página interactiva"

## La idea

Viene de [Andrej Karpathy](https://x.com/karpathy/status/2105819303471976479):

> Pasaremos cada vez más tiempo entendiendo lo que generan los modelos. Pedí artefactos descartables a medida: texto en ASD-STE100, diagramas, páginas HTML interactivas, videos explicadores a medida. A medida que la inteligencia y el código son abundantes, cosas que antes no tenían sentido crear ahora sí.

Su escalera, de barato a rico:

```mermaid
flowchart LR
  T["✍️ Texto STE100"] --> D["📊 Diagrama"]
  D --> H["🌐 HTML interactivo"]
```

Y su tesis de fondo: los LLMs hacen el trabajo pesado, nuestro trabajo sube a supervisar y comprender. Esta skill implementa eso: el agente hace el trabajo pesado (junta hechos, genera el artefacto), vos supervisás (verificás contra hechos).

## Cómo nos sirve

Con opencode abierto el flujo es:

```mermaid
flowchart LR
  O["opencode hace el cambio"] --> E["explainer genera artefacto"]
  E --> Y["vos verificás en segundos"]
```

En vez de releer un diff largo, pedís el nivel que corresponda y lo entendés en minutos. Cada nivel cuesta más que el anterior: empezá abajo, subí solo si hace falta.

## Niveles

| Nivel | Qué recibís | Cuándo |
|---|---|---|
| `text` | `explainer.md` estilo STE100 (o al 80%) | Leer rápido |
| `diagram` | `diagram.mmd` + SVG verificado | Flujos, protocolos, relaciones |
| `html` | Página autocontenida (Tailwind + Mermaid por CDN), se abre sola | Explorar a tu ritmo |

## Uso

Parado en cualquier repo, en el chat de tu agente:

```
usa la skill explainer, nivel text, para explicar qué hace este repo
y cuál es su cambio más importante del último commit.
Target: .
```

```
con lo anterior, subí a nivel diagram: un diagrama de flujo del proceso
hechos -> nivel -> generar -> verificar.
```

O directo por CLI (estructura base + hechos, el agente escribe el contenido):

```bash
scripts/explain.sh <pr-url|archivo|tema> --level text|diagram|html
```

## Estructura

```
skills/explainer/SKILL.md      # 4 pasos: hechos → nivel → generar → verificar
  references/STE100.md         # escritura controlada
  references/DIAGRAM.md        # Mermaid + verificación SVG
  references/HTML.md           # patrón de un solo archivo, probado
scripts/explain.sh             # junta hechos, arma la base en out/
```

Reglas: lo barato primero, cada afirmación remite a hechos verificados, nada va al repo salvo que lo pidas.

Funciona con OpenCode, Claude Code, Cursor y cualquier agente que lea `SKILL.md` (`npx skills add` lo instala en el tuyo).

## Fuentes

- **Karpathy**: la escalera texto → diagrama → HTML → video y el planteo trabajo pesado/supervisión (enlace arriba). Implementamos los tres primeros niveles; video quedó fuera a propósito.
- **Skills de Matt Pocock** (`improve-codebase-architecture`, `prototype`, `teach`): el patrón HTML que copiamos, de un solo archivo, Tailwind + Mermaid por CDN, a temp, apertura automática con `xdg-open`. Probado en flujo diario.
- **Psychopomp** (`kitlangton/psychopomp`, Rust + wgpu): evaluado en esta máquina (compila, presenta, exporta). Potente pero pesado; descartado como backend de video por bloat. Queda en git history por si aparece un caso real.

## Licencia

MIT
