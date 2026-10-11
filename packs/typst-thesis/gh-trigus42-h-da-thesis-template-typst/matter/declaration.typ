#import "../template.typ": unnumbered-heading, thesis-info

#unnumbered-heading("Eigenständigkeitserklärung")

Ich versichere hiermit, dass ich die vorliegende Arbeit selbstständig verfasst und keine anderen als die im Literaturverzeichnis angegebenen Quellen benutzt habe.

Alle Stellen, die wörtlich oder sinngemäß aus veröffentlichten oder noch nicht veröffentlichten Quellen entnommen sind, sind als solche kenntlich gemacht.

Die Zeichnungen oder Abbildungen in dieser Arbeit sind von mir selbst erstellt worden oder mit einem entsprechenden Quellennachweis versehen.

Diese Arbeit ist in gleicher oder ähnlicher Form noch bei keiner anderen Prüfungsbehörde eingereicht worden.

#thesis-info(data => [
  #v(2em)
  #emph[#data.location, #data.date]
  #v(10mm)
  #align(right, block(width: 53mm)[#line(length: 100%) #align(center, data.author)])
])
