#import "../components/font.typ": bold_upper

#let cover(
  title,
  author,
  supervisor,
  second,
  advisor,
  date
) = {
  set text(size: 1.2em)
  set page(numbering: none)
  place(
    top + center,
    dy: 6em,
    {
      pad(
        x: 10%,
        stack(
          spacing: 4em,
          image("../res/nordakademie_logo.png", width: 60%),
          bold_upper([Bachelor's Thesis in Software Engineering]),
          text(size: 2em, title)
        )
      )
    }
  )
  place(
    bottom + center,
    {
      show table.cell.where(x: 0): text.with(weight: 700)
      table(
        columns: 2,
        stroke: none,
        align: left,
        inset: 7pt,
        [Author:], author,
        [Supervising examiner:], supervisor,
        [Second examiner:], second,
        [Advisor:], advisor,
        [Submission Date:], date,
      )
    }
  )
  pagebreak()
}
