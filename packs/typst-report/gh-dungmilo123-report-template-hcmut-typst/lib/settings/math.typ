#let setup-math(body) = {
    set math.equation(numbering: "(1)")

    // Optional: If you want equations to break across lines automatically
    // set math.equation(break: true)
    body
}

// Usage: #theorem("Title")[Content...]
#let theorem(title, body) ={
    block(
        fill: rgb("#f0f8ff"),
        stroke: (left: 2pt + blue),
        inset: 10pt,
        width: 100%,
        below: 1em,
        [
            *#title.* #body
        ]
    )
}