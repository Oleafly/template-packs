#let degree(
    kind: none,
    year: none,
    field: none,
    school: "Johns Hopkins School of Medicine",
    mentors: none,
) = {

    let phd = kind == "Ph.D. expected"

    if phd {
        assert(mentors != none)
    } else {
        assert(mentors == none)
    }

    if phd {
        table(
            columns: (1fr, 4em, 2fr, 2fr),
            inset: 0.3em,
            rows: 2,
            kind, year, field, school,
            table.cell(
                x: 2,
                y: 1,
                colspan: 2,
                mentors
            )
        )
    } else {
        table(
            columns: (1fr, 4em, 2fr, 2fr),
            inset: 0.3em,
            kind, year, field, school
        )
    }
}

#let experience(name: none, duration: none, description: none) = {
        table(
            columns: (2fr, 7em, 5fr),
            inset: 0.3em,
            name, duration, description
        )
}

#let funding(source: none, duration:none, amount:none, description: none, id: none) = {
    if id != none {
        table(
            inset: 0em,
            rows: 2,
            table(
                columns: (1fr, 7em, 8em, 1fr),
                source, duration, amount, description
            ),
            table(id),
        )
    } else {
        table(
            columns: (1fr, 7em, 8em, 1fr),
            source, duration, amount, description
        )
    }
}

#let award(year: none, name: none, source: none) = {
        table(
            columns: (4em, 2fr, 5fr),
            inset: 0.3em,
            year, name, source
        )
}

#let make_author(x) = {
    if x.len() == 2 {
        assert(x.at(1) == "me")
        return(text(weight: "bold")[#x.at(0)])
    }
    x
}

#let publication(
    authors: none,
    year: none,
    title: none,
    journal: none,
    volume: none,
    pages: none
) = {
    let formatted_authors = for author in authors {
        (make_author(author),)
    }
    let location = if volume != none{
        if pages != none {
            [#volume: #pages]
        } else {
            volume
        }
    }
    par(hanging-indent: 2em)[#formatted_authors.join(", "). (#year) #title. #journal #location]
}

#let invention(date: none, title: none) = {
    table(
        columns: (7em, 1fr),
        inset: 0.3em,
        date, title
    )
}

#let service(date: none, description: none) = {
    table(
        columns: (7em, 1fr),
        inset: 0.3em,
        date, description
    )
}

#let cv(
    name: none,
    date: datetime.today().display("[year]-[month]-[day]"),
    degrees: none,
    experiences: none,
    fundings: none,
    awards: none,
    publications: none,
    publications_unreviewed: none,
    publications_other: none,
    inventions: none,
    services: none,
) = {
    set page(
        paper: "us-letter",
        margin: (left: 0.5in, right: 0.5in, top: 0.5in, bottom: 0.5in)
    )
    show heading.where(level: 1): set text(10pt)
    set par(leading: 0.5em)
    set table(stroke: none)
    set text(10pt)

    /*LETTERHEAD*/
    align(center)[CURRICULUM VITAE FOR Ph.D. CANDIDATES]
    align(center)[The Johns Hopkins University School of Medicine]
    v(1em)

    /*NAME AND DATE*/
    set align(left)
    grid(
        columns: (1fr, 1fr),
        rows: 2,
        align: center,
        column-gutter: 1fr,
        row-gutter: 0.3em,

        rect(name, stroke: (bottom: 0.5pt + black), width: 100%, inset: 0.2em),
        rect([#date], stroke: (bottom: 0.5pt + black), width: 100%, inset: 0.2em),
        [Name], [Date of this version]
    )
    v(1em)

    [= Educational History]
    pad(table(inset: 0em, ..degrees), left: 2em)

    if experiences != none {
        [= Professional Experience]
        pad(table(inset: 0em, ..experiences), left: 2em)
    }

    if funding != none {
        [= Scholarships, fellowships, funding]
        pad(table(inset: 0em, ..fundings), left: 2em)
    }
    if awards != none {
        [= Awards and Honors]
        pad(table(inset: 0em, ..awards), left: 2em)
    }

    if publications != none {
        [= Publications, peer reviewed]
        pad(table(inset: 0.2em, ..publications), left: 2em)
    }
    if publications_unreviewed != none {
        [= Publications, unreviewed]
        pad(table(inset: 0.2em, ..publications_unreviewed), left: 2em)
    }

    if publications_other != none {
        [= Posters, abstracts, etc.]
        pad(table(inset: 0.2em, ..publications_other), left: 2em)
    }
    if inventions != none {
        [= Inventions, Patents, Copyrights]
        pad(table(inset: 0.2em, ..inventions), left: 2em)
    }
    if services != none {
        [= Service and leadership]
        pad(table(inset: 0em, ..services), left: 2em)
    }
}
