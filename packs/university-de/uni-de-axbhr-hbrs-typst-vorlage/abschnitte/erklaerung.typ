// ─── Erklärung ───────────────────────────────────────────────────────────────
// Entspricht abschnitte/Erklärung.tex  (\section* → nicht nummeriert, nicht im ToC)
#import "../meta.typ": *

#heading(numbering: none, outlined: false)[Erklärung]

#thesis-author \
#thesis-author-address

#v(1em)

Hiermit erkläre ich, dass ich die vorliegende Arbeit selbst angefertigt habe;
die aus fremden Quellen direkt oder indirekt übernommenen Gedanken sind als
solche kenntlich gemacht.

#v(0.5em)

Die Arbeit wurde bisher keiner Prüfungsbehörde vorgelegt und auch noch nicht
veröffentlicht.

#v(3em)

#table(
  columns: (1fr, 1fr),
  stroke: none,
  inset: (x: 0pt, y: 3pt),
  line(length: 6cm), line(length: 6cm),
  [Ort, Datum], [Unterschrift],
)
