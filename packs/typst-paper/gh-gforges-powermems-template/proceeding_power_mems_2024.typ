#import "template_proceeding_power_mems.typ": template_proceeding
#show: corps_du_texte => template_proceeding(
  title: [
    My Paper
  ],
  authors: (
    (
    name: "Gregoire Forges",
    affiliation: ("1","2"),
    ),
    (
    name: "uuu Ferrera",
    affiliation: ("1",), 
    ),
  ),

  affiliations: (
  (
    name : "Github"  ,
    number: ("1",)
  ),
  (
    name : "Typst"  ,
    number: ("2",)
  ),
  ),

  corps_du_texte,

  abstract: lorem(20),
  keywords: lorem(20),
  
)
= introduction
== Sous-section 1
#h(0.635cm)
#lorem(140)

@figure_1

= Section 2

#figure(
  align(center,image("test.jpg", width: 70%)),
  caption: [test image et légende],
)<figure_1>


#h(0.635cm)
#lorem(100)

= Section 3
== Sous-section 1
#h(0.635cm)
#lorem(20)

CECI EST UN TEST POUR LES EQUATIONS.

Let $a$, $b$, and $c$ be the side
lengths of right-angled triangle.
Then, we know that:
$ a^2 + b^2 = c^2 $

Prove by induction:
$ cases(sum_(k=1)^n k = (n(n+1)) / 2,x=2)  $

== Sous-section 2
#h(0.635cm)
#lorem(20)

#figure(
  table(
  columns: (1fr, auto, auto),
  inset: 10pt,
  align: center + horizon,
  table.header(
    [], [*Area*], [*Parameters*],
  ),
  "cylinder",
  $ pi h (D^2 - d^2) / 4$,
  [
    $h$: height \
    $D$: outer radius \
    $d$: inner radius
  ],
  "tetrahedron",
  $ sqrt(2) / 12 a^3$,
  [$a$: edge length]
), 
caption: [test tableau] 
)

Voici des exemples de citation d'article @hernandez_christelle_2015 ou de livre @flandrin_ecrire_nodate

#bibliography("test_pour_template.bib", style:"institute-of-electrical-and-electronics-engineers")