# Video (opcional)

Solo si el usuario pide video o narracion. Backends intercambiables; el default es ninguno hasta elegirlo.

## Backend psychopomp

Requiere la skill vecina `psychopomp-reel` (mismo repo) instalada y resuelve el motor con `scripts/bootstrap-psychopomp.sh` via `$PSYCHOPOMP_DIR`. Sigue esa skill para molde PR o concepto, guion, sheet y render. Termina con su criterio: `plan validate` valido + `ffprobe` 1920x1080 60fps AAC.

Si el backend falta o falla, entrega el nivel HTML y reporta el faltante en vez de bloquear.
