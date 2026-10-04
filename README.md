# explainer

Orquestador propio de explainers (idea Andrej: artefactos descartables para entender outputs). Niveles: texto STE100, diagrama, HTML, video opcional.

```bash
npx skills add lucasvidela94/explainer -a opencode -s explainer
scripts/explain.sh <pr-url|archivo|tema> --level text|diagram|html|video [--backend psychopomp]
```

Segunda skill en este repo: `psychopomp-reel`, backend opcional de video sobre tecnologia de terceros (Kit Langton). Solo si pides video con ese backend:

```bash
npx skills add lucasvidela94/explainer -a opencode -s psychopomp-reel
scripts/bootstrap-psychopomp.sh
```
