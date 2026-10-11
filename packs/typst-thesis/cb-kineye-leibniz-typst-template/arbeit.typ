#set page(
  margin: (
    top: 2.5cm,
    bottom: 2cm,
    left: 4cm,
    right: 2cm,
  ),
)

#set text(
  font: "Arial", //installed via ttf-ms-win11-auto from aur
  size: 11pt,
  lang: "eng", //führt zu deutschen Anführungszeichen
)

#set par(
  justify: true, //blocksatz
  leading: 1em, //zeilenabstand
  spacing: 1.6em, //paragraph gap
)


#set page(
  margin: (top: 1.31cm, bottom: 0.49cm, left: 2.29cm, right: 2.29cm),
)
#v(2cm)
#align(left)[
  Leibniz Fachhochschule Hannover\
  Bachelor of Science: IT-Security \
  Mentored by: Prof. Dr. INSERT\


]
#v(4cm)

#align(center)[
  Bachelor's Thesis\
  IT Security
  #heading[INSERT]
]


#show heading.where(): set text(14pt, rgb("#4b69c6"))
#v(13cm)
#align(left)[
  name\
  Straße \
  Postleizahl Ort \
  Matrikelnummer: \
  E-Mail:  \@leibniz-fh.de
]


#pagebreak()

#outline(title: "Outline", target: heading.where(numbering: "1."))
#pagebreak()

= Abbreviations

/ example: example abbreviation

#pagebreak()
#counter(page).update(1) // reset the page number
#set page(
  margin: (
    top: 2.5cm,
    bottom: 2cm,
    left: 4cm,
    right: 2cm,
  ),
  numbering: "S.1",
)

#set heading(numbering: "1.")
#counter(heading).update(0)

= Abstract

= Introduction
= Context
= b's Implementation with ...

== Implementation Process at

== Automated Processes and Workflows

== Real-World Benefits Observed
== Challenges and Limitations Encountered

== Impact on Team and Processes

= Reflection and Evaluation

= Conclusion
#pagebreak()
#bibliography(
  "Iso.bib",
  style: "apa",
  full: true,
)

#pagebreak()
= Ehrenwörtliche Erklärung

Hier mit versichere ich, ..., dass die vorliegende Arbeit von mir
selbstständig und ausschließlich unter Verwendung der angegebenen Quellen und
Literatur-werke angefertigt worden ist. Alle Stellen, die wörtlich oder
annähernd wörtlich aus Veröffentlichungen entnommen worden sind, wurden als
solche kenntlich gemacht.

// #figure(
//   image(
//     "/sources/Unterschrift.png",
//     width: 40%,
//   ),
//   outlined: false,
// )


<Ort>, der 22.09.2025
