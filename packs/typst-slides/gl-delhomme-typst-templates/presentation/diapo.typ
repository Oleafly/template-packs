// This template has been copied from https://github.com/lvignoli/diapo
#let headnumberingsize = 80pt
#let headtextsize = 40pt
#let textsize = 32pt
#let scriptsize = 20pt
#let codesize = 12pt
#let footnotesize = 14pt
#let papertype = "presentation-16-9"
#let textfont = "New Computer Modern"

#let slidered = rgb(89.8%, 0%, 9.8%)
#let slidedarkgrey = rgb(14.9%, 14.9%, 14.9%)
#let slidedarkblue = rgb(24%, 29%, 51%)
#let slidelightblue = rgb(49%, 61%, 73%)
#let slideblack = rgb(4%, 4%, 4%)
#let slidegrey = rgb(40%, 40%, 40%)
#let slidelightgrey = rgb(95%, 95%, 95%)
#let slidegreen = rgb(20%, 43%, 0%)

#let transition(
        // The slide content.
        body,
) = {
        page(
                paper: papertype,
                background: rect(width: 100%, height: 100%, fill: slidelightgrey),
                header: none,
                footer: none,
        )[
                #set align(center+horizon)
                #set text(textsize, font: textfont, fill: slidedarkblue, weight: "regular")
                #body
        ]
}

// You can choose your background color (black by default)
#let lastpage(
        thanks : "Merci de votre attention",
        body,
        bcolor: slidedarkblue
) = {

  let textcolor = white
  if bcolor == white {
    textcolor = slideblack
  }
        page(
                margin: (x: 2cm, y: 2cm),
                paper: papertype,
                background: rect(width: 100%, height: 100%, fill: bcolor),
                header: none,
                footer: none,
        )[
                #text(textsize, font: textfont, fill: textcolor, weight: "bold")[
                  #align(center + horizon)[
                    #thanks \
                    #text(18pt, font: textfont, fill: textcolor, weight: "light")[
                      #body
                    ]
                  ]
                ]
          #place(bottom + right)[#text(size: scriptsize, fill: textcolor)[]]
        ]
}

#let titlepage(
  title,
  author,
  date,
) = {
        page(background: none, header: none, footer: none, margin: (x: 2cm, y: 2cm))[
          #align(center + horizon)[
            #set text(headtextsize, weight: "bold", fill: slideblack)
            #title
            #set text(18pt, weight: "light", fill: slideblack)
            #let count = author.len()
            #let ncols = calc.min(count, 3)
            #grid(
                    columns: (auto,) * ncols,
                    column-gutter: 16pt,
                    row-gutter: 24pt,
                    ..author.map(author => {
                            author.name
                            if (author.keys().contains("affiliation")) {
                                    linebreak()
                                    author.affiliation
                            }
                            if (author.keys().contains("email")) {
                                    linebreak()
                                    link("mailto:" + author.email)
                            }
                    }),
            )

            #text(features: ("case",))[#date]
          ]
        ]
}


#let diapo(
        // The presentation's title, which is displayed on the title slide.
        title: [Title],

        // The presentation's author, which is displayed on the title slide.
        author: none,

        // The date, displayed on the title slide.
        date: none,

        // If true, display the total number of slide of the presentation.
        display-lastpage: false,

        // The presentation's content.
        body
) = {
        // Ensure that the type of `author` is an array
        author = if type(author) == str { ((name: author),) }
                else if type(author) == array { author }
                else { panic("expected string or array, found " + type(author)) }

        // Set the metadata.
        set document(title: title, author: author.map(author => author.name))

        // Configure default page and text properties.
        set text(font: textfont, weight: "light", fill: slidedarkgrey)
        set list(marker: ([#text(fill: black)[--]], [-]))
        set page(
                margin: (x: 2cm, y: 2cm),
                paper: papertype,
                footer: [
                        #set text(size: footnotesize, fill: slidedarkgrey)
                        #grid(
                          columns: (30%, 40%, 20%, 10%),
                          ..author.map(author => {
                            emph(author.name)
                          }),
                          [
                            #set align(left)
                            #title
                          ],
                          [
                            #set align(center)
                            #date
                          ],
                          { [
                              #set align(right)
                              #context [ #counter(page).display("1/1", both: display-lastpage) ]
                            ]
                          }
                        )
                ],
        )
        // Default size for raw code blocks
        show raw.where(block: true): set text(size: codesize)

        // Display the title page.
        titlepage(title, author, date)

        // Customize headings to show new slides
        show heading.where(level: 1): it => {
                page(footer: none)[
                  #set heading(numbering: "1")
                  #counter(heading).step()
                  #align(horizon)[
                    #text(size: headnumberingsize, font: textfont, weight: "bold", fill: slidedarkgrey)[#counter(heading).display() - ] 
                    #text(size: headtextsize, font: textfont, weight: "bold", fill: slidedarkgrey)[#smallcaps(it.body)]
                  ]
                  #v(0.5em)
                ]
        }

        show heading.where(level: 2): it => {
                pagebreak()
                set text(size: textsize, font: textfont, weight: "bold", fill: slidedarkgrey)
                align(top, it)
                v(0.5em)
        }

        set text(size: 18pt, font: textfont, fill: slidedarkgrey)
        // Add the body.
        body
}
