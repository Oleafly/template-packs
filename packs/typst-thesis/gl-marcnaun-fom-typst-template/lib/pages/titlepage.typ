// ─── Title page per FOM guidelines ────────────────────────────────────────────
#import "../style.typ": body-size, h3-size, leading, h-spacing

#let titlepage(meta) = {
  set page(numbering: none, header: none, footer: none)
  set par(spacing: 0pt, leading: leading)

  let gap  = v(h-spacing)
  let gap2 = v(2 * h-spacing)

  let supervisor-label = if meta.document.type in ("Bachelorarbeit", "Masterarbeit") {
    [Erstgutachter/in:]
  } else {
    [Betreuer/in:]
  }

  let degree  = meta.document.at("degree",  default: "")
  let module  = meta.document.at("module",  default: "")

  align(center)[
    #image("../fom-logo.png", width: 4cm)

    #gap

    #text(size: h3-size, weight: "bold")[#meta.university.name] \
    #text(size: body-size)[Hochschulzentrum #meta.university.location]

    #gap2

    #text(size: h3-size, weight: "bold")[#meta.document.type] \
    #text(size: body-size)[im Studiengang #meta.document.program]

    #gap2

    // Degree (Bachelorarbeit/Masterarbeit) or module (all other document types)
    #if degree != "" [
      #text(size: body-size)[zur Erlangung des Grades eines] \
      #text(size: h3-size, weight: "bold")[#degree]
      #gap2
    ] else if module != "" [
      #text(size: body-size)[im Modul] \
      #text(size: h3-size, weight: "bold")[#module]
      #gap2
    ]

    #text(size: body-size)[über das Thema] \
    #text(size: h3-size, weight: "bold")[#meta.document.title]
    #if meta.document.subtitle != "" [
      #linebreak()
      #text(size: body-size)[#meta.document.subtitle]
    ]

    #gap2

    // Authors comma-separated on one line
    #text(size: body-size)[von] \
    #text(size: h3-size, weight: "bold")[#meta.authors.map(a => a.name).join(", ")]

    #gap2
  ]

  // Metadata at bottom of page
  let ids = meta.authors.map(a => a.id).join(", ")

  let meta-rows = ()
  if meta.document.supervisor != "" {
    meta-rows += ([#supervisor-label], [#meta.document.supervisor])
  }
  meta-rows += ([Matrikelnummer(n):], [#ids])
  meta-rows += ([Abgabedatum:],       [#meta.document.date])

  place(bottom + left, dy: -1.5cm)[
    #set text(size: body-size)
    #grid(
      columns: (4cm, 1fr),
      row-gutter:  1em,
      align:       (left, left),
      ..meta-rows,
    )
  ]

  pagebreak()
}
