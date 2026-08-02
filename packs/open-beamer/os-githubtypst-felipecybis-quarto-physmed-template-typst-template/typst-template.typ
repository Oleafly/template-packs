#let poster(
  // The poster's title.
  title: "Paper Title",

  // A string of author names.
  authors: "Author Names (separated by commas)",

  // Department name.
  departments: "Department Name",

  // Poster banner.
  banner: "Banner/logos Path",

  // Footer text.
  // For instance, Name of Conference, Date, Location.
  // or Course Name, Date, Instructor.
  footer_text: "Footer Text",

  // Any URL, like a link to the conference website.
  footer_url: "Footer URL",

  // Email IDs of the authors.
  footer_email_ids: "Email IDs (separated by commas)",

  // Color of the footer.
  footer_color: "Hex Color Code",

  // DEFAULTS
  // ========
  // For 3-column posters, these are generally good defaults.
  // Tested on 36in x 24in, 48in x 36in, and 36in x 48in posters.
  // For 2-column posters, you may need to tweak these values.
  // See ./examples/example_2_column_18_24.typ for an example.

  // Defaults to A0
  paper: "a0",

  // Defaults to landscape
  flipped: true,

  body_font_size: "28",

  // Any keywords or index terms that you want to highlight at the beginning.
  keywords: (),

  // Number of columns in the poster.
  num_columns: "3",

  // Column size used as spacing to the left of the title (in in).
  left_title_column_size: "0",

  // Column size used as spacing to the right of the title (in in).
  right_title_column_size: "0",

  // Title and authors' column size (in in).
  title_column_size: "20",

  // Title and authors' row size (in in).
  title_row_size: "4.1",

  // Poster title's font size (in pt).
  title_font_size: "48",

  // Authors' font size (in pt).
  authors_font_size: "36",

  // Authors' font size (in pt).
  department_font_size: "36",

  // Footer's URL and email font size (in pt).
  footer_url_font_size: "30",

  // Footer's text font size (in pt).
  footer_text_font_size: "40",

  margin_top: "0",
  margin_left: "1",
  margin_right: "1",
  margin_bottom: "2",

  space_after_header: "0",

  // The poster's content.
  body
) = {
  // Set the body font.
  body_font_size = int(body_font_size) * 1pt
  set text(font: "STIX Two Text", size: body_font_size)
  title_font_size = int(title_font_size) * 1pt
  authors_font_size = int(authors_font_size) * 1pt
  num_columns = int(num_columns)
  left_title_column_size = float(left_title_column_size) * 1in
  right_title_column_size = float(right_title_column_size) * 1in
  title_column_size = float(title_column_size) * 1in
  title_row_size = float(title_row_size) * 1in
  footer_url_font_size = int(footer_url_font_size) * 1pt
  footer_text_font_size = int(footer_text_font_size) * 1pt
  department_font_size = int(department_font_size) * 1pt
  margin_top = float(margin_top) * 1in
  margin_left = float(margin_left) * 1in
  margin_right = float(margin_right) * 1in
  margin_bottom = float(margin_bottom) * 1in
  space_after_header = float(space_after_header) * 1pt

  let to-string(content) = {
    if content.has("text") {
      content.text
    } else if content.has("children") {
      content.children.map(to-string).join("")
    } else if content.has("body") {
      to-string(content.body)
    } else if content == [ ] {
      " "
    }
  }

  flipped = flipped == "true"
  // Configure the page.
  // This poster defaults to 36in x 24in.
  set page(
    paper: paper,
    flipped: flipped,
    margin: 
      (top: margin_top, left: margin_left, right: margin_right, bottom: margin_bottom),
    background: align(center + top, image(banner, width: 100%)),
    footer: [
      #set align(center)
      #set text(footer_url_font_size, font: "Courier")
      #block(
        fill: rgb(footer_color),
        width: 100%,
        inset: 20pt,
        radius: 10pt,
        [
          #link(to-string(text(footer_url)))
          #h(1fr) 
          #text(size: footer_text_font_size, smallcaps(footer_text)) 
          #h(1fr) 
          #link("mailto:"+to-string(text( footer_email_ids)))[#text(footer_email_ids)]
        ]
      )
    ]
  )

  // Configure equation numbering and spacing.
  set math.equation(numbering: "(1)")
  show math.equation: set block(spacing: 0.65em)

  // Configure lists.
  set enum(indent: 10pt, body-indent: 9pt)
  set list(indent: 10pt, body-indent: 9pt)

  // Configure headings.
  set heading(numbering: "I.A.1.")
  show heading: it => locate(loc => {
    // Find out the final number of the heading counter.
    let levels = counter(heading).at(loc)
    let deepest = if levels != () {
      levels.last()
    } else {
      1
    }

    set text(24pt, weight: 400)
    if it.level == 1 [
      // First-level headings are centered smallcaps.
      #set align(center)
      #set text({ 32pt })
      #show: smallcaps
      #v(50pt, weak: true)
      #if it.numbering != none {
        numbering("I.", deepest)
        h(7pt, weak: true)
      }
      #it.body
      #v(35.75pt, weak: true)
      #line(length: 100%)
    ] else if it.level == 2 [
      // Second-level headings are run-ins.
      #set text(style: "italic")
      #v(32pt, weak: true)
      #if it.numbering != none {
        numbering("i.", deepest)
        h(7pt, weak: true)
      }
      #it.body
      #v(10pt, weak: true)
    ] else [
      // Third level headings are run-ins too, but different.
      #if it.level == 3 {
        numbering("1)", deepest)
        [ ]
      }
      _#(it.body):_
    ]
  })

  // Arranging the logo, title, authors, and department in the header.
  align(center + top,
    grid(
      align: center + horizon,
      rows: (title_row_size),
      columns: (left_title_column_size, title_column_size, right_title_column_size),
      // fill: gray,
      column-gutter: 0pt,
      row-gutter: 50pt,
      "",
      par(leading: 0.5em, text(title_font_size, white, title + "\n", weight: 700)) + v(title_font_size/2, weak: true) +
      text(authors_font_size, white, authors + "\n") + v(title_font_size/3, weak: true) + text(department_font_size, white, departments),
      "",
    )
  )

  v(space_after_header)

  // Start three column mode and configure paragraph properties.
  show: columns.with(num_columns, gutter: 64pt)
  set par(justify: true, first-line-indent: 0em)
  show par: set block(spacing: 0.65em)

  // Display the keywords.
  if keywords != () [
      #set text(24pt, weight: 400)
      #show "Keywords": smallcaps
      *Keywords* --- #keywords.join(", ")
  ]

  // Display the poster's contents.
  body
}
