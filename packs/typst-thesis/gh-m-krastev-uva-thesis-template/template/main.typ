#import "@preview/great-theorems:0.1.1": *
#import "@preview/rich-counters:0.2.1": *

// A show rule for the template.
#let uva-thesis(body) = [
    /*
        LaTeX-like look from https://typst.app/docs/guides/guide-for-latex-users,
        tweaked to look like https://codeberg.org/m4lvin/illc-uva-thesis-template
        (page margins cannot quite be the same, as Typst and LaTeX
        handle margins/paddings somewhat differently).
      */
    #set page(margin: (bottom: 2.8cm, rest: 2.1cm), footer-descent: 40%)
    #set par(leading: .85em, first-line-indent: 1.8em, justify: true)
    #set text(font: "New Computer Modern", size: 11pt)
    // New computer Moderno Mono is not shipped with Typst, and it would be
    // excessive to only ship it with the package for raw text, as it requires its
    // own CLi flag
    // #show raw: set text(font: "New Computer Modern Mono")
    #show heading: set block(above: 1.4em, below: 1em)

    // uva thesis look from https://codeberg.org/m4lvin/illc-uva-thesis-template
    #set page(numbering: "1")
    #set heading(numbering: "1.1.1.1")
    #set outline(indent: 2em)
    #set cite(style: "institute-of-electrical-and-electronics-engineers")
    #set bibliography(style: "institute-of-electrical-and-electronics-engineers")
    #show: great-theorems-init

    #body
]

// A parametric, non-numbered thesis titlepage...
#let uva-titlepage(
    title: "The Answers to Life, the Universe, and Everything",
    author: "John Q. Public",
    student-number: "12345678",
    supervisors: ("John Smith",),
    examiner: "Jane Doe",
    second-reader: "John Doe",
    degree: "MSc Artificial Intelligence",
    credits: "42 EC",
    date: datetime.today(),
    period: "Period in which the research was carried out",
    content,
) = {
    set align(center)
    // Size of the thesis's title
    let title-size = 17pt
    // Size of frontpage elements that should be smaller of the thesis's title
    // alone
    let subtitle-size = 14pt

    set page(numbering: none)

    v(30pt)

    text(smallcaps(degree) + "\n" + smallcaps("Master Thesis"), size: subtitle-size, weight: 500)

    line(length: 100%)

    text(smallcaps(title), size: title-size, weight: 100)

    line(length: 100%)

    text("by")

    linebreak()

    text(size: subtitle-size)[#smallcaps[#author]]

    linebreak()

    student-number

    v(1em)

    text(size: subtitle-size)[#date.display("[month repr:long] [day padding:zero], [year]")]

    v(1em)

    credits
    v(-0.5em)
    period

    v(1em)

    pad(left: 30%)[
        #align(left)[
            #text(style: "italic")[Supervisor:]
            #linebreak()
            #supervisors.map(smallcaps).join(", ")
        ]
    ]

    pad(right: 30%)[
        #align(right)[
            #text(style: "italic")[Examiner:]
            #linebreak()
            #smallcaps[#examiner]

            #v(1em)

            #text(style: "italic")[Second reader:]
            #linebreak()
            #smallcaps[#second-reader]
        ]
    ]

    align(
        bottom,
        image(
            "uvalogo_regular_p_nl.svg",
            alt: "University of Amsterdam logo. A white U combined with the 3 Saint Andrew's crosses symbolizing the City of Amsterdam on a square black background. The accompanying text says 'Universiteit van Amsterdam'.",
            width: 65%,
        ),
    )

    pagebreak()

    set align(left)
    content
}
// A non-numbered page dedicated to the thesis abstract.
#let uva-abstract(body) = [
    #set page(numbering: none)
    #align(center + horizon, heading("Abstract", numbering: none, outlined: false))
    #body
    #pagebreak()
    #counter(page).update(1)
]

// A first-level heading dedicated to thesis chapters.
#let uva-chapter(body) = [
    #pagebreak()
    #hide(heading(body, hanging-indent: 0pt, level: 1, supplement: [Chapter]))
    #text(size: 28pt, weight: "bold")[
        #set par(first-line-indent: 0pt)
        #text(size: 24pt, [Chapter #context counter(heading).display()])

        #body
    ]
]

// A counter for mathematical blocks
#let mathcounter = rich-counter(identifier: "mathblocks", inherited_levels: 1)

// A block for mathematical definitions
#let definition = mathblock(blocktitle: "Definition", counter: mathcounter)

// A block for mathematical theorems
#let theorem = mathblock(blocktitle: "Theorem", counter: mathcounter)

// A block for mathematical lemmas
#let lemma = mathblock(blocktitle: "Lemma", counter: mathcounter)

// A block for mathematical corollaries
#let corollary = mathblock(blocktitle: "Corollary", counter: mathcounter)

// A block for mathematical remarks
#let remark = mathblock(blocktitle: "Remark", prefix: [_Remark._])

// A block for mathematical proofs
#let proof = proofblock()
