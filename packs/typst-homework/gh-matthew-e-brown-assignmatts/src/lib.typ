#import "./palettes.typ" as palettes

/// A pre-configured block to place questions into.
#let question = block.with(
    width: 100%,
    inset: 1.0em,
    breakable: false,
    stroke: (left: 1pt + gray),
    radius: (right: 1pt),
    fill: luma(240),
)

/// General template for most written assignments.
#let assignment(
    /// The main title of the assignment. If it is not `none`, appears at the top of the first page
    /// and in the top-right of the page header.
    title: none,
    /// The student/author name. Appears underneath the title / and in the top-left of the page
    /// header. Currently, multiple authors are not supported.
    author: none,
    /// The `ABCD-1234H` course code. Appears next to the course name above the title, as well as in
    /// in the top-right of the page margins before the assignment title.
    course-code: none,
    /// The full name of the course. Appears above the title on the first page.
    course-name: none,
    /// The title to add to the PDF.
    pdf-title: none,
    /// The author(s) to add to the PDF.
    pdf-author: none,
    /// Set to `true` to put the title on its own page.
    title-page: false,
    /// Extra content to include underneath the title before the rest of the content. If
    /// `title-page` is `false`, it is placed directly after the title with a bit of extra space
    /// beneath it. If `title-page` is true, it is placed on the title page.
    preamble: none,
    /// What page size to use.
    page-size: "us-letter",
    /// How large to make the page margins.
    page-margins: 1in,
    /// The font-stack to use for main body text.
    main-font: ("New Computer Modern"),
    /// The font-stack to use for equations.
    math-font: ("New Computer Modern Math"),
    /// The font-stack to use for `raw` text elements.
    code-font: ("DejaVu Sans Mono"),
    /// The colour of the line that should separate footnotes from the rest of the document.
    footnotes-line-color: blue,
    /// Whether or not each page should have its own set of numbers/symbols for footnotes.
    footnotes-per-page: false,
    /// The body of the document.
    doc
) = {
    // A couple "private" defaults
    let par-spacing = 1.40em
    let par-leading = 0.70em

    // =============================================================================================
    // ==== General text styles and spacing
    // =============================================================================================

    // Set fonts
    set text(size: 11pt, font: main-font, lang: "en")
    show math.equation: set text(font: math-font)
    show raw: set text(font: code-font)

    show heading.where(level: 1): set text(size: 11pt * 1.2)
    show heading.where(level: 2): set text(size: 11pt * 1.1)

    // Block spacing
    set block(spacing: par-spacing) // Default spacing for all blocks, can be overridden
    show heading: set block(above: 1.6em, below: 1.2em)

    set par(leading: par-leading, spacing: par-spacing, linebreaks: "optimized")
    set list(indent: 1.25em)
    set enum(indent: 1.25em)

    // Highlight links blue and underline them, but only if they're hyperlinks
    show link: it => {
        if type(it.dest) == str and (
            it.dest.starts-with("http://") or
            it.dest.starts-with("https://") or
            it.dest.starts-with("mailto:") or
            it.dest.starts-with("tel:")
        ) {
            underline(text(fill: rgb(0, 98, 209), it))
        } else {
            it
        }
    }

    // =============================================================================================
    // ==== Page-wide layout
    // =============================================================================================

    set document(
        title: if pdf-title != auto { pdf-title } else if title != none [ #title ] else { none },
        author: if pdf-author != none { pdf-author } else { () },
    )

    // Creates a block that will extend horizontally outwards by half the page margins.
    let margin-block(body) = context {
        /// Helper for finding the absolute value of the page's horizontal margins.
        let margin-value(m) = if m == auto {
            // https://typst.app/docs/reference/layout/page/#parameters-margin says that, if `auto`,
            // "the margins are set automatically to 2.5/21 times the smaller dimension of the
            // page."
            calc.min(page.width, page.height) * 2.5 / 21
        } else if type(m) == relative {
            (page.width * m.ratio) + m.length
        }

        // We want the sides of our header/footer content to extend outwards an equal amount from
        // the center of the document, specifically, half the page margins. In cases where the
        // margins differ, we want to find the smaller of the two.
        let margin-size = if type(page.margin) == dictionary {
            // Left/right have precedence over inside/outside, and x is just a shorthand for setting
            // left/right. If it's a dictionary, it should always have L/R *or* inside/outside.
            if "left" in page.margin {
                let l = margin-value(page.margin.left)
                let r = margin-value(page.margin.right)
                calc.min(l, r)
            } else if "inside" in page.margin {
                let i = margin-value(page.margin.inside)
                let o = margin-value(page.margin.outside)
                calc.min(i, o)
            } else {
                panic("page margins are in an unknown format")
            }
        } else {
            // If it's not a dictionary, then it's either `auto` or a `relative`, which'd be the
            // same for all four sides. Just use that value directly.
            margin-value(page.margin)
        }

        set text(size: 0.90em)
        move(dx: -(margin-size / 2), block(width: 100% + margin-size, body))
    }

    let header-content = margin-block[
        #if footnotes-per-page {
            counter(footnote).update(0)
        }

        #author
        #h(1fr)
        #(course-code, title).filter(x => x != none).join[: ]
    ]

    let footer-content = margin-block[
        #set align(right)
        #context counter(page).display(page.numbering, both: true)
    ]

    set page(
        paper: page-size,
        numbering: "p. 1/1",
        margin: page-margins,
        header-ascent: 50%,
        footer-descent: 50%,
        header: header-content,
        footer: footer-content,
    )

    // =============================================================================================
    // ==== Styles for individual elements
    // =============================================================================================

    set outline(indent: 2.4em)

    // -- Footnotes
    // --------------------------------------------------------

    let fn-stroke = (thickness: 0.75pt, paint: footnotes-line-color, cap: "round")
    set footnote.entry(gap: 0.5em, clearance: 1em, separator: line(length: 100%, stroke: fn-stroke))

    show footnote.entry: it => {
        set par(justify: true)
        set text(size: 0.90em)

        let loc = it.note.location()
        let num = numbering(it.note.numbering, ..counter(footnote).at(loc))

        let space = 0.65em
        grid(
            columns: (auto, 1fr),
            column-gutter: 0pt,
            block(inset: (right: space, top: 0.2em), width: 1.7em, align(right, strong(num))),
            block(inset: (left: space, y: 0.2em), stroke: (left: 0.25pt + gray), it.note.body),
        )
    }

    // -- Figures
    // --------------------------------------------------------

    set figure(gap: par-leading * 1.85)

    // Un-justify and shrink figure caption text, make supplement and counter bold
    show figure.caption: it => {
        set text(0.90em)
        set par(justify: false)
        [*#it.supplement #it.counter.display():* #it.body]
    }

    // =============================================================================================
    // ====                                   END OF PREAMBLE                                   ====
    // =============================================================================================

    let title-block = if title != none {
        set align(center)
        set par(leading: 1.15em)
        set text(1.15em)

        // If there's a title alone on a title page, it doesn't need extra padding below it.
        let title-padding = if title-page and preamble == none {
            0pt
        } else {
            3.25em
        }

        block(below: title-padding, [
            #(course-code, course-name).filter(x => x != none).join[: ] \
            #text(2.00em, weight: 700, title) \
            #author
        ])
    } else {
        none
    }

    // If we have a title page, wrap the title block in it its own page with some different spacing
    // first. Otherwise, just spit it out right away.
    if title-page {
        // New footer just for this page.
        let footer = margin-block[
            #set align(right)
            #context counter(page).display(page.numbering, both: false)
        ]

        page(numbering: "i.", footer: footer, {
            v(0.25fr)
            title-block
            preamble
            v(1.00fr)
        })

        counter(page).update(1)
    } else {
        title-block

        if preamble != none {
            preamble
            v(par-spacing * 2, weak: true)
        }
    }

    doc
}
