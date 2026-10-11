// chapters/01-introduction.typ

= Introduction
#lorem(101)
@exemple2024 // Citation bibtex
// Paragraphes

== Contexte
#lorem(90)
(@fig:annexe-logo) // Citation d'une figure annexe


== Problématique
#lorem(70)
#v(1em)
#figure(
  table(
    columns: (auto, 1fr, auto), 
    
    // 2. Style : alignement vertical au centre, un peu d'espace interne
    inset: 10pt,
    align: horizon,
    
    // 3. En-tête du tableau
    table.header(
      [*Variable*], [*Description*], [*Valeur*]
    ),
    
    // 4. Contenu
    table.hline(stroke: 0.5pt + gray), // Trait fin gris
    [$x$], [#lorem(5)], [$1.33$],
    table.hline(stroke: 0.5pt + gray),
    [$y$], [#lorem(8)], [$298$],
    table.hline(),
  ),
  caption: [Un exemple de tableau.],
  kind: table // Important pour qu'elle aille dans la "Liste des tableaux"
) <tab:constantes-exp>