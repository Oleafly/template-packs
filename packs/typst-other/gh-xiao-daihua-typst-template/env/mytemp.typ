#import "lib.typ": *

#let notetemp(
    title: [Paper Title],
    author: [Albert Einstein],
    date: datetime.today().display("[month repr:long] [day], [year]"),
    abstract: none,
    doc,
) = {
    set page(
        paper: "a4",
        margin: (x: 25mm, y: 25mm),
        numbering: "1",
    )
    set par(
        justify: true,
        spacing: 1em,
        first-line-indent: 1.5em,
    )
    set text(
        size: 11pt,
        font: ("New Computer Modern", "Songti SC"),
    )
    set heading(numbering: "1.1")
    show heading: it => {
        it
        v(0.3em)
    }

    show link: it => {
        text(fill: rgb("#2F6FD6"))[#it]
    }
    set math.equation(numbering: "(1.1)")
    show: thmbox-init()
 align(center)[
        #v(2em)
        #text(
            size: 18pt,
        )[#title]
        #v(0.5em)

        #text(size: 13pt)[
            #author \
      \
            #date
        ]
    ]
    v(1em)

    if abstract != none {
        align(center)[
            #strong[Abstract]
        ]
        v(-1em)
        align(left)[
            #text(size: 11pt)[\ #abstract]
        ]
    }
    v(1.7em)

    outline()
    v(1.5em)

    doc
}

