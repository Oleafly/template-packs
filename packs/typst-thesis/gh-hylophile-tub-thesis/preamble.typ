#let preamble(
  title,
  name,
  is-masters: false,
  student-id,
  supervisor,
  first-examiner,
  second-examiner,
  chair,
  institute,
  abstract-de,
  abstract-en: none,
) = {
  let thesis-kind = if is-masters { "Masterarbeit" } else { "Bachelorarbeit" }
  grid(
    align: center, gutter: 1fr, columns: 1fr,
    scale(180%, image("tu-berlin-logo-long-red.svg")),
    text(size: 2em)[*#thesis-kind*],
    text(size: 1.5em)[*#title*],
    text(
      size: 1.25em,
      {
        show table.cell: it => {
          if it.x == 1 {
            set align(left)
            emph(it)
          } else {
            set align(right)
            it
          }
        }
        table(
          columns: 2,
          stroke: none,
          column-gutter: 1em,
          row-gutter: .5em,
          [vorgelegt von], [#name],
          [Matrikelnummer], [#student-id],
          [eingereicht am], datetime.today().display(),
          [Betreuer], [#supervisor],
          [Erstprüfer], [#first-examiner],
          [Zweitprüfer], [#second-examiner],
        )
      },
    )
    ,

    [Fachgebiet #chair\ Institut für #institute\ Technische Universität Berlin]
  )

  pagebreak()

  heading(outlined: false)[Eidesstattliche Erklärung]

  [Hiermit versichere ich, #name, an Eides statt, dass ich die vorliegende
    Masterarbeit mit dem Titel _ #title _ selbständig und ohne fremde Hilfe
    verfasst und keine anderen als die angegebenen Hilfsmittel benutzt habe. Die
    Stellen der Arbeit, die dem Wortlaut oder dem Sinne nach anderen Werken
    entnommen wurden, sind in jedem Fall unter Angabe der Quelle kenntlich
    gemacht. Die Arbeit ist noch nicht veröffentlicht oder in anderer Form als
    Prüfungsleistung vorgelegt worden.]

  {
    set line(stroke: .75pt, length: 15em)
    v(4em)
    grid(
      columns: 3,
      column-gutter: 1fr,
      row-gutter: .5em,
      align: center,
      line(), [], line(),
      [Ort, Datum], [], [Unterschrift],
    )
  }

  pagebreak()

  heading(outlined: false)[Kurzfassung]
  {
    set text(lang: "de")
    abstract-de
  }
  pagebreak()

  if abstract-en != none {
    heading(outlined: false)[Abstract]
    abstract-en
    pagebreak()
  }
}
