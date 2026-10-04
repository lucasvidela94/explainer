---
name: psychopomp-reel
description: Explicar un PR, cambio o concepto con video Psychopomp. Usalo cuando el usuario pide reel, walkthrough visual o explainer narrado.
---

# Psychopomp Reel

Un **reel** es un video explicador determinista: un Scene Program Rust emite un Scene Plan JSON y el mismo plan se presenta en vivo o se exporta a MP4 1080p60. Motor canonico: `https://github.com/kitlangton/psychopomp`, clonado por bootstrap, nunca con path fijo.

## Bootstrap (obligatorio primero)

Resuelve el motor sin asumir paths:

```bash
scripts/bootstrap-psychopomp.sh [--dir "$PSYCHOPOMP_DIR"]
```

Termina cuando imprime `PSYCHOPOMP_DIR=<ruta>` y `plan --help` responde. Si `cargo`, `ffmpeg` o `gh` faltan, el script dice el comando exacto de instalacion y se detiene.

## Pasos

1. **Fijar hechos.** Lee el diff real (`gh pr diff`, `gh pr view`) o el codigo del concepto y escribe una frase para conducta rota, conducta fija y cambio. Termina cuando cada afirmacion del guion traza a codigo, test o corrida; lo no verificado queda fuera.

2. **Elegir molde.** Para PR usa `scenes/pr-walkthrough/src/stop_stage.rs`; para concepto usa `scenes/data-modeling` o `scenes/keyed-grid`. Copia la forma, no partas de crate vacio. Termina cuando `cargo run -p <crate>` escribe el reel JSON. Detalle en [references/PR-REEL.md](references/PR-REEL.md) o [references/CONCEPT-REEL.md](references/CONCEPT-REEL.md).

3. **Guion y voz.** Guion en `scenes/<nombre>/narration/script.json`, un clip por parte, cada beat con frase ancla distinta. Borrador con `bun scripts/narrate.ts ... --draft`; final con ElevenLabs o Fish Audio. Termina cuando `plan validate <reel>` es valido. Voces y limites en [references/PR-REEL.md](references/PR-REEL.md).

4. **Revisar antes de renderizar.** `plan inspect <reel>` + contact-sheet con `bun scripts/sheet.ts ... --shutter`. Termina cuando cada segmento fue mirado sin texto solapado ni cortado. Checklist en [references/VERIFY.md](references/VERIFY.md).

5. **Renderizar y entregar.** `plan render <reel> output/<nombre>.mp4 --theme neutral`. Termina cuando `ffprobe` confirma 1920x1080, 60fps, AAC y duracion igual a `plan inspect`. Devuelve la ruta del MP4.

## Reglas

- Fuente de verdad: `AGENTS.md`, `CONTEXT.md`, `ARCHITECTURE.md`, `SCENE_PLANS.md` dentro de `$PSYCHOPOMP_DIR`. Esta skill no los duplica.
- Motion fisico (energia, Send/Connect/Settle/Hit): skill `explainer-motion` del motor.
- Artefactos generados van a `output/` y `target/`, nunca al repo.
