#import "../slide.typ": jump, meanwhile, pause, setup, theme
#import "@preview/octique:0.1.1": octique-inline

#let colors = theme.colors
#let fonts = theme.fonts
#let primary = colors.primary

#let linkto(url, icon: "link") = link(url, box(baseline: 30%, move(dy: -0.15em, octique-inline(icon))))

#let keydown(key) = box(
    stroke: 1.4pt + colors.neutral-soft,
    fill: luma(248),
    inset: (x: 0.35em, y: 0.08em),
    radius: 3pt,
    baseline: 0.14em,
    text(font: "IBM Plex Mono", size: 0.86em, key),
)

#let mark(body) = text(fill: primary, weight: "bold", body)

#let note-box(title, body) = block(
    width: 100%,
    inset: (x: 0.75em, y: 0.55em),
    fill: rgb("#fbf4f5"),
    stroke: (left: 4pt + primary, rest: 0.6pt + colors.primary-muted),
    radius: 4pt,
    {
        text(fill: primary, weight: "bold", title)
        parbreak()
        body
    },
)

#let feature-table(..rows) = {
    let cells = rows.pos()
    let data-row-count = calc.ceil(cells.len() / 2)

    table(
        columns: (1fr, 2fr),
        stroke: none,
        inset: (x: 0.55em, y: 0.38em),
        fill: (_, row) => if row == 0 { colors.primary-soft } else { colors.primary-muted },
        row-gutter: range(0, data-row-count).map(index => if index == 0 { 0.2em } else { 0.1em }),
        column-gutter: 0.1em,
        align: (left, left),
        table.header(text(fill: white, weight: "bold")[Feature], text(fill: white, weight: "bold")[Usage]),
        ..cells,
    )
}
