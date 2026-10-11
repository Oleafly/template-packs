#import "glossary.typ": glossary
#import "@preview/hydra:0.6.2": hydra, anchor
#import "@preview/bytefield:0.0.8": bytefield, bit, bits, flag, bitheader, bf-config, note, group

// Clean Thesis style, after cleanthesis.sty by R. Langner (LPPL 1.3+).


// --- What you will want to edit ---------------------------------------------

// Every user-visible title, in one place; translate here.
#let strings = (
  contents:     "Table des matières",
  figures:      "Table des figures",
  tables:       "Liste des tableaux",
  listings:     "Liste des listings",
  bibliography: "Bibliographie",
  webpages:     "Webpages",
  glossary:     "Glossaire",
  part:         "Partie",
  chapter:      "Chapitre",
  appendix:     "Annexe",
)

#let colors = (
  main:         cmyk(100%, 50%, 10%, 1%),   // headings, refs, rules
  accessory:    cmyk(18%, 98%, 18%, 0%),    // caption labels
  black:        luma(0%),
  gray:         luma(50%),
  gray-light:   luma(80%),
  gray-lighter: luma(95%),
)

#let font-serif   = ("Charter BT", "Latin Modern Roman")  // body
#let font-sans    = ("TeX Gyre Heros",)                   // headings, footer
#let font-sans-lm = ("Latin Modern Sans",)                // caption labels, ToC parts
#let font-display = ("TeX Gyre Bonum",)                   // "Partie I" on part pages
#let font-mono    = ("Latin Modern Mono",)                // code, URLs

// LaTeX's \tiny..\huge ladder at 11pt.
#let sz = (
  normal: 10.95pt, small: 10pt, smaller: 8.5pt, footnote: 9pt, script: 8pt,
  large: 12pt, Large: 14.4pt, LARGE: 17.28pt, huge: 20.74pt,
)
#let caption-size = 9.5pt
#let code-size    = 9.5pt


// --- Measured from the LaTeX original; change only to move things -----------

// A4 with cleanthesis.sty's KOMA typearea (BCOR 25mm, DIV 15).
#let page-width    = 210mm
#let page-height   = 297mm
#let margin-inner  = 40.417mm
#let margin-outer  = 30.833mm
#let margin-top    = 24.75mm
#let margin-bottom = 48.51mm
#let text-width    = 138.75mm

// Vertical unit for heading and ToC spacing -- not the body line pitch.
#let leading-unit = 13.6pt

// Distances from the top of the page.
#let ch-title-y   = 37.25mm    // chapter title
#let ch-rule-y    = -5.13mm    // chapter number and its rule
#let ch-body-y    = 61.13mm    // first line of chapter text
#let ch-rule-size = 5cm
#let part-label-y = 82.20mm    // "Partie I"
#let part-rule-y  = 106.01mm   // rule under it
#let part-title-y = 134.41mm   // part title
#let part-label-size    = 54pt
#let part-rule-overhang = 5.3pt   // how far the rule passes the text edge

#let foot-baseline-y = 276.31mm
#let foot-rule       = (w: 1.25pt, h: 100pt, rise: 10pt)
#let foot-gap-number = 10pt
#let foot-gap-mark   = 0.75cm
#let foot-number-box = 1.5cm
#let foot-overhang   = foot-gap-number + foot-number-box

#let listing-numsep   = 15pt
#let listing-numwidth = 1.4em

// Per level: width of the number column, and space above the entry.
#let toc-numwidths = (7mm, 9.2mm, 14.7mm)
#let toc-gaps      = (1.31, 0.65, 0.56)


// --- Internal state ---------------------------------------------------------

#let ct-pagestyle = state("ct-pagestyle", "empty")
#let ct-appendix = state("ct-appendix", false)
#let ct-blank = state("ct-blank", false)

#let pagestyle(name) = ct-pagestyle.update(name)

#let cleardoublepage() = {
  pagebreak(weak: true)
  ct-blank.update(true)
  pagebreak(to: "odd", weak: true)
  ct-blank.update(false)
}
// --- Numbering helpers ------------------------------------------------------

#let heading-number(nums, appendix) = {
  if nums.len() == 0 { return none }
  let head = if appendix { numbering("A", nums.first()) } else { str(nums.first()) }
  (head, ..nums.slice(1).map(str)).join(".")
}

// Chapter label of whatever is current; 0 before the first chapter.
#let chapter-num() = {
  let ch = counter(heading).get()
  heading-number((if ch.len() > 0 { ch.first() } else { 0 },), ct-appendix.get())
}

// A float reports its anchor, its caption the real page (typst/typst#4359).
#let figure-loc(loc, kind) = {
  let figs = query(figure.where(kind: kind))
  let caps = query(figure.caption).filter(c => c.kind == kind)
  let i = figs.position(f => f.location() == loc)
  let pg = if i == none or i >= caps.len() { loc.page() } else { caps.at(i).location().page() }
  let tops = query(<ct-page-top>)
  if pg <= tops.len() { tops.at(pg - 1).location() } else { loc }
}

#let hang-left(body) = context box(width: 0pt, move(dx: -measure(body).width, body))

// --- Footer -----------------------------------------------------------------

#let footer-mark(level, flush-right: false) = {
  let style(body) = text(font: font-sans, size: sz.footnote,
                         fill: colors.main, weight: "regular", body)

  // "Chapitre 3" or "Annexe A" for a chapter, "3.2" for a section.
  let label-of(hd) = {
    if hd.numbering == none { return none }
    let nums = counter(heading).at(hd.location())
    let apx = ct-appendix.at(hd.location())
    if hd.level != 1 { return heading-number(nums, apx) }
    if apx { [#strings.appendix #numbering("A", nums.first())] }
    else { [#strings.chapter #nums.first()] }
  }

  let render(hd) = {
    let width = if hd.level == 1 { 0.65 * text-width } else {
      calc.min(measure(style(hd.body)).width, 0.7 * text-width)
    }
    let title = box(width: width, {
      set par(justify: false, leading: 0.4em)
      align(if flush-right { right } else { left }, style(hd.body))
    })
    let label = label-of(hd)
    if label == none { title } else {
      style(text(fill: colors.black, weight: "bold", label)) + h(0.25cm) + title
    }
  }

  let mark(lvl) = hydra(lvl, book: false, skip-starting: false, display: (_, c) => render(c))
  // A chapter with no sections falls back to the chapter mark.
  let found = mark(level)
  if found == none and level != 1 { mark(1) } else { found }
}

#let footer-page-number(side) = box(
  width: foot-number-box,
  align(side, text(font: font-sans, size: sz.normal, weight: "bold",
                   fill: colors.black, context counter(page).display())),
)

#let footer-rule() = box(
  width: foot-rule.w, height: foot-rule.h,
  baseline: foot-rule.h - foot-rule.rise, fill: colors.main,
)

#let make-footer() = context {
  let style = ct-pagestyle.get()
  if style == "empty" or ct-blank.get() { return none }

  let loc = here()
  let odd = calc.odd(loc.page())
  let opens-chapter = query(heading.where(level: 1))
    .any(h => h.location().page() == loc.page())
  let mark = if style == "scrheadings" and not opens-chapter {
    footer-mark(if odd { 2 } else { 1 }, flush-right: odd)
  }

  // The verso footer is the recto one mirrored.
  let parts = (
    ..if mark != none { (mark, h(foot-gap-mark)) } else { () },
    footer-rule(),
    h(foot-gap-number),
    footer-page-number(if odd { left } else { right }),
  )
  let row = box((if odd { parts } else { parts.rev() }).join())

  let dy = foot-baseline-y - foot-rule.rise - (page-height - margin-bottom)
  let side = if odd { right } else { left }
  place(top + side, dx: if odd { foot-overhang } else { -foot-overhang }, dy: dy, row)
}

// --- Parts ------------------------------------------------------------------

#let part-supplement = [Partie]

// Parts are unnumbered level-1 headings; the supplement tells them from
// chapters and leaves the label free for the author's own <part:...>.
#let part(title) = heading(
  level: 1, numbering: none, outlined: true, supplement: part-supplement, title,
)

#let is-part(h) = h.func() == heading and h.supplement == part-supplement

#let part-index(loc) = {
  let parts = query(heading).filter(is-part)
  parts.position(h => h.location().position() == loc.position()) + 1
}

#let part-page(body) = context {
  let n = part-index(here())
  let prev = ct-pagestyle.get()
  // Leave the facing verso blank; the part page itself sits on the recto.
  pagebreak(weak: true)
  ct-blank.update(true)
  pagebreak(to: "even", weak: true)
  pagebreak(to: "odd")   // a bare pagebreak() collapses on an empty page
  ct-blank.update(false)
  ct-pagestyle.update("empty")
  place(top + right, dy: part-label-y - margin-top,
    text(font: font-display, size: part-label-size, fill: colors.main.lighten(20%), weight: "regular",
         top-edge: "cap-height", bottom-edge: "baseline")[#strings.part #numbering("I", n)])
  place(top + left, dx: -margin-inner, dy: part-rule-y - margin-top,
        rect(width: margin-inner + text-width + part-rule-overhang, height: 2pt,
             fill: colors.black))
  place(top + right, dy: part-title-y - margin-top, block(width: 0.8 * text-width, {
    set text(font: font-sans, size: sz.huge, weight: "regular", hyphenate: false)
    set par(justify: false, leading: 0.45em)
    align(right, body)
  }))
  pagebreak()
  ct-pagestyle.update(prev)
}
// --- Chapter opening page ---------------------------------------------------

#let chapter-head(number, body) = context {
  let title = box(width: 0.7 * text-width, {
    set text(font: font-sans, size: sz.huge, weight: "regular", fill: colors.black,
             top-edge: "cap-height", bottom-edge: "baseline", hyphenate: false)
    set par(justify: false, leading: 0.45em)
    body
  })
  place(top + left, dy: ch-title-y - margin-top, title)

  if number != none {
    place(top + right, dy: ch-rule-y - margin-top, {
      box(width: 2pt, height: ch-rule-size, baseline: 5pt, fill: colors.main)
      h(sz.huge)
      text(font: font-sans, size: 60pt, weight: "regular", fill: colors.main,
           top-edge: "cap-height", bottom-edge: "baseline", number)
    })
  }

  v(calc.max(ch-body-y - margin-top,
             ch-title-y - margin-top + measure(title).height + 18.56mm))
}

// --- The template: every set and show rule ----------------------------------

#let cleanthesis(title: "", author: "", body) = {
  set document(title: title, author: author)

  set page(
    width: page-width, height: page-height,
    margin: (inside: margin-inner, outside: margin-outer,
             top: margin-top, bottom: margin-bottom),
    binding: left, footer-descent: 0pt, footer: make-footer(),
    header: anchor(), header-ascent: 0pt,
    background: place(top, [#metadata(none)<ct-page-top>]),
  )

  set text(font: font-serif, size: sz.normal, lang: "fr",
           fill: colors.black, hyphenate: true)
  // Targets LaTeX pitch: \setstretch{1.2} -> 16.26pt, parskip=half -> +8.13pt.
  set par(justify: true, leading: 0.8137em, spacing: 1.556em, first-line-indent: 0pt)

  set heading(numbering: (..n) => {
    if n.pos().len() <= 3 { numbering("1.1", ..n.pos()) }
  })

  show heading.where(level: 1): it => context {
    if is-part(it) { return part-page(it.body) }
    let n = counter(heading).get().first()
    for k in (image, table, "listing") { counter(figure.where(kind: k)).update(0) }
    cleardoublepage()
    chapter-head(
      if it.numbering == none { none } else { heading-number((n,), ct-appendix.get()) },
      it.body,
    )
  }

  let sec-head(it, size, above, below) = context {
    let num = heading-number(counter(heading).get(), ct-appendix.get())
    block(above: above * leading-unit, below: below * leading-unit, width: 100%, {
      set text(font: font-sans, size: size, fill: colors.main, weight: "regular",
               hyphenate: false)
      set par(justify: false, leading: 0.35em)
      hang-left(text(fill: colors.black, [#num#h(10pt)])) + it.body
    })
  }
  show heading.where(level: 2): it => sec-head(it, sz.LARGE, 2.98, 2.142)
  show heading.where(level: 3): it => sec-head(it, sz.Large, 2.67, 1.832)

  show heading.where(level: 4): it => block(
    above: 2.46 * leading-unit, below: 1.42 * leading-unit, width: 100%,
    text(font: font-sans, size: sz.normal, weight: "bold", hyphenate: false, it.body),
  )
  show heading.where(level: 5): it => block(
    above: 2.54 * leading-unit, below: 1.05 * leading-unit, width: 100%,
    text(font: font-sans, size: sz.small, weight: "bold", hyphenate: false, it.body),
  )

  set figure(numbering: n => context [#chapter-num().#n], gap: 0.9em)
  show figure.where(kind: table): set figure(supplement: [Tab.])
  show figure.where(kind: "listing"): set figure(supplement: [List.])

  show figure.caption: it => context {
    let prefix = text(font: font-sans-lm, weight: "bold", fill: colors.accessory,
      [#it.supplement #chapter-num().#it.counter.get().first():]) + h(0.5em)
    let indent = measure(text(size: caption-size, prefix)).width
    block(width: 100%, {
      set text(size: caption-size, hyphenate: false)
      set par(justify: false, leading: 0.45em, hanging-indent: indent)
      align(left, prefix + it.body)
    })
  }

  show raw.where(block: true): it => block(
    width: 100%, fill: colors.gray-lighter, inset: (x: 8pt, y: 4pt),
    stroke: (left: 3pt + colors.gray-light),
    {
      set par(leading: 0.489em)
      show raw.line: l => {
        box(width: 0pt, move(dx: -listing-numsep, align(right,
          box(width: listing-numwidth,
              text(font: font-sans, size: sz.smaller, fill: colors.gray)[#l.number]))))
        l.body
      }
      align(left, text(font: font-mono, size: code-size, it))
    },
  )
  show raw.where(block: false): it => text(font: font-mono, size: 1.18em, it)

  set table(inset: (x: 6pt, top: 4.2pt, bottom: 5.2pt), stroke: 0.4pt)
  show table: it => {
    set text(size: sz.small)
    set par(leading: 0.45em, spacing: 0.55em)
    it
  }

  set list(indent: 0pt, spacing: 0.85em, body-indent: 0.5em)
  set enum(indent: 0pt, spacing: 0.85em, body-indent: 0.5em)
  set ref(supplement: none)
  show ref: it => context {
    let el = it.element
    if el == none { return text(fill: colors.main, it) }
    if is-part(el) {
      return link(el.location(), text(fill: colors.main,
                                      numbering("I", part-index(el.location()))))
    }
    if el.func() == figure {
      let loc = el.location()
      let ch = counter(heading).at(loc).first()
      let n = counter(figure.where(kind: el.kind)).at(loc).first()
      return link(figure-loc(loc, el.kind),
                  text(fill: colors.main)[#heading-number((ch,), ct-appendix.at(loc)).#n])
    }
    text(fill: colors.main, it)
  }
  show cite: it => text(fill: colors.main, it)

  show: bf-config.with(
    row-height: 1.72em, stroke: 0.4pt + colors.black,
    header-font-size: 6pt, field-font-size: sz.normal,
  )

  body
}

// --- Authoring: document structure ------------------------------------------

#let unnumbered-chapter(body, outlined: false) = heading(
  level: 1, numbering: none, outlined: outlined, body,
)

#let unnumbered-section(body) = block(
  above: 2.98 * leading-unit, below: 2.142 * leading-unit, width: 100%,
  text(font: font-sans, size: sz.LARGE, fill: colors.main, weight: "regular", body),
)

#let paragraph(title, body) = block(above: 2.5em, width: 100%,
  par(box(text(font: font-sans, size: sz.small, weight: "bold", fill: colors.black, title)
          + h(0.7em)) + body),
)

#let appendix() = {
  ct-appendix.update(true)
  counter(heading).update(0)
}

#let wide(body, extra: 24mm, width: 100%) = box(width: text-width + extra, block(width: width, body))

#let abstract(title, body, size: 11pt, leading: 0.8137em, spacing: 1.556em, top: 8mm) = {
  unnumbered-chapter[#title]
  v(top)
  set text(size: size)
  set par(leading: leading, spacing: spacing)
  body
}

// --- Authoring: figures, tables, code ---------------------------------------

#let listing(caption: none, placement: none, body) = figure(
  body, caption: caption, kind: "listing", supplement: [List.], placement: placement,
)

#let listing-zone(body) = raw(body, block: true)

#let subcap(letter, caption) = {
  set text(size: sz.footnote)
  set par(justify: false, leading: 0.45em)
  align(left, text(font: font-sans, fill: colors.accessory, [(#letter)]) + " " + caption)
}

#let subfig(letter, body, caption) = block({
  set align(left)
  body
  v(0.5em, weak: true)
  subcap(letter, caption)
})

#let subfigures(caption: none, columns: auto, gutter: 1em, kind: image,
                placement: none, ..panels) = {
  let ps = panels.pos()
  figure(
    grid(
      columns: if columns == auto { ps.len() } else { columns },
      column-gutter: gutter, row-gutter: 1.1em,
      ..ps.enumerate().map(((i, p)) => subfig(numbering("a", i + 1), p.at(0), p.at(1))),
    ),
    caption: caption,
    kind: kind,
    placement: placement,
  )
}

#let bitfield(..fields) = box(width: 16em, bytefield(bpr: 16, ..fields))

#let bf-label(size: 7pt, body) = text(size: size, body)

#let bf-header = bitheader.with(angle: 0deg)

// --- Authoring: references and glossary -------------------------------------

#let missing-ref(tag) = text(fill: red)[?#tag]

#let subref(parent, letter, kind: image) = context {
  let els = query(parent)
  if els.len() == 0 { return missing-ref(str(parent)) }
  let loc = els.first().location()
  let ch = counter(heading).at(loc).first()
  let chap = heading-number((ch,), ct-appendix.at(loc))
  let n = counter(figure.where(kind: kind)).at(loc).first()
  link(figure-loc(loc, kind), text(fill: colors.main)[#chap.#n#letter])
}

#let gls(key, plural: false) = {
  if key not in glossary { return text(fill: red)[?#key] }
  let e = glossary.at(key)
  let short = if plural { e.short + "s" } else { e.short }
  let c = counter("gls:" + key)
  // First use expands to the long form, as \newacronym's long-short style.
  link(label("gls:" + key), context if c.get().first() == 0 {
    emph(if plural { e.long + "s" } else { e.long }) + " (" + short + ")"
  } else { short })
  c.step()
}

#let glspl(key) = gls(key, plural: true)

#let glsshort(key) = {
  if key not in glossary { return text(fill: red)[?#key] }
  link(label("gls:" + key), glossary.at(key).short)
}

// --- Front and back matter --------------------------------------------------

#let outline-line(prefix, body, page-num, offset: 0pt, numwidth: 0pt,
                  dots: true, bold: false, gap: 0pt) = block(
  above: gap, below: 0pt, width: 100%,
  {
    set text(weight: if bold { "bold" } else { "regular" })
    pad(left: offset, par(hanging-indent: numwidth, {
      box(width: numwidth, prefix)
      body
      h(0.6em)
      if dots { box(width: 1fr, repeat[#h(0.38em).#h(0.38em)]) } else { h(1fr) }
      h(0.6em)
      box(width: 1.6em, align(right, page-num))
    }))
  },
)

#let toc(depth: 3) = {
  unnumbered-chapter[#strings.contents]
  show outline.entry: it => context {
    let lvl = calc.min(it.level, toc-numwidths.len())
    let loc = it.element.location()
    if is-part(it.element) {
      return text(font: font-sans-lm, size: 12pt, link(loc, outline-line(
        numbering("I", part-index(loc)), it.body(), it.page(),
        numwidth: 8mm, dots: false, bold: true, gap: 2.0 * leading-unit,
      )))
    }
    let nums = counter(heading).at(loc)
    let prefix = if it.element.numbering == none { it.prefix() } else {
      heading-number(nums, ct-appendix.at(loc))
    }
    link(loc, outline-line(
      prefix, it.body(), it.page(),
      offset: toc-numwidths.slice(0, lvl - 1).sum(default: 0pt),
      numwidth: toc-numwidths.at(lvl - 1),
      dots: it.level != 1,
      bold: it.level == 1,
      gap: toc-gaps.at(lvl - 1) * leading-unit,
    ))
  }
  outline(title: none, depth: depth)
}

#let float-list(title, kind) = {
  unnumbered-chapter(outlined: true)[#title]
  show outline.entry: it => context {
    let loc = it.element.location()
    let ch = heading-number((counter(heading).at(loc).first(),), ct-appendix.at(loc))
    // Counters reset per chapter, so n == 1 marks a new chapter.
    let n = counter(figure.where(kind: kind)).at(loc).first()
    let gap = (if n == 1 { 1.31 } else { 0.52 }) * leading-unit
    let dest = figure-loc(loc, kind)
    link(dest, outline-line([#ch.#n], it.body(), [#counter(page).at(dest).first()],
                            numwidth: toc-numwidths.at(1), gap: gap))
  }
  outline(title: none, target: figure.where(kind: kind))
}

#let glossary-list(title: strings.glossary) = {
  unnumbered-chapter(outlined: true)[#title]
  let keys = glossary.keys().sorted(key: k => upper(glossary.at(k).short))
  let prev = none
  for k in keys {
    let e = glossary.at(k)
    let letter = upper(e.short.slice(0, 1))
    if prev != none and letter != prev { v(1.0em) }
    prev = letter
    [#block(above: 0.75em, below: 0pt, width: 100%,
      text(font: font-sans, weight: "bold", fill: colors.main.lighten(15%), e.short)
        + h(0.6em) + emph(e.long))#label("gls:" + k)]
  }
}

#let list-of-figures() = float-list(strings.figures, image)

#let list-of-tables() = float-list(strings.tables, table)

#let list-of-listings() = float-list(strings.listings, "listing")

// --- Bibliography -----------------------------------------------------------

// bib/alphanumeric.csl brackets two values; these pick them back out.
#let label-marker = regex("\u{27ea}[^\u{27eb}]+\u{27eb}")
#let cite-marker = regex("\u{27e6}[^\u{27e7}]+\u{27e7}")

#let marker-text(m) = m.text.trim(regex("[\u{27e6}-\u{27eb}]"))

// Webpages list: same style plus biblatex's "@" label prefix.
#let web-csl = bytes(read("bib/alphanumeric.csl").replace(
  "<text variable=\"citation-label\"/>",
  "<text value=\"@\"/><text variable=\"citation-label\"/>",
))

#let cit-pages(hits) = {
  let loc-of = (:)
  for (pg, loc) in hits { if str(pg) not in loc-of { loc-of.insert(str(pg), loc) } }

  let runs = ()
  for pg in loc-of.keys().map(int).sorted() {
    if runs != () and runs.last().last() + 1 == pg {
      runs.at(-1).push(pg)
    } else {
      runs.push((pg,))
    }
  }

  let page-link(pg) = link(loc-of.at(str(pg)), str(pg))
  // french.lbx: "pages" is p., invariable.
  [(cf. p. #runs.map(r => if r.len() == 1 { page-link(r.first()) } else {
    page-link(r.first()) + [–] + page-link(r.last())
  }).join(", "))]
}

// Typst pins the CSL hanging indent to 1.5em, so the block shifts to widen it
// to `indent` — the label column, which the label is then drawn back into.
#let bib-hang = 1.5em

#let bib-entries(indent, body) = pad(left: indent - bib-hang, {
  show bibliography: it => {
    set par(leading: 0.55em, spacing: 1.05 * leading-unit)
    show link: set text(font: font-mono)
    show regex("url:"): text(size: 0.8em)[URL] + ":"
    show label-marker: m => box(width: bib-hang,
      move(dx: bib-hang - indent, text(fill: colors.main, marker-text(m))))
    show cite-marker: m => context cit-pages(
      query(cite).filter(c => str(c.key) == marker-text(m))
        .map(c => (counter(page).at(c.location()).first(), c.location())))
    it
  }
  body
})

#let thesis-bibliography(path, web: none, indent: 18mm, web-indent: 22mm) = {
  unnumbered-chapter(outlined: true)[#strings.bibliography]
  set text(size: sz.small)
  bib-entries(indent, bibliography(path, title: none, style: "bib/alphanumeric.csl"))
  if web != none {
    unnumbered-section[#strings.webpages]
    bib-entries(web-indent, bibliography(web, title: none, style: web-csl))
  }
}

// --- Title and copyright pages ----------------------------------------------

#let jury-member(m) = grid(
  columns: (1fr, auto), column-gutter: 1em,
  { h(1.5em); strong[#m.first #smallcaps(m.last)]
    if m.position != "" [, #m.position]
    [, #m.affiliation] },
  emph(m.role),
)

#let jury-page(meta) = page(
  margin: (left: 2.8cm, right: 2.5cm, top: 2cm, bottom: 2cm),
  footer: none,
  {
    set par(justify: false, spacing: 0.55em)
    for (i, logo) in meta.logos.enumerate() {
      if i > 0 { h(1fr) }
      box(image(logo, height: 1.7cm))
    }
    v(1fr)

    align(center, {
      text(size: sz.large)[Thèse présentée pour l'obtention du grade de]
      v(1em)
      text(size: sz.LARGE, meta.degree)
      v(2em)
      text(size: sz.small)[Spécialité]
      v(0.5em)
      text(size: sz.Large, meta.speciality)
      v(2em)
      text(size: sz.large)[École doctorale]
      v(0.5em)
      text(size: sz.Large, meta.doctoral-school)
    })
    v(1fr)

    align(right, {
      text(size: sz.LARGE, meta.title)
      parbreak()
      line(length: 100%, stroke: 0.4pt)
      parbreak()
      text(size: sz.Large, meta.author)
    })
    v(1fr)

    [Soutenue publiquement le : #text(size: sz.large, emph(meta.defense-date))]
    v(1em)
    [Devant un jury composé de :]
    v(0.3em)
    for m in meta.jury { jury-member(m) }
  },
)

#let copyright-page(meta) = {
  set align(right)
  emph(meta.dedication)
  v(1fr)
  set align(left)
  grid(
    columns: (0.25 * text-width, 1fr), column-gutter: 1em, align: top,
    image("gfx/thesis-copyright.png", width: 100%),
    {
      strong[Copyright:]
      linebreak()
      [Except where otherwise noted, this work is licensed under]
      linebreak()
      strong(meta.license)
    },
  )
}
