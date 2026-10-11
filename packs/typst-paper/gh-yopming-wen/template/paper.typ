// import codly package for code block
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.8": *

#let font_family_base = "Palatino Linotype";
#let font_family_heading = "Roboto"
#let font_family_monospace = "Iosevka"

#let color_fsu_blue = cmyk(100%, 57%, 0%, 2%)
#let color_fsu_gray = cmyk(3%, 0%, 0%, 32%)
#let color_fsu_magenta = cmyk(27%, 100%, 0%, 2%)
#let color_fsu_yellow = cmyk(0%, 24%, 94%, 0%)
#let color_fsu_orange = cmyk(0%, 53%, 100%, 0%)
#let color_fsu_green = cmyk(94%, 0%, 100%, 0%)
#let color_fsu_dark_gray = cmyk(0%, 0%, 0%, 77%)



#let template(
  title_page: 0, // 0 means no page break after the title, otherwise 1
	title: [],
  short_title: [],
  author: [],
  email: [],
  course_no: [],
  course_name: [],
  doc,
) = {

  /**** codly package configuration ****/
  show: codly-init.with()
  codly(
    zebra-fill: none,
    display-icon: true,
    languages: codly-languages,
  )


  /**** Code ****/
  show raw.where(): it => {
    block(
      breakable: false, // code block not divided into two pages
      text(size: 9pt, fill: color_fsu_orange, font: font_family_monospace)[#it]
    )
  }


  /**** Text ****/
  set text(size: 10pt, weight: 450, font: font_family_base)
  set block(spacing: 1em)
  set par(justify: false, first-line-indent: 0pt)
  show par: set align(left)

  show strong: set text(fill: color_fsu_blue)

  // raw, inline
  show raw.where(block: false): box.with(
    fill: luma(240),
    inset: (x:2pt, y:0pt),
    radius: 2pt,
    baseline: 0pt,
  )

  show raw.where(block: false): text.with(
    fill: color_fsu_blue
  )


  /**** Page ****/
  set page(
    paper: "us-letter", 
    margin: (left: 20mm, right: 20mm, top: 30mm, bottom: 25mm),
  )

  set page(
    header: context{
      set text(size: 9pt)
      set text(top-edge: .4em)

      // first page
      if here().page() == 1 {
        grid(
          columns: (1fr, 3fr),
          gutter: 5pt,
          align(bottom, image("./assets/fsu.jpg", width: 25%)),
          align(
            right, 
            text(
              // font: font_family_heading, 
              fill: color_fsu_blue,
              // weight: "bold",
              size: 6pt
            )[#course_no \ #course_name]
          )
        )

        line(length: 100%, stroke: 1pt + black)
      }

      // starting from 2nd page
      if here().page() > 1 {
        // use short_title if it is defined; use title otherwise
        if short_title != none {
          text(short_title)
        } else {
          text(title)
        }

        h(1fr)
        text(course_no)

        line(length: 100%, stroke: .4pt + black)
      }
    },
    footer: context{
      set text(size: 9pt)
      if here().page() > 1 {
        line(length: 100%, stroke: .4pt + black)

        text(email)
        h(1fr) // align right
        text[#here().page()]
      }
    }
  )


  /**** paragraph ****/
  set par(
    spacing: 1em,
  )


  /**** Headings ****/
  // if parameter heading_number is 1, show numberings
  set heading(numbering: "1.1.a.")

  show heading: set block(above: 2em, spacing: 1em) // top, bottom
  show heading: set text(font: font_family_heading)

  show heading.where(level:1): set block(above: 2em)

  show heading.where(level: 4): set block(above: 1.5em, below: 1em)
  show heading.where(level: 4): set heading(numbering: none, outlined: false)
  show heading.where(level: 4): block.with(
    stroke: (left:3pt + black, rest: none),
    outset: (left: -1.5pt),
    inset: (left: 8pt)
  )

  show heading.where(level: 5): set block(above: 1.5em, below: 1em)
  show heading.where(level: 5): set heading(numbering: none, outlined: false)
  show heading.where(level: 5): underline.with(offset: 4pt, stroke: 1pt)

  // font size/weight/styles for headings
  show heading.where(level:1): set text(size: 13pt, weight: "bold")
  show heading.where(level:2): set text(size: 12pt, weight: "bold")
  show heading.where(level:3): set text(size: 11pt, weight: "bold")
  show heading.where(level:4): set text(size: 10pt, weight: "bold")
  show heading.where(level:5): set text(size: 10pt, weight: "bold", style: "italic")


  /**** Mathematics ****/
  set math.equation(numbering: "(1)")
  show math.equation: set block(spacing: 1.5em)


  /**** Footnotes ****/
  set footnote.entry(
    indent: 0em,
    separator: line(length: 25%, stroke: 0.75pt),
    // gap: 0.65em
  )
  show footnote.entry: set text(7.25pt)


  /**** Figures ****/
  set figure(supplement: [Fig.])
  set figure(
    placement: none, // placement none: follow text
    gap: 0.5em,
  )

  set figure.caption(position: bottom)
  show figure.caption: set text(size: 8pt)
  show figure.caption: set align(center)
  show figure.caption: set par(first-line-indent: 0em)

  show figure.where(kind: table): set figure(supplement: [Table])
  show figure.where(kind: table): set figure(gap: 0.5em)
  show figure.where(kind: table): set figure.caption(position: top)

  show table: set text(size: 9pt)


  /**** Lists ****/
  set list(indent: 1em, marker: ([•], [‣], [⁃]))

  set enum(indent: 1em)


  /**** Link ****/
  show link: it => {
    underline(it.body)
  }


  /**** Bibliography ****/
  set bibliography(style: "ieee")
  show bibliography: set par(first-line-indent: 0em)
  show bibliography: set block(spacing: 1em)
  show bibliography: it=> {
    show heading: set block(above: 3em, below: 1.5em)
    it
  }

  /**** Title Page ****/
  // padding before title
  if title_page == 1 {
    v(10em)
  }

  // title
  {
    set document(title: title)
    set text(weight: "black", size: 16pt, font: font_family_heading, fill: color_fsu_blue)
    block(title)
  }

  // course name
  if title_page == 1 {
    set text(size: 12pt)
    text(course_no)
    h(5pt)
    text(course_name)
    v(1em)
  }

  // author email
  {
    block(text(author))
    block(text(email))
  }
  v(1em)

  if title_page == 1 {
    pagebreak()
  } else {
    line(length: 100%, stroke: 0.4pt + black)
    v(1em)
  }

  /**** doc ****/
  doc
}
