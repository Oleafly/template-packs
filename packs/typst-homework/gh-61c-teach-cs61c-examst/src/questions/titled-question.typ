#import "../states.typ"

#let titled-question(
  title: "CS61KaChow",
) = {
  states.question-num.step()
  states.part-num.update(0)
  let question-number = states.question-num.get().at(0)
  states.questions.update(it => { 
    it.push((
      num: question-number + 1,
      points: 0
    ))
    return it
  })
  
  v(-12pt)
  context [
    #show raw: set text(style: "normal", weight: 700)
    #let question-number = states.question-num.get().at(0)
    #grid(
      columns:(auto, 1fr, auto),
      align: (left + bottom, left + bottom, right + bottom),
      [ Q#question-number #h(0.5em) #metadata(question-number)<titled-question>],
      text(size: 12pt, style: "italic")[ #title ],
      text(size: 12pt, style:"normal", baseline: 2pt)[ (#states.questions.at(<exam-end>).at(question-number - 1).points points) ]
    )
  ]

  v(12pt)
}

#let titled-subquestion(
  title: "CS61CSubKaChow"
) = {
  // states.question-num.step()
  states.part-num.step()
  states.sub-part-num.update(0)
  let question-number = states.question-num.get().at(0)
  context [
    #set text(size: 12pt)
    #show raw: set text(style: "normal", weight: 700)
    #let question-number = states.question-num.get().at(0)
    #let part-number = states.part-num.get().at(0)
    #grid(
      columns:(0.15fr, 1fr, 1fr),
      align: (left + bottom, left + bottom, right + bottom),
      [ Q#question-number.#part-number #metadata(question-number)<titled-question>],
      text(size: 12pt, style: "italic")[ #title ],
      // text(size: 12pt, style:"normal", baseline: 2pt)[ (#states.questions.at(<exam-end>).at(question-number - 1).points points) ]
    )
  ]

  v(12pt)
}
