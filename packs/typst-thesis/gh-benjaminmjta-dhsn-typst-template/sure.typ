#import "_setup.typ": *

= Eidesstattliche Erklärung

Ich erkläre an Eides statt, dass ich die vorliegende Arbeit selbstständig und nur
unter Verwendung der angegebenen Quellen und Hilfsmittel angefertigt habe.
Die Zustimmung des Dualen Praxispartners zur Verwendung interner Unterlagen
habe ich eingeholt. Bestandteile der Arbeit, die unter Verwendung von Hilfsmitteln
oder Methoden der Künstlichen Intelligenz bearbeitet oder die mittels Künstlicher
Intelligenz generiert wurden, wurden als solche in der Arbeit ausdrücklich kenntlich
gemacht. Die Arbeit wurde bisher in gleicher oder ähnlicher Form weder
veröffentlicht noch einer anderen Prüfungsbehörde vorgelegt.

#place(top + left, dx: 285pt, dy: 320pt)[
  #image("figures/Unterschrift.png", height: 40pt)
]

#v(10em)
#align(center)[
  #block(width: 100%)[
    #grid(
      columns: (1fr, 1fr),
      align(left)[Dresden, den #SubmissionDate],
      overline(offset: -1em)[#align(right)[Unterschrift #Author]],
    )
  ]
]

#pagebreak()