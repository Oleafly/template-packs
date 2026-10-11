// 参考文献
#let _set_references(csl_style: none, body) = {
    set bibliography(title: "参考文献", style: "gb-7714-2015-numeric")

    show bibliography: it =>{
        set heading(level: 1, numbering: none)

        set par(justify: false, leading: 1.24em, first-line-indent: 2em)

        it
    }

    body
}

