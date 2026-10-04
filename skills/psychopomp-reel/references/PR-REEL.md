# PR Reel

Molde: `$PSYCHOPOMP_DIR/scenes/pr-walkthrough/src/stop_stage.rs` (Stage + Callouts + RollingNumber + zoom a diff) o `flagship.rs` (Stage film + zoom a codigo).

Estructura: intro, por cambio `<slug>-before`, `<slug>-after`, `<slug>-code`, outro.

Guion `scenes/<nombre>/narration/script.json`: un clip por parte, menos de 30s hablados cada uno, cada beat visual con frase ancla distinta. Si una frase falta en el transcript, el build hace panic con su clip: cambia el ancla a palabras que el transcript contenga.

Voz:
- Borrador sin API: `bun scripts/narrate.ts scenes/<nombre>/narration/script.json --draft` (macOS `say`).
- ElevenLabs: `engine: "elevenlabs"`, modelo `eleven_v4`, requiere `ELEVENLABS_API_KEY`.
- Fish Audio: `engine: "fish"`, requiere `FISH_AUDIO_API_KEY`.

El script normaliza loudness, transcribe timings con Whisper y escribe `<id>.mp3`, `<id>.words.json`, `narration.json`. Al cambiar voz o motor, reconstruye el Scene Plan contra los nuevos timings.
