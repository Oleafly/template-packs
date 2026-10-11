#import "@preview/gantty:0.5.1": gantt

= Planification <planification>

== Planification initiale <planification-initiale>

Un exemple de planification et de Gantt utilisant la bibliothèque #link("https://typst.app/universe/package/gantty/")[gantty].\
\
Dates clés administratives :

  - oct-dec 2025 : sélection, élaboration et affectation du sujet
  - 16.02.2026 : Démarrage du travail
  - 20.02.2026 : Kick-off
  - 16.03.2026 : Documents de confidentialité
  - 16.04.2026 : Cahier des charges final
  - 16.05.2026 : Rendu intermédiaire
  - 24.07.2026 : Rendu final du travail
  - 03.09.2026 : Défense du travail de Bachelor

#v(5%)
#figure(
  gantt(yaml("planification-gantt.yaml")),
  caption: [
    Planification initiale du projet
  ])<gantt>