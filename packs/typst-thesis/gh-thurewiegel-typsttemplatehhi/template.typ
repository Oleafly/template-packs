// NOTE:
// This file contains two things:
// 1) a local template implementation (used via lib.typ)
// 2) the reusable template inputs used by main.typ
// You can edit overview.typ for content values and template() for layout/style.

#let template(
  is-thesis: true,
  thesis: "Master Thesis",
  cover-logo-left: "../assets/logos/UPlogo.png",
  cover-logo-left-width: 90pt,
  cover-logo-right: "../assets/logos/HHIlogo.png",
  cover-logo-right-width: 170pt,
  cover-page-margin: (left: 22mm, right: 22mm, top: 18mm, bottom: 20mm),
  cover-main-text-size: 23pt,
  university-name: "University of Potsdam",
  cover-institute-line: "Thesis conducted at the Fraunhofer Heinrich Hertz Institute (Fraunhofer HHI), Berlin",
  title: "",
  keywords: none,
  abstract: none,
  author: "",
  faculty: "",
  study-course: "",
  supervisors: (),
  submission-date: none,
  before-content: none,
  after-content: none,
  body,
) = {
  let THESIS_HEADING_EXTRA_TOP_MARGIN = 70pt
  let PAGE_MARGIN_TOP = 35mm
  let PAGE_MARGIN = 27.5mm

  // Set the document's basic properties.
  set document(author: author, title: title, date: submission-date)
  set page(
    margin: (left: PAGE_MARGIN, right: PAGE_MARGIN, top: PAGE_MARGIN_TOP, bottom: 46mm),
    numbering: "i",
    number-align: right,
    binding: left,
    header-ascent: 24pt,
    header: context {
      // Before
      let selector_before = selector(heading.where(level: 1)).before(here())
      let level_before = int(counter(selector_before).display())
      let headings_before = query(selector_before)

      if headings_before.len() == 0 {
        return
      }

      // After
      let selector_after = selector(heading.where(level: 1)).after(here())
      let level_after = level_before + 1
      let headings_after = query(selector_after)

      if headings_after.len() == 0 {
        return
      }

      // Get headings
      let heading_before = headings_before.last()
      let heading_after = headings_after.first()

      // Decide on heading
      let heading = heading_before
      let level = level_before

      if heading_after.location().page() == here().page() {
        if (
          heading_after.location().position().y == (THESIS_HEADING_EXTRA_TOP_MARGIN + PAGE_MARGIN_TOP)
            or heading_after.location().position().y == PAGE_MARGIN_TOP
        ) {
          // Next header is first element of page
          return
        } else {
          heading = heading_after
          level = level_after
        }
      }

      set text(size: 11.5pt)
      grid(
        rows: 2,
        gutter: 5pt,
        if heading.numbering != none {
          emph(str(level) + " " + heading.body)
        } else {
          emph(heading.body)
        },
        line(length: 100%, stroke: 0.7pt),
      )
    },
  )
  set par(leading: 9pt)
  set text(font: "New Computer Modern", lang: "en", size: 10.85pt)
  set heading(
    numbering: "1.1",
  )


  // Configure headings
  let font_size = 10pt
  let top_margin = 0pt
  let bottom_margin = 0pt

  // Configure h1
  if is-thesis {
    font_size = 21pt
    top_margin = 25pt
    bottom_margin = 45pt
  } else {
    font_size = 18pt
    top_margin = 30pt
    bottom_margin = 25pt
  }

  show heading.where(level: 1): set block(above: top_margin, below: bottom_margin)
  show heading.where(level: 1): set text(size: font_size, weight: 600)
  show heading.where(level: 1): it => {
    if is-thesis {
      // New page if configured
      pagebreak(weak: true)
      v(THESIS_HEADING_EXTRA_TOP_MARGIN)
      it
    } else {
      it
    }
  }

  // Configure h2
  if is-thesis {
    font_size = 14pt
    top_margin = 30pt
    bottom_margin = 25pt
  } else {
    font_size = 13pt
    top_margin = 30pt
    bottom_margin = 25pt
  }

  show heading.where(level: 2): set block(above: top_margin, below: bottom_margin)
  show heading.where(level: 2): set text(size: font_size)

  // Configure h3
  if is-thesis {
    font_size = 11pt
    top_margin = 20pt
    bottom_margin = 15pt
  } else {
    font_size = 11pt
    top_margin = 20pt
    bottom_margin = 15pt
  }

  show heading.where(level: 3): set block(above: top_margin, below: bottom_margin)
  show heading.where(level: 3): set text(size: font_size)

  // Cover
  import "pages/cover.typ": cover_page
  cover_page(
    is-thesis: is-thesis,
    thesis: thesis,
    cover-logo-left: cover-logo-left,
    cover-logo-left-width: cover-logo-left-width,
    cover-logo-right: cover-logo-right,
    cover-logo-right-width: cover-logo-right-width,
    cover-page-margin: cover-page-margin,
    cover-main-text-size: cover-main-text-size,
    university-name: university-name,
    cover-institute-line: cover-institute-line,

    title: title,
    author: author,
    faculty: faculty,
    study-course: study-course,
    supervisors: supervisors,
    submission-date: submission-date,
  )

  // Abstract
  if abstract != none {
    import "pages/abstract.typ": abstract_page
    abstract_page(
      author: author,
      title: title,
      keywords: keywords,
      abstract: abstract,
    )
  }

  // Table of contents.
  include "pages/outline.typ"

  // List of Figures
  if is-thesis {
    include "pages/list_of_figures.typ"
  }

  // List of Tables
  if is-thesis {
    include "pages/list_of_tables.typ"
  }

  // Listings
  if is-thesis {
    include "pages/listings.typ"
  }

  // Include before-content pages
  before-content

  // Content
  {
    // Reset page numbering and set it to numbers
    set page(
      numbering: "1",
    )
    counter(page).update(1)

    set par(justify: true)

    body

    // Include after-content pages
    after-content
  }
}
