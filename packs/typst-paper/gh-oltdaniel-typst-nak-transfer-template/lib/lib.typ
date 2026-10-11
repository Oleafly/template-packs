#import "translations.typ": translations

#let nak_tl(
  language: "de",
  title: "Paper Title",
  author: "Max Mustermann",
  matriculation-number: 12345,
  transfermodule-number: 1,
  centurion: "Technische Informatik/IT-Engineering, T22",
  show-header-always: false,
  use-sans: false,
  before-content: none,
  after-content: none,
  body,
) = {
  // Template settings
  let dark_blue = color.rgb(8, 31, 92)
  let font_size = if use-sans {
    11pt
  } else {
    12pt
  }
  let font = if use-sans {
    // NOTE: Arial font is suggested, but it is not a free font
    "New Computer Modern Sans"
  } else {
    // NOTE: Times New Roman font is suggested, but it is not a free font
    // This is the Typst Default font
    "Libertinus Serif"
  }
  let margin_y = 3cm
  let margin_x = 2cm

  let paragraph_spacing = 1.75em
  let heading_margin_top = 1.75em
  let heading_margin_bottom = 1em

  // Change font
  set text(size: font_size, font: font)

  // Document config
  import "pages/header.typ": header

  set document(title: title, author: str(author))
  set text(lang: language)
  set page(
    header: if show-header-always { header } else { none },
    margin: (y: margin_y, x: margin_x),
  )
  set par(spacing: paragraph_spacing)
  show heading.where(level: 1): set block(above: heading_margin_top, below: heading_margin_bottom)
  show heading.where(level: 2): set block(above: heading_margin_top, below: heading_margin_bottom)

  // Cover
  import "pages/cover.typ": cover
  cover(
    transfermodule-number,
    matriculation-number,
    title,
    centurion,
  )

  // Table of Contents
  import "pages/table_of_contents.typ": toc
  set page(numbering: "I")
  counter(page).update(1)
  toc()

  pagebreak(weak: true)
  include "pages/list_of_figures.typ"

  pagebreak(weak: true)
  include "pages/list_of_tables.typ"

  before-content

  {
    // Reset page numbering and set it to numbers
    set page(
      numbering: "1",
    )
    counter(page).update(1)

    // Display heading numbering
    set heading(numbering: "1.1")

    // Prevgent paragraph indents
    set par(justify: true)

    body

    after-content
  }
}

#let print-appendix(appendix) = {
  heading(translations.appendix, numbering: none)
  set heading(numbering: "A.1 ")
  counter(heading).update(0)

  appendix
}
