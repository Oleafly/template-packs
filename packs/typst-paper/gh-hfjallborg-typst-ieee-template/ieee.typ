

#let display_authors(authors) = {
  authors.map(it => {
    if it.at("email") != none {
      it.at("name") + " (" + it.at("email") + ")"
    } else {
      it.at("name")
    }
  }).join(", ")
}


#let display_abstract(abstract) = {
  set text(style: "italic", weight: "bold")

  "Abstract – " + abstract
}


#let maketitle(title: none, authors: (), textsize: 10pt, abstract: none, compact_title: false) = {

  place(
    top + center,
    scope: "parent",
    float: true,
    [
      #set text(size: 24pt)
      #set align(center)
      #title
      #linebreak()

      // Byline
      #set text(size: textsize)
      #display_authors(authors)

      #linebreak()

      // Abstract
      #if abstract != none {
        display_abstract(abstract)
      }
      
    #if compact_title {
      line(length: 100%)
      v(1em)
    }

    ],
  )

  if not compact_title {
    pagebreak()
  }


}


#let author(name, email: none) = {
  return (
    name: name,
    email: email
  )
}


#let conf(
  title: none,
  authors: (),
  abstract: [],
  parstyle: "indent",
  columns: 2,
  textsize: 10pt,
  number_sections: true,
  title_page: true,
  compact_title: false,
  doc,
) = {

  set page(
    columns: columns,
  )

  set text(
    size: textsize,
  )

  show heading: set text(size: textsize, weight: "regular")

  show heading.where(level: 1): set heading(
    numbering: (..nums) => {
      return numbering("I.", nums.pos().last())
    }
  ) if number_sections
  show heading.where(level: 1): it => {
    if parstyle == "indent" {
      v(0.65em)
    }
    set align(center)
    smallcaps[#it]
    v(0.65em)
  }

  show heading.where(level: 2): set heading(
    numbering: (..nums) => {
      return numbering("A.", nums.pos().last())
    }
  ) if number_sections
  show heading.where(level: 2): it => {
    set par(first-line-indent: 0em)

    if parstyle == "indent" {
      v(0.65em)
    }
    
    if number_sections {
        counter(heading).display(it.numbering)
      }
    set text(style: "italic")
    " " + it.body
    linebreak()
  }
  
  show heading.where(level: 3): set heading(
    numbering: (..nums) => {
      return numbering("1)", nums.pos().last())
    }
  ) if number_sections
  show heading.where(level: 3): it => {
    box([
      #if parstyle == "indent" {
        v(0.65em)
      }
      #if number_sections {
        counter(heading).display(it.numbering)
      }
      #set text(style: "italic")
      #it.body:
    ])
  }

    show heading.where(level: 4): set heading(
    numbering: (..nums) => {
      return numbering("1a)", nums.pos().at(2), nums.pos().at(3))
    }
  ) if number_sections
  show heading.where(level: 4): it => {
    box([
  
      #h(1em)
      #if number_sections {
        counter(heading).display(it.numbering)
      }
      #set text(style: "italic")
      #it.body:
    ])
  }


  // Paragraph styling
  set par(
    justify: true,
    spacing: 0.65em,
    first-line-indent: 1em
  ) if parstyle == "indent"
  set par(
    justify: false,
    spacing: 1.65em,
  ) if parstyle == "block"

  if title_page {
    maketitle(title: title, authors: authors, abstract: abstract, compact_title: compact_title)
  }


  // Figures and tables  
  show figure.where(kind: table): set figure.caption(position: top)
  show figure.where(kind: table): set figure(
    numbering: "I"
  )

  show figure.caption: it => {
    if it.kind == table {
      smallcaps[Table ] + it.numbering
      linebreak()
      it.body
    } else {
      "Fig.  " + context counter(figure).display() + "\u{2002}" + it.body
    }
  }
  
  doc
}
