#import "@preview/codelst:2.0.2": *
#import "@preview/hydra:0.6.1": hydra
#import "locale.typ": *
#import "titlepage.typ": *
#import "declaration-of-authorship.typ": *
#import "check-attributes.typ": *

// Workaround for the lack of an `std` scope.
#let std-bibliography = bibliography

#let thesis(
  title: none,
  authors: (:),
  language: none,
  type-of-thesis: none,
  show-declaration-of-authorship: true,
  show-table-of-contents: true,
  show-abstract: true,
  abstract: none,
  abstract_de: none,
  appendix: none,
  declaration-of-authorship-content: none,
  university: "Technische Universität Ilmenau",
  university-location: "Ilmenau",
  city: "Ilmenau",
  supervisor: (:),
  date: none,
  date-format: "[day].[month].[year]",
  bibliography: none,
  bib-style: "din-1505-2-alphanumeric.csl",
  math-numbering: "(1)",
  logo: image("logo.svg"),
  ignored-link-label-keys-for-highlighting: (),
  body,
) = {
  // check required attributes
  check-attributes(
    title,
    authors,
    language,
    type-of-thesis,
    show-declaration-of-authorship,
    show-table-of-contents,
    show-abstract,
    abstract,
    appendix,
    university,
    university-location,
    supervisor,
    date,
    city,
    bibliography,
    bib-style,
    logo,
    math-numbering,
    ignored-link-label-keys-for-highlighting,
  )


  // ---------- Fonts & Related Measures ---------------------------------------

  let body-font = "New Computer Modern"
  let body-size = 12pt
  let heading-font = "New Computer Modern"
  let h1-size = 24pt
  let h2-size = 16pt
  let h3-size = 12pt
  let h4-size = 12pt
  let page-grid = 16pt  // vertical spacing on all pages


  // ---------- Basic Document Settings ---------------------------------------

  set document(title: title, author: authors.map(author => author.name))
  let many-authors = authors.len() > 3
  let in-frontmatter = state("in-frontmatter", true)    // to control page number format in frontmatter
  let in-body = state("in-body", true)                  // to control heading formatting in/outside of body

  // customize look of figure
  set figure.caption(separator: [ --- ], position: bottom)

  // math numbering
  set math.equation(numbering: math-numbering)


  // show links in dark blue
  show link: set text(fill: blue.darken(40%))

  // ========== TITLEPAGE ========================================


  titlepage(
      authors,
      date,
      heading-font,
      language,
      logo,
      many-authors,
      supervisor,
      title,
      type-of-thesis,
      university,
      university-location,
      date-format,
      page-grid,
  )
  counter(page).update(1)

  // ---------- Page Setup ---------------------------------------

  // adapt body text layout to basic measures
  set text(
    font: body-font,
    lang: language,
    size: body-size - 0.5pt,      // 0.5pt adjustment because of large x-hight
    top-edge: 0.75 * body-size,
    bottom-edge: -0.25 * body-size,
  )
  set par(
    spacing: page-grid,
    leading: page-grid - body-size,
    justify: true,
  )

  set page(
    margin: (top: 3cm, bottom: 3cm, left: 3cm, right: 3cm),
    header:
      grid(
        columns: (1fr, 1fr),
        align: (left, right),
        row-gutter: 0.5em,
        smallcaps(text(font: heading-font, size: body-size,
          context {
            hydra(1, display: (_, it) => it.body, use-last: true, skip-starting: false)
          },
        )),
        text(font: heading-font, size: body-size,
          number-type: "lining",
          context {if in-frontmatter.get() {
              counter(page).display("i")      // roman page numbers for the frontmatter
            } else {
              counter(page).display("1")      // arabic page numbers for the rest of the document
            }
          }
        ),
        grid.cell(colspan: 2, line(length: 100%, stroke: 0.5pt)),
      ),
      header-ascent: page-grid,
  )


  // ========== FRONTMATTER ========================================

  // ---------- Heading Format (Part I) ---------------------------------------

  show heading: set text(weight: "bold", fill: luma(80), font: heading-font)
  show heading.where(level: 1): it => {v(2 * page-grid) + text(size: h1-size, it)}

  // ---------- Abstract ---------------------------------------

  if (show-abstract and abstract_de != none) {
    heading(level: 1, numbering: none, outlined: false, ABSTRACT.at("de"))
    text(abstract_de)
  }

  if (show-abstract and abstract != none) {
    heading(level: 1, numbering: none, outlined: false, ABSTRACT.at("en"))
    text(abstract)
    pagebreak()
  }

  // ---------- ToC (Outline) ---------------------------------------

  // top-level TOC entries in bold without filling
  show outline.entry.where(level: 1): it => {
    set block(above: page-grid)
    set text(font: heading-font, weight: "semibold", size: body-size)
    link(
      it.element.location(),    // make entry linkable
      it.indented(it.prefix(), it.body() + box(width: 1fr,) +  it.page())
    )
  }

  // other TOC entries in regular with adapted filling
  show outline.entry.where(level: 2).or(outline.entry.where(level: 3)): it => {
    set block(above: page-grid - body-size)
    set text(font: heading-font, size: body-size)
    link(
      it.element.location(),  // make entry linkable
      it.indented(
          it.prefix(),
          it.body() + "  " +
            box(width: 1fr, repeat([.], gap: 2pt), baseline: 30%) +
            "  " + it.page()
      )
    )
  }

  if (show-table-of-contents) {
    outline(
      title: TABLE_OF_CONTENTS.at(language),
      indent: auto,
      depth: 3,
    )
  }

  in-frontmatter.update(false)  // end of frontmatter
  counter(page).update(0)       // so the first chapter starts at page 1 (now in arabic numbers)

  // ========== DOCUMENT BODY ========================================

  // ---------- Heading Format (Part II: H1-H4) ---------------------------------------

  set heading(numbering: "1.1.1")

  show heading: it => {
    set par(leading: 4pt, justify: false)
    text(it, top-edge: 0.75em, bottom-edge: -0.25em)
    v(page-grid, weak: true)
  }

  show heading.where(level: 1): it => {
    set par(leading: 0pt, justify: false)
    pagebreak()
    context{
      if in-body.get() {
        v(page-grid * 3)
        text(CHAPTER.at(language) + " " + counter(heading).display(),size: h1-size)
        linebreak()
        v(0.5em)
        text(               // heading text on separate line
          it.body, size: h1-size,
          top-edge: 0.75em,
          bottom-edge: -0.25em,
        )
      } else {
        v(2 * page-grid)
        text(size: h1-size, counter(heading).display() + h(0.5em) + it.body)   // appendix
      }
    }
  }

  show heading.where(level: 2): it => {v(16pt) + text(size: h2-size, it)}
  show heading.where(level: 3): it => {v(16pt) + text(size: h3-size, it)}
  show heading.where(level: 4): it => {v(16pt) + smallcaps(text(size: h4-size, weight: "semibold", it.body))}

 // ---------- Body Text ---------------------------------------

  body


  // ========== APPENDIX ========================================

  in-body.update(false)


  // ---------- Bibliography ---------------------------------------

  show std-bibliography: set heading(numbering: it => h(-12pt) + "")
  if bibliography != none {
    set std-bibliography(
      title: REFERENCES.at(language),
      style: bib-style,
    )
    bibliography
  }

  show outline: set heading(numbering: it => h(-12pt) + "")
  show outline: set heading(outlined: true)
  outline(
    title: TOC_FIGS.at(language),
    target: figure.where(kind: image),
  )

  outline(
    title: TOC_TABLES.at(language),
    target: figure.where(kind: table),
  )



  set heading(numbering: "A.1")
  counter(heading).update(0)


  // ---------- Appendix (other contents) ---------------------------------------

  if (appendix != none) {       // the user has to provide heading(s)
    appendix
  }

  // ========== LEGAL BACKMATTER ========================================

  set heading(numbering: it => h(-12pt) + "", outlined: false)



  // ---------- Declaration Of Authorship ---------------------------------------

  if (show-declaration-of-authorship) {
    declaration-of-authorship(
      authors,
      title,
      declaration-of-authorship-content,
      date,
      language,
      many-authors,
      city,
      date-format,
    )
  }

}
