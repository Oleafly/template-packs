#import "../theme.typ": *

#let heading-style(body) = {
  show heading: set text(font: f-sans-bold, fill: c-ink)

  set heading(numbering: (..numbers) => {
    let n = numbers.pos()
    assert(
      n.len() <= 6,
      message: "Intestazione con profondità anomala ("
        + str(n.len())
        + " livelli). "
        + "Controlla se nel capitolo corrente c'è una riga che inizia con uno o più '=' "
        + "usata per sbaglio come separatore invece che con #line().",
    )
    if n.len() == 1 {
      numbering("I", ..n)
    } else if n.len() == 2 {
      numbering("1", ..n.slice(1))
    } else {
      numbering("1.1", ..n.slice(1))
    }
  })

  body
}
