#import "@preview/codelst:2.0.2": *
#import "@preview/unify:0.7.1": *
#import "@preview/physica:0.9.3": *
#import "@preview/equate:0.3.1": *

#set page(numbering: none)

// フォントサイズ
#let title_size = 28pt
#let large = 18pt
#let medium = 12pt
#let normal = 10.5pt
#let small = 10pt
#let tiny = 8pt
// フォント
#let default_font = "Harano Aji Mincho"
#let gothic_font = "Harano Aji Gothic"
#let math_font = "New Computer Modern Math"

#let project(title: "", author: "", course: "", mentor: "", body) = {
    // Heading
    set heading(numbering: none)
    show heading: it => text(
        font: gothic_font,
        weight: "medium",
        lang: "ja",
    )[#pad(bottom: -12pt, it) #par(text(size: 0pt, ""))]

    // Figure
    show figure: it => pad(y: 1em, it)
    show figure.caption: it => text(it, lang: "ja")

    // Table
    set table(stroke: none)
    show figure.where(kind: table): set figure.caption(position: top)

    // Equation
    set math.equation(numbering: "(1)", number-align: bottom)
    set math.mat(delim: "[")
    show math.equation: set text(font: math_font)
    set math.equation(
        numbering: it => { "(5." + [#it] + ")" },
        number-align: (right + bottom),
        supplement: "式",
    )

    // Set the document's basic properties.
    set document(author: author.name, title: title)
    set text(font: default_font, size: normal, weight: "regular", lang: "ja")
    set page(paper: "a4", margin: 25mm)
    set par(justify: true, first-line-indent: normal)
    let date = datetime.today()

    // Title row.
    align(center)[
        #v(2em)
        #block(text(weight: "medium", size: title_size, title))
        #v(2em)
        #block(text(weight: "regular", size: large, course))
    ]
    v(1fr)

    align(right)[
        #table(
            columns: 2,
            [研究室 :], [#author.lab],
            [学籍番号 :], [#author.number],
            [氏名 :], [#author.name],
        )
        提出日 : #date.year() 年 #date.month() 月 #date.day() 日
    ]

    pagebreak()

    counter(page).update(1)
    counter(figure).update(1)
    set page(numbering: "1", number-align: center)

    body

    pagebreak()

    bibliography(
        "../bib.yaml",
        title: "参考文献",
        style: "ieee",
        full: true,
    )
}
