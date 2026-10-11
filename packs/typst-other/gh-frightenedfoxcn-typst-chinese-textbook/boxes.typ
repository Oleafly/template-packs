#import "@preview/showybox:2.0.3": *
#import "fontconfig.typ": *

#let outlinebox(it) = [
  #showybox(
    frame: (
      body-color: blue.lighten(80%),
      radius: 0pt,
      thickness: 0pt,
    )
  )[
    #v(2em)
    #text(size: 18pt, font: ("Times New Roman", "STHeiti"), weight: "bold", fill: blue.darken(40%), align(right)[#it.body])
  ]
  #v(2em)
]

#let headingbox(it) = if it.level == 1 {
  showybox(
    frame: (
      body-color: blue.lighten(80%),
      radius: 0pt,
      thickness: 0pt,
      title-color: color.rgb(0, 0, 0, 0),
    ),
    title-style: (
      sep-thickness: 0pt,
      color: blue.darken(20%).desaturate(50%),
      boxed-style: (
        anchor: (
          x: right,
          y: horizon,
        ),
        offset: (
          x: 3.5em
        )
      )
    ),
    title: text(size: 100pt, font: ("Cambria"), style: "italic", [#counter(heading).get().at(0)])
  )[
    #text(size: 18pt, font: ("Times New Roman", "STHeiti"), weight: "bold", fill: blue.darken(40%), align(right)[#it.body])
  ]
  v(25pt)
  } else {
  showybox(
    frame: (
      radius: 0pt,
      thickness: 0pt,
    ),
    text(size: 16pt, font: ("Times New Roman", "STZhongsong"), weight: "bold", fill: blue.darken(40%), align(center)[
      #counter(heading).display() #h(1em)
      #it.body
    ])
  )
}

#let infobox(title : none, body) = showybox(
  frame: (
    border-color: blue,
    title-color: blue.lighten(80%),
    radius: 0pt,
    thickness: (y: 1pt),
    body-inset: (y: 1.5em),
  ),
  title-style: (
    sep-thickness: 1pt,
    color: black,
  ),
  align: center,
  title: if title != none {
    text(font: title-fonts, title)
  } else {
    ""
  }, 
  breakable: true,
  [
    #text(font: remark-fonts, body)
  ]
)

#let extrabox(body) = showybox(
  frame: (
    thickness: 0pt,
    radius: 5pt,
    body-inset: 1em,
    body-color: blue.lighten(80%)
  ), [
    #h(2em) #text(font: remark-fonts, body)
  ]
)

#let partpage(name) = page(
  header: none,
  footer: none
  ,{
    align(right + horizon, [
      #show figure.caption: it => {}
      #context figure(
      kind: "part",
      supplement: [Part],
      caption: name,
      numbering: "A",
      showybox(
        frame: (
          border-color: white,
          body-color: blue.lighten(80%),
          radius: 0pt,
          thickness: 0pt,
          title-color: rgb(0, 0, 0, 0),
          body-inset: (top: 2em)
        ),
        title-style: (
          sep-thickness: 0pt,
          color: blue.darken(20%).desaturate(50%),
          boxed-style: (
            anchor: (
              x: right,
              y: horizon,
            ),
          )
        ),
        title: text(size: 50pt, font: (heading-num-fonts), style: "italic", [Part #numbering("A", counter("part").get().at(0))]),
        align(right, box(inset: 2em)[#text(size: 25pt, font: title-fonts, fill: blue.darken(40%))[#name #counter("part").step()]])
    ))])
  })

#let signature(content) = showybox(
  frame: (
    thickness: 0pt,
    radius: 0pt,
    inset: (top: 2pt),
    // body-color: blue.lighten(80%)
  ),
  [
    #set text(
      font: code-fonts,
    )
    #show emph: set text(
      font: code-fonts
    )
    #show strong: set text(
      font: code-fonts
    )
    #h(-2em, weak: true) #content
    #v(8pt)
  ]
)

#let funcbox(
  name,
  keyword: none,
  mandatory-args: none,
  selective-args: none,
  docs: none,
  ending: true
) = showybox(
    frame: (
    thickness: 0pt,
    radius: 0pt,
    inset: (bottom: if ending {2pt} else {-6pt}, top: 2pt),
    // body-color: blue.lighten(80%)
  ),
  [
    #set text(
      font: code-fonts,
    )
    #show emph: set text(
      font: code-fonts
    )
    #show strong: set text(
      font: code-fonts,
    )
    #text(fill: purple)[#h(-2em, weak: true) #keyword ]#name`(`#if mandatory-args != none {
      for (idx, i) in mandatory-args.enumerate() {
        emph[#i] + if idx != mandatory-args.len() - 1 {
          emph[, ]
        }
      }
    }#if selective-args != none {
      for (idx, i) in selective-args.enumerate() {
        text(fill: luma(160), style: "italic", [, ] + i)
      }
    }`)`
    #if docs != none {
      text(font: remark-fonts, rect(
        stroke: (left: 2pt + luma(200)),
        inset: (top: 0pt, left: 16pt),
        outset: (left: -5pt)
      )[
        #set par(
          first-line-indent: (amount: 0em, all: true)
        )
        #show emph: set text(
          font: remark-fonts
        )
        #show strong: set text(
          font: remark-fonts
        )
        #docs
      ])
    }
  ]
)