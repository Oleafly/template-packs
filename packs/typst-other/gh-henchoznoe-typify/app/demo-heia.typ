// -------------------------------------------------------------------------
// File: demo-heia.typ
// Authors : Noé Henchoz & Yoan Gilliand
// Date: 2025-12-02
// Description: Démonstration complète des fonctionnalités Typify (thème HEIA).
// License: MIT
// Copyright: (c) 2025 Noé Henchoz & Yoan Gilliand
// -------------------------------------------------------------------------

#import "template/main.typ": project
#import "lib/alerts.typ": error, info, success, warning
#import "lib/code.typ": code-frame
#import "lib/badges.typ": badge

#show: project.with(
  title: "Guide Typify",
  subtitle: "Template de documentation professionnel",
  authors: ("Noé Henchoz", "Yoan Gilliand"),
  date: datetime.today(),
  classe: "ISC-IL-2A - Ingénierie Logicielle",
  cover: true,
  heia: true,
  toc: true,
  tof: true,
  bibliography: true,
)

= Introduction

Typify est un template Typst conçu pour créer des documents académiques et professionnels. Il propose deux thèmes : HEIA-FR (ce document) et un thème par défaut sobre.

#info[
  Ce guide présente un exemple de chaque composant disponible dans Typify.
]

#pagebreak()

= Composants Visuels

== Alerts

Les alerts permettent d'attirer l'attention sur des informations importantes :

#success[
  *Succès* : Pour indiquer une opération réussie ou un résultat positif.
]

#warning[
  *Attention* : Pour signaler un point nécessitant une vigilance particulière.
]

#error[
  *Erreur* : Pour mettre en évidence un problème critique ou une erreur.
]

== Badges

Les badges sont utiles pour marquer des versions ou des statuts : #badge("v1.0", color: blue) #badge("Stable", color: green) #badge("Beta", color: orange)

== Code Source

Le template supporte la coloration syntaxique avec titre et numérotation optionnelle :

#code-frame(title: "fibonacci.py", lang: "python", numbers: true)[
  ```python
  def fibonacci(n):
      """Calcule le n-ième nombre de Fibonacci."""
      if n <= 1:
          return n
      return fibonacci(n-1) + fibonacci(n-2)
  ```
]

#pagebreak()

= Structures de Données

== Tableaux

Les tableaux sont automatiquement stylisés avec un header en couleur primaire du thème :

#figure(
  table(
    columns: 3,
    [*Composant*], [*Description*], [*Statut*],
    [Alerts], [Notifications visuelles], badge("OK", color: green),
    [Code], [Coloration syntaxique], badge("OK", color: green),
    [Tableaux], [Données structurées], badge("OK", color: green),
  ),
)

== Figures

Les figures peuvent être référencées dans le texte et apparaissent dans la table des illustrations en fin de document. La @fig:demo illustre la personnalisation visuelle possible avec le template.

#figure(
  rect(
    width: 100%,
    height: 6cm,
    fill: gradient.linear(rgb("#007CB7"), rgb("#AFA8A1")),
    radius: 8pt,
    align(center + horizon)[
      #text(size: 20pt, fill: white, weight: "bold")[
        Exemple de Figure
      ]
    ],
  ),
  caption: [Visualisation avec dégradé aux couleurs HEIA-FR],
) <fig:demo>

#pagebreak()

= Utilisation

== Structure de Document

Un document Typify typique suit cette structure :

#code-frame(title: "document.typ", lang: "typist")[
  ```typst
  #import "template/main.typ": project

  #show: project.with(
    title: "Mon Travail",
    subtitle: "Sous-titre optionnel",
    authors: ("Auteur 1", "Auteur 2"),
    date: datetime.today(),
    classe: "Classe ou Cours",
    cover: true,
    heia: true,  // ou false pour thème par défaut
    toc: true,
    tof: true,
    bibliography: true,
    bibliography-file: "bibliography.bib",
  )

  = Introduction
  Votre contenu ici...
  ```
]

== Paramètres Disponibles

Le template accepte les paramètres suivants :

*Paramètres obligatoires :*
- `title` : Titre du document (défaut: "Typify Document")
- `authors` : Liste des auteurs (peut être vide)

*Paramètres optionnels :*
- `subtitle` : Sous-titre du document
- `date` : Date du document (défaut: aujourd'hui)
- `date-format` : Format de la date (défaut: "DD.MM.YYYY")
- `classe` : Classe ou cours

*Options de mise en page :*
- `cover` : Afficher la page de garde (true/false)
- `heia` : Utiliser le thème HEIA-FR (true/false, défaut: true)
- `header` : Afficher l'en-tête (false par défaut, true après page 1)
- `footer` : Afficher le pied de page (true/false, défaut: true)

*Tables et références :*
- `toc` : Générer la table des matières (true/false)
- `tof` : Générer la table des illustrations (true/false)
- `bibliography` : Générer la bibliographie (true/false)
- `bibliography-file` : Chemin du fichier .bib (défaut: "bibliography.bib")

== Architecture du Template

Le template est organisé de manière modulaire :

#code-frame(title: "Structure", lang: "text")[
  ```
  template/
  ├── main.typ              # Point d'entrée principal
  ├── config.typ            # Configuration et constantes
  ├── components/
  │   ├── header.typ       # En-têtes (avec/sans logo)
  │   ├── footer.typ       # Pieds de page
  │   ├── cover-heia.typ   # Page de garde HEIA-FR
  │   ├── cover-default.typ # Page de garde générique
  │   ├── outlines.typ     # Tables (matières & illustrations)
  │   └── bibliography.typ # Génération bibliographie
  └── themes/
      ├── heia.typ         # Configuration HEIA-FR
      └── default.typ      # Configuration générique
  ```
]

#pagebreak()

= Références et Citations

Les citations bibliographiques peuvent être insérées dans le texte en utilisant la syntaxe `@clé`. Par exemple, pour en savoir plus sur Typst, consultez @haug2023.

Les références bibliographiques sont automatiquement formatées et listées en fin de document (voir _Bibliographie_ ci-dessous).
