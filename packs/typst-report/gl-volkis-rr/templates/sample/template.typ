#import "/templates/common-functions/includes.typ": default_outline, code, get_version

// If you want to learn more about how templates are parsed, and what options can be overwritten, check out template-parser.typ in the libs directory.

// The structure file is an optional file that lets you 
// overwrite functions that decide how the document should be
// structured.

// This value should be the name of a file in the same directory as the template.typ file
#let structure_file = "structure.typ"

// We like 'Vulnerability', but maybe you like something else!
//#let vulnerability_titles = (
//    plural: "Findings",
//    singular: "Finding"
//)

// This is a color_palette, currently `main` is the only 
// colour in use by RR, but you can stick whatever you 
// want in here and use it in your document.
#let color_palette = (
    "main": rgb("#218380"),
)

// Here we define how tables should be rendered. This shows all possible options.
#let table_format = (
    bg: white,
    heading: (
        fg: white,
        bg: rgb("#218380"),
        bold: true
    )
)


// Here we define how each different risk should be
// formatted in vulnerability tables or in the risk matrix
// The options we can set are bg, fg and bold. 
// These options default to white, black and true respectively.
#let risk_format = (
    "low": (
       bg: rgb("#4D7C8A"),
       fg: white,
    ),
    "medium": (
        bg: rgb("#F2D0A9"),
        fg: white
    ),
    "high": (
        bg: rgb("#D88C9A"),
        fg: white
    ),
    "critical": (
        bg: rgb("#5E4352"),
        fg: white
    ),
    "open": (
        bg: rgb("#81F4E1"),
        fg: black
    ),
    "closed": (
        bg: rgb("#FF729F"),
        fg: white
    )
)

// Add risk bubbles to the ToC
#let risk_in_outline = true

// Like in risk_format, here is where we define how the
// priorities will be formatted in tables.
// The options we can set are bg, fg and bold. 
// These options default to white, black and true respectively.
#let priority_format = (
  "low": (
    bg: rgb("A0C7F2"),
  ),
  "medium": (
    bg: rgb("FFFF00"),
  ),
  "high": (
    bg: rgb("FFBB84"),
  ),
)

// Here we return a page that is rendered as the titlepage,
// If you are writing a template from scratch, this is probably 
// the most you'll have to interact with Typst's syntax.
#let titlepage(title, company, client, version_history) = {
    // Let's grab the most recent version_history entry
    let history = version_history.last()

    return page(
        // Let's set our background on the titlepage to titlepage.svg
        background: image("/templates/sample/titlepage.svg", fit: "stretch"),
        // We don't want a footer here, so explicitly set that there isn't one
        footer: [],
        // This is the actual content on the titlepage
        {
            // First we align the content on our page so it is centred both horizontally and vertically
            set align(center + horizon)

            // Now we put in our title, we don't quite want it to go to
            // the side of the page, so let's put it in a box:
            box(width: 90%, {
                // We don't want justified spaces if a linebreak gets forced
                set par(justify: false)

                // Lets make a bold, 24pt title
                strong(text(24pt, title))
            })

            // Lets add a little bit of spacing
            v(0.5em)

            // Finally, let's add a sub-heading that says the client and date
            [
                // Set the font-size inside our block of content
                #set text(size: 16pt)

                // This is inside a content block, so we refer to vars as #var.
                // Check out https://typst.app/docs/reference/foundations/datetime/#format for date-time formatting.
                Prepared for #client

                #history.date.display("[day] [month repr:long] [year]") 
            ]
        }
    )
}


// This function sets a lot of the show rules for Typst
// Some of the stuff you'd probably be worth looking into is
// show rules around headings.
#let conf(
  title: none,
  company: none,
  client: none,
  contributors: (),
  version_history: (),
  doc,
) = {
  // Pull a version number that is used in our footer
  let history = version_history.last()
  let version = get_version(history.version)

  // Here we configure what a normal page's background should look like
  set page(
    // This is the SVG that gets placed in the top-right of the page.
    // It's A4 sized, meaning that it gets placed correctly
    background: image("page-bg.svg", fit: "stretch", width: 100%),
    // If you wanted to place a smaller SVG in the top right, 
    // you would need some more complex code, but it's very doable.
    // Here is an example to get you started:
    // ```typst
    // background: {
    //    place(alignment: top + right, dx: 1cm, dy: 1cm,
    //        image("page-bg.svg")
    //    )
    // }
    // ```

    // We like A4 size pages
    paper: "a4",
    
    // These are sensible margins
    margin: (x: 2.5cm, y: 3cm),

    // This footer is a little more complex, but think of a grid
    // as a table without any lines.
    footer: {
        grid(
            // First we create two columns, fr is just a fractional amount over the entire width.
            columns: (3fr, 1fr),
            // Then we write our first columns content:
            title + "\nVersion " + str(version) + ", released " + history.date.display("[day] [month repr:long] [year]"),
            // Then we have our second  columns content, which is right-aligned:
            context {
                align(right, "Page " + counter(page).display())
            }
        )
    },
    // This pushes the footer down a bit into the margin, so it better fits
    footer-descent: 0.75cm,
  )

  // This formats code blocks to have a nice background around them
  show raw: code

  // This replaces #[TODO] content blocks with a giant red warning
  show regex("^TODO$"): text([TODO!], fill: red, size: 64pt)

  // A hack that adds a zero-width space in-between each character in a link so it gets line-broken correctly.
  let breaklink(url) = link(url, for c in url [#c.replace(c,c+sym.zws)])

  // Unfortunately links still struggle to get broken across lines, so this is a jank fix
  show regex("https://[^\s]+"): url => breaklink(url.text)
  show regex("http://[^\s]+"): url => breaklink(url.text)

  // This helps us to make lists look more consistent
  let list-indent = 1em
  set list(indent: list-indent)
  show list: it => {
      box(width: 100% - (2 * list-indent), it)
  }

  // This helps us to make enums look more consistent, but breaks + syntax
  let enum-indent = 1em
  set enum(indent: enum-indent)
  show enum: it => {
      box(width: 100% - (2 * enum-indent), it)
  }

  // We like setting paragraph justification to true
  set par(justify: true)

  // The document should probably be left-aligned
  set align(left)

  // Custom ref for rendering vulnerability references and Appendixes correctly.
  show ref: it => {
    let el = it.element
    if el != none and el.supplement == [Vulnerability] {
      link(el.location(), strong(el.body))
    } else if el != none and el.supplement == [Appendix] {
      let prefix = (el.numbering)(..counter(heading).at(el.location()))
      link(el.location(), [#strong(prefix.slice(0, prefix.len() - 1))])
    } else {
      it
    }
  }


  doc
}

// Here we define some text options that get passed verbatim 
// to the text() function in a set rule. However, the template 
// parser defines a sensible default for the font and font size 
// which can be overwritten like so:
#let text_options = (
    font: "Fira Sans"
)

// If we want a custom last_page, we should define one. In this case,
// we are just taking the titlepage background and applying it to 
// a page with no footer and no content.
#let last_page = page(
    background: image("/templates/sample/titlepage.svg", fit: "stretch"),
    footer: [],
    []
)
