#let setup(
  title: none,
  name: none,
  header-footer-width: 110%,
  doc,
) = {
  set document(title: title, author: name)
  set text(font: "New Computer Modern")
  set par(justify: true)

  show link: it => {
    set text(fill: blue, font: "FreeMono")
    it
  }

  show cite: it => {
    show regex("\d+"): set text(fill: blue)
    it
  }

  // set up footnote colouring
  show footnote: set text(blue)
  show footnote.entry: it => {
    let loc = it.note.location()
    text(
      fill: blue,
      super(
        numbering(
          "1",
          ..counter(footnote).at(loc),
        ),
      ),
    )
    it.note.body
  }

  set enum(numbering: "1.a.i.")

  show math.equation.where(block: true): eq => {
    block(width: 100%, inset: 0pt, align(center, eq))
  }

  set page(
    paper: "a4",
    header: context {
      if here().page() != 1 {
        set align(center)
        block(
          width: header-footer-width,
          [
            #title
            #h(1fr)
            #name
            #v(-0.66em)
            #line(length: 100%)
          ],
        )
      } else {
        []
      }
    },
    footer: context {
      set align(center)
      set block(width: header-footer-width)
      line(length: 100%)
      v(-0.66em)
      align(center)[#here().page()]
    },
  )

  let date = datetime.today()
  let ord_ind = if date.day() >= 10 and date.day() <= 20 {
    "th"
  } else if calc.rem(date.day(), 10) == 1 {
    "st"
  } else if calc.rem(date.day(), 10) == 2 {
    "nd"
  } else if calc.rem(date.day(), 10) == 3 {
    "rd"
  } else {
    "th"
  }

  align(center)[
    = #title
    == #name
    === #date.display("[day padding:none]" + ord_ind + " [month repr:long] [year]")
    #block(
      width: header-footer-width,
      line(length: 100%),
    )
  ]

  doc
}


#let appendix(body) = {
  set heading(numbering: "A.1 :", supplement: [Appendix])
  body
}
