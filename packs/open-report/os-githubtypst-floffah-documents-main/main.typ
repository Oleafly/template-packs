#import "@preview/wordometer:0.1.4": word-count, total-words

// Feature inspiration taken from Ilm (MIT) - https://github.com/talal/ilm

// The project function defines how your document looks.
// It takes your content and some metadata and formats it.
// Go ahead and customize it to your liking!
#let project(
  title: "",
  authors: (),
  authorsVertical: false,
  date: none,
  logo: none,
  abstract: none,

  formal: false,
  
  // Whether to display a maroon circle next to external links.
  external-link-circle: true,
  // Display an index of figures (images).
  figure-index: (
    enabled: false,
    title: "",
  ),
  bibliography: none,
  word-counter: (
    enabled: false,
    auto-include-body: false,
  ),
  declaration: none,
  
  body,
) = context {  
  set text(region: "GB")
  
  // Set the document's basic properties.
  set document(author: authors.map(a => a.name), title: title)
  
  set text(font: "Arial", lang: "en", size: 12pt)

  // Set paragraph spacing.
  let leading = 1.5em
  let leading = leading - 0.75em // "Normalization"
  set block(spacing: leading)
  set par(spacing: leading * 2)
  set par(leading: leading)

  set heading(numbering: "1.")

  {
    // See ILM (MIT) - https://github.com/talal/ilm/blob/main/lib.typ
    show link: it => {
      it
      // Workaround for ctheorems package so that its labels keep the default link styling.
      if external-link-circle {
        if type(it.dest) == str {
          sym.wj
          h(1.6pt)
          sym.wj
          super(box(height: 3.8pt, circle(radius: 1.2pt, stroke: 0.7pt + rgb("#993333"))))
        } else if type(it.dest) == label {
          sym.wj
          h(0.6pt)
          sym.wj
          super(box(height: 3.8pt, text("#", stroke: 0.2pt + rgb("#0284c7"))))
        }
      }
    }
  
    // Title page.
    // The page can contain a logo if you pass one with `logo: "logo.png"`.
    v(0.6fr)
    if logo != none {
      let logopath = "images/napier.png"

      if logo != "napier" {
        logopath = logo
      }
      
      align(right, image(logopath, width: 26%))
    }
    v(9.6fr)
  
    text(1.1em, date)
    v(1.2em, weak: true)
    text(2em, weight: 700, title)
  
    // Author information.
    let authorGridColumns = (1fr,) * calc.min(3, authors.len())
    let gutter = 1em
    
    if (authorsVertical) {
      authorGridColumns = (1fr)
      gutter = 1.2em
    }
    
    pad(
      top: 0.7em,
      right: 20%,
      grid(
        columns: authorGridColumns,
        gutter: gutter,
        ..authors.map(author => align(start)[
          *#author.name* \
          #author.affiliation
        ]),
      ),
    )

    if word-counter.enabled {
      v(10pt)

      text(strong("Word count") + " - " + total-words)
    }

    if declaration != none {
      v(10pt)
  
      text(strong("Declaration"))
      linebreak()
      text[
         declare, in accordance with Edinburgh Napier University’s Academic Integrity Regulations that: except where explicit reference is made to the contribution of others\*, this assignment is the result of my own work, and has not been submitted for any module, programme or degree at Edinburgh Napier University or any other institution.
  
         \*IMPORTANT: Contribution of includes use of generative Artificial Intelligence (AI) tools. Ensure you have read the University Guidelines for Students on AI & Writing Assistant Tools). Please declare here whether you have used such tools, and to what extent:
         #linebreak()
         #declaration
      ]
    }
  
    v(2.4fr)
    pagebreak()
  
    // Abstract page.
    if abstract != none {
      v(1fr)
      align(center)[
        #heading(
          outlined: false,
          numbering: none,
          text(0.85em, smallcaps[Abstract]),
        )
        #abstract
      ]
      v(1.618fr)
      pagebreak()
    }
  
  
    // Table of contents.
    outline(depth: 3, indent: 1em)
    pagebreak()
  
  
    // Main body.
    set par(justify: true)
    set text(hyphenate: false, size: 15pt)
    set list(marker: ([•], [◦], [‣], [⁃]))
  
    // Utils
    let ignore(content) = {}

    counter(page).update(1)
    set page(numbering: "1", number-align: right)
    
    if word-counter.auto-include-body {
      show: word-count
    
      body
    } else {
      body
    }
  
    pagebreak()
  }

  bibliography

  // See ILM (MIT) - https://github.com/talal/ilm/blob/main/lib.typ
  let fig-t(kind) = figure.where(kind: kind)
  let has-fig(kind) = counter(fig-t(kind)).get().at(0) > 0
  if figure-index.enabled {
    show outline: set heading(outlined: true)
    context {
      let imgs = figure-index.enabled and has-fig(image)
      if imgs {
        // Note that we pagebreak only once instead of each each
        // individual index. This is because for documents that only have a couple of
        // figures, starting each index on new page would result in superfluous
        // whitespace.
        pagebreak()
      }

      if imgs { outline(title: figure-index.at("title", default: "Index of Figures"), target: fig-t(image)) }
    }
  }
}

#let cite-via(
  citation,
  via,
  form: "normal"
) = {
  cite(citation, form: form, supplement: "as cited in " + cite(via, form: "author") + " " + cite(via, form: "year"))
}