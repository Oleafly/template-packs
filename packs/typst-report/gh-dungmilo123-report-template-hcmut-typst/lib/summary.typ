#import "utils.typ": duallang

#let make-summary(lang: "en")= {
    set page(header: none, footer: none)

    let toc-title = duallang(lang, "Table of Contents", "Mục lục")

    align(center, heading(outlined: false, numbering: none)[#toc-title])
    v(1em)
    outline(title: none, indent: auto, depth: 3)

    pagebreak()

    let lof-title = duallang(lang, "List of Figures", "Danh sách hình")

    align(center, heading(outlined: false, numbering: none)[#lof-title])
    v(1em)
    outline(title: none, target: figure.where(kind: image), indent: auto)

    pagebreak()
    counter(page).update(1)
}