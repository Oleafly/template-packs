#let layout_config(doc, alternating_layout: true, author: "Author", title: "Title") = {
    let currentH() = {
        let elems = query(selector(heading.where(level: 1)).after(here()))
        if elems.len() != 0 and elems.first().location().page() == here().page() {
            return elems.first().body
        } else {
            elems = query(selector(heading.where(level: 1)).before(here()))
            if elems.len() != 0 {
                return elems.last().body
            }
        }
    }

    // misc
    set page(
        paper: "a4",
        margin: (top: 3.2cm, rest: 2.7cm),
        header: context {
            if calc.rem(here().page(), 2) == 0 [
                #grid(
                    columns: (1fr, 1fr, 1fr),
                    //align(left)[#page-num],
                    none, align(center, title), align(right)[],
                )
            ] else [
                #grid(
                    columns: (1fr, 1fr, 1fr),
                    align(left)[], align(center)[#currentH()],
                    //align(right)[#page-num],
                    none,
                )
            ]
        },
    )

    set heading(numbering: "1.1")

    doc

    show ref: it => if it.type == figure {
        [it.supplement]
    }
}
