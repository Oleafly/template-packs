
// This is an example typst template (based on the default template that ships
// with Quarto). It defines a typst function named 'article' which provides
// various customization options. This function is called from the 
// 'typst-show.typ' file (which maps Pandoc metadata function arguments)
//
// If you are creating or packaging a custom typst template you will likely
// want to replace this file and 'typst-show.typ' entirely. You can find 
// documentation on creating typst templates and some examples here: 
//   - https://typst.app/docs/tutorial/making-a-template/
//   - https://github.com/typst/templates


#let generic-report(

  // Custom Start
  prepared-for: none,
  system: none,

  // dictionary with two keys: A `path` to an image file and a `width` size percentage
  left-header-logo: none,
  right-header-logo: none,
  // Custom End
  
  title: none,
  subtitle: none,
  authors: none,
  date: none,
  abstract: none,
  abstract-title: none,
  cols: 1,
  margin: (x: .75in, y: .5in),
  paper: "us-letter",
  lang: "en",
  region: "US",
  font: "libertinus serif",
  fontsize: 11pt,
  title-size: 1.5em,
  subtitle-size: 1.25em,
  heading-family: "libertinus serif",
  heading-weight: "bold",
  heading-style: "normal",
  heading-color: black,
  heading-line-height: 0.65em,
  sectionnumbering: none,
  pagenumbering: "1",
  toc: false,
  toc_title: none,
  toc_depth: none,
  toc_indent: 1.5em,
  doc,
) = {
  set page(
    paper: paper,
    margin: margin,
    numbering: pagenumbering,
    footer: context [
      #date
      #h(1fr)
      Page
      #counter(page).display("1 of 1", both: true)
    ]
  )
  set par(justify: true)
  set text(lang: lang,
           region: region,
           font: font,
           size: fontsize)
  set heading(numbering: sectionnumbering)

  grid(
    columns: (1fr, 1fr),
    gutter: 1em,
    align: (left, right),
    image(left-header-logo.path, width: left-header-logo.width),
    image(right-header-logo.path, width: right-header-logo.width),
  )

  if title != none {
    align(center)[#block(inset: 2em)[
      #set par(leading: heading-line-height)
      #if (heading-family != none or heading-weight != "bold" or heading-style != "normal"
           or heading-color != black) {
        set text(font: heading-family, weight: heading-weight, style: heading-style, fill: heading-color)
        text(size: title-size)[#title]
        if subtitle != none {
          parbreak()
          text(size: subtitle-size)[#subtitle]
        }
      } else {
        text(weight: "bold", size: title-size)[#title]
        if subtitle != none {
          parbreak()
          text(weight: "bold", size: subtitle-size)[#subtitle]
        }
      }
    ]]
  }

  if authors != none {
    let first-author = authors.first()

    align(center)[
      #table(
        // columns: 2,
        columns: (auto, auto),
        stroke: 0.5pt + rgb("666675"),
        align: left,
      [*Prepared By:*], [#first-author.name],
      [*Prepared For:*], [#prepared-for],
      [*DCI System:*], [#system],
      )
    ]
  }


  // Original Code
  // if authors != none {
  //   let count = authors.len()
  //   let ncols = calc.min(count, 3)
  //   grid(
  //     columns: (1fr,) * ncols,
  //     row-gutter: 1.5em,
  //     ..authors.map(author =>
  //         align(center)[
  //           #author.name \
  //           #author.affiliation \
  //           #author.email
  //         ]
  //     )
  //   )
  // }
  //

  // if date != none {
  //   align(center)[#block(inset: 1em)[
  //     #date
  //   ]]
  // }

  if abstract != none {
    block(inset: 2em)[
    #text(weight: "semibold")[#abstract-title] #h(1em) #abstract
    ]
  }

  if toc {
    let title = if toc_title == none {
      auto
    } else {
      toc_title
    }
    block(above: 0em, below: 2em)[
    #outline(
      title: toc_title,
      depth: toc_depth,
      indent: toc_indent
    );
    ]
  }

  if cols == 1 {
    doc
  } else {
    columns(cols, doc)
  }
}

#set table(
  inset: 6pt,
  stroke: none
)
