#let title(
    topic: none,
    faculty: none,
    author: none,
    index: none,
    promotor: none,
    city: "Warszawa",
    date: none,
    degree: none,
    speciality: none,
    institute: none,
    body
) = {
    set page(paper: "a4", margin: (x: 3cm, y: 2.5cm))
    set align(center)
    box(
        height: 15mm,
        grid(
            columns: 2,
            rows: (1fr, 1fr),
            row-gutter: 0mm,
            column-gutter: 5mm,
            grid.cell(
                align: top,
                text(
                    font: "Adagio Slab",
                    size: 24pt,
                    "Politechnika Warszawska",
                ),
            ),
            grid.cell(
                align: horizon,
                rowspan: 2,
                image("assets/images/pw.jpg", width: 25mm, height: 25mm)
            ),
            grid.cell(
                align: bottom,
                text(
                    tracking: 0.66em,
                    font: "Adagio Slab",
                    size: 12pt,
                    upper(faculty),
                )
            )
        ),
    )

    v(40pt)

    text(size: 12pt, [#institute])
    

    v(40pt)

    text(size: 43pt,font: "Adagio Slab", bottom-edge: "descender", [Praca dyplomowa\ magisterska])
    
    linebreak()
    v(20pt)

    text(size: 12pt, [Na kierunku #degree])
    if speciality != none [
        #linebreak()
        #text(size: 12pt, [w specjalności #speciality])
    ]
    
    linebreak()
    v(60pt)

    text(size: 14pt, [#topic])

    linebreak()
    v(60pt)

    text(size: 21pt, [#author])
    linebreak()
    text(size: 12pt, [Numer albumu #index])
    
    linebreak()
    v(40pt)
    
    text(size: 12pt, "promotor")
    linebreak()
    text(size: 12pt, [#promotor])

    align(bottom, text(size: 12pt, [#city #date]))

    body
}



