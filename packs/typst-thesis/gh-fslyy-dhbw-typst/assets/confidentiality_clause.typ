// Strings kept here rather than in FTL because this file is self-contained
// and may be included independently of the main template.
#let __strings = (
  title: (
    de: "Sperrvermerk",
    en: "Confidentiality Clause",
  ),
  clause: (
    de: "Der Inhalt dieser Arbeit darf weder als Ganzes noch in Auszügen Personen außerhalb des Prüfungsprozesses und des Evaluationsverfahrens zugänglich gemacht werden, sofern keine anderslautende Genehmigung des Dualen Partners vorliegt.",
    en: "The content of this thesis must not be made accessible, either in its entirety or in excerpts, to individuals outside the examination process and evaluation procedure, unless there is explicit permission from the partner company.",
  ),
)

#let confidentialityClauseWith(lang: "en") = [
  #let s(key) = __strings.at(key).at(lang)

  #align(center)[
    #set text(fill: red)
    #heading(outlined: false, numbering: none, s("title"))
  ]
  #v(3pt)
  #s("clause")
]
