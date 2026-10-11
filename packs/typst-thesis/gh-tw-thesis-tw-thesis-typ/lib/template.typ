#import "util.typ": fill, month-name, pad2, roc-year, spread, strip-footnotes

#let thesis(cfg, body) = {
  let l = cfg.layout
  let hd = l.heading
  let s = cfg.strings
  let cr = cfg.cross-ref
  let roc = y => roc-year(y, offset: s.era-offset)
  let sp = t => spread(t, gap: l.title-spread)

  // set by `just release`
  let watermark = sys.inputs.at("watermark", default: "false") == "true"

  // --- Global Settings ---
  set page(paper: l.paper, margin: l.margin)

  // pin the line box to 1em, so line advance is exactly line-height x font size,
  // which is what 行高 means; typst's own edges move with the font
  set text(
    // font-latin may be one family or a list, tried in order
    font: (if type(l.font-latin) == array { l.font-latin } else { (l.font-latin,) }) + l.font-cjk,
    size: l.font-size,
    lang: if l.language == "chinese" { "zh" } else { "en" },
    region: if l.language == "chinese" { "TW" } else { "US" }, // 圖/表, not 图/表
    top-edge: l.line-box.top,
    bottom-edge: l.line-box.bottom,
  )

  // `all: true` also indents the paragraph right after a heading; without it
  // typst skips that one, which is the usual convention
  let indent = if l.first-line-indent-all {
    (amount: l.first-line-indent, all: true)
  } else {
    l.first-line-indent
  }
  set par(
    justify: l.justify,
    leading: (l.line-height - 1) * 1em,
    spacing: l.par-spacing,
    first-line-indent: indent,
  )

  set footnote(numbering: l.footnote-numbering)

  // Caption positions follow the merged school and thesis settings.
  show figure.where(kind: image): set figure.caption(position: l.caption-position.image)
  show figure.where(kind: table): set figure.caption(position: l.caption-position.table)
  show figure.where(kind: "code"): set figure.caption(position: l.caption-position.code)
  show figure.where(kind: table): set block(breakable: true)
  // A figure breaks Typst's run of paragraphs; a zero-height paragraph keeps
  // the following body paragraph indented without changing heading behavior.
  show figure: it => {
    it
    ""
    context v(-par.spacing - measure("").height)
  }

  show cite: set text(fill: cfg.bibliography.color)
  show ref: set text(fill: cfg.bibliography.color)

  // --- Headings ---
  show heading: set par(
    leading: (hd.line-height - 1) * 1em,
    first-line-indent: 0em,
  )

  // appendices set their own pattern ("A.1", "B.1", ...), which starts with a
  // letter; the body's pattern ("1.1") starts with a digit and is numbered
  // 第一章 / 第一節 instead
  let is-appendix = n => (
    type(n) == str and n.len() > 0 and not "0123456789".contains(n.first())
  )

  // Dot-separated C/S/B is a compact preset; braces also work in prose.
  let cross-ref-format = (template, nums) => {
    let tokens = template.split(".")
    let pattern = if tokens.all(token => token in ("C", "S", "B")) {
      tokens.map(token => "{" + token + "}").join(".")
    } else { template }
    fill(pattern, (
      C: numbering(cr.numbering, nums.at(0)),
      S: if nums.len() > 1 { numbering(cr.numbering, nums.at(1)) } else { "" },
      B: if nums.len() > 2 { numbering(cr.numbering, nums.at(2)) } else { "" },
    ))
  }

  show ref: it => {
    let el = it.element
    if it.form != "normal" or it.supplement != auto or el == none or el.func() != heading or el.numbering == none or el.level > 3 {
      return it
    }
    let nums = counter(heading).at(el.location())
    let label = if is-appendix(el.numbering) {
      let num = numbering(el.numbering, ..nums.slice(0, el.level))
      s.appendix.at(0) + num + s.appendix.at(1)
    } else {
      let template = (cr.chapter, cr.section, cr.subsection).at(el.level - 1)
      cross-ref-format(template, nums)
    }
    link(el.location(), label)
  }

  let appendix-number(it, level) = {
    let nums = counter(heading).at(it.location()).slice(0, level + 1)
    let n = numbering(it.numbering, ..nums)
    if level == 0 { s.appendix.at(0) + n + s.appendix.at(1) } else { n }
  }

  // `sticky` keeps the heading on the same page as what follows it -- without
  // it, a heading can end up alone at the bottom of a page with its content
  // pushed to the next one
  let numbered(it, level, zh, en) = block(width: 100%, above: 0pt, below: 0pt, sticky: true, {
    set align(hd.align.at(level))
    set text(size: hd.size.at(level), weight: hd.weight)
    v(hd.gap-above.at(level))
    if it.numbering != none {
      if is-appendix(it.numbering) {
        appendix-number(it, level)
      } else {
        let n = counter(heading).at(it.location()).at(level)
        if l.language == "chinese" { zh(n) } else { en(n) }
      }
      h(hd.number-gap.at(level))
    }
    it.body
    v(hd.gap-below.at(level))
  })

  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    if l.footnote-per-chapter { counter(footnote).update(0) }
    if l.equation-per-chapter { counter(math.equation).update(0) }
    numbered(
      it,
      0,
      n => s.chapter.at(0) + numbering("一", n) + s.chapter.at(1),
      n => s.chapter-en + " " + numbering("1", n),
    )
  }

  show heading.where(level: 2): it => numbered(
    it,
    1,
    n => s.section.at(0) + numbering("一", n) + s.section.at(1),
    n => s.section-en + " " + numbering("1", n),
  )

  show heading.where(level: 3): it => numbered(
    it,
    2,
    n => numbering("一", n) + s.subsection,
    n => numbering("1", n) + s.subsection,
  )

  show heading.where(level: 4): it => block(width: 100%, above: 0pt, below: 0pt, sticky: true, {
    set align(hd.align.at(3))
    set text(size: hd.size.at(3), weight: hd.weight)
    v(hd.gap-above.at(3))
    it.body
    v(hd.gap-below.at(3))
  })

  // --- Cover Page ---
  let cv = cfg.cover
  page(margin: cv.margin)[
    #set align(center)
    #set text(size: cv.size.org, weight: cv.weight.org)
    #cfg.university#cfg.college#cfg.institute \
    #cfg.degree#cfg.type \

    #v(cv.gap)
    #set text(size: cv.size.org-en, weight: cv.weight.org-en)
    #cfg.institute-en \
    #cfg.college-en \

    #v(cv.gap)
    #set text(size: cv.size.university-en, weight: cv.weight.university-en)
    #cfg.university-en \
    #cfg.degree-en #cfg.type-en \

    #v(cv.flex)
    #text(size: cv.size.title, weight: cv.weight.title)[#cfg.title] \
    #text(size: cv.size.title-en, weight: cv.weight.title-en)[#cfg.title-en] \

    #v(cv.flex)
    #set text(size: cv.size.author, weight: cv.weight.author)
    #cfg.author \
    #cfg.author-en \

    #v(cv.flex)
    #set text(size: cv.size.advisor, weight: cv.weight.advisor)
    #fill(cv.advisor-zh, (
      label: s.advisor-label, advisor: cfg.advisor, doctor: s.doctor,
    )) \
    #fill(cv.advisor-en, (
      label: s.advisor-label-en, advisor: cfg.advisor-en, doctor: s.doctor-en,
    )) \

    #v(cv.flex)
    #set text(size: cv.size.date, weight: cv.weight.date)
    #fill(cv.date-zh, (
      era: s.era,
      roc: roc(cfg.date.year),
      year-unit: s.year-unit,
      month: pad2(cfg.date.month),
      month-unit: s.month-unit,
    )) \
    #fill(cv.date-en, (
      month-name: month-name(cfg.date.month, s.months),
      year: cfg.date.year,
    ))
  ]

  // --- Verification Letter ---
  let vf = cfg.verification
  let vg = vf.grid
  let rule-pair = grid(
    columns: (1fr, 1fr),
    column-gutter: vg.gutter,
    line(length: vg.rule-pair), line(length: vg.rule-pair),
  )
  pagebreak(weak: true)
  set page(margin: l.margin)
  [
    #set align(center)
    #set text(size: vf.size.university, weight: vf.weight.university)
    #fill(vf.degree-line, (
      university: cfg.university, institute: cfg.institute, degree: cfg.degree, type: cfg.type,
    )) \
    #set text(size: vf.size.title, weight: vf.weight.title)
    #sp(vf.title) \

    #v(vf.flex)
    #set text(size: vf.size.thesis-title, weight: vf.weight.thesis-title)
    #cfg.title \
    #cfg.title-en \

    #v(vf.flex)
    #set align(left)
    #set text(size: vf.size.body, weight: vf.weight.body)
    #set par(justify: l.justify, first-line-indent: l.first-line-indent)
    #fill(vf.statement, (
      author: cfg.author,
      id: cfg.id,
      university: cfg.university,
      institute: cfg.institute,
      degree: cfg.degree,
      type: cfg.type,
      roc: roc(cfg.oral-date.year),
      month: pad2(cfg.oral-date.month),
      day: pad2(cfg.oral-date.day),
    ))

    #v(vf.flex)
    #set align(center)
    #grid(
      columns: vg.columns,
      rows: vg.rows,
      align: (right + bottom, center + bottom),
      [#s.committee], [#line(length: vg.rule)],
      [], [#set align(center + horizon); #s.committee-advisor],
      [], rule-pair,
      [], rule-pair,
      [#s.director],
      [
        #h(vg.director-indent)
        #move(
          dx: vg.director-offset.at(0),
          dy: vg.director-offset.at(1),
          line(length: vg.rule-pair),
        )
      ],
    )
    #v(vf.flex-end)
  ]

  // --- TOC, LOF, LOT ---
  let o = cfg.outline
  let pn = cfg.page-number
  // Keep page.numbering for outline entries; decorate only the header/footer.
  let page-label = context {
    if page.numbering != none and pn.format != "" {
      align(pn.align, fill(pn.format, (
        page: numbering(page.numbering, ..counter(page).get()),
      )))
    }
  }
  pagebreak(weak: true)
  set page(
    numbering: o.page-numbering,
    header: if pn.position == "top" { page-label } else { [] },
    footer: if pn.position == "bottom" { page-label } else { [] },
  )
  counter(page).update(1)

  // entries carry the same 第一章 / 第一節 label as the heading itself, not the
  // raw "1.1" the numbering pattern would give
  show outline.entry: it => {
    let el = it.element

    // rebuilding an entry drops the link typst puts on the default one
    let linked = body => link(el.location(), body)

    // a figure caption may carry a footnote; keep it out of the list of figures
    if el.func() == figure {
      let clean = strip-footnotes(el.caption.body)
      return linked(it.indented(
        it.prefix(),
        clean + h(0.3em) + box(width: 1fr, it.fill) + h(0.3em) + it.page(),
      ))
    }
    let prefix = if el.func() == heading and el.numbering != none {
      let n = counter(heading).at(el.location())
      if is-appendix(el.numbering) {
        let num = numbering(el.numbering, ..n.slice(0, it.level))
        if it.level == 1 { s.appendix.at(0) + num + s.appendix.at(1) } else { num }
      } else if l.language != "chinese" {
        it.prefix()
      } else if it.level == 1 {
        s.chapter.at(0) + numbering("一", n.at(0)) + s.chapter.at(1)
      } else if it.level == 2 {
        s.section.at(0) + numbering("一", n.at(1)) + s.section.at(1)
      } else {
        numbering("一", n.at(it.level - 1)) + s.subsection
      }
    } else { it.prefix() }

    let entry = linked(it.indented(prefix, it.inner(), gap: hd.number-gap.at(it.level - 1)))
    if it.level == 1 {
      v(o.entry-gap, weak: true)
      if o.entry-bold { strong(entry) } else { entry }
    } else { entry }
  }

  outline(title: text(size: o.title-size)[#sp(cfg.titles.toc)], depth: o.depth, indent: o.indent)
  pagebreak(weak: true)
  outline(title: text(size: o.title-size)[#sp(cfg.titles.lof)], target: figure.where(kind: image))
  pagebreak(weak: true)
  outline(title: text(size: o.title-size)[#sp(cfg.titles.lot)], target: figure.where(kind: table))

  // --- Main Matter ---
  set page(
    numbering: o.body-numbering,
    background: if watermark and cfg.watermark.image != none {
      place(center + horizon, image(cfg.watermark.image, width: cfg.watermark.width))
      // the image itself carries no alpha, so wash it out with a white veil
      if cfg.watermark.opacity < 100% {
        place(rect(width: 100%, height: 100%, fill: white.transparentize(cfg.watermark.opacity)))
      }
    },
  )
  counter(page).update(1)

  body
}
