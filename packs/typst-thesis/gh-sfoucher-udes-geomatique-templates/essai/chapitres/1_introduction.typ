#import "../styles.typ": *

= Introduction <chap:introduction>

Dans ce modèle, les styles sont paramétrés afin de respecter les normes de mise en page d'un mémoire ou d'une thèse présentées dans le #link("https://www.usherbrooke.ca/geomatique/fileadmin/sites/geomatique/espace-etudiant/guide-redaction2004_vf.pdf")[guide de rédaction de Jean-Marie Dubois]. #text(fill: eclipsepurple)[*La table des matières et les titres des chapitres et des sections présentés dans ce modèle sont fournis à titre indicatif seulement. Ils doivent être revus et adaptés afin de refléter fidèlement les objectifs, la méthodologie et les résultats propres à votre recherche.*]

== Mise en contexte <sec:mise_en_contexte>

Voici un paragraphe.

Voici un second paragraphe.

#lorem(120)

#lorem(110)

== Problématique <sec:problematique>

#lorem(100)

== Objectifs <sec:objectifs>

Décrire l'objectif principal et les objectifs spécifiques.

Bonnes pratiques pour nommer les _labels_ (étiquettes) dans un document Typst :

- *chap:* pour les _chapitres_ : `<chap:introduction>`.
- *sections :*
  - *sec:* pour les _sections de niveau 1_ : `<sec:mise_en_contexte>`.
  - *subsec:* pour les _sous-sections de niveau 2_ : `<subsec:sous_section>`.
  - *subsubsec:* pour les _sous-sections de niveau 3_ : `<subsubsec:sous_sous_section>`.
- *fig:* pour les _figures_ : `<fig:territoire_etude>`.
- *tab:* pour les _tableaux_ : `<tab:statistiques_descrip>`.
- *eq:* pour les _équations_ : `<eq:rmse>`.
- *algo:* pour les _algorithmes_ : `<algo:dijkstra>`.

Ces conventions permettent d'assurer une bonne organisation et lisibilité du code source, et d'éviter les conflits entre les _labels_. Elles permettent aussi de faire référence à un élément dans le texte. Par exemple...

Comme discuté dans la section~@sec:mise_en_contexte, ...
