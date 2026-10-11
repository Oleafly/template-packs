#let template(doc) = {
    set page(paper: "a5", margin: (top: 5mm, rest: 2mm))
    set text(font: "ProFont IIx Nerd Font", size: 12pt)
    block(doc)
    place(bottom+center, text(size: 6pt, fill: gray, "unreleased"))
}