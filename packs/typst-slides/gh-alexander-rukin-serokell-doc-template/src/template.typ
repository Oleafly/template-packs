// =============================================================================
// Serokell document template - all branding lives here.
// Authors should not need to edit this file; they only write Markdown.
// =============================================================================

// ---------------------------------------------------------------- design tokens

#let accent = rgb("#D92B04")
#let ink = rgb("#1A1A1A") // body text
#let ink-soft = rgb("#5A5F66") // captions, page numbers, table rules
#let ink-faint = rgb("#72777E") // table header repeated on a later page
#let hairline = rgb("#DDE1E5") // table / block borders
#let code-bg = rgb("#F5F6F7")

// Google Sans Flex ships as per-optical-size families. Picking the family
// chooses the optical size; `weight` chooses the cut.
// Each face is a fallback list: Golos Text covers the Cyrillic that Google Sans
// Flex does not carry, and the emoji font at the end resolves an emoji typed
// anywhere in the Markdown to a glyph instead of an empty box. Without the Golos
// entry Typst falls back to its own default serif, so a Russian heading would
// come out in a face that belongs to no template at all.
// Noto Color Emoji (COLRv1) is bundled: it is vector, so it stays sharp in
// print, and it is half the size of the bitmap build. Apple Color Emoji cannot
// be bundled, its licence does not allow redistribution.
#let font-emoji = "Noto Color Emoji"
#let font-display = ("Google Sans Flex 120pt", "Golos Text", font-emoji) // cover title only
#let font-heading = ("Google Sans Flex 36pt", "Golos Text", font-emoji) // h1-h3
#let font-body = ("Google Sans Flex 24pt", "Golos Text", font-emoji) // body copy
#let font-mono = ("JetBrains Mono", "Golos Text", font-emoji) // code

#let size-body = 10.5pt
#let leading-body = 0.72em

// Cover title. Anything from "medium" to "black" is available in
// assets/fonts - dial the weight here rather than in the cover function.
#let title-size = 40pt
#let title-weight = "semibold"

// How wide a Markdown table is drawn. Two modes:
//   "auto" - columns are sized to their contents, so a narrow table occupies
//            only part of the text width and sits to the left.
//   "full" - columns share the text width equally, so every table spans the
//            full measure regardless of how little is in it.
// A document can override this from its frontmatter with `tables: full`.
#let table-width = "auto"

#let page-margin = (top: 24mm, bottom: 55mm, x: 20mm)
#let page-width = 210mm // A4
#let page-height = 297mm // A4

// ---------------------------------------------------------------- artwork
//
// The mountains are drawn at ONE size everywhere: full page width, peak at
// `art-peak-height`. Content pages do not get a shrunken copy - they get the
// same composition, dissolved into the page from the top.
//
// How the dissolve works, because it is easy to get backwards: a white
// gradient is painted ON TOP of the photo, opaque white at the top fading to
// fully clear at the bottom. The photo itself is never made transparent. That
// keeps the mountain solid where it meets the trim edge (nothing shows through
// it) and removes the hard horizontal cut at its top edge, so the artwork
// fades out like cloud rather than ending in a line.
//
// Making the image itself semi-transparent instead would let the page show
// through the rock, which reads as a mistake.

#let art-peak-height = 92mm

// Where the white veil stops being fully opaque. Below this fraction of the
// artwork the mountain starts becoming visible; above it the artwork is gone.
// Raise it to push the mountain further down the page.
//
// Kept clear of body text on purpose: content's own bottom margin sits at
// depth (1 - page-margin.bottom / art-peak-height) = 40.2% into this box, so
// anything at or above that line is still content, not footer. A value at or
// below that depth would let the mountain show through before text reaches
// its own margin, putting visible rock behind the last line on a page. 45%
// keeps a few points of margin past 40.2% so a descender or a table row's
// bottom inset doesn't tip over the line. Re-derive both numbers together if
// page-margin.bottom or art-peak-height changes.
#let art-fade-start = 45%

// Vertical centre of the Serokell mark baked into the peak image, as a fraction
// of that image's height measured from its top. Taken from the source PNG: the
// glyph occupies rows 773..835 of 940. The page number is aligned to the same
// line, so the two read as one row across the foot of the page. Re-measure this
// if footer-mountains-right.png is ever replaced.
#let art-logo-centre = 0.8553
#let footer-baseline = art-peak-height * (1.0 - art-logo-centre)

#let mountains(peak-height: art-peak-height) = {
  box(width: page-width, height: peak-height, {
    // Left: pale range across the full page width, sitting on the baseline.
    place(bottom + left, image("/assets/footer-mountains-left.png", width: page-width))
    // Right: high-contrast peak, carrying the Serokell mark, drawn on top.
    place(bottom + right, image("/assets/footer-mountains-right.png", height: peak-height))
  })
}

// Content-page backdrop: the same mountains, veiled from the top.
// Used as `page(background:)` so it sits behind the body text.
#let backdrop(has-art: true) = {
  if not has-art { return none }

  place(bottom + left, box(width: page-width, height: art-peak-height, {
    mountains()
    // 90deg runs the gradient top -> bottom.
    place(bottom + left, rect(
      width: page-width,
      height: art-peak-height,
      fill: gradient.linear(
        (white, 0%),
        (white, art-fade-start),
        (white.transparentize(100%), 100%),
        angle: 90deg,
      ),
    ))
  }))
}

// ---------------------------------------------------------------- footer

// Page number only, inside the footer, left-hand side. The artwork is no longer
// footer content - it is the page background - so the footer stays a thin strip
// and the number sits in it rather than floating above a band.
#let make-footer(has-art: true, cover-page: true) = context {
  let n = counter(page).get().first()
  // Page 1 is the cover and carries no footer chrome - but only when there is
  // a cover. Without one, page 1 is already content and needs its number.
  if cover-page and n <= 1 { return }

  // The number is centred on `footer-baseline`, the same line the Serokell mark
  // sits on inside the artwork. A fixed-height box centred with `horizon` keeps
  // that true regardless of the number's own font size.
  let slug = 6mm

  box(width: 100%, height: page-margin.bottom, {
    place(
      bottom + left,
      dy: -(footer-baseline - slug / 2),
      box(height: slug, align(horizon, text(
        font: font-body,
        size: 8.5pt,
        weight: "medium",
        fill: ink-soft,
        str(n),
      ))),
    )
    if not has-art {
      // Keeps the layout honest when assets/ is not populated.
      place(top + left, line(length: 100%, stroke: 0.6pt + hairline))
    }
  })
}

// ---------------------------------------------------------------- cover page

#let cover(title: none, subtitle: none, author: none, date: none, has-art: true) = {
  // background: none - the cover paints its own artwork at full strength, and
  // must not also inherit the veiled content-page backdrop.
  page(
    margin: (top: 34mm, bottom: 0mm, x: 20mm),
    footer: none,
    header: none,
    background: none,
    {
    // Accent rule as the brand anchor at the top of the cover.
    box(width: 18mm, height: 3.5pt, fill: accent)
    v(10mm)

    text(
      font: font-display,
      size: title-size,
      weight: title-weight,
      fill: ink,
      hyphenate: false,
      // justify: false, or the body text's justification stretches a short
      // first line of the title across the full measure.
    )[#par(leading: 0.28em, justify: false, title)]

    if subtitle != none {
      v(5mm)
      text(font: font-heading, size: 15pt, weight: "regular", fill: ink-soft)[
        #par(leading: 0.5em, justify: false, subtitle)
      ]
    }

    v(8mm)

    // Author / date, set as a quiet two-line block.
    text(font: font-body, size: 10pt, fill: ink, {
      if author != none {
        text(weight: "semibold", author)
        linebreak()
      }
      if date != none {
        text(fill: ink-soft, date)
      }
    })

    // Push the artwork to the bottom edge of the cover, at full strength.
    place(bottom + left, dx: -page-margin.x, {
      if has-art {
        mountains()
      } else {
        box(width: page-width, height: art-peak-height, place(
          bottom + left,
          line(length: 100%, stroke: 0.6pt + hairline),
        ))
      }
    })
    },
  )
}

// ---------------------------------------------------------------- md tables

// Shared so both width modes are styled identically.
#let table-stroke = (x, y) => (
  top: if y == 0 { 0pt } else { 0.5pt + hairline },
  bottom: 0pt,
  left: 0pt,
  right: 0pt,
)

// Gutter between columns, but the outer edges stay flush with the margins.
#let table-inset = (x, y) => (
  left: if x == 0 { 0pt } else { 6mm },
  right: 0pt,
  top: 7pt,
  bottom: 7pt,
)

// Rebuild a Markdown table as a grid, in both width modes.
//
// A grid is required, not a table, because:
//   * `set table(columns: ..)` cannot win: cmarker passes `columns`
//     explicitly when it builds the element;
//   * a `show table` rule returning a new `table` matches its own output and
//     recurses until Typst gives up;
//   * the heavy rule under the header is an explicit line carried inside
//     `table.header`'s own children (below), and only a `show` rule that
//     rebuilds children this way can produce it without recursing.
// A grid takes the same stroke and inset API, so the result differs from a
// table only in column widths.
//
// The heavy rule under the header is an explicit `grid.hline` carried inside
// the header's own children, so it travels with the header wherever it
// repeats and competes with no cell's stroke.
//
// Header labels are greyed where the header repeats on a later page, so the
// repeat reads as a reminder of the columns rather than another row or a
// new table. A header cell tells a repeat apart by its own page: Typst lays
// each repetition out at its own location, so `here().page()` gives the
// page it is drawn on. That is compared against a marker in the first body
// row, which always sits on the page of the header's first appearance - a
// marker placed before the grid would not, since orphan prevention can move
// the header and first row together to the next page. `table-id` matches
// each table to its own marker.
//
// Cell content is styled explicitly here rather than through `show table:
// set text(..)` / `set par(..)` in the caller: those rules apply only while
// the element stays a `table`, and this function hands back a `grid`.
//
// Cells are marked `breakable: false` so a row that does not fit in the
// remaining space on a page moves whole to the next page instead of
// splitting its content mid-sentence. Only rows whose cells are all under
// 20% of the page's usable height: a taller row stays breakable, so it
// cannot overflow a page outright. The decision is per row, not per cell,
// so a single tall cell pins its whole row. Rows are taken as runs of `n`
// cells, which holds because Markdown tables have no spans.
//
// The `context` measurement needs wraps the whole grid, not each cell: a
// `grid.cell` returned from its own `context` block reaches the grid as an
// opaque element, so `breakable`, `colspan`, and `rowspan` on it would be
// silently lost.
#let table-id = counter("table-id")

#let rebuild-table(it, tables) = context {
  let n = if type(it.columns) == int { it.columns } else { it.columns.len() }
  let col-width = (page-width - 2 * page-margin.x) / n
  let page-content-height = page-height - page-margin.top - page-margin.bottom

  let id = table-id.get().first()
  let grey-if-repeated(body) = context {
    let marker = query(<table-first-row>).filter(m => m.value == id)
    let repeated = marker.len() > 0 and here().page() > marker.first().location().page()
    if repeated { text(fill: ink-faint, body) } else { body }
  }

  // `mark-first: true` tags the first cell for `grey-if-repeated` to find.
  let convert(cells, header: false, mark-first: false) = {
    let out = ()
    for (i, row) in cells.chunks(n).enumerate() {
      let styled = row.enumerate().map(((j, c)) => text(
        font: if header { font-heading } else { font-body },
        weight: if header { "semibold" } else { "regular" },
        size: 9.5pt,
        if header { grey-if-repeated(c.body) }
        else if mark-first and i == 0 and j == 0 { [#metadata(id)<table-first-row>] + c.body }
        else { c.body },
      ))
      let breakable = styled.any(s => {
        measure(s, width: col-width).height > page-content-height * 20%
      })
      for (c, s) in row.zip(styled) {
        let extra = (breakable: breakable)
        let cs = c.at("colspan", default: 1)
        if cs != 1 { extra.insert("colspan", cs) }
        let rs = c.at("rowspan", default: 1)
        if rs != 1 { extra.insert("rowspan", rs) }
        out.push(grid.cell(..extra, s))
      }
    }
    out
  }

  let kids = ()
  let body = ()
  for c in it.children {
    if c.func() == table.header {
      kids.push(grid.header(
        ..convert(c.children, header: true),
        grid.hline(stroke: 1pt + ink),
      ))
    } else if c.func() == table.footer {
      kids += convert(body, mark-first: true)
      body = ()
      kids.push(grid.footer(..convert(c.children)))
    } else {
      body.push(c)
    }
  }
  kids += convert(body, mark-first: true)

  // Column alignment from the Markdown colons lives on the table element's
  // `align` field as an array like (left, center, right), NOT on the cells -
  // the cells carry nothing but their body. Forgetting to carry this over
  // silently left-aligns every column.
  set par(justify: false)
  grid(
    columns: if tables == "full" { (1fr,) * n } else { it.columns },
    align: it.at("align", default: auto),
    stroke: table-stroke,
    inset: table-inset,
    ..kids,
  )
}

// ---------------------------------------------------------------- main show rule

// `cover-page: false` drops the title page entirely. A Markdown file with no
// frontmatter has no title, author, or date to put on one, so it is built as
// bare content starting on page 1.
#let report(
  title: none,
  subtitle: none,
  author: none,
  date: none,
  has-art: true,
  tables: table-width,
  cover-page: true,
  body,
) = {
  set document(
    title: if title == none { "" } else { title },
    author: if author == none { () } else { author },
  )

  set page(
    paper: "a4",
    margin: page-margin,
    footer: make-footer(has-art: has-art, cover-page: cover-page),
    // 0mm so the footer box starts exactly at the top of the bottom margin.
    footer-descent: 0mm,
    background: backdrop(has-art: has-art),
  )

  set text(font: font-body, size: size-body, fill: ink, lang: "en")
  // Ragged right, not justified. Inline code is close to unbreakable, so when a
  // pill does not fit the rest of a line it moves down whole and justification
  // stretches the line it left behind. Every document type here carries inline
  // code - proposals, audit reports, profiles with a stack line - so this is the
  // normal case, not an edge one. Ragged right has no failure mode; justified
  // text with rivers does.
  set par(justify: false, leading: leading-body, spacing: 1.15em)

  // --- headings -------------------------------------------------------------
  show heading: set text(font: font-heading, fill: ink, hyphenate: false)

  // Each heading opens with a weak break above it - 20mm/15mm/9mm for
  // H1/H2/H3 - and closes with a smaller fixed gap below it - 7mm/5mm/3.5mm -
  // weak so it collapses at the top of a page instead of stacking with the
  // page margin. The above-gap is skipped when this heading directly follows
  // another heading, so two headings in a row don't get a doubled gap.
  let after-heading = state("after-heading", false)
  let reset-after-heading = it => {
    after-heading.update(false)
    it
  }

  show heading.where(level: 1): it => {
    context if not after-heading.get() { v(20mm, weak: true) }
    after-heading.update(true)
    block(text(size: 20pt, weight: "bold", it.body))
    v(7mm, weak: true)
  }

  show heading.where(level: 2): it => {
    context if not after-heading.get() { v(15mm, weak: true) }
    after-heading.update(true)
    block(text(size: 14pt, weight: "semibold", it.body))
    v(5mm, weak: true)
  }

  show heading.where(level: 3): it => {
    context if not after-heading.get() { v(9mm, weak: true) }
    after-heading.update(true)
    block(text(size: 11.5pt, weight: "semibold", fill: ink-soft, it.body))
    v(3.5mm, weak: true)
  }

  // --- paragraphs ------------------------------------------------------------
  show par: reset-after-heading

  // --- links ----------------------------------------------------------------
  show link: it => text(fill: accent, it)

  // --- code -----------------------------------------------------------------
  show raw: set text(font: font-mono, size: 9pt)
  // Inline code: subtle tint, no border.
  show raw.where(block: false): it => box(
    fill: code-bg,
    inset: (x: 3pt, y: 0pt),
    outset: (y: 3pt),
    radius: 2pt,
    it,
  )
  // Block code: tinted panel with an accent spine on the left.
  // NOTE: the body must be a content block with a `set par`, not a `par(..)`
  // call. Wrapping raw in an explicit `par` makes Typst treat the code as
  // block-level content inside a paragraph and silently drop it.
  show raw.where(block: true): it => {
    after-heading.update(false)
    block(
      width: 100%,
      fill: code-bg,
      stroke: (left: 2pt + accent),
      radius: (right: 3pt),
      inset: (x: 10pt, y: 9pt),
      {
        set par(justify: false, leading: 0.6em)
        it
      },
    )
  }

  // --- tables ---------------------------------------------------------------
  // Clean and rule-light: a heavy line under the header (its labels greyed where
  // it repeats on a later page), hairlines between rows.
  // Every table is rebuilt as a grid, in both width modes - see `rebuild-table`
  // for why, and for why cell styling lives there rather than in a `show
  // table: set ..` rule here.
  show table: it => {
    after-heading.update(false)
    table-id.step()
    rebuild-table(it, tables)
  }

  // --- quotes ---------------------------------------------------------------
  set quote(block: true)
  show quote: it => {
    after-heading.update(false)
    block(
      width: 100%,
      inset: (left: 9mm, right: 4mm, y: 1mm),
      stroke: (left: 2.5pt + accent),
      text(size: 10.5pt, fill: ink-soft, style: "italic", it.body),
    )
  }

  // --- lists ----------------------------------------------------------------
  set list(marker: text(fill: accent, weight: "bold")[•], indent: 3mm, spacing: 0.9em)
  set enum(indent: 3mm, spacing: 0.9em, numbering: n => text(
    fill: accent,
    weight: "semibold",
    [#n.],
  ))
  show list: reset-after-heading
  show enum: reset-after-heading

  // --- figures --------------------------------------------------------------
  show figure.caption: set text(size: 8.5pt, fill: ink-soft)
  // A captioned Markdown image comes out as a `figure`; resetting here, not on
  // `image` directly, is what keeps this from also firing on the cover and
  // footer artwork, which call `image` directly outside any figure or
  // paragraph and must stay untouched by anything declared in this function -
  // see the footer NOTE below.
  show figure: reset-after-heading
  // NOTE: deliberately no `set image(width: 100%)` here. A global image set
  // rule also hits the cover and footer artwork and, combined with their
  // explicit `height`, stretches them out of aspect. Body images are sized in
  // main.typ, scoped to the rendered Markdown only.

  // --- rules ----------------------------------------------------------------
  // Deliberately not wired into `after-heading`, unlike the block types above:
  // the cover and footer draw their own decorative `line`s through this same
  // selector, and their position relative to body content in the document's
  // flow is not something to depend on. A leftover manual `---` still gets a
  // normal accent-hairline; it just does not double as an after-heading reset.
  show line: set line(stroke: 0.6pt + hairline)

  if cover-page {
    cover(
      title: title,
      subtitle: subtitle,
      author: author,
      date: date,
      has-art: has-art,
    )
    // Content starts on page 2; the cover is page 1 and carries no footer.
    counter(page).update(2)
  }

  body
}

// ---------------------------------------------------------------- frontmatter

// Minimal YAML-ish frontmatter reader so authors can put title/author/date at
// the top of their .md and never touch Typst. Supports `key: value` lines and
// optional surrounding quotes.
#let split-frontmatter(src) = {
  let m = src.match(regex("(?s)^---\r?\n(.*?)\r?\n---\r?\n?"))
  if m == none { return ((:), src) }

  let meta = (:)
  for line in m.captures.first().split("\n") {
    let line = line.trim()
    if line == "" or line.starts-with("#") { continue }
    let parts = line.split(":")
    if parts.len() < 2 { continue }
    let key = parts.first().trim()
    let value = parts.slice(1).join(":").trim()
    // strip matching surrounding quotes
    if value.len() >= 2 and (
      (value.starts-with("\"") and value.ends-with("\""))
        or (value.starts-with("'") and value.ends-with("'"))
    ) {
      value = value.slice(1, -1)
    }
    meta.insert(key, value)
  }
  (meta, src.slice(m.end))
}
