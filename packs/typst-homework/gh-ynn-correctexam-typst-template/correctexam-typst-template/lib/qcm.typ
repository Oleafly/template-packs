#import "markers.typ": _question-counter, _sub-counter, _exercise-counter, _emit-marker

#let _qcm-item(content) = [
  #text(size: 1.1em)[□]
  #h(0.35em)
  #content
]

#let qcm(columns: 1, ..items) = context {
  // Default is a single column to match historical LaTeX/CorrectExam expectations.
  // Multi-column layout remains available through the `columns` argument.
  let choices = items.pos()
  if choices.len() == 0 {
    panic("qcm requires at least one choice")
  }

  let q = _question-counter.get().first()
  let sub = _sub-counter.get().first()
  let ex = _exercise-counter.get().first()
  let key = "correctexam-answer-" + str(q) + "-" + str(sub) + "-" + str(ex)
  let safe-cols = int(calc.max(columns, 1))
  let safe-items = choices

  [
    #layout(size => {
      let row-count = int(calc.ceil(safe-items.len() / safe-cols))
      let rows = stack(
        spacing: 0.12cm,
        ..range(row-count).map(r => {
          grid(
            columns: safe-cols,
            column-gutter: 0.8cm,
            ..range(safe-cols).map(c => {
              let idx = r * safe-cols + c
              if idx < safe-items.len() {
                [#_qcm-item(safe-items.at(idx))]
              } else {
                []
              }
            }),
          )
        }),
      )

      let zone = box(width: size.width)[#rows]
      let zone-height = measure(zone).height

      [
        #_emit-marker(key, size.width, zone-height, type: "qcm")
        #zone
      ]
    })
    #_sub-counter.step()
    #v(0.25cm)
  ]
}
