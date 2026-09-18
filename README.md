# TDT4173

Arbeidsmappen er `~/tdt4173-repo` på Google Workbench.
Åpne den med VS Code Remote SSH. Kode, notebooks, data og Git brukes der.

På Mac-en, fra denne mappen:

```bash
make code   # Start Workbench ved behov og åpne prosjektet i VS Code
make stop   # Stopp VM-en når du er ferdig
```

`make status` viser status. Tilkoblingen bruker `.env` (se `.env.example`),
Google Cloud CLI og VS Code med Remote SSH. Ingen filer synkroniseres.
Mac-kopien er ikke arbeidsmappen for modellutviklingen.

I remote-vinduet skal det stå `SSH: ...` nederst til venstre.
Velg en Python-kjerne på VM-en for notebooks.
Bruk vanlig Git i dette vinduet: velg filer, commit og push.
GitHub-pålogging er separat fra Google-pålogging og kan kreves ved første push.
Datasettet er usporet; ikke ta det med i commits uten å avklare deling med gruppen.

Lagrede filer på VM-en beholdes når den stoppes; kjørende programmer stoppes.
