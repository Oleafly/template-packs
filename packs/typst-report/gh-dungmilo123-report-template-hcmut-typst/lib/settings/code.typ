#let setup-code(body) = {
    // Inline code
    show raw.where(block: false): box.with(
        fill: luma(240),
        inset: (x: 3pt, y: 0pt),
        outset: (y: 3pt),
        radius: 2pt,
    )

    // Block code
    show raw.where(block: true): block.with(
        fill: luma(245),
        stroke: luma(100),
        inset: 10pt,
        radius: 4pt,
        width: 100%,
    )

    show raw: set text(font: "JetBrains Mono", size: 10pt)

    body
}
