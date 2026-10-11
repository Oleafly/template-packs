#import "template/eg-paper.typ": *

#show: eg-paper.with(
  authors: [
    Ömercan Yazici#super([1])#orcid("0000-0003-0306-757X"),
    Pascal Grittmann#super([1])#orcid("0000-0002-5325-3744") and
    Philipp Slusallek#super([1,2])#orcid("0000-0002-2189-2429")
  ],
  short-authors: [
    Ömercan Yazici, Pascal Grittmann & Philipp Slusallek
  ],
  affiliations: [
    #super([1])Saarland University, Saarland Informatics Campus, Saarbrücken, Germany \
    #super([2])DFKI, Saarland Informatics Campus, Saarbrücken, Germany
  ],
  submission-id: [paper1042],
  anonymous: false,
  title: [Typst Author Guidelines for EUROGRAPHICS Proceedings Manuscripts],
  short-title: [Typst Author Guidelines],
  abstract: [
    #lorem(100)
  ],
  CCS-concepts: [
    • *Computing methodologies* $->$ Ray tracing; Rendering;
  ],
  short-venue: [EUROGRAPHICS 2026],
  venue: [
    EUROGRAPHICS 2026 / B. Masia and J. Thies\
    (Guest Editors)
  ],
  teaser-image: image("/figures/eg_new.jpg", width: 100%),
  teaser-caption: [This image shows quite clearly that our method is superior to doing nothing at all, which is a good start.],
  license: licenses.cc-by,
)

#add-bib-resource(read("references.bib"))

= Introduction

@fig-teaser is showing our superiority.
#lorem(100)

== Subsection in the introduction

#lorem(100)

$
  L_"o" (x, omega_"o") = L_"e" (x, omega_"o" ) + integral_Omega f_s (x, omega_"o", omega_"i") L_"i" (x, omega_"i") abs(cos theta_"i") dif omega_"i" quad
$ <eq-rendering>

It is a shame that @eq-rendering is so awesome.

#figure(
  image("/figures/sampleFig.jpg"),
  caption: [Here is a sample figure],
)

== This is a test

#lorem(100)

#figure(
  image("/figures/sampleFig.jpg"),
  caption: [Here is a sample figure with a much longer caption that should hopefully also still look fine here.],
)

=== Subsubsection
#lorem(100)

= And more
#lorem(100)

#layout(size => {
  size.width.mm()
})

#lorem(100)

#lorem(100)

#figure(
  scope: "parent",
  image("/figures/sampleFig.jpg"),
  caption: [Here is a sample figure with a much longer caption that should hopefully also still look fine here. It should span the full page.],
)

#lorem(100)

#lorem(100)

#lorem(100)

#lorem(100)

#lorem(100)

#cite("heitz2015sggx") #cite("Vorba2019")

This is text #cite("Rath2022")

And we want more of #cite("Veach95Mis", "Grittmann2022")
