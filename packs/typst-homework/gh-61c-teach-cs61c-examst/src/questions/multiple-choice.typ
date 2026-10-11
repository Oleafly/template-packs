#import "../states.typ"

#let _correct() = context [
  #let fill = white

  #if states.print-answers.get() {
    fill = black
  }

  #square(size: 10pt, fill: fill, stroke: black)
  #if states.show-answer-letters.get() {
    states.answer-letters.step()
    set text(size: 8pt)
    place(center + horizon)[
      #set text(size: 8pt, weight: 700)
      #states.answer-letters.display("A")
    ]
  }
]

#let _bad() = context [
  #let check-stroke = stroke(
    thickness: 2.3pt,
    paint: luma(50%),
    cap: "round",
  )

  #place(
    center + horizon,
    dx: -1.5pt,
    dy: 1.5pt,
    [ #line(length: 4pt, angle: 55deg, stroke: check-stroke) ],
  )

  #place(
    center + horizon,
    dx: 2pt,
    dy: 3.1pt,
    [ #line(length: 8pt, angle: -60deg, stroke: check-stroke) ],
  )

  #square(size: 10pt, stroke: black)
  #if states.show-answer-letters.get() {
    states.answer-letters.step()
    place(center + horizon)[
      #set text(size: 8pt, weight: 700)
      #states.answer-letters.display("A")
    ]
  }
]

#let _choice() = context [
  #square(size: 10pt, stroke: black)[]
  #if states.show-answer-letters.get() {
    states.answer-letters.step()
    place(center + horizon)[
      #set text(size: 8pt, weight: 700)
      #states.answer-letters.display("A")
    ]
  }
]

#let correct(body) = {
  (
    "selection": _correct,
    "body": [#body],
  )
}

#let bad(body) = {
  (
    "selection": _bad,
    "body": [#body],
  )
}

#let choice(selection, body) = {
  grid(
    columns: 3,
    column-gutter: 5pt,
    align: horizon,
    [#h(6pt)], selection(), [#body],
  )
}

#let _multi-select-cols(cols, none-above, ..body) = {
  let num-items = body.pos().len() + if type(none-above) != none { 1 }
  let items-per-col = num-items / cols
  let rem = calc.rem(num-items, cols)
  let col-counter = 0
  let last-break = 0
  columns(cols)[
    #for (i, b) in body.pos().enumerate() {
      if type(b) == dictionary { choice(b.selection, b.body) }
      if type(b) == content { choice(_choice, b) }
      if cols == 1 { continue }
      if (
        (
          calc.rem(i + 1, calc.ceil(items-per-col)) == 0 and (i + 1) / calc.ceil(items-per-col) <= rem
        )
          or (
            calc.rem(i + 1, calc.floor(items-per-col)) == 0 and (i + 1) / calc.ceil(items-per-col) > rem
          )
            and i + 1 != num-items
      ) [ #colbreak() ]
    }
    #{
      show square: it => circle(radius: it.width.length / 2, fill: it.fill, stroke: it.stroke)
      if type(none-above) == bool {
        if none-above {
          choice(_choice, [None of the above])
        }
      } else if type(none-above) == type(auto) {
        if body.pos()
              .filter(it => type(it) == dictionary)
              .filter(it => it.selection == _correct)
              .len() == 0 {
                choice(_correct, [None of the above])
              } else {
                choice(_choice, [None of the above])
              }
      } else if type(none-above) == function {
        choice(none-above, [None of the above])
      }
    }
  ]
}

#let _multi-select-grid(cols, none-above, ..body) = {
  let lst = for (i, b) in body.pos().enumerate() {
    let result = none
    if type(b) == dictionary { result = choice(b.selection, b.body) }
    if type(b) == content { result = choice(_choice, b) }
    (result,)
  }
  
  states.answer-letters.update(1)
  if none-above != none {
    let num-items = body.pos().len()
    let num-cols = if type(cols) == int {
      cols
    } else if type(cols) == array {
      cols.len()
    }
    let none-above-span = num-cols - calc.rem(num-items, num-cols)

    lst.push(grid.cell(
      colspan: none-above-span,
      {
        show square: it => circle(radius: it.width.length / 2, fill: it.fill, stroke: it.stroke)
        if type(none-above) == bool and none-above{
          choice(_choice, [None of the above])
        } else if type(none-above) == type(auto) {
          if body.pos()
                .filter(it => type(it) == dictionary)
                .filter(it => it.selection == _correct)
                .len() == 0 {
                  choice(_correct, [None of the above])
                } else {
                  choice(_choice, [None of the above])
                }
        } else if type(none-above) == function {
          choice(none-above, [None of the above])
        }
      }
    ))
  }
  
  grid(
    columns: cols, column-gutter: 1em, row-gutter: 1em,
    ..lst.slice(0, -1), ..lst.slice(-1)
  )
}

#let multi-select(cols: 1, none-above: none, ..body) = {
  _multi-select-grid(cols, none-above, ..body)
}

#let multi-choice(cols, none-above, ..body) = {
  show square: it => circle(radius: it.width.length / 2, fill: it.fill, stroke: it.stroke)

  multi-select(cols, none-above, ..body)
}
