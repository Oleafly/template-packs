// This file is used to set universal formatting options

#import "fig.typ": _fig-num

#let style(doc) = {
  //Underlining for links
  
  show link: underline

  // Level 1 Heading formatting (Heading 1)
  set heading(numbering: "1.1.1")
  show heading.where(level: 1) : set heading(numbering: none)
  show heading.where(level: 1) : set text(size: 16pt)
  show heading.where(level: 1) : set align(center)

  show heading : it => {
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)
    it
  }

  show heading.where(level: 1): it => {
    counter(heading).step()
      it
  }
  // Level 2 heading formatting(Heading 2)
  show heading.where(level: 2) : set text(size: 14pt)

  // Level 3 heading formatting(heading 3)
  show heading.where(level: 3) : set text(size: 13pt)

  set page(
    paper: "a4",
    margin: (top: 1in, bottom: 1in, left: 1.5in, right: 1in)
  )
  set text(size: 12pt,
  font: "Times New Roman",
  top-edge: 1em
  )
  set figure(numbering: _fig-num)
  set page(numbering: "1")
  doc
}  
