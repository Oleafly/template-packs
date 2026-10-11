#import "front_matter.typ": *
#import "back_matter.typ": *

#let thesis(
    english_title: "",
    dutch_title: "",
    cover_info: "",
    degree: "",
    supervisor: "",
    defense_date: "",
    author: "",
    author_birth: "",
    author_funding: "",
    body,
    bib_file: "",
    acknowledgements: "",
    publications: "",
    about_author: "",
) = {
    set document(title: english_title, author: author)
    show link: set text(fill: blue)


    // cover pages
    preface(
        english_title: english_title,
        dutch_title: dutch_title,
        cover_info: cover_info,
        degree: degree,
        supervisor: supervisor,
        defense_date: defense_date,
        author: author,
        author_birth: author_birth,
        author_funding: author_funding,
    )


    // basic page setup
    set page(width: 170mm, height: 240mm, margin: (inside: 2.5cm, outside: 2cm, y: 2cm))


    // outline setup
    show outline.entry.where(level: 1): it => {
        v(1em, weak: false)
        strong(it)
    }
    set outline.entry(fill: none)
    outline(indent: auto)


    // text and paragraph setup
    set text(
        font: "Libertinus Serif",
        size: 10pt,
        lang: "en",
    )
    set par(
        justify: true,
        spacing: 0.65em,
        first-line-indent: 1.5em,
    )


    // heading setup
    set heading(numbering: "1.1  ")
    show heading: set block(above: 2em, below: 1.5em)
    show heading.where(level: 1): it => {
        // always start on odd pages.
        state("content.switch").update(false)
        pagebreak(to: "odd", weak: true)
        state("content.switch").update(true)

        // show the normal chapters
        if it.numbering != none {
            // reset the counters for equations, figures, tables and raw text
            counter(math.equation).update(0)
            counter(figure.where(kind: image)).update(0)
            counter(figure.where(kind: table)).update(0)
            counter(figure.where(kind: raw)).update(0)

            // show the chapter number and title
            set par(justify: false)
            set block(above: 2em, below: 2em)
            v(1em, weak: true)
            align(center, text(size: 3em, weight: 500, [#counter(heading).display().first()]))
            align(center, line(length: 100%))
            align(center, text(size: 1.5em, weight: 700, [#it.body]))
            align(center, line(length: 100%))
            v(1em, weak: true)
        } else {
            // show the heading of references, acknowledgements...
            text(size: 1.3em, weight: 700, [#it.body])
            hide(line(length: 100%))
            v(1em, weak: true)
        }
    }
    show heading.where(level: 2): set text(size: 1.2em, weight: 700)


    // header setup
    set page(header: context {
        let page_number = counter(page).get().first()
        let is_start_chapter = query(heading.where(level: 1, outlined: true))
            .map(it => counter(page).at(it.location()).first())
            .contains(page_number)

        // skip the first page of each chapter and empty pages
        if not is_start_chapter and state("content.switch", false).get() {
            let before = query(heading.where(level: 1, outlined: true).before(here())).last()
            if before.numbering != none {
                // for normal chapters
                if calc.odd(page_number) {
                    [#smallcaps(before.body) #h(1fr) #page_number]
                } else {
                    [#page_number #h(1fr) #smallcaps("Chapter") #counter(heading).display().first()]
                }
            } else {
                // for other chapters
                if calc.odd(page_number) {
                    [#smallcaps(before.body) #h(1fr) #page_number]
                } else {
                    [#page_number #h(1fr) #smallcaps(before.body)]
                }
            }
            v(-0.2em)
            line(length: 100%, stroke: 0.05em)
        }
    })


    // footer setup
    //   set page(footer: context {
    //     let page_number = counter(page).get().first()
    //     let is_start_chapter = query(heading.where(level: 1, outlined: true))
    //       .map(it => counter(page).at(it.location()).first())
    //       .contains(page_number)

    //     // skip the first page of each chapter and empty pages
    //     if not is_start_chapter and state("content.switch", false).get() {
    //       if calc.even(page_number) {
    //         rotate((page_number - 1) * -15deg, ellipse(width: 4em, height: 0.8em, fill: black))
    //         // rotate(page_number * -5deg, text(3em)[👻])
    //       }
    //     }
    //   })


    // figure setup and table numbering setup
    set figure(placement: auto, gap: 1.5em)
    show figure: set block(above: 3em, below: 2em)
    let figure_numbering = super => numbering("1.1", counter(heading).get().first(), super)
    show figure.where(kind: image): set figure(numbering: figure_numbering)
    show figure.where(kind: table): set figure(numbering: figure_numbering)
    show figure.caption: it => {
        context [#text(size: 0.9em)[*#it.supplement~#it.counter.display()#it.separator*#h(0.5em)#it.body]]
    }


    // table setup
    show table.cell.where(y: 0): strong


    // equation setup
    show math.equation: set block(above: 1.5em, below: 1.2em)
    let equation_numbering = super => numbering("(1.1)", counter(heading).get().first(), super)
    set math.equation(numbering: equation_numbering)


    // list setup
    set list(indent: 1.5em)


    // reference setup
    show ref: set text(fill: blue)


    // reset the page counter before the text starts
    context counter(page).update(1)


    // your content goes here
    body


    // bibliography
    bibliography("../" + bib_file, title: "References", style: "american-physics-society")


    // acknowledgements
    acknowledgement(acknowledgements)


    // publication list
    publication(publications)


    // about the author
    about(about_author)
}
