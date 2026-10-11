// Copyright 2026 Leedehai.
// Use of this code is governed by a MIT license in the LICENSE.txt file.
// Repository: https://github.com/Leedehai/typst-flow-book

#import "@preview/marginalia:0.3.1" as marginalia
#import "@preview/in-dexter:0.7.2": make-index

#let quote-impl(body, attribution: none) = {
  show quote: it => block(inset: (x: 1em), spacing: auto)[
    #emph(it.body)
    #if it.attribution != none { align(right)[-- #it.attribution] }
  ]
  quote(block: true, attribution: attribution, body)
}

#let weblink-impl(url, content) = {
  let display = if content == none {
    [#show raw: set text(fill: blue);#underline(raw(url))] // No whitespaces.
  } else {
    set text(fill: blue)
    underline(content)
  }
  link(url)[#display]
}

// The metadata holder. Access with `#book.meta`.
#let meta-holder = state("the-flow-book-meta", (:))
#let meta-impl(key) = {
  meta-holder.get().at(key)
}

#let chapter-suboutline(
  chapter-heading,
  depth: none,
) = {
  set outline.entry(fill: repeat([.], gap: 0.15em))

  context {
    let headings-after = query(
      selector(heading.where(outlined: true)).after(
        chapter-heading.location(),
        inclusive: false,
      ),
    )
    let last-sub-heading = headings-after
      .slice(0, headings-after.position(h => h.level <= chapter-heading.level))
      .at(-1, default: none)
    // This chapter has no sub headings at all; no "last one" to speak of.
    if last-sub-heading == none { return }

    outline(
      // Must be 'none' to prevent error "pagebreak not allowed inside of
      // containers". Explanation of error: we have a show rule that inserts
      // a pagebreak before every heading, and this outline() function is
      // called within that show rule. A non-none title will also results in
      // in a heading for this outline block, and hence with that show rule
      // Typst will try inserting a pagebreak before this outline heading,
      // inside the outer heading's layout container. It doesn't make sense
      // and thus forbidden.
      title: none,
      target: selector(heading.where(outlined: true))
        .after(
          chapter-heading.location(),
          inclusive: false,
        )
        .before(last-sub-heading.location()),
      depth: if depth == none { none } else { chapter-heading.level + depth },
    )
  }
}

#let is-chapter-appendix = state("is-chapter-appendix", false)

// Add page header, for pages that contain a chapter (i.e. level-1) heading
#let chapter-header(it, margin-note-metrics, i10n-text) = {
  let formatted = (
    heading: text(size: 1.5em)[#it.body],
    num: if is-chapter-appendix.get() {
      text(size: 1.5em)[
        #i10n-text.appendix-abbreviated-heading-prefix
        #numbering(it.numbering, counter(heading).at(it.location()).first())
      ]
    } else {
      text(size: 3em)[
        #numbering(it.numbering, counter(heading).at(it.location()).first())
      ]
    },
  )
  let divider = line(
    // A sufficiently long line, extending above the page top
    length: page.height,
    angle: 270deg,
  )
  // Absolute count, not using the resettable counter(page)
  let page-num = here().page()
  if calc.odd(page-num) {
    let chapter-header = align(right)[
      #box(width: page.width - margin-note-metrics.width * 2)[
        #set par(justify: false)
        #formatted.heading
      ]
      #h(1em)
      #box(width: margin-note-metrics.width)[
        #align(right.inv())[#h(0.5em)#formatted.num]
      ]
    ]
    marginalia.wideblock([
      #place(
        top + right,
        dx: -margin-note-metrics.width - margin-note-metrics.sep / 2,
        dy: measure(chapter-header).height,
        divider,
      )
      #chapter-header
      #v(1em)
    ])
  } else {
    let chapter-header = align(left)[
      #box(width: margin-note-metrics.width)[
        #align(left.inv())[#formatted.num#h(0.5em)]
      ]
      #h(1em)
      #box(width: page.width - margin-note-metrics.width * 2)[
        #set par(justify: false)
        #formatted.heading
      ]
    ]
    marginalia.wideblock([
      #place(
        top + left,
        dx: margin-note-metrics.width + margin-note-metrics.sep / 2,
        dy: measure(chapter-header).height,
        divider,
      )
      #chapter-header
      #v(1em)
    ])
  }
}

// Find the level-1 or level-2 heading that "owns" this page.
// If there's such a heading on this exact page, then this is the heading.
// Otherwise, the heading is found by looking at previous pages.
#let find-heading(current-page) = {
  // 1. Look for a level-1 heading starting on this EXACT page
  let headings-on-page = query(heading.where(level: 1)).filter(
    h => h.location().page() == current-page,
  )
  if headings-on-page.len() > 0 {
    return (
      heading-of-page: headings-on-page.first(),
      heading-on-this-page: true,
    )
  }

  // 2. Look for a level-2 heading starting on this EXACT page
  let headings-on-page = query(heading.where(level: 2)).filter(
    h => h.location().page() == current-page,
  )
  if headings-on-page.len() > 0 {
    return (
      heading-of-page: headings-on-page.first(),
      heading-on-this-page: true,
    )
  }

  // 3. Fall back to the last level-1 or level-2 heading in past pages
  let past-headings = query(
    heading.where(level: 1).or(heading.where(level: 2)).before(here()),
  )
  if past-headings != () {
    return (
      heading-of-page: past-headings.last(),
      heading-on-this-page: false,
    )
  }

  return (
    heading-of-page: none,
    heading-on-this-page: false,
  )
}

// Add page header, for all pages.
#let page-header(current-page) = {
  let (heading-of-page, heading-on-this-page) = find-heading(current-page)
  if heading-of-page == none or heading-of-page.numbering == none { return }
  // If the page has a chapter heading, then we don't add a page header.
  if heading-of-page.level == 1 and heading-on-this-page { return }

  let chapter-num = counter(heading).at(heading-of-page.location())
  let formatted = (
    num: text(style: "italic")[
      #numbering(heading-of-page.numbering, ..chapter-num)
    ],
    divider: box(line(length: 10em, angle: 90deg, stroke: 0.8pt)),
    heading: text(style: "italic")[#heading-of-page.body],
  )

  // Absolute count, not using the resettable counter(page)
  let page-num = here().page()
  if calc.odd(page-num) {
    marginalia.wideblock(align(right)[
      #formatted.heading
      #h(1em)
      #formatted.divider
      #h(1em)
      #box(width: 1cm)[#align(right.inv())[#formatted.num]]
    ])
  } else {
    marginalia.wideblock(align(left)[
      #box(width: 1cm)[#align(left.inv())[#formatted.num]]
      #h(1em)
      #formatted.divider
      #h(1em)
      #formatted.heading
    ])
  }
}

// The template.
#let setup-impl(opts, body) = {
  // --------------------------------- GLOBAL ----------------------------------
  meta-holder.update(
    (
      title: opts.title,
      subtitle: opts.subtitle,
      author: opts.author,
      publisher: opts.publisher,
      versioning: opts.versioning,
    )
      + opts.meta-dict,
  )

  set page(paper: opts.paper-size)
  set super(size: 0.8em)

  show bibliography: bib => {
    show link: l => {
      if type(l.dest) == str and l.body.func() != raw and l.body.has("text") {
        show raw: set text(fill: blue)
        link(l.dest, underline(raw(l.body.text)))
      } else {
        l
      }
    }
    bib
  }

  let odd-pagebreak() = {
    {
      show pagebreak.where(to: "odd", weak: true): set page(
        background: align(
          center + horizon,
          text(style: "italic")[#opts.i10n-texts.blank-page-message],
        ),
      )
      pagebreak(to: "odd", weak: true)
    } // Scoped
  }

  let cover-page-sub-content(config, s) = {
    if config.font != auto {
      // text(font: auto) is not accepted, so we have to use an if-condition.
      set text(font: config.font)
      text(size: config.size, weight: config.weight)[#s]
    } else {
      text(size: config.size, weight: config.weight)[#s]
    }
  }

  let reset-counters() = {
    counter(heading).update(0)
    counter(math.equation).update(0)
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)
    counter(figure.where(kind: raw)).update(0)
  }

  // ------------------------------- FRONTMATTER -------------------------------
  {
    odd-pagebreak()
    // Cover page
    [
      #if opts.title-head != none {
        opts.title-head
      }
      #if opts.versioning != none {
        h(1fr)
        let version = if opts.versioning.at("version", default: none) != none {
          opts.versioning.version
        }
        let date = if opts.versioning.at("build-date", default: none) != none {
          datetime.today().display(opts.versioning.build-date)
        }
        (version, date).join(h(1em))
      }
      #align(center)[
        #v(1fr)
        #cover-page-sub-content(opts.cover-page-fonts.title, opts.title) \
        #v(1em)
        #cover-page-sub-content(opts.cover-page-fonts.subtitle, opts.subtitle) \
        #v(2fr)
        #cover-page-sub-content(opts.cover-page-fonts.author, opts.author)
        #v(1em)
        #cover-page-sub-content(opts.cover-page-fonts.publisher, opts.publisher)
        #v(1em)
      ]
    ]

    if opts.copyright-page != none {
      pagebreak(weak: true)
      opts.copyright-page
    }

    if opts.opening-page != none {
      odd-pagebreak()
      opts.opening-page
    }

    if opts.dedication-page != none {
      odd-pagebreak()
      opts.dedication-page
    }

    show heading.where(level: 1): it => {
      counter(footnote).update(0)
      text(size: 1.5em)[#it.body]
      v(1em)
    }

    if opts.foreword != none {
      odd-pagebreak()
      set page(numbering: "i")
      reset-counters()
      heading(level: 1, numbering: none)[#opts.i10n-texts.forward]
      opts.foreword
    }

    if opts.preface != none {
      odd-pagebreak()
      set page(numbering: "i")
      reset-counters()
      heading(level: 1, numbering: none)[#opts.i10n-texts.preface]
      opts.preface
    }

    if opts.show-table-of-contents {
      odd-pagebreak()
      outline(title: [#opts.i10n-texts.table-of-contents], indent: auto)
    }

    if opts.show-list-of-figures {
      odd-pagebreak()
      outline(
        title: [#opts.i10n-texts.list-of-figures],
        target: figure.where(kind: image),
      )
    }

    if opts.show-list-of-tables {
      odd-pagebreak()
      outline(
        title: [#opts.i10n-texts.list-of-tables],
        target: figure.where(kind: table),
      )
    }
  } // Scoped

  // ------------------------ BODY (MAIN AND APPENDICES) -----------------------
  {
    odd-pagebreak()
    reset-counters()

    set par(justify: true)
    set heading(numbering: "1.1")

    // Configure marginalia layout (side notes)
    show: marginalia.setup.with(
      outer: (
        width: opts.margin-note-metrics.width,
        sep: opts.margin-note-metrics.sep,
        far: 2cm,
      ),
      book: true, // Alternates margins per page
    )

    set page(
      numbering: "1",
      number-align: center + top,
      header: context {
        let current-page = here().page()
        page-header(current-page)
      },
      footer: context {
        // Absolute count, not using the resettable counter(page)
        let page-num = here().page()
        marginalia.wideblock(align(center)[#page-num])
      },
    )

    // Remove the separator from the footnote.entry rule, because it
    // is hard to get the starting point of the separator line right,
    // given there is a margin.
    set footnote.entry(separator: none)

    // Forces the footnote text to span the text block + margin width
    // and forces the entry body to appear like an enumerated list entry
    show footnote.entry: it => context {
      let loc = it.note.location()
      let num = counter(footnote).at(loc).first()
      let enum-like-entry = enum(
        numbering: "1",
        body-indent: 1em,
        enum.item(num)[#it.note.body],
      )
      marginalia.wideblock(enum-like-entry)
    }

    show heading.where(level: 1): it => {
      pagebreak(weak: true)
      counter(footnote).update(0)
      marginalia.notecounter.update(0)

      if it.numbering == none {
        text(size: 1.5em)[#it.body]
      } else {
        chapter-header(it, opts.margin-note-metrics, opts.i10n-texts)
      }

      // Inject the mini-TOC right below the chapter heading
      if opts.show-chapter-outline {
        marginalia.note(
          numbering: none,
          box(
            width: opts.margin-note-metrics.width,
            text(style: "italic", size: 8pt, chapter-suboutline(it, depth: 1)),
          ),
        )
      }

      // Necessary to prevent the gap, which has the height equal to the
      // mini-TOC, between the chapter heading and the chapter text.
      v(0pt, weak: true)
    }

    show heading.where(level: 2): it => {
      v(1em)
      it // Render the title
      v(1em)
    }

    body // This is the main body

    if opts.appendices.chapters.len() != 0 {
      reset-counters()
      odd-pagebreak()

      {
        show heading: none // Invisble in document, but still in the outline.
        heading(numbering: none)[#opts.i10n-texts.appendix-title-in-outline]
        if opts.appendices.title-page != none {
          set page(header: none)
          opts.appendices.title-page
          set page(footer: none)
          odd-pagebreak()
        }
      } // Scoped

      set heading(numbering: "I.1")
      is-chapter-appendix.update(true)

      for appendix in opts.appendices.chapters {
        appendix
      }
    }
  } // Scoped

  // ------------------------------- BACKMATTER --------------------------------
  {
    reset-counters()
    set par(justify: true)
    set heading(numbering: none)
    set page(numbering: "1")

    if opts.bibliography != none {
      odd-pagebreak()
      show heading.where(level: 1): it => {
        text(size: 1.5em)[#it]
      }
      opts.bibliography
    }

    if opts.show-index {
      odd-pagebreak()
      show heading.where(level: 1): it => {
        text(size: 1.5em)[#it]
      }
      [= #opts.i10n-texts.index]
      v(1em)
      // This font is embedded in Typst.
      set text(font: "DejaVu Sans Mono", size: 0.9em)
      columns(2)[#make-index(
        use-page-counter: true, // Use page counter, not absolute page number.
        use-bang-grouping: true, // LaTeX bang grouping syntax.
        entry-casing: it => it, // Don't capitalize the first letter.
      )]
    }
  } // Scoped
}
