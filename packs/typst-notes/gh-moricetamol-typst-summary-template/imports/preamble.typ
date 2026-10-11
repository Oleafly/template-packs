#import "template.typ": apply-format, hor-rule, big-rule, main-color, math-color, code-color
#import "@preview/hydra:0.6.2": hydra, anchor


#let init(body, name: "Title", description: lorem(20), dark-mode: false, language: "en") = [
  #show: apply-format.with(
    name: name,
    description: description,
    dark: dark-mode,
  )

  #heading(numbering: none, outlined: false)[
    #if language == "en" [
      Contents
    ] else if language == "de" [
      Inhalt
    ] else [
      Language not defined
    ]
  ]
  #columns(2)[
    #outline(title: none) // title needs to be none, otherwise it will also be compressed into the column
  ]
  #pagebreak()

  // Set header
  #set page(
    header: context {
      let starts-l1 = query(heading.where(level: 1).after(here()))
      if starts-l1.len() > 0 and starts-l1.first().location().page() == here().page() {
        return
      }
      
      columns(2, gutter: 0pt)[
        #align(left)[#emph(hydra(1))]
        #colbreak()
        #align(right)[#emph(hydra(2))]
      ]
      hor-rule(stroke: 1pt)
    },
  )

  // Set footer
  #set page(footer: context{
    align(right)[
      #counter(page).display(
        "1|1",
        both: true
      )
    ]
  })
  // Reset page numbering
  #counter(page).update(1)

  #body
]