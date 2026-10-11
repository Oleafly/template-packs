#import "../utils/counter.typ": c-counter, choices

#let render-choice() = {
  context {
    let current-choices = choices.get()
    if current-choices.len() == 0 { return }

    let width = ()
    for (letter, content) in current-choices {
      let choice-text = text[#letter. ] + content
      let measured = measure(choice-text)
      width.push(measured.width)
    }
    
    let max = calc.max(..width)
    let total = width.sum()
    let container = 9.82cm
    let margin = measure([#h(18pt)]).width
    let available = container - margin

    v(0.2em)

    if max <= available * 0.25 and total <= available * 0.8 {
      pad(left: 18pt, {
        set par(justify: false)
        
        grid(
          columns: (1fr,) * current-choices.len(),
          column-gutter: 1em,
          ..current-choices.map(((letter, content)) => [
            #text[#letter. ]#content
          ])
        )
      })
      
    } else if max <= available * 0.45 {
      let fit = true
      let i = 0
      while i < current-choices.len() and fit {
        let left = if i < width.len() { width.at(i) } else { 0pt }
        let right = if i + 1 < width.len() { width.at(i + 1) } else { 0pt }

        if (left + right) > available * 0.9 {
          fit = false
        }
        i += 2
      }
      
      if fit {
        pad(left: 18pt, [
          #let left = ()
          #let right = ()

          #for (i, choice) in current-choices.enumerate() {
            if calc.rem(i, 2) == 0 {
              left.push(choice)
            } else {
              right.push(choice)
            }
          }
          
          #grid(
            columns: (1fr, 1fr),
            column-gutter: 2em,
            [
              #for (letter, content) in left [
                #set par(justify: false)
                #text[#letter. ]#content
                #v(0.3em)
              ]
            ],
            [
              #for (letter, content) in right [
                #set par(justify: false)
                #text[#letter. ]#content
                #v(0.3em)
              ]
            ]
          )
        ])
      } else {
        for (letter, content) in choices {
          pad(left: 18pt, [
            #set par(hanging-indent: 1.2em, justify: false)
            #text[#letter. ]#content
          ])
          v(0.3em)
        }
      }
      
    } else {
      for (letter, content) in current-choices {
        pad(left: 18pt, [
          #set par(hanging-indent: 1.2em, justify: false)
          #text[#letter. ]#content
        ])
        v(0.3em)
      }
    }
    
    v(0.5em)
    choices.update(())
  }
}

#let choice(body) = {
  c-counter.step()
  context {
    let current = c-counter.get().first()
    let letter = numbering("A", current)
    choices.update(choices => choices + ((letter, body),))
  }
  []
}


#let reset-choice() = {
  c-counter.update(0)
}
#let finish-choice() = {
  render-choice()
}