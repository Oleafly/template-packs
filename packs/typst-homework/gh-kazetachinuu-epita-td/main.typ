// =============================================================================
// Example TD document - Showcasing template features
// =============================================================================
// Compile: typst compile main.typ
// Watch:   typst watch main.typ

#import "src/lib.typ": *

// =============================================================================
// DOCUMENT SETUP
// =============================================================================
// All parameters are optional with sensible defaults.
// Uncomment and modify as needed.

#show: td.with(
  title: "Introduction à Typst",
  subtitle: "TD 1 - Prise en main",
  course: "EPITA",
  term: "APPING2 S7",
  authors: ("Hugo Sibony", "Jules Aubert", "Léa Bonet"),
  group: "C1",
  logo: image("images/epita-logo.png", width: 6cm),
  confidentiality: "TLP:AMBER",
  toc: true,
  // --- Optional overrides ---
  // lang: "en",
  // date-fmt: "[month repr:long] [day], [year]",
  // titlepage-labels: (authors: "Author(s)", group: "Team", date: "Date"),
  // header-left: "Custom Left",
  // header-right: "Custom Right",
)

// =============================================================================
// CONTENT
// =============================================================================

= Introduction

Ce document présente les fonctionnalités du template *epita-td* pour Typst.
L'objectif est de fournir une alternative moderne à LaTeX pour la rédaction
de travaux dirigés.

== Objectifs du TD

#requirement[
  - Comprendre la syntaxe de base de Typst
  - Utiliser les différentes boîtes sémantiques
  - Personnaliser les titres et icônes
  - Maîtriser le compteur de questions
]

= Exercices de base

== Questions de cours

#question[
  Qu'est-ce que Typst et en quoi diffère-t-il de LaTeX ?
]

#response[
  Typst est un système de composition de documents moderne qui offre :
  - Une syntaxe plus simple et intuitive
  - Une compilation quasi-instantanée
  - Un langage de programmation intégré
  - Une gestion native des erreurs lisible
]

#question[
  Comment créer une liste numérotée en Typst ?
]

#response[
  On utilise le préfixe `+` pour les listes numérotées :

  ```typst
  + Premier élément
  + Deuxième élément
  + Troisième élément
  ```

  + Premier élément
  + Deuxième élément
  + Troisième élément
]

== Exercice pratique

#question[
  Écrivez une commande Typst pour afficher "Hello, World!" en gras et en bleu.
]

#cmd[
  ```typst
  #text(fill: blue, weight: "bold")[Hello, World!]
  ```
]

#result[
  #text(fill: blue, weight: "bold")[Hello, World!]
]

= Personnalisation des boîtes

Ce template permet de personnaliser facilement chaque boîte via des paramètres optionnels.

== Personnalisation du titre

#question(title: "Exercice Bonus")[
  Cette question utilise un titre personnalisé au lieu de "Question N".
]

#response(title: "Answer")[
  Vous pouvez aussi changer le titre des réponses (utile pour l'anglais).
]

== Format de numérotation

#reset-questions(0)

#question(format: "Q{num}")[
  Format court : affiche *Q1* au lieu de "Question 1".
]

#question(format: "Exercice {num}")[
  Format personnalisé : affiche *Exercice 2*.
]

#question(format: "{num}.")[
  Format minimaliste : affiche *3.*
]

== Numérotation explicite avec `question-num`

#question-num(42)[
  Cette question affiche le numéro 42 sans affecter le compteur auto.
]

#question-num(1, format: "Ex. {num}")[
  Combinaison : numéro explicite + format personnalisé = *Ex. 1*
]

== Personnalisation des icônes

#question(icon: sym.star)[
  Cette question utilise une étoile comme icône.
]

#question(icon: sym.arrow.r)[
  Cette question utilise une flèche.
]

#question(icon: none)[
  Cette question n'a pas d'icône du tout.
]

== Personnalisation des couleurs

#question(color: colors.response)[
  Cette question utilise la couleur verte (normalement pour les réponses).
]

#response(color: colors.warning)[
  Cette réponse utilise la couleur rouge (normalement pour les avertissements).
]

== Boîte entièrement personnalisée

#custom-box(
  title: "Note de l'auteur",
  icon: sym.note,
  color: colors.metadata,
)[
  Utilisez `custom-box` pour créer des boîtes avec n'importe quel titre,
  icône et couleur.
]

#custom-box(
  title: "Définition",
  icon: sym.equiv,
  color: colors.requirement,
)[
  *Algorithme* : Suite finie d'opérations permettant de résoudre un problème.
]

== Boîte sans en-tête

#colorbox(color: colors.question)[
  `colorbox` crée une boîte colorée simple sans barre de titre.
  Utile pour mettre en évidence du contenu.
]

= Gestion du compteur de questions

== Réinitialisation à zéro

#reset-questions(0)

#question[
  Après `#reset-questions(0)`, cette question est numérotée *1*.
]

#question[
  Et celle-ci est numérotée *2*.
]

== Réinitialisation à une valeur arbitraire

#reset-questions(9)

#question[
  Après `#reset-questions(9)`, cette question est numérotée *10*.
]

== Utilité par section

#reset-questions(0)

#question[
  On peut réinitialiser le compteur à chaque nouvelle section pour avoir
  une numérotation locale (Question 1, 2, 3... par section).
]

= Toutes les boîtes disponibles

Voici un aperçu de toutes les boîtes sémantiques du template :

#question[
  `question` : Pour les questions (auto-numérotées).
]

#response[
  `response` : Pour les réponses.
]

#response-inline[
  `response-inline` : Réponse sans barre de titre.
]

#cmd[
  `cmd` : Pour les commandes terminal.
]

#result[
  `result` : Pour afficher un résultat.
]

#important[
  `important` : Pour les avertissements critiques.
]

#tip[
  `tip` : Pour les astuces et conseils.
]

#info[
  `info` : Pour les informations complémentaires.
]

#requirement[
  `requirement` : Pour les prérequis.
]

#scope[
  `scope` : Pour définir le périmètre.
]

#example[
  `example` : Pour les exemples et démonstrations.

  ```c
  int fibonacci(int n) {
      int a = 0, b = 1;
      while (n-- > 0) {
          b = a + b;
          a = b - a;
      }
      return a;
  }
  ```
]

= Alias français

Le template fournit des alias en français :

#que[
  `que` = `question`
]

#res[
  `res` = `response`
]

#astuce[
  `astuce` = `tip`
]

#prerequis[
  `prerequis` = `requirement`
]

#exemple[
  `exemple` = `example`
]

= Tableaux et mathématiques

#reset-questions(0)

#question[
  Créez un tableau des opérateurs mathématiques.
]

#response[
  #figure(
    table(
      columns: (auto, auto, auto),
      inset: 8pt,
      align: center,
      table.header(
        [*Opération*], [*Symbole*], [*Exemple*],
      ),
      [Addition], [$+$], [$2 + 3 = 5$],
      [Soustraction], [$-$], [$5 - 2 = 3$],
      [Multiplication], [$times$], [$4 times 3 = 12$],
      [Division], [$div$], [$12 div 4 = 3$],
    ),
    caption: [Opérations mathématiques de base],
  )
]

#question[
  Écrivez la formule quadratique.
]

#response[
  $ x = (-b plus.minus sqrt(b^2 - 4 a c)) / (2 a) $
]

= Figures et images

#question[
  Comment intégrer une image avec légende ?
]

#response[
  ```typst
  #figure(
    image("images/epita-logo.png", width: 4cm),
    caption: [Logo EPITA],
  ) <fig:logo>
  ```
]

#figure(
  image("images/epita-logo.png", width: 4cm),
  caption: [Logo EPITA],
) <fig:logo>

Référence : voir @fig:logo.

= Diagrammes avec CeTZ

#info[
  CeTZ est la bibliothèque de dessin pour Typst.
  Import : `#import "@preview/cetz:0.3.4"`
]

#import "@preview/cetz:0.3.4": canvas, draw

#figure(
  canvas(length: 1cm, {
    import draw: *

    // Axes
    set-style(stroke: (paint: black, thickness: 0.5pt))
    line((-0.5, 0), (5, 0), mark: (end: "stealth"))
    line((0, -0.5), (0, 3.5), mark: (end: "stealth"))

    // Labels
    content((5.3, 0), $x$)
    content((0, 3.8), $y$)

    // Curve
    set-style(stroke: (paint: blue, thickness: 1pt))
    let pts = ((0, 0), (1, 1), (2, 1.5), (3, 2.5), (4, 3))
    for (i, p) in pts.enumerate() {
      circle(p, radius: 0.06, fill: blue)
      if i > 0 { line(pts.at(i - 1), p) }
    }
  }),
  caption: [Graphique simple],
)

= Conclusion

#scope[
  Ce TD couvre :
  - Les boîtes sémantiques et leur personnalisation
  - La gestion du compteur de questions
  - Les paramètres `title`, `icon`, `color`, `format`
  - Les fonctions `reset-questions()`, `question-num()`, `custom-box()`
]

#tip[
  Consultez `src/config.typ` pour modifier les valeurs par défaut globalement.
]

#important[
  N'hésitez pas à explorer le code source dans `src/` pour comprendre
  le fonctionnement interne du template.
]

#align(center)[
  #v(1em)
  _Fin du TD 1_
]
