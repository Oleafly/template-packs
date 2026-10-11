#import "./modele.typ": main_color, project, appendix
#import "@preview/chronos:0.3.0"
#import "@preview/timeliney:0.4.0"

#show: project.with(
  title: "Titre",
  project: "Projet",
  authors: "Auteur",
  verifier: "Vérificateur",
  approver: "Appobateur",
  reference: "Référence",
  //  number_per_chapter: false,
  //  display_prefix: true,
  revision: (
    (
      version: "1",
      date: datetime.today(),
      description: "Première version",
    ),
  ),
)

= Introduction

#hide[@bookA]
#hide[@bookB]

Le présent document montre un squelette de format de document.

= Fonctionnalités

- Citation de document (p.ex. @bookC2).
- Acronyme (p.ex. @EMV)
- Tableau

#figure(
  table(
    columns: (1fr, 1fr, 1fr, 6fr),
    align: (center + horizon, center + horizon, center + horizon, left + horizon),
    fill: (_x_, y) => if y == 0 { main_color } else { white },
    table.header(
      text(weight: "bold", fill: white, [Nom]),
      text(weight: "bold", fill: white, [Format]),
      text(weight: "bold", fill: white, [Taille]),
      text(weight: "bold", fill: white, [Description]),
    ),
    [Ch. 1], [0 -- 9], [3], [Champ 1],
    [Ch. 2], [0 -- 9], [2], [Champ 2],
    [Ch. 3], [ASCII], [1], [Champ 3],
  ),
  caption: [Exemple de tableau],
)

- Diagramme de séquence

#figure(
  chronos.diagram({
    import chronos: *
    _par("Dev 1", show-bottom: false, color: white)
    _par("Dev 2", show-bottom: false, color: white)
    _col("Dev 1", "Dev 2", width: 8cm)

    _gap()
    _evt("Dev 1", "enable")
    _evt("Dev 2", "enable")
    _seq("Dev 1", "Dev 2", comment: "Message 1", comment-align: "center")
    _seq("Dev 2", "Dev 1", comment: "Réponse 1", comment-align: "center")
    _gap()
    _gap()
    _gap()
    _seq("Dev 2", "Dev 1", comment: "Réponse 2", comment-align: "center")
    _gap()
    _evt("Dev 1", "disable")
    _evt("Dev 2", "disable")
  }),
  caption: [
    Test de diagramme de séquence
  ],
)

- Code (voir #link(<code_anchor>)[appendices])

#pagebreak()

- Gantt

#figure(caption: [Planning])[
#timeliney.timeline(
  show-grid: true,
  {
    import timeliney: *

    headerline(group(([*2022*], 11)))
    headerline(
      group(([Fév], 3)),
      group(([Mar], 5)),
      group(([Avr], 3)),
    )

    taskgroup(title: [*Lot 1*], {
      task([Tâche 1], (from: 1, to: 2, style: (stroke: 3pt+main_color)))
      task([Tâche 2], (from:2,to:6, style: (stroke: 3pt+main_color)))
      task([Tâche 3], (from:1,to:3, style: (stroke: 3pt+main_color)))
    })

    taskgroup(title: [*Lot 2*], {
      task([Tâche 4], (from:6,to:8, style: (stroke: 3pt+main_color)))
      task([Tâche 5], (from:8,to:8.5, style: (stroke: 3pt+main_color)), (from:8.5,to:10, style: (stroke: 3pt+gray)))
    })

    milestone(
      at: 1,
      style: (stroke: (dash: "dashed")),
      align(center, [
        *Début*\
        18/02
      ])
    )

    milestone(
      at: 6,
      style: (stroke: (dash: "dashed")),
      align(center, [
        *RC*\
        18/03
      ])
    )

    milestone(
      at: 10,
      style: (stroke: (dash: "dashed")),
      align(center, [
        *Livraison*\
        12/04
      ])
    )
        milestone(
      at: 8.5,
      style: (stroke: ( thickness:1pt, paint:main_color, dash: "dashed")),
      align(center, [
         #text(fill: main_color, size: 25pt)[#sym.triangle.filled.t]
      ])
    )
  }
)]


#show: appendix.with()

= Exemple de code <code_anchor>

#figure(caption: [Exemple de code Rust])[
  ```rust
  pub fn main() {
      println!("Hello, world!");
  }
  ```]


#figure(caption: [Exemple de code C++])[
  ```cpp
  #include <iostream>

  int square(int num) {
    return num * num;
  }

  int main() {
    std::cerr << square(5) << "\n";
  }
  ```]

#figure(caption: [Exemple de code bash])[
  ```bash
  #!/bin/bash

  echo "test"
  ```]
