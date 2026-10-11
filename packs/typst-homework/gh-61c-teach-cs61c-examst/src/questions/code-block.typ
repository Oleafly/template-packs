#import "../states.typ": *
#import "part.typ": qnum

#let custom-blank(it) = context {
  let len-re = regex("(\{\d+\})")
  let undertext = it.text.trim(len-re).slice(2, -2).trim("\s")
  let txt = it.text

  let width = 10em
  let inset = 3pt
  let outset = 1pt

  if txt.contains(len-re) {
    width = int(txt.find(len-re).find(regex("\d+"))) * measure(` `).width
  }
  box(
    stroke: (bottom: 1pt + black),
    inset: (bottom: inset),
    height: 0.5em,
    width: width,
    outset: (bottom: outset),
    [
      #place(bottom + center, dy: 11pt, text(size: 8pt, undertext))
    ],
  )
}

#let code-blank(it) = context {
  let disp = print-answers.get()
  let len-re = regex("(\{\d+\})")
  let sol = it.text.trim(len-re).slice(2, -2).trim("\s")
  let txt = it.text


  let width = if disp {
    calc.max(measure(sol).width, measure(qnum()).width)
  } else { 10em }
  let inset = if disp { 0pt } else { 3pt }
  let outset = if disp { 2pt } else { 0pt }

  part-num.step()

  if txt.contains(len-re) and not print-answers.get() {
    width = int(txt.find(len-re).find(regex("\d+"))) * measure(` `).width
  }
  box(
    stroke: (bottom: 1pt + black),
    inset: (bottom: inset),
    height: 1em,
    width: width,
    outset: (bottom: outset),
    [
      #if print-answers.get() {
        // set text(fill: red)
        align(center + bottom, sol)
      }
      #place(bottom + center, dy: 11pt, text(size: 8pt, qnum()))
    ],
  )
}

#let code-block(it, ans-space: 0.5em, disp-nums: false, post-pad: 0em) = {
  set text(top-edge: 0pt)
  set align(top)
    
  let line_no = counter("line-no")
  line_no.update(0)
  line_no.step()

  let re = regex("<\|.*?\|>(\{\d+\})?")
  let custom-re = regex("@\|.*?\|@(\{\d+\})?")
  
  block(
    height: auto, width: 100%, breakable: false,
    stroke: 0.5pt, inset: (left: -1.4em, top: 0.6em)
  )[
    #table(
      stroke: 0pt,
      columns: (1.4em, 1fr), row-gutter: 4pt,
      align: (right + bottom, left),
      ..for line in it.text.split("\n") {
        let lower_pad = if line.contains(re) { ans-space } else { 0em } 
        (
          context [ 
            #if disp-nums { line_no.get().at(0) }
            #v(lower_pad)
          ], 
          [
            #show re: it => code-blank(it)
            #show custom-re: it => custom-blank(it)
            #line_no.step()
            
            #line
            #v(lower_pad)
          ]
        )
      }
    )
    #if (it.text.split("\n").at(-1).match(re) != none 
    or   it.text.split("\n").at(-1).match(custom-re) != none) {
      v(post-pad)
    }
  ]
}

