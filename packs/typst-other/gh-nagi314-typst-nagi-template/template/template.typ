#let mytemplate(
    author, // writer's name
    doc
    ) = {
    set page(
        paper: "a4",
        margin: (x: 25mm, y: 25mm),
        columns: 1,
        numbering: "1 / 1",
        number-align: center + bottom,
    )

    set par(
        justify: true
    )

    set document(
        author: author, 
        date: auto,
    )

    // 数式のフォント設定
    show math.equation: set text(font: "New Computer Modern Math")

    // 日本語の文字は原ノ味明朝に
    let jp_font = "Harano Aji Mincho"
    show regex("[\p{scx:Han}\p{scx:Hira}\p{scx:Kana}]"): set text(
        font: jp_font, 
        lang: "ja", 
    )

    set heading(numbering: none)
    show heading.where(level: 1): set text(size: 17pt)
    show heading.where(level: 2): set text(size: 14pt)

    doc
}
