#import "../styles.typ": *

= Matériel et méthodes <chap:metho>

Introduction et annonce du plan du chapitre.

#lorem(100)

== Territoire d'étude <sec:territoire_etude>

#lorem(110)

#lorem(90)

== Données <sec:donnees>

=== Données primaires <subsec:donnees_primaires>

#lorem(90)

=== Données secondaires <subsec:donnees_secondaires>

#lorem(90)

== Structuration des données <sec:structuration_donnees>

#lorem(90)

== Méthodes d'analyse <sec:methodes_analyses>

=== Méthode 1 <subsec:methodes1>

#lorem(90)

=== Méthode 2 <subsec:methodes2>

#lorem(90)

==== Sous-section <subsubsec:sous_section>

#lorem(80)

==== Sous-section <subsubsec:sous_section2>

#lorem(80)

=== Méthode 3 <subsec:methodes3>

Comment numéroter et faire référence à une équation ? Les mesures du RMSE et de $R^2$ (équations~@eq:rmse et~@eq:r2) sont utilisées...

$ "RMSE" = sqrt(frac(sum_(i=1)^n (y_i - hat(y)_i)^2, n)) $ <eq:rmse>

$ R^2 = frac(sum_(i=1)^n (hat(y)_i - overline(y))^2, sum_(i=1)^n (y_i - overline(y))^2) $ <eq:r2>

L'équation de la régression linéaire multiple s'écrit :

$ Y = X beta + epsilon quad "avec :" $ <eq:regression_lineaire>

- $Y$ est un vecteur de dimension $n times 1$ pour la variable dépendante, soit une colonne avec $n$ observations.
- $X$ est une matrice de dimension $n times (k+1)$ pour les $k$ variables indépendantes, incluant une autre colonne pour la constante.
- $beta$ est un vecteur de dimension $k+1$, soit les coefficients de régression pour les $k$ variables et la constante.
- $epsilon$ est un vecteur de dimension $n times 1$ pour les résidus.

L'analyse des résultats du modèle est présentée dans le tableau @tab:tableau1.

#figure(
  caption: [Premier tableau du chapitre 3],
  table(
    columns: (auto, auto, auto, auto),
    align: (left, center, center, center),
    inset: (x: 8pt, y: 5pt),
    table.hline(),
    [*Colonne A*], [*Colonne B*], [*Colonne C*], [*Colonne D*],
    table.hline(),
    ..(([Texte],) * 20),
    table.hline(),
    table.cell(colspan: 4, align: left, stroke: none,
      inset: (x: 0pt, top: 4pt))[
      #text(size: 9pt)[_Note :_ facultatif.]
    ],
  ),
) <tab:tableau1>

Différentes fonctions Kernel peuvent être utilisées (figure @fig:kernels).

#figure(
  box(width: 100%, align(center, image("../figures/kernels.png", width: 80%))),
  caption: [Fonctions noyaux (kernel) pour définir la matrice de pondération W(i)],
) <fig:kernels>

#figure(
  caption: [Deuxième tableau du chapitre 3],
  table(
    columns: (auto, auto, auto, auto),
    align: (left, center, center, center),
    inset: (x: 8pt, y: 5pt),
    table.hline(),
    [*Colonne A*], [*Colonne B*], [*Colonne C*], [*Colonne D*],
    table.hline(),
    ..(([Texte],) * 20),
    table.hline(),
    table.cell(colspan: 4, align: left, stroke: none,
      inset: (x: 0pt, top: 4pt))[
      #text(size: 9pt)[_Note :_ facultatif.]
    ],
  ),
) <tab:tableau2>

#pagebreak()

En théorie des graphes, l'algorithme de Dijkstra résout le problème du plus court chemin (algorithme @algo:dijkstra).

#algorithme([Algorithme de Dijkstra], pseudocode-list(booktabs: true)[
  + *Entrée :* un graphe $G = (V, E)$ avec des poids $w(u,v) >= 0$ et un sommet source $s in V$
  + *Sortie :* les distances minimales $d[v]$ de $s$ à chaque sommet $v in V$, et les prédécesseurs
  + *pour chaque* $v in V$ *faire*
    + $d[v] <- oo$
    + $"prec"[v] <-$ indéfini
  + $d[s] <- 0$
  + $Q <- V$ #h(1fr) #text(size: 0.85em, fill: luma(120))[\// file de priorité contenant tous les sommets]
  + *tant que* $Q != emptyset$ *faire*
    + $u <-$ sommet dans $Q$ avec la plus petite valeur $d[u]$
    + supprimer $u$ de $Q$
    + *pour chaque* voisin $v$ de $u$ *faire*
      + *si* $v in Q$ *et* $d[u] + w(u,v) < d[v]$ *alors*
        + $d[v] <- d[u] + w(u,v)$
        + $"prec"[v] <- u$
  + *retourner* $d$ et $"prec"$
]) <algo:dijkstra>

Pour intégrer des acronymes dans le texte, utiliser la fonction #raw("gls(\"nom-acronyme\")"). Les acronymes doivent être préalablement définis dans le fichier `auxiliaires/acronymes.typ`. Un hyperlien sur l'acronyme renvoie automatiquement à la liste des acronymes.

Voici un exemple, les principaux indices de végétation sont :

- #gls("ndvi")
- #gls("rvi")
- #gls("savi")
- #gls("osavi")
- #gls("msavi")
- #gls("ndre")
- #gls("ndwi")
- #gls("msi")

Note : la fonction #raw("gls(...)") gère automatiquement l'affichage du nom complet lors de sa première occurrence, puis de son acronyme seul par la suite.

Le plus couramment utilisé et connu est le #gls("ndvi").

Avec les #gls("sig").

Selon l'#gls("onu") et l'#gls("oms").
