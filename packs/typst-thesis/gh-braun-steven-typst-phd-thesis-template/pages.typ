#import "definitions.typ": *
#import "constants.typ": *

// Inserts a page break only when currently on an even page.
#let pagebreakAtEven() = {
    context {
        if calc.even(here().page()) {
            pagebreak()
        }
    }
}

// Renders the statutory declaration page required by the promotionsordnung. This is specific to the Technische Universität Darmstadt and needs to be customized for other institutions.
#let page-promotionsordnung(author, date, city) = {
    [
        // Erklärung Promotionsordnung
        #align(
            center,
        )[
            #heading(
                outlined: false, numbering: none, text(header-size, smallcaps[Erklärung laut Promotionsordnung]),
            )
        ]

        _§8 Abs. 1 lit. c PromO_\

        Ich versichere hiermit, dass die elektronische Version meiner Dissertation mit der schriftlichen
        Version übereinstimmt.

        _§8 Abs. 1 lit. d PromO_\

        Ich versichere hiermit, dass zu einem vorherigen Zeitpunkt noch keine Promotion versucht wurde. In
        diesem Fall sind nähere Angaben über Zeitpunkt, Hochschule, Dissertationsthema und Ergebnis dieses
        Versuchs mitzuteilen.

        _§9 Abs. 1 PromO_\

        Ich versichere hiermit, dass die vorliegende Dissertation selbstständig und nur unter Verwendung der
        angegebenen Quellen verfasst wurde.

        _§9 Abs. 2 PromO_\

        Die Arbeit hat bisher noch nicht zu Prüfungszwecken gedient.

        _ #city, #date.display("[day].[month].[year]") _

        #linebreak()
        #linebreak()

        // #image("res/signature-blue.png", width: 40%)
        \<_Insert signature here_\>
        #line(length: 40%, stroke: 0.5pt)
        #author.name

        #pagebreak(weak: true)
    ]
}

// Shows English and German abstracts with heading and separation.
#let page-abstract() = {
    // Abstract page.
    align(center)[
        #heading(outlined: false, numbering: none, text(header-size, smallcaps[Abstract]))
    ]

    include "pages/abstract-en.typ"

    pagebreak(weak: true)

    align(
        center,
    )[
        #heading(outlined: false, numbering: none, text(header-size, smallcaps[Zusammenfassung]))
    ]

    include "pages/abstract-de.typ"

    pagebreak(weak: true)
}

// Displays the acknowledgments page and breaks to the next page.
#let page-acknowledgments() = {
    align(
        center,
    )[
        #heading(outlined: false, numbering: none, text(header-size, smallcaps[Acknowledgments]))
    ]

    include "pages/acknowledgments.typ"

    pagebreak(weak: true)
}


// Simple quote page with centered quotation and author attribution.
#let page-quote() = [

    #align(center + horizon)[
        _"Some quote."_

        --- Someone quoted
    ]

    #pagebreak(weak: true)

]


// Builds the front cover page with title, author, and program details.
#let page-title(title, author, date, university, department) = {
    v(5em)
    align(center)[
        #text(28pt, weight: 500, thesis-red, smallcaps[#title])
    ]

    align(center)[
        #text(18pt, smallcaps[#author.name])
    ]

    v(1fr)

    align(center + horizon)[
        #set text(size: 14pt)
        #smallcaps[Doctoral thesis] \
        // Submitted in fulfillment of the requirements for the \
        // degree of _Doctor rerum naturalium (Dr. rer. nat.)_ \

        Submitted in fulfillment of the requirements for the degree of \
        _Doctor rerum naturalium (Dr. rer. nat.)_ \

        Reviewers \
        Prof. Dr. Reviewer 1 \
        Prof. Dr. Reviewer 2 \

        #department \
        #university \

        #date.display("[month repr:long] [day padding:none], [year]") \

    ]

    v(1fr)

    align(center + horizon)[
        #image("res/logo-front.svg", width: 40%)
    ]


    pagebreak(weak: true)
}

// Shows the back of the title page with metadata, license, and defense date.
#let page-title-back(author, title, date-defense, university, city) = {
    align(
        bottom,
    )[
        #author.name\
        _ #title _ \
        #city, #university

        // Year thesis published in TUprints: 2025\
        Date of defense: #date-defense.display("[day].[month].[year]")

        #grid(columns: (4fr, 1fr), gutter: 1.0cm)[
            This work is licensed under a #link(
                "https://creativecommons.org/licenses/by-nc-sa/4.0/",
            )[Creative Commons "Attribution-NonCommercial-ShareAlike 4.0 International"] license.][
            #image("./res/cc-by-nc-sa-logo.svg", width: 100%)
        ]
    ]
}

// Creates a chapter opener page with stylized heading and cleared header/footer.
#let chapter-page(title) = {
    context {
        set page(header: "", footer: "")

        // Add chapter title
        align(center + horizon)[
            #smallcaps[
                #text(thesis-red, size: 32pt)[
                    #heading(level: 1, numbering: none)[
                        #title
                    ]
                ]
            ]
        ]

        // Remove header
        set page(header: "")
    }
}

// Formats an individual publication entry with metadata, abstract, and optional paging gaps.
#let publication-page(
    title: "", abstract: "", authors: [], venue: "",
    year: "", equal-contribution-notice: false, break-page: true, pages: -1, contributions-par: ""
) = [

    // == #title
    #heading(level: 2, outlined: false)[#title]

    #if authors.len() == 1 [
        #authors.at(0)
    ] else [
        #authors.slice(0, -1).join(", "), and #authors.at(-1)
    ]

    #venue, #year.

    #v(1.5em)

    _Abstract_

    #v(0.25em)

    #abstract

    #v(1.5em)

    _Contributions_

    #v(0.25em)

    #contributions-par

    #if equal-contribution-notice [
        #align(bottom)[
            #text(size: 10pt)[
                #line(stroke: 0.25pt, length: 50%)
                #h(2em) #sym.dagger indicates equal author contribution
            ]
        ]
    ]

    #if break-page {
        pagebreak(weak: true)
    }

    #for i in range(0, pages) {
        counter(page).step()
    }

    // Disable footer (page number)
    #set page(footer: "")
]


// Generates the table of contents with styled top-level entries.
#let page-outline() = {
    // Table of contents.
    show outline.entry.where(level: 1): it => {
        v(1.5em, weak: true)
        strong(it)
    }

    outline(depth: 3, indent: auto)

    pagebreak(weak: true)
}

// Lists all figure entries from image figures in the document.
#let page-list-of-figures() = {
    // Table of contents.
    outline(
        title: [List of Figures],
        target: figure.where(kind: image),
    )
    pagebreak(weak: true)
}


// Displays the publication and contribution summary page.
#let page-publication-list-summary() = [
    #align(
        center,
    )[
        #heading(outlined: false, numbering: none, text(header-size, smallcaps[Publications and Contributions]))
    ]

    #include "pages/publication-list-summary.typ"

    #pagebreak(weak: true)
]


// Shows the notation legend page.
#let page-notation() = [
    #align(
        center,
    )[
        #heading(outlined: false, numbering: none, text(header-size, smallcaps[Notation]))
    ]

    #include "pages/notation.typ"

    #pagebreak(weak: true)
]


// Presents the acronym list page.
#let page-acronyms() = [
    #align(
        center,
    )[
        #heading(outlined: false, numbering: none, text(header-size, smallcaps[Acronyms]))
    ]

    #include "pages/acronyms.typ"

    #pagebreak(weak: true)
]
