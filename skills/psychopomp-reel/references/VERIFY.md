# Verify

1. `cargo run --release -- plan validate <reel>` valido.
2. `plan inspect <reel>` para spans de segmentos.
3. Contact-sheet por segmento en beats before/switch/after/code:
   `bun scripts/sheet.ts <reel> t1,t2,... --theme neutral --shutter --out output/sheet.jpg`
   Con `PSYCHOPOMP_SHADER_DIR=crates/psychopomp-render/src/render` los cambios a `stage.wgsl`/`stage_post.wgsl` se ven sin rebuild Rust.
4. Render de un segmento con audio (`plan render <reel> out.mp4 --cue <scene-id>`) e inspecciona frames en movimiento, no solo endpoints.
5. Render completo: `plan render <reel> output/<nombre>.mp4 --theme neutral`.
6. `ffprobe`: 1920x1080, 60fps, AAC, duracion igual a `plan inspect`, loudness cerca de -16 LUFS con picos bajo -1 dBFS.
7. Mantiene verde: `cargo test --workspace`, `cargo fmt --check`, clippy estricto del workspace.
