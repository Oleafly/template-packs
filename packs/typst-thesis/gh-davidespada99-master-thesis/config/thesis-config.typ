#import "../config/constants.typ": chapter
#import "../config/variables.typ": myName, myTitle, myTitle2, myLang,

// Monospace cell helper — available for import in all files
#let mc(content) = text(font: "Source Code Pro", size: 7pt, content)

#let config(
    myAuthor: myName,
    myTitle: myTitle+myTitle2,
    myLang: myLang,
    body
) = {
  // Set the document's basic properties.
    set document(author: myAuthor, title: myTitle)
    show math.equation: set text(weight: 400)

    // LaTeX look 
    set page(
        margin: 3.3cm, 
        number-align: center)

    
    // set par(leading: 0.55em, first-line-indent: 1.8em, justify: true)
    set par(
        leading: 0.85em,
        spacing: 0.85em,
        first-line-indent: (
            amount: 1.2em,
            all: false,
            ),
        justify: true
    )

    
    set text(
        font: "EB Garamond", 
        size: 10.5pt, 
        features: (onum: 1, liga: 1),
        lang: myLang,
        )

    show figure.caption: set text(size: 9.5pt)
    show figure.where(kind: raw): set figure(supplement: "Code")

    set heading(numbering: "1.1.1.1")
    // Figure numbering: chapter.figure (e.g., 1.1, 1.2, 2.1, etc.) or A.1, A.2, ... in appendix
    set figure(numbering: num => {
        let heads = counter(heading).get()
        let in-appendix = state("appendix-mode", false).get()
        if in-appendix {
            // numbering("A.1", 1, n) → "A.1"; ("A.1", 2, n) → "B.1" for appendix B, etc.
            numbering("A.1", ..heads.slice(0, calc.min(1, heads.len())), num)
        } else {
            numbering("1.1", ..heads.slice(0, calc.min(1, heads.len())), num)
        }
    })

    // "Source Code Pro" for code blocks
    show raw: set text(font: "Source Code Pro", size: 7.5pt, lang: myLang)

    show heading: set block(above: 1.5em, below: 1em)

    set list(indent: 1em)
  
    show heading: it => {
        if it.level == 1 and it.numbering != none {
            v(10em)
            align(right, 
                stack(
                dir: ttb,
                spacing: 1em,
                if it.numbering != none {
                    text(size: 6em, fill: rgb("#B5001B"), features: (onum: 0, liga: 0))[#counter(heading).display(it.numbering)]
                },
                text(size: 2em, it.body),
                []
            ))
        }
        // Abstract, acknowledgements, etc.
        else if it.level == 1 and it.numbering == none {
            align(right, 
                stack(
                dir: ttb,
                spacing: 1em,
                if it.numbering != none {
                    text(size: 5em, fill: rgb("#B5001B"), features: (onum: 0, liga: 0))[#counter(heading).display("1")]
                },
                text(size: 1.8em, it.body),
                []
            ))
        }
        else if it.level == 2 {
            v(1.3em)
            align(left, 
                stack(
                    dir: ltr,
                    spacing: 1.5em,
                    if it.numbering != none {
                        text(size: 1.3em, font: "EB Garamond", weight: "light",  features: (onum: 1, liga: 1))[#counter(heading).display("1.1")]
                    },
                    text(size: 1.3em, weight: "light")[#smallcaps(it.body)],
                ))
            v(0.5em)
        }
        else if it.level == 3 {
            align(left, 
            stack(
                dir: ltr,
                spacing: 1em,
                if it.numbering != none {
                    text(size: 1.2em, font: "EB Garamond", weight: "light",  features: (onum: 1, liga: 1))[#counter(heading).display("1.1")]
                },
                text(size: 1.2em, weight: "light")[#smallcaps(it.body)],
                []
            ))
        }
        else if it.level > 3 {
            align(left, 
            stack(
                dir: ltr,
                spacing: 1em,
                if it.numbering != none {
                    text(size: 1em, font: "EB Garamond", weight: "light",  features: (onum: 1, liga: 1))[#counter(heading).display("1.1")]
                },
                text(size: 1em, weight: "light")[#smallcaps(it.body)],
                []
            ))
        }

    }
    
    body

}
