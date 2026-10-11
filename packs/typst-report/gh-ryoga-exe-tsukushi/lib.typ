// Tsukushi, a minimal Typst v0.13 template for japanese university coursework reports

#let tsukushi(
  title: "",
  subtitle: "",
  authors: (),
  keywords: (),
  date: datetime.today(),
  deadline: none,
  date-format: "[year]年[month repr:numerical padding:none]月[day padding:none]日",
  lang: "ja",
  font-serif: ("Noto Serif", "Noto Serif CJK JP"),
  font-san: ("Noto Sans", "Noto Sans CJK JP"),
  paper: "a4",
  body,
) = {
  set document(
    title: title,
    author: authors.map(a => a.name),
    keywords: keywords,
    date: date,
  )
  set page(
    numbering: "1",
    number-align: center,
    paper: paper,
  )
  set text(font: font-serif, lang: lang)

  show strong: set text(font: font-san, weight: 450)
  set list(indent: 1.5em)
  set enum(indent: 1.5em)
  set terms(indent: 1.5em, separator: h(1em, weak: true))
  show list: set block(spacing: 1.3em)
  show enum: set block(spacing: 1.3em)
  show terms: set block(spacing: 1.3em)

  set heading(numbering: "1.")
  show heading: set text(font: font-san, weight: "medium", lang: lang)
  show heading: it => pad(top: 0.8em, bottom: 0.6em, it)

  show figure: it => pad(y: 1em, it)
  show figure.caption: it => pad(top: 0.5em, text(0.8em, it))

  show math.equation.where(block: true): set block(spacing: 1.5em)

  set par(
    first-line-indent: (amount: 1em, all: true),
    justify: true,
    spacing: 0.67em,
    leading: 0.67em,
  )

  set footnote(numbering: sym.dagger + "1")
  show footnote: it => {
    set text(size: 1em)
    it
  }
  show footnote.entry: it => {
    set text(size: 0.85em)

    grid(
      columns: (auto, 1fr),
      gutter: 0.75em,
      numbering(sym.dagger + "1", ..counter(footnote).at(it.note.location())),
      it.note.body
    )
  }

  align(center)[
    #block(
      text(
        font: font-san,
        size: 1.9em,
        weight: "semibold",
        title,
      ),
    )
    #if subtitle != "" {
      block(
        spacing: 1.2em,
        text(
          font: font-san,
          size: 1.4em,
          weight: "semibold",
          subtitle,
        ),
      )
    }
    #v(1em, weak: true)
  ]

  pad(
    top: 0.75em,
    x: 2em,
    for authors in authors.chunks(3) {
      grid(
        columns: (1fr,) * authors.len(),
        gutter: 1em,
        ..authors.map(author => align(
          center,
          text[
            #text(weight: "bold", author.name) \
            学籍番号：#author.id \
            所属：#author.affiliation
          ],
        ))
      )
    }
  )

  align(
    center,
    block(
      spacing: 1.2em,
      text(
        size: 0.9em,
        if deadline == none {
          date.display(date-format)
        } else [
          締切日：#deadline.display(date-format) \
          提出日：#date.display(date-format)
        ],
      ),
    )
  )

  body
}
