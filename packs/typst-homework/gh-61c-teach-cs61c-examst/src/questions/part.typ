#import "../states.typ": *

#let add-points-hidden(n) = context {
  let question-number = question-num.get().at(0)

  questions.update(it => {
    it.at(question-number - 1).points += n
    return it
  })
}

#let add-points(n) = context {
  add-points-hidden(n)
  if n > 0 [(#n #if n == 1 [point] else [points])]
}

#let qref(label) = context {
  "Q"
  str(question-num.at(label).at(0))
  "."
  str(part-num.at(label).at(0))
}

#let qref-raw(label) = context {
  raw("Q" + str(question-num.at(label).at(0)) + "." + str(part-num.at(label).at(0)))
}

#let qnum() = context [
  Q#question-num.get().at(0).#part-num.get().at(0)
]

#let subqnum() = context [
    Q#question-num.get().at(0).#part-num.get().at(0).#sub-part-num.get().at(0)
]

#let part(
  points: none,
  noprompt: false,
  body,
) = {
  block(height: auto, breakable: false)[
    #part-num.step()
    #if points == none { points = 1 }

    #context {
      if noprompt {
        stack(dir: ltr, spacing: 0.5em, qnum(), add-points(points), block(width: 80%, body))
      } else {
        grid(
          columns: (2em, 1fr),
          align: (right + top, left + top),
          inset: 2pt,
          qnum(),
          [
            #add-points(points)
            #body
          ],
        )
      }
    }
  ]
}

#let subpart(
  points: none,
  noprompt: false,
  body,
) = {
  block(height: auto, breakable: false)[
    #sub-part-num.step()
    #if points == none { points = 1 }

    #context {
      if noprompt {
        stack(dir: ltr, spacing: 0.5em, subqnum(), add-points(points), block(width: 80%, body))
      } else {
        grid(
          columns: (4em, 1fr),
          align: (right + top, left + top),
          inset: 2pt,
          subqnum(),
          [
            #add-points(points)
            #body
          ],
        )
      }
    }
  ]
}

#let subparts(
  ..body
) = {
  for b in body.pos() {
    b
  }
}

