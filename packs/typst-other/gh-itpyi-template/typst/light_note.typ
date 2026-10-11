// modified from https://github.com/mbollmann/typst-kunskap.git
// #import "@preview/linguify:0.4.2": *
// Set theorem environments
#import "dingli.typ": *

#let parvirtual = {
"" 
context v(-par.spacing -  measure("").height)
}

#let link-color = rgb("#3282B8")
#let muted-color = luma(160)
#let block-bg-color = luma(240)

#let text-muted(it) = {text(fill: muted-color, it)}


// Report template
#let light_note(
    // Metadata
    title: [Title],
    author: "Anonymous",
    header: "",
    date_created: datetime.today().display("[month repr:long] [day padding:zero], [year repr:full]"),
    date_modified: datetime.today().display("[month repr:long] [day padding:zero], [year repr:full]"),
    abstract: [],
    toc: true,

    // Paper size
    paper-size: "a4",

    // Fonts
    body-font: ("New Computer Modern","Latin Modern Roman","Libertinus Serif","Noto Serif", "Songti SC"),
    body-font-size: 11pt,
    raw-font: ("Cascadia Code", "Menlo", "CodeNewRoman Nerd Font", "Latin Modern Mono"),
    raw-font-size: 9pt,
    caption-size: 10pt,
    headings-font: ("Helvetica", "New Computer Modern Sans","Latin Modern Sans",  "Libertinus Sans", "Noto Sans","Heiti SC"),
    math-font: ("New Computer Modern Math","Latin Modern Math", "Libertinus Math"),

    // Colors
    link-color: link-color,
    muted-color: muted-color,
    block-bg-color: block-bg-color,

    // The main document body
    body
) = {
    // Configure page size
    set page(
        paper: paper-size,
        margin: (top: 2.625cm),
    )

    // Set the document's metadata
    set document(title: title, author: author)

    // Set the fonts
    set text(font: body-font, size: body-font-size, weight: 450) // book weight for New Computer Modern font
    show raw: set text(font: raw-font, size: raw-font-size)
    show math.equation: set text(font: math-font)

    show heading: it => {
        // Add vertical space before headings
        if it.level == 1 {
            v(6%, weak: true)
        } else {
            v(4%, weak: true)
        }

        // Set headings font
        set text(font: headings-font, weight: "regular")
        it

        // Add vertical space after headings
        v(3%, weak: true)
    }
    
    set heading(numbering: "1.")

    // show heading.where(level: 3): it => text(
    //     font: headings-font,
    //     size: body-font-size,
    //     weight: "regular",
    //     it.body + h(1em),
    // )

    // Set paragraph properties
    set par(leading: 8pt, spacing: 8pt, justify: true)

    // Set list styling
    set enum(indent: 1.5em, numbering: "1.a.i.")
    set list(indent: 1.5em)
    set terms(indent: 1.5em, hanging-indent: 3em)
    // Redefine term list item in order to redefine the term font
    // show terms.item: it => par(
    //     hanging-indent: terms.indent + terms.hanging-indent,
    //     {
    //         h(terms.indent)
    //         text(font: body-font, weight: "bold", it.term)
    //         h(1.1em)
    //         it.description
    //     }
    // )
    // 
    // Set equation spacing 
    show math.equation.where(block: true): set block(above: 15pt, below: 15pt)

    // Set math label
    
    set math.equation(numbering: "(1)")
    show ref: it => {
      let eq = math.equation
      let el = it.element
      if el != none and el.func() == eq {
        // Override equation references.
        link(el.location(),numbering(
          el.numbering,
          ..counter(eq).at(el.location())
        ))
      } else {
        // Other references as usual.
        it
      }
    }
    

    // Display block code with padding and shaded background
    show raw.where(block: true): block.with(
        inset: (x: 1.5em, y: 5pt),
        outset: (x: -1em),
        width: 100%,
        fill: block-bg-color,
    )
    show raw.where(block: true): set par(justify: false)

    // Display inline code with shaded background while retaining the correct baseline
    show raw.where(block: false): box.with(
        inset: (x: 3pt, y: 0pt),
        outset: (y: 3pt),
        fill: block-bg-color,
    )

    // Set block quote styling
    show quote.where(block: true): set pad(x: 1.5em)

    // Set figure caption
    // show figure.caption: it => {
    //     set align(left)
    //     set text(size: caption-size)
    //     it
    // }
    show figure.caption: it => {
        set text(size: caption-size, font: body-font)
        layout(size => [
            #let text-size = measure(
                it
            )
            #let my-align
            #if text-size.width < size.width {
            my-align = center
            } else {
            my-align = left
            }

            #align(my-align, it)
        ])
    }

    show figure: it => {
        if it.caption != none and it.placement == none {
            v(2em, weak: true)
            it
            parvirtual
            v(2em, weak: true)
        } else {
            it
        }
    }

    show figure.where(kind: image): set text(size: caption-size)
    show figure.where(kind: "inline"): set text(size: caption-size)


    // Set link styling
    show link: it => {
        set text(fill: link-color)
        it
    }
    
    // Set theorem environments
    
    show: thmrules

    // TYPESETTING THE DOCUMENT
    // -----------------------------------------------------------------------
    // Set page header and footer (numbering)
    set page(
        header: context {
            if counter(page).get().first() > 1 [
                #set text(font: headings-font, weight: "regular", fill: muted-color, size: caption-size)
                #header
                #h(1fr)
                #title
            ] else [
                #set text(font: headings-font, weight: "regular")
                #header
            ]
        },
        numbering: (..nums) => {
            set text(font: headings-font, weight: "regular" ,fill: muted-color)
            nums.pos().first()
        },
    )

    // set citation
    set bibliography(style: "springer-mathphys")

    // Set title block
    {
        v(26pt)
        text(font: headings-font, weight: "bold", size: 20pt, title)
        linebreak()
        v(16pt)
        if type(author) == array {
            text(font: body-font, author.join(", "))
        } else {
            text(font: body-font, author)
        }
        if date_created != none {
            v(2pt)
            text(font: body-font, smallcaps[Date created: ])
            text(font: body-font, date_created + "\n")
        }
        if date_created != none {
            text(font: body-font, smallcaps[Date modified: ])
            text(font: body-font, date_modified)
        }
        v(1em)
        if abstract != [] {
            text(font: headings-font, size: 16pt, weight: "regular", "Abstract")
            v(11pt)
            set par(first-line-indent: (amount: 2em))
            text(font: body-font, abstract)
        }
    }
    

    if toc{
    outline()
    v(2em)
    }

    // Main body
    set par(first-line-indent: 1.5em)
    {body}
}


#let light_note_cn(
    // Metadata
    title: [Title],
    author: "Anonymous",
    header: "",
    date_created: datetime.today().display("[month repr:long] [day padding:zero], [year repr:full]"),
    date_modified: datetime.today().display("[month repr:long] [day padding:zero], [year repr:full]"),
    abstract: [],
    toc: true,

    // Paper size
    paper-size: "a4",

    // Fonts
    body-font: ("New Computer Modern","Latin Modern Roman","Libertinus Serif","Noto Serif", "Songti SC"),
    body-font-size: 11pt,
    raw-font: ("Cascadia Code", "Menlo", "CodeNewRoman Nerd Font", "Latin Modern Mono"),
    raw-font-size: 9pt,
    caption-size: 10pt,
    headings-font: ("Helvetica", "New Computer Modern Sans","Latin Modern Sans",  "Libertinus Sans", "Noto Sans","Heiti SC"),
    math-font: ("New Computer Modern Math","Latin Modern Math", "Libertinus Math", "Songti SC"),
    emph-font: ("New Computer Modern","Latin Modern Roman","Libertinus Serif","Noto Serif", "Kaiti SC"),

    // Colors
    link-color: link-color,
    muted-color: muted-color,
    block-bg-color: block-bg-color,

    // The main document body
    body
) = {
    // Configure page size
    set text(lang: "zh")
    set page(
        paper: paper-size,
        margin: (top: 2.625cm),
    )

    // Set the document's metadata
    set document(title: title, author: author)

    // Set the fonts
    set text(font: body-font, size: body-font-size, weight: 450) // book weight for New Computer Modern font
    show raw: set text(font: raw-font, size: raw-font-size)
    show emph: set text(font: emph-font, size: body-font-size) // Kaiti instead of italic for emphasis
    show math.equation: set text(font: math-font)

    show heading: it => {
        // Add vertical space before headings
        if it.level == 1 {
            v(6%, weak: true)
        } else {
            v(4%, weak: true)
        }

        // Set headings font
        set text(font: headings-font, weight: "regular")
        it

        // Add vertical space after headings
        v(3%, weak: true)
    }
    
    set heading(numbering: "1.")

    // show heading.where(level: 3): it => text(
    //     font: headings-font,
    //     //size: body-font-size,
    //     weight: "regular",
    //     it.body + h(1em),
    // )
    
    // Set equation spacing 
    show math.equation.where(block: true): set block(spacing: 15pt)

    // Set math label
    
    set math.equation(numbering: "(1)")
    show ref: it => {
      let eq = math.equation
      let el = it.element
      if el != none and el.func() == eq {
        // Override equation references.
        link(el.location(),numbering(
          el.numbering,
          ..counter(eq).at(el.location())
        ))
      } else {
        // Other references as usual.
        it
      }
    }

    // Set paragraph properties
    set par(leading: 8pt, spacing: 8pt, justify: true)

    // Set list styling
    set enum(indent: 2em, numbering: "1.a.i.")
    set list(indent: 2em)
    set terms(indent: 2em, hanging-indent: 2em)
    // Redefine term list item in order to redefine the term font
    // show terms.item: it => par(
    //     hanging-indent: terms.indent + terms.hanging-indent,
    //     spacing: 1em,
    //     {
    //         h(0em)
    //         text(font: body-font, weight: "bold", it.term)
    //         h(1.1em)
    //         it.description
    //     }
    // )

    // Display block code with padding and shaded background
    show raw.where(block: true): block.with(
        inset: (x: 1.5em, y: 5pt),
        outset: (x: -1em),
        width: 100%,
        fill: block-bg-color,
    )
    show raw.where(block: true): set par(justify: false)

    // Display inline code with shaded background while retaining the correct baseline
    show raw.where(block: false): box.with(
        inset: (x: 3pt, y: 0pt),
        outset: (y: 3pt),
        fill: block-bg-color,
    )

    // Set reference font
    show ref: set text(font: body-font)

    // Set figure caption
    // show figure.caption: it => {
    //     set align(left)
    //     set text(size: caption-size, font: body-font)
    //     it
    // }
    // 
    show figure.caption: it => {
        set text(size: caption-size, font: body-font)
        layout(size => [
            #let text-size = measure(
                it
            )
            #let my-align
            #if text-size.width < size.width {
            my-align = center
            } else {
            my-align = left
            }

            #align(my-align, it)
        ])
    }

    show figure: it => {
        if it.caption != none and it.placement == none {
            v(2em, weak: true)
            it
            parvirtual
            v(2em, weak: true)
        } else {
            it
        }
    }

    show figure.where(kind: image): set text(size: caption-size)

    // set indent after headings
    show selector.or(heading): it => {
        it
        // v(-par.spacing) 
        // { "" }
        if it.body.text != "目录" {
            ""
            v(-par.spacing - measure("").height)
        }
    }

    let pagebreak_old() = pagebreak()
    let pagebreak_new() = {
        pagebreak()
        ""
        v(-par.spacing - measure("").height)
    }
    


    // Set block quote styling
    show quote.where(block: true): set pad(x: 1.5em)

    // Set link styling
    show link: it => {
        set text(fill: link-color)
        it
    }

    // Set theorem environments
    
    show: thmrules

    // TYPESETTING THE DOCUMENT
    // -----------------------------------------------------------------------
    // Set page header and footer (numbering)
    set page(
        header: context {
            if counter(page).get().first() > 1 [
                #set text(font: headings-font, weight: "regular", fill: muted-color, size: caption-size)
                #header
                #h(1fr)
                #title
            ] else [
                #set text(font: headings-font, weight: "regular")
                #header
            ]
        },
        numbering: (..nums) => {
            set text(font: headings-font, weight: "regular" ,fill: muted-color)
            nums.pos().first()
        },
    )

    // set citation
    set bibliography(style: "gb-7714-2015-numeric")

    // Set title block
    {
        v(26pt)
        text(font: headings-font, weight: "bold", size: 20pt, title)
        linebreak()
        v(16pt)
        if type(author) == array {
            text(font: body-font, style: "italic", author.join(", "))
        } else {
            text(font: body-font, author)
        }
        if date_created != none {
            v(2pt)
            text(font: body-font, [创建日期: ])
            text(font: body-font, date_created + "\n")
        }
        if date_created != none {
            text(font: body-font, style: "italic", [修改日期: ])
            text(font: body-font, date_modified)
        }
        v(1em)
        if abstract != [] {
            text(font: headings-font, size: 16pt, weight: "regular", "摘要")
            v(11pt)
            set par(first-line-indent: (amount: 2em, all: true))
            text(font: body-font, abstract)
        }
    }
    

    if toc{
    outline()
    ""
    v(1em)
    }

    // Main body
    set par(first-line-indent: (amount: 2em))
    {body}
}
