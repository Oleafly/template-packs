// =====================================================================
// Customizable settings. Every constant below is what the Graduate
// School cares about most: page margins, font sizes, spacing rhythm,
// and how each kind of heading and figure presents itself. Edit values
// in this block first; only descend into the rest of the file when a
// change cannot be expressed by tweaking a constant.
//
// Conventions:
//   - Geometry/spacing: inches (use `in` suffix).
//   - Font sizes: points (use `pt` suffix).
//   - Em-relative gaps that should scale with the surrounding font:
//     em (use `em` suffix).
// =====================================================================

// ---- Page and paragraph defaults ----
#let standard-portrait-margins = ( // Default page margins for the body and most front-matter pages.
  top: 1in,
  bottom: 1in,
  left: 1.25in,
  right: 1.25in,
)
#let text-block-width = 6in // Centered prose width reused by body-aligned blocks.
#let body-text-size = 12pt // Document-wide body font size.
#let body-first-line-indent = 0.25in // First-line indent for body paragraphs.
#let body-tracking-compensation = -0.05pt // Per-glyph tracking shrink applied to compensate for the absence of microtype font expansion in front matter and the copyright page; lets caption text wrap at the same word boundaries as the LaTeX source. Set to 0pt to disable.
#let double-spaced-leading = 0.2183in // Default line spacing for thesis body prose.
#let single-spaced-leading = 0.0867in // Tighter line spacing for lists, headings, and captions.

// Front-matter heading controls. These affect Abstract, Acknowledgments,
// Preface, Table of Contents, List of Figures, and similar level-1 headings
// that appear before Chapter 1.
#let front-heading-top-gap = 1in // Top offset for front-matter titles like Abstract and Acknowledgments. Combined with the 1" page top margin this gives the 2" top margin the Graduate School format guide requires for major heading pages.
#let outline-heading-top-gap = 1in // Top offset for ToC/LoF/LoT-style titles. Combined with the 1" page top margin this gives the 2" top margin the format guide requires for major heading pages.
#let front-heading-text-size = 14pt // Font size for front-matter page titles. Capped at 14pt because the format guide allows only 12- or 14-pt for major headings.
#let front-heading-gap-below = 0.272in // Blank space between a front-matter title and the content below it.
#let outline-heading-gap-below = 0.411in // Blank space between a ToC/LoF/LoT title and the first entry.

// Chapter opening controls. These shape the "Chapter 1 / Introduction"
// treatment at the start of each chapter or appendix.
#let chapter-heading-top-gap = 1in // Top offset for chapter-opening headings. Combined with the 1" page top margin this gives the 2" top margin the format guide requires for the first page of each chapter.
#let chapter-heading-text-size = 14pt // Font size for both the chapter number and the chapter title. Capped at 14pt because the format guide allows only 12- or 14-pt for major headings.
#let chapter-number-title-gap = 0.0518in // Vertical gap between the chapter number line and the title line.
#let chapter-heading-gap-below = 0.238in // Blank space between the chapter heading block and the first paragraph.

// Section and subsection controls. Increase the "above" values here if the
// chapter body needs more breathing room around headings.
#let section-heading-above = 0.4in // Space above a level-2 section heading.
#let section-heading-below = 0.358in // Space below a level-2 section heading.
#let section-heading-text-size = 12pt // Font size for level-2 section headings.
#let section-heading-prefix-gap = 0.0833in // Horizontal gap between a section number and its title text.
#let subsection-heading-above = 0.3167in // Space above a level-3 subsection heading.
#let subsection-heading-below = 0.358in // Space below a level-3 subsection heading.
#let subsection-heading-text-size = 12pt // Font size for level-3 subsection headings. The format guide allows only 12- or 14-pt for subheadings.
#let subsection-heading-prefix-gap = 0.0611in // Horizontal gap between a subsection number and its title text.

// Title-page controls. These are intentionally broken into small named gaps so
// the title page can be tuned without searching through the body template.
#let title-page-paragraph-leading = double-spaced-leading // Line spacing for the centered title-page text blocks.
#let title-page-top-gap = 1.450in // Top offset before the thesis title on the title page. (Preserves the prior absolute on-page position after the page top margin tightened to 1".)
#let title-page-title-size = 12pt // Font size for the thesis title on the title page.
#let title-page-after-title = 0.220in // Gap after the thesis title.
#let title-page-after-by = 0.018in // Gap after the word `by`.
#let title-page-after-author = 0.288in // Gap after the author name.
#let title-page-previous-degree-spacing = 0.0583in // Vertical spacing between stacked previous-degree lines.
#let title-page-after-previous-degrees = 0.128in // Gap after the previous-degrees block.
#let title-page-rule-length = 3.5433in // Length of the horizontal rule on the title page.
#let title-page-rule-stroke = 0.567pt // Stroke weight of the horizontal rule on the title page.
#let title-page-after-rule = 0.022in // Gap after the horizontal rule.
#let title-page-after-metadata = 0.15in // Gap after the degree/college/year metadata block. Intentionally larger than the LaTeX reference so the `Accepted by:` line is not crammed against the year.
#let title-page-after-accepted = 0.018in // Gap after the `Accepted by:` line.

// Built-in outline controls. Typst's outline engine is used for the table of
// contents and the list of tables.
#let toc-depth = 2 // Maximum heading depth included in the table of contents.
#let toc-indent-step = 0.25in // Extra indentation added for each deeper ToC level.
#let toc-level-one-entry-gap = 0.45in // Vertical gap before a top-level ToC entry.
#let toc-level-two-entry-gap = 0.2917in // Vertical gap before a second-level ToC entry.
#let toc-level-two-left-indent = 0.25in // Left indent applied to level-2 ToC entries.
#let toc-prefix-body-gap = 1em // Gap between a section number ("1.1") and its title in the ToC.
#let toc-entry-leading = 0.1667in // Line spacing inside wrapped ToC entries.
#let list-entry-gap = 0.4333in // Vertical gap between entries in simpler built-in lists like LoT.
#let caption-list-inset-left = 0in // Extra left inset for built-in caption lists; keep at zero unless pulling inward.
#let caption-list-inset-right = 0in // Extra right inset for built-in caption lists; keep at zero unless pulling inward.
#let outline-entry-text-size = 12pt // Font size for built-in outline entries.
#let outline-entry-leading = single-spaced-leading // Line spacing for built-in outline entries outside the ToC.
#let outline-leader-gap = 0.09in // Dot spacing in built-in outline leader fills (matches LaTeX dot rhythm).
#let toc-page-column-width = 0.4in // Width of the right-aligned page-number column in the ToC.

// Heading prefix gap shared by front-matter and figure-list level-1 headings.
#let outline-heading-prefix-gap = 0.1389in // Horizontal gap between a level-1 numbering prefix and the heading body.

// Copyright page positioning. The copyright block sits at the bottom of the
// page; this is the top offset that pushes it down.
#let copyright-top-gap = 7.327in // Top offset before the copyright block on the copyright page. (Keeps the block ~2" from the page bottom after the page top margin tightened to 1", per the format guide's "approximately 2 inches from the bottom" rule.)

// Controls for the list of figures.
#let figure-list-page-margins = standard-portrait-margins // Page margins used only while rendering the list of figures.
#let figure-list-heading-top-gap = outline-heading-top-gap // Top offset for the `List of Figures` title.
#let figure-list-heading-text-size = front-heading-text-size // Font size for the `List of Figures` title.
#let figure-list-heading-gap-below = outline-heading-gap-below // Gap between the LoF title and the first figure entry.
#let figure-list-entry-gap = 0.45in // Vertical gap between one full LoF entry block and the next.
#let figure-list-entry-text-size = 12pt // Font size for LoF labels, captions, leaders, and page numbers.
#let figure-list-entry-leading = single-spaced-leading // Line spacing inside a wrapped LoF caption.
#let figure-list-label-rail-width = 0.75in // Width reserved for the `Figure X.X` label rail.
#let figure-list-caption-left-gap = 0.15in // Blank space between the label rail and the start of the caption rail.
#let figure-list-leader-dot-gap = outline-leader-gap // Dot-to-dot spacing inside the LoF leader fill.
#let figure-list-page-column-width = 0.4in // Width reserved at right for the page number.
#let figure-list-leader-extension = 0.275in // Width the leader extends past the caption-justification right edge. Tuned so 2 dots fit cleanly when prefixed by a single dot-gap.

// Image figure layout. Spacing of the image, its caption, and the gap to
// the body text that follows it.
#let image-figure-gap = 1.5em // Gap between an image-figure body and its caption.
#let image-figure-caption-below-gap = 1.25em // Extra vertical space inserted after an image-figure caption to push the next body paragraph away from it (LaTeX `\@plus.2\p@` style).

// Caption controls. Image captions stay at the bottom and are fully justified.
// Table captions move to the top and are centered like the class examples.
#let figure-caption-text-size = 12pt // Font size for image captions under figures.
#let figure-caption-label-gap = 0.1667in // Horizontal gap between `Figure x.y` and the image caption text.
#let table-caption-text-size = 12pt // Font size for table captions above tables.
#let table-caption-label-gap = 0.1667in // Horizontal gap between `Table x.y` and the table caption text.
#let table-caption-gap-above = 0.2in // Space above the full table-caption block.
#let table-caption-gap-below = 0.1083in // Space between the table-caption block and the table body below it.

#let section-order = counter("uofsc-etd-section-order")
#let heading-depth = state("uofsc-etd-heading-depth", 0)
#let page-regime = state("uofsc-etd-page-regime", "hidden")
#let body-heading-kind = state("uofsc-etd-body-heading-kind", "chapter")
#let level-one-audit-override = state("uofsc-etd-level-one-audit-override", none)
#let smcp-font-state = state("uofsc-etd-smcp-font", ("Latin Modern Roman Caps", "Latin Modern Roman 12", "New Computer Modern", "Times New Roman", "Arial"))
#let document-meta = document

#let require(name, value) = {
  if value == none or value == [] or value == () or value == "" {
    panic("uofsc-etd requires `" + name + "`.")
  }
}

#let key-at(dict, key, default: none) = {
  if dict != none and key in dict { dict.at(key) } else { default }
}

#let list-value(lists, key, default) = {
  if lists == none { default } else { key-at(lists, key, default: default) }
}

#let plain-string(value) = {
  if type(value) == str { value } else { repr(value) }
}

#let graduate-role-config(document) = {
  if document == "thesis" {
    (advisor: [Director of Thesis], committee: [Reader])
  } else if document == "dissertation" {
    (advisor: [Major Professor], committee: [Committee Member])
  } else {
    panic("`document` must be either `\"thesis\"` or `\"dissertation\"`.")
  }
}

#let heading-numbering(..nums) = {
  let values = nums.pos()
  if values.len() == 1 {
    [Chapter #values.at(0)]
  } else if values.len() == 2 {
    numbering("1.1", ..values)
  } else {
    numbering("1.1.1", ..values)
  }
}

#let appendix-numbering(..nums) = {
  let values = nums.pos()
  if values.len() == 1 {
    [Appendix #numbering("A", values.at(0))]
  } else if values.len() == 2 {
    numbering("A.1", ..values)
  } else {
    numbering("A.1.1", ..values)
  }
}

#let body-figure-numbering(num) = {
  let values = counter(heading).get()
  let major = if values.len() == 0 { 0 } else { values.first() }
  if major == 0 {
    numbering("1", num)
  } else if body-heading-kind.get() == "appendix" {
    numbering("A.1", major, num)
  } else {
    numbering("1.1", major, num)
  }
}

// Equations follow the chapter/appendix number and restart whenever a new
// level-1 body heading begins.
#let body-equation-numbering(num) = {
  let values = counter(heading).get()
  let major = if values.len() == 0 { 0 } else { values.first() }
  if major == 0 {
    numbering("(1)", num)
  } else if body-heading-kind.get() == "appendix" {
    numbering("(A.1)", major, num)
  } else {
    numbering("(1.1)", major, num)
  }
}

#let page-regime-pattern(regime) = {
  if regime == "roman" {
    "i"
  } else if regime == "arabic" {
    "1"
  } else {
    none
  }
}

#let resolve-numbering(pattern, values) = {
  if pattern == none {
    none
  } else if type(pattern) == function {
    pattern(..values)
  } else {
    numbering(pattern, ..values)
  }
}

#let audit(section-id, regime, extra: (:)) = context metadata((
  kind: "uofsc-etd-audit",
  section-id: section-id,
  physical-page: here().page(),
  displayed-page: counter(page).get().first(),
  numbering-regime: regime,
  section-order: section-order.get().first(),
  ..extra,
))

#let sequenced-audit(prefix, regime) = context metadata((
  kind: "uofsc-etd-audit",
  section-id: prefix + str(section-order.get().first()),
  physical-page: here().page(),
  displayed-page: counter(page).get().first(),
  numbering-regime: regime,
  section-order: section-order.get().first(),
))

#let layout-marker(marker, extra: (:)) = context metadata((
  kind: "uofsc-etd-layout",
  marker: marker,
  physical-page: here().page(),
  position: here().position(),
  ..extra,
))

#let check-heading-depth(level) = heading-depth.update(previous => {
  if level > previous + 1 {
    panic("Heading levels may not skip directly from " + str(previous) + " to " + str(level) + ".")
  }
  level
})

// Front-matter level-1 headings are centered, unbolded small caps with a fixed
// top offset. Adjust the style constants above instead of editing this block
// inline whenever possible.
#let front-level-one-heading-with(
  it,
  top-gap: front-heading-top-gap,
  gap-below: front-heading-gap-below,
  text-size: front-heading-text-size,
) = {
  check-heading-depth(it.level)
  let prefix = resolve-numbering(it.numbering, counter(heading).get())
  pagebreak(weak: true)
  block(width: 100%)[
    #v(top-gap)
    #align(center)[
      #context {
        set text(font: smcp-font-state.get(), size: text-size, weight: "regular")
        if prefix == none {
          smallcaps(it.body)
        } else {
          smallcaps([#prefix #h(outline-heading-prefix-gap) #it.body])
        }
      }
    ]
    #v(gap-below)
  ]
}

#let front-level-one-heading(it) = front-level-one-heading-with(it)

#let front-outline-heading(it) = front-level-one-heading-with(
  it,
  top-gap: outline-heading-top-gap,
  gap-below: outline-heading-gap-below,
)

// Body level-1 headings render the chapter/appendix openings. The chapter
// counter and the title are separated so each can be tuned independently.
#let body-level-one-heading(it) = {
  check-heading-depth(it.level)
  section-order.step()
  let override = level-one-audit-override.get()
  if override != none {
    level-one-audit-override.update(none)
  }
  if it.numbering != none {
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)
    counter(math.equation).update(0)
  }
  let prefix = resolve-numbering(it.numbering, counter(heading).get())
  pagebreak(weak: true)
  block(width: 100%)[
    #v(chapter-heading-top-gap)
    #align(center)[
      #context {
        set text(font: smcp-font-state.get(), size: chapter-heading-text-size, weight: "regular")
        if prefix == none {
          smallcaps(it.body)
        } else {
          smallcaps(prefix)
          linebreak()
          v(chapter-number-title-gap)
          smallcaps(it.body)
        }
      }
    ]
    #v(chapter-heading-gap-below)
  ]
  if override != none {
    audit(override.id, override.regime)
  } else if it.numbering != none {
    if body-heading-kind.get() == "appendix" {
      sequenced-audit("appendix-", "arabic")
    } else {
      sequenced-audit("chapter-", "arabic")
    }
  }
}

// Level-2 headings are the primary section headings inside a chapter. They are
// intentionally not bolded. Increase the "above" spacing if sections feel too
// cramped after long paragraphs.
#let level-two-heading(it) = {
  check-heading-depth(it.level)
  let prefix = resolve-numbering(it.numbering, counter(heading).get())
  block(above: section-heading-above, below: section-heading-below, sticky: true)[
    #context {
      set text(size: section-heading-text-size, weight: "regular")
      set par(first-line-indent: 0pt, justify: false)
      if prefix == none {
        text(font: smcp-font-state.get(), smallcaps(it.body))
      } else {
        prefix
        h(section-heading-prefix-gap)
        text(font: smcp-font-state.get(), smallcaps(it.body))
      }
    }
  ]
}

// Level-3 headings follow the same visual language as sections, but with a
// slightly smaller size and a slightly tighter vertical footprint.
#let level-three-heading(it) = {
  check-heading-depth(it.level)
  let prefix = resolve-numbering(it.numbering, counter(heading).get())
  block(above: subsection-heading-above, below: subsection-heading-below, sticky: true)[
    #context {
      set text(size: subsection-heading-text-size, weight: "regular")
      set par(first-line-indent: 0pt, justify: false)
      if prefix == none {
        text(font: smcp-font-state.get(), smallcaps(it.body))
      } else {
        prefix
        h(subsection-heading-prefix-gap)
        text(font: smcp-font-state.get(), smallcaps(it.body))
      }
    }
  ]
}

#let normalize-person(kind, value, default-role: none, title-required: false) = {
  if value == none {
    none
  } else {
    require(kind, value)
    let name = key-at(value, "name")
    let title = key-at(value, "title")
    let role = key-at(value, "role", default: auto)
    require(kind + ".name", name)
    if title-required {
      require(kind + ".title", title)
    }
    (
      name: name,
      title: title,
      role: if role == auto and default-role != none { default-role } else { role },
      signature: key-at(value, "signature"),
    )
  }
}

#let normalize-committee(committee, default-role) = {
  if committee == none {
    ()
  } else {
    committee.enumerate().map(((index, entry)) =>
      normalize-person("committee[" + str(index + 1) + "]", entry, default-role: default-role)
    )
  }
}

#let document-lists(lists) = (
  figures: list-value(lists, "figures", auto),
  tables: list-value(lists, "tables", auto),
  code: list-value(lists, "code", auto),
  symbols: list-value(lists, "symbols", none),
  abbreviations: list-value(lists, "abbreviations", none),
)

#let front-section(id, title, body, outlined: true) = {
  section-order.step()
  heading(level: 1, outlined: outlined)[#title]
  audit(id, "roman")
  {
    set par(first-line-indent: body-first-line-indent, leading: double-spaced-leading, spacing: double-spaced-leading)
    set text(tracking: body-tracking-compensation)
    body
  }
}

#let render-symbol-list(entries) = table(
  columns: (auto, 1fr),
  stroke: none,
  inset: 0pt,
  column-gutter: 0.25in,
  row-gutter: 0.333in,
  ..entries.map(entry => (
    entry.symbol,
    entry.description,
  )).flatten(),
)

#let render-abbreviation-list(entries) = table(
  columns: (auto, 1fr),
  stroke: none,
  inset: 0pt,
  column-gutter: 0.25in,
  row-gutter: 0.333in,
  ..entries.map(entry => (
    entry.abbreviation,
    entry.definition,
  )).flatten(),
)

#let metadata-values(kind) = query(metadata).filter(item => {
  let value = item.value
  type(value) == dictionary and key-at(value, "kind", default: none) == kind
}).map(item => item.value)

#let figure-list-level-one-heading(it) = {
  check-heading-depth(it.level)
  let prefix = resolve-numbering(it.numbering, counter(heading).get())
  block(width: 100%)[
    #v(figure-list-heading-top-gap)
    #align(center)[
      #context {
        set text(font: smcp-font-state.get(), size: figure-list-heading-text-size, weight: "regular")
        if prefix == none {
          smallcaps(it.body)
        } else {
          smallcaps([#prefix #h(outline-heading-prefix-gap) #it.body])
        }
      }
    ]
    #v(figure-list-heading-gap-below)
  ]
}

// A figure-list entry. Caption justifies in a narrow column ending where
// LaTeX's caption ends (left of the leader-extension area). The leader
// fills the last line of the caption AND extends past the caption column
// into the leader-extension area, ending right before the page-number
// column. The page is placed at the right edge of the entry block.
#let render-figure-list-entry(entry, gap-before: 0pt) = block(
  above: gap-before,
  width: 100%,
  breakable: false,
)[
  #set text(size: figure-list-entry-text-size, weight: "regular")
  #let target = key-at(entry, "location")
  #let with-link(body) = if target != none { link(target, body) } else { body }
  #grid(
    columns: (figure-list-label-rail-width, 1fr),
    gutter: figure-list-caption-left-gap,
    with-link({
      set text(hyphenate: false)
      set par(first-line-indent: 0pt, justify: false)
      entry.label
    }),
    block(width: 100%, breakable: false)[
      #place(right + bottom, with-link(entry.page))
      #layout(size => {
        let cap-w = size.width - figure-list-leader-extension - figure-list-page-column-width
        set par(first-line-indent: 0pt, leading: figure-list-entry-leading, justify: true)
        with-link(box(width: cap-w, baseline: 0pt)[
          #entry.caption
          #h(1em, weak: true)
          #box(width: 1fr, repeat([.], gap: figure-list-leader-dot-gap, justify: true))
        ])
        h(figure-list-leader-dot-gap)
        with-link(box(width: figure-list-leader-extension - figure-list-leader-dot-gap, repeat([.], gap: figure-list-leader-dot-gap, justify: true)))
      })
    ],
  )
]

// The list of figures is rendered from metadata captured inside each placed
// image figure. That gives the figure list access to the actual displayed page
// number even when Typst floats the figure away from its source position.
// Generic caption-list renderer used for both List of Figures and List of
// Tables. Reads metadata captured by the figure helpers (image-figure,
// table-figure) and renders entries as a fixed-rail label column plus a
// justified caption with leader dots and a page number.
#let render-caption-list(id, title, metadata-kind, outlined: true) = context {
  let entries = metadata-values(metadata-kind).filter(entry =>
    key-at(entry, "outlined", default: true) and key-at(entry, "caption", default: none) != none
  )
  section-order.step()
  page(
    paper: "us-letter",
    margin: figure-list-page-margins,
    numbering: page-regime-pattern("roman"),
    number-align: center + bottom,
    footer-descent: 40%,
  )[
    #show heading.where(level: 1): figure-list-level-one-heading
    #heading(level: 1, outlined: outlined)[#title]
    #audit(id, "roman")
    #for (index, entry) in entries.enumerate() {
      render-figure-list-entry(
        entry,
        gap-before: if index == 0 { 0pt } else { figure-list-entry-gap },
      )
    }
  ]
}

#let render-figure-list(id, title, outlined: true) = render-caption-list(
  id, title, "uofsc-etd-figure-list-entry", outlined: outlined,
)

#let render-table-list(id, title, outlined: true) = render-caption-list(
  id, title, "uofsc-etd-table-list-entry", outlined: outlined,
)

#let render-code-list(id, title, outlined: true) = render-caption-list(
  id, title, "uofsc-etd-code-list-entry", outlined: outlined,
)

// Shared wrapper around Typst's built-in outline engine. This is the main knob
// for the table of contents and the list of tables.
// Keep the level-1 `heading(...)` call here. The visual title is customized by
// `front-level-one-heading`, but the semantic heading element is what keeps
// these front-matter page titles exposed correctly to PDF structure and
// accessibility tooling.
#let render-outline-list(
  id,
  title,
  target,
  depth: none,
  outlined: true,
  indent: auto,
  entry-gap: list-entry-gap,
  inset-left: 0pt,
  inset-right: 0pt,
  mode: "list",
) = context {
  section-order.step()
  heading(level: 1, outlined: outlined)[#title]
  audit(id, "roman")
  {
    pad(left: inset-left, right: inset-right)[
      #set outline(title: none, target: target, depth: depth, indent: indent)
      #set outline.entry(fill: repeat([.], gap: outline-leader-gap))
      #show outline.entry: it => context link(
        it.element.location(),
        block(
          above: if mode == "toc" {
            if it.level == 1 { toc-level-one-entry-gap } else { toc-level-two-entry-gap }
          } else {
            entry-gap
          },
        )[
          #set text(size: outline-entry-text-size, weight: "regular")
          #set par(
            first-line-indent: 0pt,
            justify: false,
            leading: if mode == "toc" { toc-entry-leading } else { outline-entry-leading },
          )
          #if mode == "toc" and it.level == 1 {
            block(width: 100%, breakable: false)[
              #place(right + bottom, it.page())
              #pad(right: toc-page-column-width)[
                #if it.prefix() != none {
                  text(font: smcp-font-state.get(), smallcaps(it.prefix()))
                  h(toc-prefix-body-gap)
                }
                #text(font: smcp-font-state.get(), smallcaps(it.body()))
                #h(1em, weak: true)
                #box(width: 1fr, it.fill)
              ]
            ]
          } else if mode == "toc" and it.level == 2 {
            block(width: 100%, breakable: false, inset: (left: toc-level-two-left-indent))[
              #place(right + bottom, it.page())
              #pad(right: toc-page-column-width)[
                #it.prefix()
                #h(toc-prefix-body-gap)
                #it.body()
                #h(1em, weak: true)
                #box(width: 1fr, it.fill)
              ]
            ]
          } else {
            it.indented(it.prefix(), it.inner())
          }
        ],
      )
      #outline(title: none, target: target, depth: depth)
    ]
  }
}

#let bibliography-section(config) = {
  require("bibliography.file", key-at(config, "file"))
  require("bibliography.style", key-at(config, "style"))
  let title = key-at(config, "title", default: [Bibliography])
  set heading(numbering: none)
  heading(level: 1)[#title]
  audit("bibliography", "arabic")
  {
    set par(first-line-indent: 0pt, leading: single-spaced-leading)
    bibliography(
      config.file,
      style: config.style,
      title: none,
    )
  }
}

#let title-page-shell(margins, body, variant) = page(
  paper: "us-letter",
  margin: margins,
  numbering: none,
)[
  #section-order.step()
  #audit("title-page", "hidden", extra: (variant: variant))
  #layout-marker("title-page", extra: (variant: variant))
  #set par(first-line-indent: 0pt, justify: false, leading: title-page-paragraph-leading)
  #body
]

// Previous degrees on the title page use a stack so the vertical spacing can
// be tuned independently from the rest of the title-page metadata.
#let render-previous-degrees(previous-degrees) = stack(
  dir: ttb,
  spacing: title-page-previous-degree-spacing,
  ..previous-degrees.map(record => [
    #set par(leading: single-spaced-leading)
    #record.degree
    #linebreak()
    #record.institution
  ]),
)

#let graduate-title-page(config) = title-page-shell(config.portrait-margins, align(center)[
  #v(title-page-top-gap)
  #text(font: config.title-font, size: title-page-title-size, smallcaps(config.title))
  #v(title-page-after-title)
  by
  #v(title-page-after-by)
  #config.author
  #v(title-page-after-author)
  #render-previous-degrees(config.previous-degrees)
  #v(title-page-after-previous-degrees)
  #line(length: title-page-rule-length, stroke: title-page-rule-stroke)
  #v(title-page-after-rule)
  Submitted in Partial Fulfillment of the Requirements
  #linebreak()
  for the Degree of #config.degree in
  #linebreak()
  #config.field
  #linebreak()
  #config.college
  #linebreak()
  University of South Carolina
  #linebreak()
  #config.year
  #v(title-page-after-metadata)
  Accepted by:
  #v(title-page-after-accepted)
  #(
    (
      [#config.advisor.name, #config.advisor.role],
      ..config.committee.map(member => [#member.name, #member.role]),
      [#config.dean.name, #config.dean.title],
    ).join(linebreak())
  )
], plain-string(config.document))

#let copyright-page(author, year, content) = page(
  paper: "us-letter",
  margin: standard-portrait-margins,
  numbering: "i",
  number-align: center + bottom,
  footer-descent: 40%,
)[
  #section-order.step()
  #audit("copyright-page", "roman")
  #set par(first-line-indent: 0pt, justify: false, leading: single-spaced-leading)
  #set text(tracking: body-tracking-compensation)
  #align(center)[
    #v(copyright-top-gap)
    #if content == true or content == auto {
      [
        Copyright by #author \
        #year \
        All Rights Reserved
      ]
    } else {
      content
    }
  ]
]

#let etd(
  title: none,
  author: none,
  year: none,
  document: none,
  degree: none,
  field: none,
  college: none,
  previous-degrees: none,
  advisor: none,
  committee: none,
  dean: none,
  abstract: none,
  summary: none,
  front-introduction: none,
  bibliography: none,
  dedication: none,
  acknowledgments: none,
  preface: none,
  prologue: true,
  lists: (:),
  appendices: none,
  copyright: false,
  font-profile: "lm",
  doc: none,
  body,
) = {
  let manuscript = if doc == none { body } else { doc }

  require("title", title)
  require("author", author)
  require("year", year)
  require("document", document)
  require("degree", degree)
  require("field", field)
  require("college", college)
  require("bibliography", bibliography)
  require("doc", manuscript)

  if document != "thesis" and document != "dissertation" {
    panic("`document` must be either `\"thesis\"` or `\"dissertation\"`.")
  }

  let fonts = if font-profile == "lm" {
    (
      text: ("Latin Modern Roman 12", "Latin Modern Roman", "New Computer Modern", "Times New Roman", "Arial"),
      title: ("Latin Modern Roman Caps", "Latin Modern Roman 12", "New Computer Modern", "Times New Roman", "Arial"),
      math: "Latin Modern Math",
    )
  } else if font-profile == "ncm" {
    (
      text: ("New Computer Modern", "Times New Roman", "Arial"),
      title: ("New Computer Modern", "Times New Roman", "Arial"),
      math: "New Computer Modern Math",
    )
  } else if font-profile == "strict-uofsc" {
    (
      text: ("Times New Roman", "Arial"),
      title: ("Times New Roman", "Arial"),
      math: "STIX Two Math",
    )
  } else {
    panic("Unknown font-profile `" + plain-string(font-profile) + "`.")
  }

  let roles = graduate-role-config(document)
  let normalized-advisor = normalize-person("advisor", advisor, default-role: roles.advisor)
  let normalized-committee = normalize-committee(committee, roles.committee)
  let normalized-dean = normalize-person("dean", dean, title-required: true)
  let list-config = document-lists(lists)

  require("advisor", normalized-advisor)
  require("committee", normalized-committee)
  require("dean", normalized-dean)
  require("abstract", abstract)
  require("previous-degrees", previous-degrees)
  if normalized-committee.len() == 0 {
    panic("uofsc-etd requires at least one committee member.")
  }

  smcp-font-state.update(fonts.title)

  set document-meta(
    title: plain-string(title),
    author: (plain-string(author),),
  )
  set page(
    paper: "us-letter",
    margin: standard-portrait-margins,
    numbering: none,
    number-align: center + bottom,
    footer-descent: 40%,
  )
  set text(
    font: fonts.text,
    size: body-text-size,
    lang: "en",
    fill: black,
    hyphenate: false,
  )
  // Document-wide show/set rules start here. Most style iteration now happens
  // through the named constants at the top of this file plus the selectors
  // below for captions, headings, and references.
  show math.equation: set text(font: fonts.math)
  set par(
    justify: true,
    first-line-indent: body-first-line-indent,
    leading: double-spaced-leading,
  )
  set figure(numbering: body-figure-numbering)
  show figure.where(kind: image): set figure(gap: image-figure-gap)
  show figure.where(kind: image): set figure.caption(
    position: bottom,
    separator: [#h(figure-caption-label-gap)],
  )
  show figure.where(kind: table): set figure.caption(
    position: top,
    separator: [#h(table-caption-label-gap)],
  )
  show figure.caption.where(kind: image): it => block(width: 100%)[
    #align(left)[
      #set text(size: figure-caption-text-size)
      #set par(
        first-line-indent: 0pt,
        justify: true,
        leading: single-spaced-leading,
      )
      #it
    ]
    #v(image-figure-caption-below-gap)
  ]
  show figure.caption.where(kind: table): it => align(center)[
    #v(table-caption-gap-above)
    #block(width: text-block-width, below: table-caption-gap-below)[
      #set text(size: table-caption-text-size)
      #set par(first-line-indent: 0pt, justify: false, leading: single-spaced-leading)
      #align(center)[#it]
    ]
  ]
  show figure.where(kind: table): it => { it; v(image-figure-caption-below-gap) }
  // Raw / code blocks reuse the image-caption styling so the caption
  // beneath a Code block reads consistently with figure captions:
  // left-aligned, justified, single-spaced, followed by a visible gap.
  show figure.where(kind: raw): set figure(gap: image-figure-gap)
  show figure.where(kind: raw): set figure.caption(
    position: bottom,
    separator: [#h(figure-caption-label-gap)],
  )
  show figure.caption.where(kind: raw): it => align(left)[
    #set text(size: figure-caption-text-size)
    #set par(
      first-line-indent: 0pt,
      justify: true,
      leading: single-spaced-leading,
    )
    #it
    #v(image-figure-caption-below-gap)
  ]
  set math.equation(
    numbering: body-equation-numbering,
    supplement: none,
  )
  show ref: it => {
    let equation = math.equation
    let element = it.element
    if element == none or element.func() != equation {
      return it
    }
    link(
      element.location(),
      numbering(
        element.numbering,
        ..counter(equation).at(element.location()),
      ),
    )
  }
  show heading.where(level: 1, outlined: false): front-outline-heading
  show heading.where(level: 1, outlined: true): front-level-one-heading
  show heading.where(level: 2): level-two-heading
  show heading.where(level: 3): level-three-heading

  if prologue {
    graduate-title-page((
      title: title,
      author: author,
      year: year,
      document: document,
      degree: degree,
      field: field,
      college: college,
      previous-degrees: previous-degrees,
      advisor: normalized-advisor,
      committee: normalized-committee,
      dean: normalized-dean,
      portrait-margins: standard-portrait-margins,
      title-font: fonts.title,
    ))

    page-regime.update("roman")
    set page(numbering: page-regime-pattern("roman"))

    if copyright != false and copyright != none {
      copyright-page(author, year, copyright)
    }

    if dedication != none {
      front-section("dedication", [Dedication], dedication)
    }

    if acknowledgments != none {
      front-section("acknowledgments", [Acknowledgments], acknowledgments)
    }

    if abstract != none {
      front-section("abstract", [Abstract], abstract)
    }

    if preface != none {
      front-section("preface", [Preface], preface)
    }

    render-outline-list(
      "table-of-contents",
      [Table of Contents],
      heading.where(outlined: true),
      depth: toc-depth,
      outlined: false,
      indent: level => level * toc-indent-step,
      mode: "toc",
    )

    context if list-config.tables == auto {
      if metadata-values("uofsc-etd-table-list-entry").filter(entry =>
        key-at(entry, "outlined", default: true) and key-at(entry, "caption", default: none) != none
      ).len() >= 4 {
        render-table-list(
          "list-of-tables",
          [List of Tables],
        )
      }
    } else if list-config.tables {
      render-table-list(
        "list-of-tables",
        [List of Tables],
      )
    }

    context if list-config.figures == auto {
      if metadata-values("uofsc-etd-figure-list-entry").filter(entry =>
        key-at(entry, "outlined", default: true) and key-at(entry, "caption", default: none) != none
      ).len() >= 4 {
        render-figure-list(
          "list-of-figures",
          [List of Figures],
        )
      }
    } else if list-config.figures {
      render-figure-list(
        "list-of-figures",
        [List of Figures],
      )
    }

    context if list-config.code == auto {
      if metadata-values("uofsc-etd-code-list-entry").filter(entry =>
        key-at(entry, "outlined", default: true) and key-at(entry, "caption", default: none) != none
      ).len() >= 1 {
        render-code-list(
          "list-of-code",
          [List of Code],
        )
      }
    } else if list-config.code {
      render-code-list(
        "list-of-code",
        [List of Code],
      )
    }

    if list-config.symbols != none and list-config.symbols != () {
      front-section("list-of-symbols", [List of Symbols], render-symbol-list(list-config.symbols))
    }

    if list-config.abbreviations != none and list-config.abbreviations != () {
      front-section("list-of-abbreviations", [List of Abbreviations], render-abbreviation-list(list-config.abbreviations))
    }

    if summary != none {
      front-section("summary", [Thesis Summary], summary)
    }

    if front-introduction != none {
      front-section("front-introduction", [Introduction], front-introduction)
    }
  }

  pagebreak(weak: true)
  counter(page).update(1)
  page-regime.update("arabic")
  set page(numbering: page-regime-pattern("arabic"))

  {
    // Suppress Typst's default "Section " heading supplement on body headings.
    // The body heading-numbering functions already emit "Chapter N" / "Appendix A"
    // for level-1 references, so the supplement would otherwise produce
    // "Section Chapter N" when a chapter is referenced via `@ch:foo`.
    set heading(supplement: none)
    body-heading-kind.update("chapter")
    set heading(numbering: heading-numbering)
    show heading.where(level: 1): body-level-one-heading
    manuscript
    bibliography-section(bibliography)
    if appendices != none {
      // Reset the level-1 heading counter so the first appendix is "A" rather
      // than the next letter after the last chapter (otherwise N chapters
      // would push the first appendix to letter N+1).
      counter(heading).update(0)
      body-heading-kind.update("appendix")
      set heading(numbering: appendix-numbering)
      appendices
    }
  }
}
