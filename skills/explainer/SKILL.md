---
name: explainer
description: >
  Explicar un PR, cambio o concepto en el nivel adecuado: texto STE100,
  diagrama o HTML interactivo.
---

# Explainer

Un **explainer** es un artefacto descartable que sube la escalera de understanding: texto controlado, diagrama, pagina interactiva. Cada nivel es mas caro que el anterior; empieza abajo y sube solo si el usuario lo pide.

## Pasos

1. **Fijar hechos.** Corre `scripts/explain.sh <target> --level <nivel>` y trabaja solo en el directorio que imprime. Guarda ahi el material real como `facts.md`: diff, codigo o descripcion del concepto. No inventes rutas: el directorio impreso es la unica ubicacion valida. Termina cuando cada afirmacion del artefacto traza a esa fuente; lo no verificado queda fuera.

2. **Elegir nivel.** `text` para leer, `diagram` para flujos y relaciones, `html` para explorar a tu ritmo. Termina cuando el nivel responde a lo pedido sin pagar el siguiente.

3. **Generar.** Sigue la referencia del nivel: [STE100](references/STE100.md), [DIAGRAM](references/DIAGRAM.md) o [HTML](references/HTML.md). Termina cuando el artefacto existe en el directorio de la corrida y cubre todos los hechos del paso 1.

4. **Verificar.** Relee el artefacto contra `facts.md`: sin afirmaciones nuevas, sin jerga innecesaria, sin nodo o escena sin fuente. Termina cuando todo lo mostrado traza a hechos y el artefacto abre correctamente. Devuelve la ruta absoluta del directorio.

## Reglas

- Lo barato primero: nunca subas de nivel si el actual alcanza.
- Cada corrida vive en su propio directorio fresco bajo temp; nunca escribas en el repo salvo `--out` explicito del usuario.
