#import "@preview/pergamon:0.8.0": *

#add-bib-resource(read("bib/schuyler.bib"))

#set text(
    font: "New Computer Modern",
    size: 10pt
)
#let tt = text.with(font: "IBM Plex Mono", size: 8pt)

#let greens9p6 = rgb(35, 139, 69)
#let reds9p7 = rgb(165, 15, 21)

#let latex() = smallcaps[
    L#h(-3pt)#text(baseline: -2pt, size: 7pt)[A]#h(-4.5pt)
    T#h(-2pt)#text(baseline: 2pt, size: 10pt)[E]#h(-4pt)
    X
]

#let cpp() = [
    C#text(baseline: -1pt, size: 7pt)[#(sym.plus)#(sym.plus)]
]

#set page(
    paper: "us-letter",
    margin: (x: 1in, y: 1in),
    header: {
        table(
            columns: (1fr, 1fr, 1fr),
            align: (left, center, right),
            stroke: none,
            [#smallcaps[Schuyler Eldridge]],
            [#smallcaps[Curriculum Vitae]],
            [#smallcaps[Last Updated #datetime.today().display("[year]/[month]/[day]")]]
        )
        v(-1.25em)
        line(
            length: 100%,
            stroke: 0.5pt
        )
    },
    footer: context {
        let pageNumber = counter(page).get().first()
        if pageNumber == 1 {
            line(
                length: 100%,
                stroke: 0.5pt
            )
            v(-1.25em)
            table(
                columns: (1fr, 1fr, 1fr),
                align: (left, center, right),
                stroke: none,
                [#smallcaps[#link("https://github.com/seldridge")[seldridge\@github]]],
                [#smallcaps[New York, NY]],
                [#smallcaps[#link("mailto:schuyler.eldridge@gmail.com")[schuyler.eldridge\@gmail.com]]]
            )
        } else {
            align(center)[#pageNumber]
        }
    }
)

#set heading(offset: 1)

#let yamlDict = (
    yaml("cv.yaml")
)

#refsection(style: numeric-style(), [

= Experience

#let showDate(date) = {
    datetime(year: int(date.year), month: int(date.month), day: int(date.day)).display("[month]/[year]")
}

#let entry(item) = {
  let cells = (
    [#item.company],
    [#item.location #if ("remote" in item) { "(remote)" }],
    [#item.roles.map(role => emph(role.title)).join(linebreak())],
    [#item.roles.map(role => role.dates).map(date => (showDate(date.start), sym.dash.en, if ("end" in date) {showDate(date.end)} else {"Present"}).join()).join(linebreak())],
  )

  if ("summary" in item) {
    cells.push(
      table.cell(colspan: 4, inset: (left: 2em))[
        #par(justify: true)[#item.summary]
      ]
    )
  }

  cells
}

#table(
    columns: (19%, 27%, 35%, 19%),
    align: (left, left, left, left),
    stroke: none,
    ..yamlDict.employment
        .map(entry)
        .flatten()
)

= Education

#let entry(item) = (
    [#item.school],
    [#item.location],
    [#item.degrees.map(degree => emph(degree.degree)).join(linebreak())],
    [#item.degrees.map(degree => emph(degree.major)).join(linebreak())],
    [#item.degrees.map(degree => str(degree.year)).join(linebreak())]
)

#table(
    columns: (19%, 27%, 10%, 25%, 19%),
    align: (left, left, left, left, right),
    stroke: none,
    ..yamlDict.education
        .map(entry)
        .flatten()
)

#let repo(item) = (
    tt(link((item.host, "/", item.organization, "/", item.repository).join())[#(item.organization)/#(item.repository)])
)

#let stats(item) = [
    #item.commits commits
    #(tt.with(fill: greens9p6))[#item.additions#sym.plus#sym.plus]
    #(tt.with(fill: reds9p7))[#item.deletions#sym.minus#sym.minus]
]

#let fixupLanguage(lang) = {
    if lang == "\LaTeX" {
        latex()
    } else if (lang == "\CC") {
        cpp()
    } else {
        lang
    }
}

#let languages(item) = item.languages.map(fixupLanguage).join(linebreak())

#let entry(item) = (
    repo(item),
    languages(item),
    [
        #item.description
        #if ("citations" in item) {
            for c in item.citations [
                #cite(c)
            ]
        }
    ],
    stats(item.statistics)
)

= Open Source Activities

#if ("maintainer" in yamlDict) [
    == Maintainer

    #table(
        columns: (28%, 12%, 28%, 32%),
        align: (left, left, left, right),
        stroke: none,
        ..yamlDict.maintainer
            .map(entry)
            .flatten()
    )
]

#if ("contributor" in yamlDict) [
    == Selected Contributions

    #table(
        columns: (28%, 12%, 28%, 32%),
        align: (left, left, left, right),
        stroke: none,
        ..yamlDict.contributor
            .map(entry)
            .flatten()
    )
]

#if ("author" in yamlDict) [
    == Selected Authored Projects

    #let entry(item) = (
        repo(item),
        languages(item),
        item.description,
        if ("stars" in item) [#item.stars Stars] else []
    )

    #table(
        columns: (35%, 10%, 40%, 15%),
        align: (left, left, left, right),
        stroke: none,
        ..yamlDict.author
            .map(entry)
            .flatten()
    )
]

= Publications

  #set par(justify: true)
  #print-bibliography(
    title: "Peer Reviewed Conference Publications",
    filter: reference => "conference" in reference.fields.at("keywords", default: ()),
    sorting: "ydnt",
    show-all: true
  )

  #print-bibliography(
    title: "Peer Reviewed Journal Articles",
    filter: reference => "journal" in reference.fields.at("keywords", default: ()),
    sorting: "ydnt",
    show-all: true,
    resume-after: auto
  )

  #print-bibliography(
    title: "Patents and Patent Applications",
    filter: reference => "patent" in reference.fields.at("keywords", default: ()),
    sorting: "ydnt",
    show-all: true,
    resume-after: auto
  )

  #print-bibliography(
    title: "Demonstrations",
    filter: reference => "demo" in reference.fields.at("keywords", default: ()),
    sorting: "ydnt",
    show-all: true,
    resume-after: auto
  )

  #print-bibliography(
    title: "Technical Reports",
    filter: reference => "report" in reference.fields.at("keywords", default: ()),
    sorting: "ydnt",
    show-all: true,
    resume-after: auto
  )

  #print-bibliography(
    title: "Theses",
    filter: reference => "thesis" in reference.fields.at("keywords", default: ()),
    sorting: "ydnt",
    show-all: true,
    resume-after: auto
  )

  #print-bibliography(
    title: "Workshop Talks and Posters",
    filter: reference => "workshop" in reference.fields.at("keywords", default: ()),
    sorting: "ydnt",
    show-all: true,
    resume-after: auto
  )

#if ("panels" in yamlDict) [
    == Panel Participations

    #let entry(item) = (
        [#item.role: "#item.name"\ #emph(item.event)],
        [#showDate(item.date)\ #item.location]
    )

    #table(
        columns: (80%, 20%),
        align: (left, right),
        stroke: none,
        ..yamlDict.panels
            .map(entry)
            .flatten()
    )
]

= Grants

#let entry(item) = (
    [#item.agency], [#item.name], [#item.number], [#item.role], [#(showDate(item.date.start), sym.dash.en, showDate(item.date.end)).join()]
)

#table(
    columns: (1fr, 1fr, 1fr, 1fr, 1fr),
    align: (left, left, left, left, left),
    stroke: none,
    ..yamlDict.grants
        .map(entry)
        .flatten()
)

= Program Committees and Reviews

#let entry(item) = ([#item.name], [#item.role], [#item.year])

#table(
    columns: (62%, 33%, 5%),
    align: (left, left, right),
    stroke: none,
    ..yamlDict.service
        .map(entry)
        .flatten()
)

= Honors, Awards, and Fellowships

#let entry(item) = (
    [#item.name], [#if ("start" in item.date) {(showDate(item.date.start), sym.dash.en, showDate(item.date.end)).join()} else {showDate(item.date)}]
)

#table(
    columns: (0.81fr, 0.19fr),
    align: (left, left),
    stroke: none,
    ..yamlDict.awards
        .map(entry)
        .flatten()
)

#if ("thesis-committees" in yamlDict) [
    = Thesis Committees

    #let entry(item) = (
        item.role,
        item.degree,
        [#item.student\ #emph(item.title)],
        [#item.year]
    )

    #table(
        columns: (13%, 8%, 70%, 10%),
        align: (left, left, left, right),
        stroke: none,
        ..yamlDict.thesis-committees
            .map(entry)
            .flatten()
    )
]

#if ("advisor" in yamlDict) [

    #let advisor = yamlDict.advisor

    = Doctoral Advisor
    #(advisor.name) (#(advisor.institution))
]

])
