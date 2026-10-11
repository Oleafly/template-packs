#let course_doc(course, head, doc) = {

    set heading(numbering: "1.1")

    show heading: set block(below: 12pt)
    show heading.where(level: 1): set block(above: 32pt)
    show heading.where(level: 2): set block(above: 20pt)
    show heading: it => block(counter(heading).display(it.numbering) + h(1em) + it.body)
    show heading: set text(weight: "semibold")

    set quote(block: true)

    show quote: set block(fill: luma(240), inset: 5pt, above: 0pt)
    show quote: set pad(x: 0pt)

    show link: set text(fill: blue, weight: "bold")

    show raw.where(block: true): it => block(
        fill: luma(245),
        inset: 20pt,
        width: 100%,
        it
    )

    set list(indent: 1em)
    set enum(indent: 1em)
    
    set page(
        margin: (
            top: 1.25in,
            bottom: 1.25in,
            left: 0.95in,
            right: 1in
        ),

        header: context {
            set text(size: 8pt)
            if counter(page).get().first() > 1 [
                #head
                #h(1fr)
                #course.info.semester
            ]
        },

        footer: context {
            set text(size: 8pt)
            grid(
                columns: (1fr, 1fr, 1fr),
                align: (left, center, right),

                course.instructor.name,
                course.info.school,
                counter(page).display("1 of 1", both: true)
            )
        }
    )

    set text(
        font: "Libertinus Serif",
        size: 10pt,
    )

    doc
}


#let fillin_doc(course, head, doc) = {

    set heading(numbering: none)

    show heading: set block(below: 12pt)
    show heading.where(level: 1): set block(above: 32pt)
    show heading.where(level: 2): set block(above: 20pt)
    show heading: set text(weight: "semibold")

    set quote(block: true)

    show quote: set block(fill: luma(240), inset: 5pt, above: 0pt)
    show quote: set pad(x: 0pt)

    show link: set text(fill: blue, weight: "bold")

    set list(indent: 1em)
    set enum(indent: 1em)
    
    set page(
        margin: (
            top: 1.25in,
            bottom: 1.25in,
            left: 0.95in,
            right: 1in
        ),

        header: context {
            set text(size: 8pt)
            if counter(page).get().first() == 1 [
                #h(1fr)
                #text(10pt)[Name: #box(line(length: 10em, stroke: 0.5pt))]
            ] else [
                #head
                #h(1fr)
                #course.info.semester
            ]
        },

        footer: context {
            set text(size: 8pt)
            grid(
                columns: (1fr, 1fr, 1fr),
                align: (left, center, right),

                course.instructor.name,
                course.info.school,
                counter(page).display("1 of 1", both: true)
            )
        }
    )

    set text(
        font: "Libertinus Serif",
        size: 12pt,
    )

    doc
}


#let make_title(doctitle, subtitle, doc) = {
    show title: set text(
        size: 16pt,
        weight: "semibold",
    )
    show title: smallcaps
    show title: set block(below: 8pt)

    title[#doctitle]

    text(size: 12pt)[#smallcaps[#subtitle]]


    doc

}
