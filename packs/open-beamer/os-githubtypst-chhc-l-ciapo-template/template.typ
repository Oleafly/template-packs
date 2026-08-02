#let scriptsize = 8pt
#let margin-x = 1.2cm

#let transition(
    // The slide accent color. Default is a vibrant yellow.
    accent-color: rgb("1f1e33"),

    // Whether to make the text white. Default is true.
    text-color: white,

    // The slide content.
    body,
) = {
    page(
        width: 16cm,
        height: 12cm,
        margin:(top: 2cm, bottom: 2cm, left: margin-x, right: margin-x),
        background: rect(width: 100%, height: 100%, fill: accent-color),
        header: none,
        footer: none,
    )[
        #set align(center+horizon)
        #set text(28pt, fill: text-color, weight: "bold")
        #body
    ]
}

#let refpage(
    body,
) = {
    page(
        header: none,
    )[
        #text(18pt, weight: "bold")[Reference]
        #v(1em)
        
        #set par(justify: true, leading: 2em, )
        #body
    ]
}

#let longpage(
    // How many times its height is, with respect to normal pages
    hpages,
    // margin-x value, default is 1.2cm
    marginxn: margin-x,
    // The slide content.
    body,
) = {
    page(
        width: 16cm,
        height: hpages*12cm,
        margin:(left: marginxn, right: marginxn),
    )[
        #body
    ]
}

#let diapo(
    // The presentation's title, which is displayed on the title slide.
    title: [Title],

    // The presentation's author, which is displayed on the title slide.
    author: none,

    // The date, displayed on the title slide.
    date: none,

    // The email, displayed on the title slide.
    email: none,

    // If true, display the total number of slide of the presentation.
    display-lastpage: true,

    // If set, this will be displayed on top of each slide.
    short-title: none,

    // The presentation's content.
    body
) = {
    // Ensure that the type of `author` is an array
    author = if type(author) == "string" { ((name: author, email: email), ) }
        else if type(author) == "array" { author }
        else { panic("expected string or array, found " + type(author)) }

    // Set the metadata.
    set document(title: title, author: author.map(author => author.name))

    // Configure page and text properties.
    set text(font: "Lucida Sans", weight: "extralight")
    set page(
        width: 16cm,
        height: 12cm,
        margin:(top: 2cm, bottom: 1.5cm, left: margin-x, right: margin-x),
        header-ascent: 40%,
        footer-descent: 40%,
        header: [
            #let headertext = locate(loc => {
                let elemsbef = query(selector(heading).before(loc), loc,)
                let elemsaft = query(selector(heading).after(loc), loc,)
                let elem = if (elemsaft.len() > 0 and elemsaft.first().level == 1) or elemsbef.filter(e => e.level == 1).len() == 0 {
                    ()
                } else {
                    elemsbef.filter(e => e.level == 1).last().body
                }
                let subelem = if (elemsaft.len() > 0 and elemsaft.first().level <= 2) or elemsbef.filter(e => e.level == 2).len() == 0 {
                    ()
                } else {
                    elemsbef.filter(e => e.level == 2).last().body
                }
                if subelem != () { subelem + " | " }
                if elem != () { elem + " | " }
                short-title
            })
            #set align(right)
            #text()[#headertext]
        ],
        footer: [
            #let lastpage-number = locate(pos => counter(page).final(pos).at(0))
            #set align(right)
            #text(size: scriptsize)[
                #counter(page).display("1") 
                #if (display-lastpage) [\/ #lastpage-number]
            ]
        ],
    )

    // Display the title page.
    page(background: none, header: none, footer: none)[
        #set align(center+horizon)
        #set text(24pt, weight: "semibold")
        #title

        #set text(14pt, weight: "light")
        #let count = author.len()
        #let ncols = calc.min(count, 3)
        #grid(
            columns: (auto,) * ncols,
            column-gutter: 16pt,
            row-gutter: 24pt,
            ..author.map(author => {
                author.name
                if (author.keys().contains("email") and author.email != none) {
                    "  " + link("mailto:" + author.email)
                }
                if (author.keys().contains("affiliation")) {
                    linebreak()
                    author.affiliation
                }
            }),
        )

        #text(features: ("case",))[#date]
    ]

    // Customize headings to show new slides.
    show heading: set text(weight: "bold")
    show heading.where(level: 1): it => {
        pagebreak()
        align(top, it)
        v(1em)
    }
    show heading.where(level: 2): it => {
        align(top, it)
        v(1em)
    }
    show heading.where(level: 3): it => {
        align(top, it)
        v(1em)
    }

    // Customize raw
    set raw(tab-size: 4)
    show raw.where(block: true): box.with(
        fill: luma(240),
        inset: (x: 7pt, y: 7pt),
        radius: 2pt,
    )
    show raw.where(block: false): box.with(
        fill: luma(240),
        inset: (x: 3pt, y: 0pt),
        outset: (y: 3pt),
        radius: 2pt,
    )

    set heading(numbering: "1.")

    show outline.entry.where(level: 1): it => {
        v(3pt)
        strong(it)
    }
    
    show link: underline

    // Add the body.
    body
}

#let mcolor = (
    miku: color.rgb(57,197,187),
    violet: color.rgb(49,0,128),
    lblue: color.rgb(85,204,250),
    lpink: color.rgb(246,165,181),
)

#let bf(content) = text(weight: "bold")[#content]