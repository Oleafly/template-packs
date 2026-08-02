#import "@preview/drafting:0.2.2": *

#let wideblock(content) = block(width: 100% + 5cm, content)

#let abstractblock(abstract) = context {
    block(inset: (left: 1cm, right: 1cm))[
        #par(justify: true, leading: .4em, text(size: 9pt, abstract))
        #v(1cm)
    ]
}

#let titleblock(title: none, subtitle: none) = context {
    set text(
        hyphenate: false,
        size: 20pt,
        // font: sans-fonts,
    )
    set par(
        justify: false,
        leading: 0.2em,
        first-line-indent: 0pt,
    )
    title
    set text(size: 11pt)
    v(-0.65em)
    subtitle
}

#let authorsblock(authors) = context {
    v(1em)
    for i in range(calc.ceil(authors.len() / 3)) {
        let end = calc.min((i + 1) * 3, authors.len())
        let is-last = authors.len() == end
        let slice = authors.slice(i * 3, end)
        grid(
            columns: slice.len() * (1fr,),
            gutter: 11pt,
            ..slice.map(author => align(left, {
                upper(author.name)
                if "role" in author [
                    \ #author.role
                ]
                if "organization" in author [
                    \ #author.organization
                ]
                if "email" in author [
                    \ #author.email
                ]
            }))
        )

        if not is-last {
            v(16pt, weak: true)
        }
    }
}


#let tufte(
    title: "Untitled",
    header-title: "Docs Descriptive Heading",
    authors: (),
    abstract: none,
    date: datetime.today(),
    font: "Palatino",
    mono-font: "FiraCode Nerd Font",
    doc,
) = {
    // Document metadata
    set document(title: title, author: authors.map(author => author.name))

    // layout
    let date-str = if date == none { "" } else { date.display() }
    set page(
        paper: "us-letter",
        margin: (left: 3cm, right: 2.5cm, top: 2.5cm, bottom: 2cm),
        header: context {
            if counter(page).get().first() > 1 {
                [#date-str  #h(1fr) #header-title]
            }
        },
        footer: context {
            align(center, counter(page).display())
        },
    )
    set text(font: font)
    set align(center)
    titleblock(title: title)

    set-page-properties()
    set-margin-note-defaults(
        stroke: none,
        side: right,
        margin-right: 5cm,
    )

    if authors.len() > 0 { authorsblock(authors) }
    if abstract != none { abstractblock(abstract) }

    // style
    set par(justify: true)
    set align(left)
    set heading(numbering: "1.1.1.1. ")
    set math.equation(numbering: "(1)")
    show raw: set text(font: mono-font, size: 7pt)

    // content
    v(1cm)
    text(size: 10pt, block(width: 100% - 5cm, doc))
}

#let notecounter = counter("notecounter")
#let note(dy: -2em, dx: -4cm, numbered: true, content, ..args) = {
    let note-number-to-display = none // Will hold the number to use

    if numbered {
        notecounter.step() // Increment the counter
        // Get the *current* state of the counter after stepping, as a content block.
        note-number-to-display = context { notecounter.display() }
    }

    // Main text marker
    let main-text-marker = if numbered {
        context {
            super(size:8pt,note-number-to-display) // Use the captured content for superscript
        }
    } else {
        [] // No marker
    }

    // Margin note block
    let margin-note-block = text(
        size: 9pt,
        margin-note(
            if numbered {
                text(
                    size: 9pt,
                    {
                        // Use the same captured content for superscript in margin note
                        context {
                            super(size:8pt, note-number-to-display)
                        }
                        text(size: 9pt, " ")
                    },
                )
                content
            } else {
                content
            },
            dy: dy,
            page-offset-x: dx,
        ),
    )

    // Return both parts
    (main-text-marker + margin-note-block)
}


#let inline-review(color: red, size: 8pt, content, ..args) = {
    inline-note(
        fill: color.lighten(60%),
        text(size: size, content),
        ..args,
    )
}

#let side-review(color: red, size: 8pt, dx: -4cm, content, ..args) = {
    text(
        size: size,
        margin-note(
            fill: red,
            stroke: red,
            page-offset-x: dx,
            content,
        ),
    )
}

