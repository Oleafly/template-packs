#import "@preview/ctheorems:1.1.3"
#import "@preview/physica:0.9.4": super-T-as-transpose

#let theorem = ctheorems.thmbox("theorem", "Теорема", fill: rgb("#e88725")).with(numbering: none)
#let lemma = ctheorems.thmbox("theorem", "Лемма", fill: rgb("#3fbc5f")).with(numbering: none)
#let proof = ctheorems.thmproof("theorem", "Доказательство")
#let eqref(lbl) = [(#ref(lbl, supplement: none))]

#let simple_letter(
    title: none,
    author: none,
    title_color: eastern,
    numbering: "(1/1)",
    paper: "us-letter",
    margin: (left: 2cm, right: 3cm, top: 2cm, bottom: 3cm),
    lang: "en",
    font: "New Computer Modern",
    font_size: 11pt,
    title_size: 17pt,
    doc
) = [
    #set document(title: title,
        author: author,
    )
    #set page(
        paper: paper,
        header: {
            grid(align: top, columns: (auto, 1fr), align(left)[#title], align(right)[#emph(author)]) + v(-.5em) + line(length: 100%, stroke: title_color)
        },
        margin: margin,
        numbering: numbering
    )

    #set text(font: font)
    #set text(lang: lang, size: font_size)

    #set par(justify: true)
    #show heading: set text(fill: title_color)
    #show: super-T-as-transpose
    #set math.equation(numbering: "(1)")
    #set smartquote(alternative: true)

    #show ref: set ref(supplement: none)

    #align(center, text(title_size)[#title])
    #doc
]
