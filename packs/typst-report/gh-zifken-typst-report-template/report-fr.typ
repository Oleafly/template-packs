#import "template.typ": *

#show: report.with(
  title: "Rapport d'analyse IT 2026",
  subtitle: "Étude interne — infrastructures, sécurité et performance",
  authors: ((name: "A. Martin", role: "Direction technique"), (name: "C. Dubois", role: "Analyse de données")),
  date: datetime(year: 2026, month: 10, day: 6),
  lang: "fr",
)

= Synthèse exécutive

Ce rapport présente une vue d'ensemble de la situation d'une flotte de postes
informatiques au cours du premier semestre 2026. Les données sont entièrement
fictives et servent uniquement à illustrer la mise en page du modèle.

== Points clés

- Le parc géré s'élève à #strong[1 240 machines] réparties sur quatre sites.
- Le taux de remplacement a atteint #strong[18 %] contre 11 % en 2025.
- 92 % des machines ont été réinitialisées conformément à la politique interne.
- Le coût moyen de cycle de vie baisse de #strong[7,4 %] année après année.

== Indicateurs

#fancy-table(
  ([Indicateur], [2025], [2026], [Variation]),
  (
    ([Machines gérées], [1 210], [1 240], [+2,5 %]),
    ([Taux de remplacement], [11 %], [18 %], [+7 pts]),
    ([Délai moyen de remise en service], [6,2 j], [4,9 j], [−21 %]),
    ([Incidents de sécurité], [37], [19], [−49 %]),
  ),
)

= Méthodologie

== Sources de données

Les données proviennent de trois sources internes fictives :

+ L'inventaire automatisé (extraction hebdomadaire, format CSV).
+ Le registre des interventions techniques.
+ Les sondes de performance déployées sur les postes.

Les jeux de données sont consolidés puis analysés avec Python :

```python
import pandas as pd

df = pd.read_csv("fleet_2026.csv", parse_dates=["last_check"])
summary = (
    df.groupby("site")
      .agg(machines=("id", "count"),
           mean_age=("age_months", "mean"))
      .round(1)
)
print(summary)
```

== Limites

L'échantillon fictif ne couvre que les postes fixes et portables ;
les serveurs et équipements mobiles sont hors périmètre.

= Résultats

== Parc par site

#figure(
  fancy-table(
    ([Site], [Effectif], [Âge moyen (mois)], [Conformité]),
    (
      ([Nord], [412], [31,2], [94 %]),
      ([Sud], [356], [28,7], [91 %]),
      ([Est], [268], [35,4], [88 %]),
      ([Ouest], [204], [30,1], [96 %]),
    ),
  ),
  caption: [Répartition du parc géré par site (données fictives)],
) <tab-sites>

== Cycle de vie des machines

#figure(
  grid(
    columns: 2,
    column-gutter: 1em,
    image("assets/cost-curve.svg", width: 100%),
    image("assets/age-dist.svg", width: 100%),
  ),
  caption: [Coût de cycle de vie et distribution des âges (données fictives)],
) <fig-curves>

La figure @fig-curves montre que le coût marginal d'une machine croît
nettement après 42 mois d'utilisation, ce qui justifie la cible de
remplacement adoptée en 2026.

= Recommandations

== Priorités à 6 mois

- Harmoniser la politique de remplacement des sites Est et Sud.
- Industrialiser l'extraction d'inventaire avec un flux hebdomadaire chiffré.
- Publier un tableau de bord mensuel à destination de la direction.

== Feuille de route

#fancy-table(
  ([Échéance], [Action], [Responsable]),
  (
    ([T1 2027], [Unification des référentiels], [Équipe données]),
    ([T2 2027], [Chiffrement de bout en bout des extractions], [Équipe infra]),
    ([T3 2027], [Tableau de bord public interne], [Direction IT]),
  ),
)

= Annexes

=== Détail des scripts

Le script de consolidation est versionné dans le dépôt du projet :

```bash
uv run python scripts/consolidate.py --year 2026 --out build/summary.csv
```

=== Glossaire

#fancy-table(
  ([Terme], [Définition]),
  (
    ([Cycle de vie], [Période entre l'acquisition et la sortie du parc]),
    ([Conformité], [Part des machines réinitialisées selon la politique]),
  ),
)
