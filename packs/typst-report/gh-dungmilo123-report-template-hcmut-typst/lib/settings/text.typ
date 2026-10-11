#let setup-text(lang: "en", body)={
    // Set paragraph rules
    set par(
        justify: true,
        leading: 0.65em,
        spacing: 12pt,
        first-line-indent: 0pt,
    )

    // Set font rules
    set text(
        font: "IBM Plex Serif",
        size: 11pt,
        lang: lang,
        region: "VN"
    )

    show raw: set text(font: "JetBrains Mono") // for code blocks

    set heading(numbering: "1.1")
    show heading: set block(above: 2em, below: 1em)
    show heading.where(level: 1): set text(size: 14pt)
    show heading.where(level: 2): set text(size: 12pt)
    body
}