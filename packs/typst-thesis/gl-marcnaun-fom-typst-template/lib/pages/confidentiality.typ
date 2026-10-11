// ─── Confidentiality notice ────────────────────────────────────────────────────
// Only included when options.confidential = true.

#let confidentiality-notice(meta) = {
  set page(numbering: none, header: none, footer: none)
  heading(outlined: false, numbering: none)[Sperrvermerk]

  v(1em)

  [
    Die vorliegende Arbeit enthält unternehmensinterne Daten. Veröffentlichung
    und Weitergabe sind ohne ausdrückliche Genehmigung nicht gestattet. Die Arbeit
    darf nur den am Prüfungsverfahren beteiligten Personen zugänglich gemacht werden.
  ]

  v(2cm)

  grid(
    columns: (1fr, 1fr),
    [
      #line(length: 100%, stroke: 0.5pt)
      #v(0.2em)
      Ort, Datum
    ],
    [
      #line(length: 100%, stroke: 0.5pt)
      #v(0.2em)
      #meta.authors.map(a => a.name).join(", ")
    ],
  )
}
