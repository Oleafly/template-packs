#let author(
    name: "Name",
    position: "Position",
    organization: "Affiliation",
) = {
    set par(justify: false, hanging-indent: 1em)
    let entry = (
        smallcaps(name),
        position,
        emph(organization),
    ).join(", ")
    block(above: 0.6em, below: 0.5em)[#par(entry)]
}

#let abstract(heading: "Abstract", body) = {
    block(above: 1.5em, below: 1em)[#line(length: 100%, stroke: 0.5pt)]
    smallcaps(heading + ": ")
    body
    block(above: 1em, below: 1.5em)[#line(length: 100%, stroke: 0.5pt)]
}

#let date() = {
    datetime.today().display("[day padding:none] [month repr:long] [year]")
}

#let report(
    font_family: "Splentinex",
    font_size_main: 11pt,
    par_leading: 0.5em,
    par_spacing: 1.0em,
    par_justify: true,
    page_numbering_style: "1 of 1",
    title_letter_spacing: 1pt,
    body,
) = {
    set page(
        paper: "a4",
        margin: (left: 20%, right: 20%, top: 10%, bottom: 20%),
        numbering: page_numbering_style,
        number-align: center,
        footer: context [
            #date()
            #h(1fr)
            #counter(page).display(page_numbering_style, both: true)
        ]
    )
    set text(font: font_family, size: font_size_main, lang: "en")
    set par(justify: par_justify, spacing: par_spacing, leading: par_leading)
    show title: x => {
        set block(below: 1em)
        set text(size: 1.5 * font_size_main, weight: "regular", tracking: title_letter_spacing)
        upper(x)
    }
    show heading.where(level: 1): x => {
        set block(above: 2em, below: 1.2em)
        set text(size: 1.1 * font_size_main, weight: "regular")
        smallcaps(x)
    }
    show heading.where(level: 2): x => {
        set block(above: 1.5em, below: 1.2em)
        set text(size: font_size_main, weight: "regular", style: "italic")
        x
    }
    show figure: x => {
        set block(above: 2em, below: 2em)
        x
    }
    show figure.caption: set align(left)
    show table.cell.where(y: 0): set text(style: "italic")
    let frame(stroke) = (x, y) => (
        left: 0pt,
        right: 0pt,
        top: if y < 2 { stroke } else { 0pt },
        bottom: stroke,
    )
    set table(
        stroke: frame(0.5pt + black),
        align: (x, y) => (
            if x > 0 { right } else { left }
        ),
    )
    set bibliography(title: "References")

    body
}
