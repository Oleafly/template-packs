= -- Exemples<part1>

==  Sous-partie

// Mission de l’entreprise
=== Sous-sous-partie
L'Entreprise #lorem(5)
#figure(image("../images/exemple.png",
width:70%),caption:[Schéma d'exemple @trimble_trimble_lg_nodate[source Trimble]])<reseaugnss>

Je parle de la figure que je référence ici: @reseaugnss. Cette figure est très intéressante, comme en atteste la source qui référencée à la fin de ce paragraphe. @geo_gmbh_ssr_nodate


== Cadre de la mission et périmètre du projet

Je fais maintenant une liste afin d'expliquer des choses :

- a
  - aaaa
    - Elles peuvent s'imbriquer !
- b
- c

// #pagebreak()
// Parties prenantes
=== Parties prenantes
Ci-dessous se trouve un exemple de matrice RACI que j'ai défini dans un fichier à part pour faciliter ma relecture et que j'intègre à ma présentation avec un \#include et que je peux référencer avec un \@raci puisque j'ai référencé cet objet avec la référence \<raci> (voir raci.typ) : @raci.

#include "raci.typ"

=== Prévision de l'usage du temps
#include "gantt.typ"
Ce diagramme de Gantt est réalisé dans un fichier à part, gantt.typ, que j'inclus avec un \#include et qui fonctionne avec une bibliothèque typst spécifique pour faciliter son rendu.