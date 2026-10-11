// So werden Quellen zitiert: @beispiel1 @beispiel2.

#show outline.where(target: figure.where(kind: image)).or(outline.where(target: figure.where(kind: table))): it => {
  text(
    top-edge: 0mm,
    it,
  )
}

= Literaturverzeichnis
#bibliography(title: none, "../references.bib", style: "apa")

#pagebreak()

= Abbildungsverzeichnis
#outline(title: none, target: figure.where(kind: image))

#pagebreak()

= Tabellenverzeichnis
#outline(title: none, target: figure.where(kind: table))

#pagebreak()

= Code-Listings
#outline(title: none, target: figure.where(kind: raw))
