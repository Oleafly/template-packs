/// HTML-specific rendering helpers for the document theme.

/// Select an output implementation while keeping all target detection in the
/// HTML adapter. The branches are functions so unsupported HTML elements are
/// not evaluated during paged compilation.
#let when-html(html, paged) = if target() == "html" { html() } else { paged() }

/// Render a sidenote as a semantic HTML footnote aside.
#let sidenote(body, aside) = {
    body
    html.elem(
        "aside",
        attrs: (role: "doc-footnote"),
        aside,
    )
}

/// Apply the HTML-safe layout rules and inject the package assets.
#let template(theme: "light", body) = {
    // These semantic rules are shared with paged output, but are repeated here
    // to keep the HTML renderer independent from the paged implementation.
    set heading(numbering: (..numbers) => {
        if numbers.pos().len() <= 3 {
            numbering("1.1", ..numbers)
        }
    })
    set footnote(numbering: "[a]")

    // Typst's HTML exporter does not translate PDF layout rules. Keep the
    // semantic elements and let the browser styles arrange them.
    show align: it => {
        let horizontal = it.alignment.x
        let css-align = if horizontal == center {
            "center"
        } else if horizontal == right or horizontal == end {
            "right"
        } else {
            "left"
        }
        html.elem("div", attrs: (style: "text-align: " + css-align), it.body)
    }
    // Pad is also discarded by the exporter, including nested theorem text.
    show pad: it => it.body
    show grid.cell: it => it.body
    show grid: it => it.children.map(child => html.elem("div", child)).join()
    show stack: it => it.children.map(child => html.elem("div", child)).join()
    show place: it => it.body
    html.elem("style", attrs: ("data-theme": theme), read("theme.css"))
    html.elem("style", attrs: ("data-sidenotes": ""), read("sidenotes.css"))
    html.elem("script", read("sidenotes.js"))
    body
}
