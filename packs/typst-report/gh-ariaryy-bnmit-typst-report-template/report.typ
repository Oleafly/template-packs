// Composes the whole document: preamble, front matter, body, back matter.
// `template.typ` holds the shared primitives; this file is the only place
// that knows what order the parts go in.

#import "template.typ": border-of, center-table-headers, layout-of, running-footer, running-header
#import "01_preamble/01_cover.typ": cover
#import "01_preamble/02_certificate.typ": certificate
#import "01_preamble/03_acknowledgement.typ": acknowledgement
#import "02_front-matter/01_abstract.typ": abstract
#import "02_front-matter/02_table-of-contents.typ": table_of_contents
#import "02_front-matter/03_list-of-figures.typ": list_of_figures
#import "02_front-matter/04_list-of-tables.typ": list_of_tables
#import "04_back-matter/01_references.typ": references

// ---------------------------------------------------------------------------
// Front matter: abstract, contents, lists. Roman page numbers, no running head.
// ---------------------------------------------------------------------------

#let front-matter(config) = {
  let l = layout-of(config)

  set page(
    ..l.body,
    header: none,
    footer: running-footer(config, page-numbering: "I"),
  )
  set text(size: config.style.text-size.body, font: config.style.fonts.body)
  counter(page).update(1)

  if config.options.abstract {
    abstract(config)
    pagebreak()
  }

  table_of_contents(config)

  // Skipped entirely when the report has no figures or no tables, which is
  // more useful than a toggle: an empty list is never what you wanted.
  context {
    if query(figure.where(kind: image)).len() > 0 {
      pagebreak()
      list_of_figures(config)
    }
  }
  context {
    if query(figure.where(kind: table)).len() > 0 {
      pagebreak()
      list_of_tables(config)
    }
  }
}

// ---------------------------------------------------------------------------
// Body
// ---------------------------------------------------------------------------

#let chapter-separator(config, number, title) = {
  let l = layout-of(config)
  page(
    ..l.plate,
    background: border-of(config),
    header: none,
    footer: none,
    {
      set align(center + horizon)
      set par(justify: false)
      set text(weight: "bold")
      // Held well inside the border so a long chapter title wraps into a
      // block instead of running rule to rule.
      block(width: 80%)[
        #text(size: config.style.text-size.separator-label)[CHAPTER #number]
        #linebreak()
        #v(0.2em)
        #text(size: config.style.text-size.separator-title)[#upper(title)]
      ]
    },
  )
}

#let body(config, doc) = {
  let l = layout-of(config)
  let style = config.style
  let plain-pages = state("pages-without-header", ())

  set page(
    ..l.body,
    header: context {
      if not plain-pages.get().contains(here().page()) { running-header(config) }
    },
    footer: running-footer(config),
  )

  set par(
    justify: true,
    leading: style.leading,
    spacing: style.leading,
    // `all: false` indents every paragraph except the one directly after a
    // heading, which is what Word's built-in heading styles do.
    first-line-indent: (amount: style.paragraph-indent, all: false),
  )

  // `1` for a chapter and `1.2` for a section, with no trailing dot, so the
  // same numbers can be dropped straight into the contents table.
  set heading(numbering: (..nums) => {
    let n = nums.pos()
    if n.len() == 1 { str(n.first()) } else { n.map(str).join(".") }
  })

  show heading.where(level: 2): set text(size: style.text-size.h2)
  show heading.where(level: 3): set text(size: style.text-size.h3)
  show heading.where(level: 4): set text(size: style.text-size.h4, style: "italic")
  show heading: it => {
    if it.level == 1 { it } else {
      // A level-3 heading directly under a level-2 heading (no paragraph in
      // between) would otherwise stack its own leading gap on top of the
      // trailing gap the level-2 heading just left, reading as two full
      // lines of space instead of one. Drop only that one gap; every other
      // heading keeps the normal space above it.
      context {
        let prior = query(
          selector(heading).or(selector(par)).before(it.location(), inclusive: false),
        )
        let prev = if prior.len() > 0 { prior.last() } else { none }
        let sub-sub-under-sub = it.level == 3 and prev != none and prev.func() == heading and prev.level == 2
        if not sub-sub-under-sub {
          v(style.leading)
        }
      }
      it
      v(style.leading)
    }
  }

  show heading.where(level: 1): it => {
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)
    counter(math.equation).update(0)

    let number = context counter(heading).display(it.numbering)

    if config.options.chapter-separators {
      chapter-separator(config, number, it.body)
    } else {
      pagebreak(weak: true)
    }

    // Marks the first page of the chapter's running text. The header is
    // suppressed on exactly these pages; reading them off a label beats
    // arithmetic on the separator page's number, which only holds while
    // separators are switched on.
    [#metadata(none)<chapter-start>]

    block(width: 100%)[
      #text(size: style.text-size.chapter-label, weight: "bold")[CHAPTER #number]
      #set align(center)
      #set text(size: style.text-size.chapter-title, weight: "bold")
      #upper(it.body)
    ]
    v(style.leading)
  }

  // Typst makes figures non-breakable, which forces a tall table entirely on
  // to one page or off the bottom of it, instead of flowing across the page
  // boundary the way a plain table would.
  show figure: set block(breakable: true)
  show table: set block(breakable: true)
  show figure.caption: set text(size: style.text-size.caption, weight: "bold")

  let chapter-scoped(..nums) = {
    let chapter = counter(heading).get().first()
    str(chapter) + "." + str(nums.pos().first())
  }

  show figure.where(kind: image): set figure(supplement: [Figure], numbering: chapter-scoped)
  show figure.where(kind: table): set figure(supplement: [Table], numbering: chapter-scoped)

  // Table captions sit above the table, figure captions below.
  show figure.where(kind: table): it => block(breakable: true, width: 100%)[
    #align(center, it.caption)
    #it.body
  ]

  set math.equation(numbering: (..nums) => "(" + chapter-scoped(..nums) + ")")

  counter(page).update(1)
  context { plain-pages.update(query(<chapter-start>).map(e => e.location().page())) }

  doc
}

// ---------------------------------------------------------------------------

#let report(config, doc) = {
  set document(title: config.title, author: config.authors.map(a => a.name))
  // Word does not hyphenate by default and this report does not either, so
  // justified text pays for it in word spacing rather than in broken words.
  // Set once here and inherited by every page, including the preamble.
  set text(
    font: config.style.fonts.body,
    size: config.style.text-size.body,
    hyphenate: false,
  )
  set align(left)
  show: center-table-headers

  cover(config)
  certificate(config)
  acknowledgement(config)
  front-matter(config)
  // The bibliography is loaded either way. Dropping it entirely would turn
  // every `@key` in the report into a hard compile error the moment someone
  // flips this switch off, so when the list is disabled it is loaded and
  // suppressed: citations still resolve and still render as [1].
  if config.options.references {
    body(config, doc)
    references(config)
  } else {
    show bibliography: none
    body(config, doc)
    bibliography(
      config.bibliography.path,
      title: none,
      style: config.bibliography.style,
    )
  }
}
