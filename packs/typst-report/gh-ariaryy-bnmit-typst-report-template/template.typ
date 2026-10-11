// The shared layer: geometry derived from `config.layout.margin`, the running
// head and foot, the border, and the two page kinds every other file builds on.
//
// Nothing in this file is meant to be edited to change a margin or a name.
// Edit `config.typ` instead.

// ---------------------------------------------------------------------------
// Derived geometry
// ---------------------------------------------------------------------------

// One margin dict in, four sets of numbers out. `body` carries the running
// head and foot and so needs a taller vertical margin than the spec; `plate`
// is for pages that carry neither and instead want their text held inside the
// decorative border; `border` is the spec itself, which is where the rectangle
// is drawn.
#let layout-of(config) = {
  let m = config.layout.margin
  let band = config.style.header-band
  let inset = config.style.border-inset

  (
    border: m,
    body: (
      paper: config.layout.paper,
      margin: (
        left: m.left,
        right: m.right,
        top: m.top + band,
        bottom: m.bottom + band,
      ),
      // Typst measures these from the body edge outwards into the margin, so
      // leaving a tenth of the band unclaimed puts a visible gap between the
      // rules and the first and last lines of text.
      header-ascent: band * 0.9,
      footer-descent: band * 0.8,
    ),
    plate: (
      paper: config.layout.paper,
      margin: (
        left: m.left + inset,
        right: m.right + inset,
        top: m.top + inset,
        bottom: m.bottom + inset,
      ),
    ),
  )
}

// ---------------------------------------------------------------------------
// Page furniture
// ---------------------------------------------------------------------------

#let border-of(config) = if config.options.border {
  let m = config.layout.margin
  pad(
    left: m.left,
    right: m.right,
    top: m.top,
    bottom: m.bottom,
    rect(width: 100%, height: 100%, stroke: config.style.border-stroke),
  )
}

#let rules-of(config) = if config.options.header-rules {
  grid(
    rows: 2,
    gutter: 2pt,
    line(length: 100%, stroke: 0.5pt),
    line(length: 100%, stroke: 1pt),
  )
}

#let running-header(config) = {
  set text(size: config.style.text-size.running)
  grid(gutter: 6pt, rows: 2, align: left, config.title, rules-of(config))
}

// `page-numbering` selects the counter style, so the front matter can run in
// Roman numerals while the chapters and reference list run in Arabic.
#let running-footer(config, page-numbering: "1") = context {
  set text(size: config.style.text-size.running)
  grid(
    rules-of(config),
    gutter: 6pt,
    rows: 2,
    align: left,
    grid(
      columns: 3,
      block(width: 100%, "Dept. of " + config.department.abbreviation + ", BNMIT"),
      block(width: 100%, align(center, str(counter(page).display(page-numbering)))),
      block(width: 100%, align(right, config.year)),
    ),
  )
}

// A full-page card: bordered, no running head or foot, text held inside the
// border by `style.border-inset`. The cover, certificate, acknowledgement and
// chapter separators are all this page.
#let plate(config, body, alignment: center + horizon) = {
  let l = layout-of(config)
  set page(..l.plate, background: border-of(config), header: none, footer: none)
  set align(alignment)
  body
}

// ---------------------------------------------------------------------------
// Shared front-matter furniture
// ---------------------------------------------------------------------------

// Every front matter page title: the abstract, the contents, the two lists and
// the acknowledgement. `k` is the fit-page scale factor for the pages that use
// one; `drop` is extra space above the title, which only a bordered page asks
// for.
#let section-title(config, body, k: 1.0, drop: 0pt) = {
  v(drop * k)
  align(center, text(size: config.style.text-size.h1 * k, weight: "bold", upper(body)))
  v(24pt * k)
}

// The table of contents, list of figures and list of tables are the same
// object with different columns, so they are built by one function and read as
// one design. Columns are proportional rather than `auto` so all three lists
// line up with each other.
//
// The number and page columns are centred under their headings; the
// description column is left aligned and justified, so a caption that wraps
// fills the column instead of forming a ragged centred stack.
//
// The contents page needs its chapter numbers centred as one block while still
// showing a section indented under its chapter, which a centred cell cannot
// do on its own. `indented-number` below is the fix: a fixed width box, itself
// centred, holding a left aligned number. The column of numbers reads as one
// centred block and the indent survives inside it.
#let entry-table(headers, rows, columns: (2.4fr, 6.4fr, 2.2fr)) = {
  let body-align = (center + horizon, left + horizon, center + horizon)
  set par(justify: true)
  table(
    columns: columns,
    stroke: none,
    align: body-align,
    inset: (x: 4pt, y: 5pt),
    table.header(
      // Caps for the column headings, title case for the entries underneath,
      // so the heading row reads as a label rather than as another entry.
      ..headers.map(h => pad(bottom: 8pt, text(weight: "bold", upper(h)))),
    ),
    ..rows.flatten(),
  )
}

// See `entry-table`. Nudges a chapter number left and a section number right
// by half a step each, so the two read as a hierarchy while the column of
// numbers stays centred as one block. Padding rather than a fixed width box,
// so it stays centred whatever width the numbers reach.
#let indented-number(number, level: 1, step: 1.4em) = if level == 1 {
  pad(right: step, number)
} else {
  pad(left: step, number)
}

#let institute-plate(config, k: 1.0) = {
  text(
    config.institute.name + "
",
    font: config.style.fonts.institute,
    config.style.institute-color,
    size: 24pt * k,
    stroke: 0.02857em + config.style.institute-color,
  )

  set text(size: config.style.text-size.fine-print * k, font: config.style.fonts.fine-print)

  config.institute.tagline
  linebreak()
  config.institute.accreditation
  linebreak()
  [Website: #config.institute.url]
  linebreak()
}

// Shrinks a page's type and images until its content fits on one page.
//
// The cover and the certificate carry a title, an author list and a signature
// row that all vary in length between reports. Without this, a three line
// title or a fourth team member silently pushes the last two lines onto a
// second page, which is the kind of thing nobody notices until it is printed.
// `body` is a function of a scale factor; everything inside it that has a
// size must be multiplied by that factor.
#let fit-page(body, min-scale: 0.7, step: 0.02) = layout(size => {
  let k = 1.0
  while k > min-scale and measure(body(k), width: size.width).height > size.height {
    k -= step
  }
  body(k)
})

// `table.header` marks a row as repeating, but it does not align it: a table's
// `align` argument applies to every row, header included, and beats anything a
// show rule sets on the cells. So a header centred over a left aligned column
// has to be centred inside its own cell, which is what this rewrite does. It
// is applied once over the whole document, so a chapter writes a plain
// `table.header(...)` and gets a centred header row without passing anything.
#let center-table-headers(doc) = {
  let centered(cell) = if cell.func() == table.cell {
    let fields = cell.fields()
    let body = fields.remove("body")
    table.cell(..fields, align: center, body)
  } else {
    align(center, cell)
  }

  let is-centered(cell) = if cell.func() == table.cell {
    cell.fields().at("align", default: none) == center
  } else {
    cell.func() == align
  }

  show table: it => {
    let cells = it.children
    let i = cells.position(c => c.func() == table.header)
    // Without the `is-centered` guard the rebuilt table re-enters this rule
    // and wraps its header again, forever.
    if i == none or cells.at(i).children.all(is-centered) { return it }

    let header = cells.at(i).fields()
    let header-cells = header.remove("children")
    let fields = it.fields()
    let _ = fields.remove("children")

    table(
      ..fields,
      ..cells.slice(0, i),
      table.header(..header, ..header-cells.map(centered)),
      ..cells.slice(i + 1),
    )
  }

  doc
}
