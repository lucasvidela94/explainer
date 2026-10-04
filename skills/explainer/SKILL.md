---
name: explainer
description: >
  Explicar un PR, cambio o concepto en el nivel adecuado: texto STE100,
  diagrama, HTML interactivo o video.
---

# Explainer

Un **explainer** es un artefacto descartable que sube la escalera de understanding: texto controlado, diagrama, pagina interactiva, y solo al final video. Cada nivel es mas caro que el anterior; empieza abajo y sube solo si el usuario lo pide.

## Pasos

1. **Fijar hechos.** Junta el material real con `scripts/explain.sh <target> --level <nivel>`: diff, codigo o descripcion del concepto en `out/facts.md`. Termina cuando cada afirmacion del artefacto traza a esa fuente; lo no verificado queda fuera.

2. **Elegir nivel.** `text` para leer, `diagram` para flujos y relaciones, `html` para explorar a tu ritmo, `video` solo para contar una causalidad en orden con narracion. Termina cuando el nivel responde a lo pedido sin pagar el siguiente.

3. **Generar.** Sigue la referencia del nivel: [STE100](references/STE100.md), [DIAGRAM](references/DIAGRAM.md), [HTML](references/HTML.md) o [VIDEO](references/VIDEO.md). Termina cuando el artefacto existe en `out/` y cubre todos los hechos del paso 1.

4. **Verificar.** Relee el artefacto contra `out/facts.md`: sin afirmaciones nuevas, sin jerga innecesaria, sin nodo o escena sin fuente. Termina cuando todo lo mostrado traza a hechos y el artefacto abre correctamente.

## Reglas

- Lo barato primero: nunca generes video si texto o diagrama alcanzan.
- Video es opcional y usa backends intercambiables; Psychopomp es uno, no el centro.
- Artefactos van a `out/`, nunca al repo salvo que el usuario lo pida.
