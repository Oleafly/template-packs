// Contains general macros to be used across the template

#let uqHeaderSize = 26pt
#let topPadding = 2em
#let bottomPadding = 1em

#let uqHeaderNoChapter(it) = {
    v(topPadding)

    text(uqHeaderSize)[* #it.body * ]

    v(bottomPadding)
}

#let uqHeaderChapter(it) = {
    v(topPadding)

    // #counter(heading).display( it.numbering )
    text(uqHeaderSize)[* Chapter #counter(heading).display("1") *]

    v(-15pt)

    text(uqHeaderSize)[* #it.body * ]

    v(bottomPadding)
}

#let appendices(content) = {
    set heading(numbering: (..numbers) => {
        return "Appendix " + numbering("A.1", ..numbers)
    })
    show heading.where(level: 1): it => {
        v(topPadding)
        text(uqHeaderSize)[* #counter(heading).display(it.numbering) #it.body *]
        v(bottomPadding)
    }
    counter(heading).update(0)
    content
}
