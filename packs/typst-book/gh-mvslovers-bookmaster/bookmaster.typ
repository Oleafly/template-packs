// bookmaster.typ -- a BookMaster / SCRIPT/VS look for the mvslovers manuals.
//
// Style only: Times body, Helvetica headings, a heavy rule over each chapter
// title and a hairline over each section, figures framed by rules with the
// caption below, running footers carrying the chapter title and a bold folio,
// "Figure n on page p" cross-references, and a generated index.

// IBM Plex (SIL Open Font License), shipped in fonts/ and passed with
// --font-path, so a build on any host sets the same pages.
#let body-font = ("IBM Plex Serif",)
// HTML export (typst --features html, or bundle): every element below has a
// second, semantic form for the web, chosen by target(); the PDF form is the
// unchanged first branch.
#let _web() = target() == "html"
// A web site, one page per part: typst compile --features html,bundle
// --format bundle --input bm-bundle=1.  Decided without context, because in
// a bundle nothing but documents may stand at the top level.
#let _bundle = "bm-bundle" in sys.inputs

// part(file, body): one page of the web site; in the PDF and in a single
// HTML file the body as it is.
#let part(file, title: none, body) = if _bundle {
  document(file, title: title, {
    [#metadata("bm-style") <bm-style>]
    html.elem("div", attrs: (class: "bm-page"), {
      [#metadata("bm-side") <bm-side>]
      html.elem("main", {
        body
        [#metadata("bm-pager") <bm-pager>]
      })
    })
  })
} else { body }

// titlepage(): where the web site shows the title and the edition notice --
// the first part.  The PDF sets them on pages of their own and ignores this.
#let titlepage() = [#metadata("bm-titlepage") <bm-titlepage>]
#let head-font = ("IBM Plex Sans",)
#let mono-font = ("IBM Plex Mono",)

// ---------------------------------------------------------------- inline ---

// A command, keyword or option as it is typed: bold monospace.
// Both are boxed: a line must not break after the "--" of a long option.
#let cmd(x) = context if _web() { html.elem("code", attrs: (class: "cmd"), x) } else {
  box(text(font: mono-font, weight: "bold", size: 0.88em, hyphenate: false, x)) }
// A variable the reader supplies: italic monospace.
#let var(x) = context if _web() { html.elem("var", x) } else {
  box(text(font: mono-font, style: "italic", size: 0.88em, hyphenate: false, x)) }

// ----------------------------------------------------------------- index ---

// idx("term") or idx("term", "subterm"): marks the current page for the index.
#let idx(..t) = [#metadata(t.pos()) <bm-idx>]

#let _web-index() = context {
  let marks = query(<bm-idx>)
  let entries = (:)
  for m in marks {
    let key = m.value.join("\u{1F}")
    let hs = query(selector(heading).before(m.location()))
    let sec = if hs.len() > 0 { hs.last() } else { none }
    let have = entries.at(key, default: (terms: m.value, secs: ()))
    if sec != none and sec.location() not in have.secs.map(h => h.location()) { have.secs.push(sec) }
    entries.insert(key, have)
  }
  let keys = entries.keys().sorted(key: k => lower(k))
  html.elem("dl", attrs: (class: "index"), {
    for k in keys {
      let e = entries.at(k)
      html.elem("dt", e.terms.join(", "))
      html.elem("dd", e.secs.map(h => link(h.location(), h.body)).join([; ]))
    }
  })
}

#let make-index() = [#metadata("bm-index") <bm-index>] + context if _web() { _web-index() } else {
  let marks = query(<bm-idx>)
  let entries = (:)
  for m in marks {
    let key = m.value.join("\u{1F}")
    let p = counter(page).at(m.location()).first()
    let have = entries.at(key, default: (terms: m.value, pages: (), locs: ()))
    if p not in have.pages {
      have.pages.push(p)
      have.locs.push(m.location())
    }
    entries.insert(key, have)
  }
  let keys = entries.keys().sorted(key: k => lower(k))
  let letter = none
  set par(justify: false, spacing: 0pt, leading: 0.45em)
  columns(2, gutter: 0.35in)[
    #let parent = none
    #for k in keys {
      let e = entries.at(k)
      let first = upper(e.terms.first().codepoints().filter(c => c != "-").first())
      if first != letter {
        letter = first
        block(above: 1.1em, below: 0.6em, sticky: true,
          text(font: head-font, weight: "bold", size: 11pt, letter))
      }
      let folios = e.locs.zip(e.pages).map(((l, p)) => link(l, str(p))).join(", ")
      if e.terms.len() > 1 {
        // A subentry whose main entry has no page of its own still needs it.
        if parent != e.terms.first() {
          block(above: 0.35em, below: 0pt, e.terms.first())
        }
        parent = e.terms.first()
        block(above: 0.35em, below: 0pt, inset: (left: 2.2em), [#h(-1em)#e.terms.last()#h(0.6em)#folios])
      } else {
        parent = e.terms.first()
        block(above: 0.35em, below: 0pt, inset: (left: 1em), [#h(-1em)#e.terms.first()#h(0.6em)#folios])
      }
    }
  ]
}

// -------------------------------------------------------------- elements ---

// A note in the BookMaster form: "Note:" in bold, run in.
#let note(body) = context if _web() { html.elem("div", attrs: (class: "note"))[*Note:* #body] } else {
  block(above: 1em, below: 1em)[*Note:* #body] }

// A definition list: the term in a hanging column, bold monospace by default.
#let deflist(width: 1.25in, ..items) = context {
  let pairs = items.pos()
  if _web() {
    return html.elem("dl", {
      for i in range(0, pairs.len(), step: 2) {
        html.elem("dt", pairs.at(i))
        if i + 1 < pairs.len() { html.elem("dd", pairs.at(i + 1)) }
      }
    })
  }
  grid(
    columns: (width, 1fr),
    column-gutter: 0.15in,
    row-gutter: 0.9em,
    ..pairs
  )
}

// A framed screen or session: a light box, monospace, nothing reflowed.
#let screen(body) = context if _web() {
  html.elem("pre", attrs: (class: "screen"), body) } else { block(
  width: 100%, inset: (x: 10pt, y: 8pt), radius: 3pt, stroke: 0.6pt,
  { set par(justify: false); text(font: mono-font, size: 8pt, body) }) }

// A program source or listing: monospace, nothing reflowed, optionally with
// line numbers in a column of their own.
#let code(src, numbers: false, start: 1, size: 8pt) = context {
  if _web() {
    let lines = src.trim("\n", at: end).split("\n")
    let w = str(lines.len() + start - 1).len()
    let t = if numbers {
      lines.enumerate().map(((i, l)) => {
        let n = str(i + start)
        " " * (w - n.len()) + n + "  " + l
      }).join("\n")
    } else { lines.join("\n") }
    return html.elem("pre", attrs: (class: "code"), t)
  }
  set par(justify: false, leading: 0.42em, spacing: 0.42em)
  set text(font: mono-font, size: size)
  let lines = src.trim("\n", at: end).split("\n")
  if numbers {
    grid(columns: (2.6em, auto), column-gutter: 1em, row-gutter: 0.42em,
      ..lines.enumerate().map(((i, l)) => (align(right, str(i + start)), l)).flatten())
  } else {
    lines.join(linebreak())
  }
}

// A syntax diagram.  The diagram is written as text on a character grid with
// box-drawing characters; it is drawn with ruled lines, so the joints meet
// whatever the font.  A «word» is a variable and is set in italics.
#let _arms = (
  "─": (l: true, r: true), "│": (u: true, d: true),
  "┌": (d: true, r: true), "┐": (d: true, l: true),
  "└": (u: true, r: true), "┘": (u: true, l: true),
  "├": (u: true, d: true, r: true), "┤": (u: true, d: true, l: true),
  "┬": (l: true, r: true, d: true), "┴": (l: true, r: true, u: true),
  "┼": (l: true, r: true, u: true, d: true),
)
#let syntax(title: none, size: 8pt, framed: true, src) = context {
  let cw = size * 0.6
  let rh = size * 1.55
  let lw = 0.55pt
  // Split each row into cells of (char, italic).
  let rows = src.trim("\n", at: end).split("\n").map(l => {
    let cells = ()
    let it = false
    for c in l.clusters() {
      if c == "«" { it = true } else if c == "»" { it = false } else { cells.push((c, it)) }
    }
    cells
  })
  let ncol = calc.max(..rows.map(r => r.len()))
  let grid-box = box(width: ncol * cw, height: rows.len() * rh, {
    for (y, row) in rows.enumerate() {
      for (x, (c, ital)) in row.enumerate() {
        let x0 = x * cw
        let y0 = y * rh
        let cx = x0 + cw / 2
        let cy = y0 + rh / 2
        let seg(a, b) = place(top + left, line(start: a, end: b, stroke: lw))
        if c in _arms {
          let a = _arms.at(c)
          if a.at("l", default: false) { seg((x0, cy), (cx, cy)) }
          if a.at("r", default: false) { seg((cx, cy), (x0 + cw, cy)) }
          // A vertical arm is drawn only where the neighbouring cell takes
          // it up; a lone ├ or ┤ is a fragment bracket, drawn as a short tick.
          let at(yy) = if yy >= 0 and yy < rows.len() and x < rows.at(yy).len() { rows.at(yy).at(x).first() } else { " " }
          let up = a.at("u", default: false) and at(y - 1) in "│┌┐├┤┬┼▼"
          let dn = a.at("d", default: false) and at(y + 1) in "│└┘├┤┴┼▼"
          if up { seg((cx, y0), (cx, cy)) }
          if dn { seg((cx, cy), (cx, y0 + rh)) }
          if (c == "├" or c == "┤") and not up and not dn {
            seg((cx, cy - rh * 0.3), (cx, cy + rh * 0.3))
          }
        } else if c == "▼" {
          seg((cx, y0), (cx, y0 + rh))
          place(top + left, dx: cx - cw * 0.32, dy: y0 + rh * 0.62,
            polygon(fill: black, (0pt, 0pt), (cw * 0.64, 0pt), (cw * 0.32, rh * 0.38)))
        } else if c == "►" {
          seg((x0, cy), (x0 + cw, cy))
          place(top + left, dx: x0, dy: cy - rh * 0.17,
            polygon(fill: black, (0pt, 0pt), (cw * 0.8, rh * 0.17), (0pt, rh * 0.34)))
        } else if c == "◄" {
          seg((x0, cy), (x0 + cw * 0.2, cy))
          place(top + left, dx: x0 + cw * 0.2, dy: cy - rh * 0.17,
            polygon(fill: black, (cw * 0.8, 0pt), (0pt, rh * 0.17), (cw * 0.8, rh * 0.34)))
        } else if c != " " {
          place(top + left, dx: x0, dy: y0, box(width: cw, height: rh,
            align(center + horizon, text(size: size, style: if ital { "italic" } else { "normal" }, c))))
        }
      }
    }
  })
  if not framed { return context if _web() { html.frame({ set text(font: mono-font); grid-box }) } else {
    box(baseline: rows.len() * rh * 0.32, { set text(font: mono-font); grid-box }) } }
  if _web() {
    return html.elem("div", attrs: (class: "syntax"), {
      if title != none { html.elem("p", attrs: (class: "syntax-title"), strong(title)) }
      html.frame({ set text(font: mono-font); grid-box })
    })
  }
  block(width: 100%, inset: (x: 10pt, y: 9pt), stroke: 0.6pt, breakable: false, {
    set text(font: mono-font)
    if title != none {
      block(below: 0.5em, text(font: head-font, weight: "bold", size: 8.5pt, title))
    }
    grid-box
  })
}

// The stylesheet of the web form: the BookMaster look, approximately.
#let _web-css = read("web.css")

// ---------------------------------------------------------------- the book --

#let book(
  title: "",
  subtitle: "",
  short-title: "",
  // The web site's way back: the product whose landing page sits one level
  // above the book (../index.html), and the site that lists all products.
  product: "",
  home: "https://mvslovers.readthedocs.io/",
  number: "",
  date: "",
  authors: (),
  edition: [],
  body,
) = {
  set document(title: title + ": " + subtitle, author: authors)
  set text(font: body-font, size: 10pt, lang: "en", hyphenate: true)
  set par(justify: true, leading: 0.52em, spacing: 1.15em)

  // Running footers: odd pages carry the chapter title, even pages the book.
  let folio = context {
    let p = counter(page).get().first()
    let shown = counter(page).display()
    let chapters = query(heading.where(level: 1)).filter(
      h => h.location().page() <= here().page())
    let chap = if chapters.len() > 0 {
      let h = chapters.last()
      if h.numbering != none {
        [#numbering(h.numbering, ..counter(heading).at(h.location()))#h.body]
      } else { h.body }
    } else { [] }
    set text(font: head-font, size: 8.5pt)
    if calc.odd(here().page()) {
      align(right)[#chap#h(1.2em)#text(weight: "bold", size: 11pt, shown)]
    } else {
      align(left)[#text(weight: "bold", size: 11pt, shown)#h(1.2em)#short-title]
    }
  }

  show: body => if _bundle { body } else { context if _web() { body } else {
    set page(
      paper: "us-letter",
      margin: (inside: 1in, outside: 1in, top: 0.9in, bottom: 1.05in),
      footer: folio,
      footer-descent: 40%,
    )
    body
  } }

  // Raw text: monospace, a little smaller than the body.
  show raw: set text(font: mono-font, size: 0.85em, hyphenate: false)
  show raw.where(block: true): it => context if _web() { it } else { block(
    width: 100%, inset: (left: 1.2em, y: 0.2em), { set par(justify: false); it }) }

  set list(indent: 0.4em, body-indent: 0.7em, marker: ([•], [–]))
  set enum(indent: 0.4em, body-indent: 0.7em)

  // Headings.
  set heading(numbering: (..n) => if n.pos().len() == 1 { "Chapter " + str(n.pos().first()) + ". " })
  show heading: set text(font: head-font, weight: "regular", hyphenate: false)
  show heading.where(level: 1): it => context if _web() { it } else {
    pagebreak(to: "odd", weak: true)
    v(0.55in)
    block(below: 2.2em, {
      // The heavy rule spans the title, as BookMaster's head level 1 does.
      let t = if it.numbering != none { [#counter(heading).display(it.numbering)#it.body] } else { it.body }
      context {
        let w = measure(text(font: head-font, size: 22pt, t)).width
        block(below: 0.35em, line(length: calc.min(w, 6.5in), stroke: 4pt))
      }
      text(font: head-font, size: 22pt, t)
    })
  }
  show heading.where(level: 2): it => context if _web() { it } else { block(above: 2em, below: 1.1em, sticky: true, {
    line(length: 100%, stroke: 0.6pt)
    v(-0.35em)
    text(size: 15pt, weight: "bold", it.body)
  }) }
  show heading.where(level: 3): it => context if _web() { it } else { block(above: 1.6em, below: 0.9em, sticky: true,
    text(size: 11.5pt, weight: "bold", it.body)) }
  show heading.where(level: 4): it => context if _web() { it } else { block(above: 1.3em, below: 0.8em, sticky: true,
    text(font: body-font, size: 10.5pt, weight: "bold", it.body)) }

  // Figures: a rule above and below, caption under it; tables carry theirs on top.
  set figure(gap: 0.7em)
  // A figure may run onto the next page, as a long listing must; the
  // caption stays with its closing rule.
  show figure.where(kind: "fig"): set block(breakable: true)
  show figure.where(kind: "fig"): it => context if _web() { it } else { block(above: 1.4em, below: 1.4em, breakable: true, {
    line(length: 100%, stroke: 0.6pt)
    v(0.4em)
    align(left, it.body)
    v(0.3em)
    line(length: 100%, stroke: 0.6pt)
    v(0.2em)
    align(center, it.caption)
  }) }
  // A table may run onto the next page; a long one would otherwise leave
  // half a page empty.
  show figure.where(kind: table): set block(breakable: true)
  show figure.where(kind: table): it => context if _web() { it } else { block(above: 1.4em, below: 1.4em, breakable: true, {
    block(sticky: true, width: 100%, align(left, it.caption))
    v(0.3em)
    it.body
  }) }
  show figure.caption: it => text(size: 9.5pt)[#it.supplement #context it.counter.display(it.numbering). #it.body]
  set table(stroke: (x, y) => (
    top: if y == 0 { 1.2pt } else if y == 1 { 0.9pt } else { 0.4pt },
    bottom: 1.2pt, left: none, right: none))
  show table.cell.where(y: 0): set text(font: head-font, weight: "bold", size: 9pt)
  show table: set par(justify: false)
  set table(inset: (x: 6pt, y: 5pt), align: left)

  // Cross-references in the BookMaster form.
  show ref: it => {
    let el = it.element
    if el == none { return it }
    let p = counter(page).at(el.location()).first()
    // BookMaster leaves out "on page n" when the target is on this page.
    let on = if _web() or el.location().page() == here().page() { [] } else { [ on page #p] }
    if el.func() == figure {
      let n = el.counter.at(el.location()).first()
      link(el.location())[#el.supplement #n#on]
    } else if el.func() == heading {
      if el.level == 1 and el.numbering != none {
        // "Chapter 3" or "Appendix A": the heading's own number, less ". ".
        let n = numbering(el.numbering, ..counter(heading).at(el.location())).trim(". ", at: end)
        link(el.location())[#n, “#el.body”#on]
      } else {
        link(el.location())[“#el.body”#on]
      }
    } else { it }
  }

  // Contents: spaced dot leaders, chapters set off.
  show outline.entry: it => context if _web() {
    let el = it.element
    let t = if el.func() == figure { el.caption.body } else { el.body }
    link(el.location(), it.indented(it.prefix(), t))
  } else { it }
  // A grid has no HTML form: its cells follow one another, side by side
  // where the stylesheet has room.
  show grid: it => context if _web() {
    html.elem("div", attrs: (class: "grid"), it.children.map(c => html.elem("div", c.body)).join())
  } else { it }
  set outline.entry(fill: box(width: 1fr, repeat(gap: 0.45em)[.]))
  show outline.entry.where(level: 1): it => context if _web() { it } else {
    if it.element.func() == heading { block(above: 1.1em, strong(it)) }
    else { block(above: 0.5em, link(it.element.location(),
      it.indented([#it.element.counter.at(it.element.location()).first().], it.inner(), gap: 0.6em))) }
  }

  // ---------------------------------------------------------- title page --
  let web-title() = {
    html.elem("header", attrs: (class: "titlepage"), {
      html.elem("h1", attrs: (class: "title"), [#title #linebreak() #subtitle])
      html.elem("p", [Document Number #number])
      html.elem("p", date)
      html.elem("p", authors.join(", "))
    })
    html.elem("section", attrs: (class: "edition"), edition)
  }
  // Every page of a web site carries the stylesheet; a single file once.
  show <bm-titlepage>: it => if _bundle { web-title() } else { none }
  // The frame of each page of a web site: the bar on top, the contents on
  // the left with the current chapter opened, the way on at the bottom.
  let web-num(h) = if h.numbering == none { [] } else {
    numbering(h.numbering, ..counter(heading).at(h.location())).replace("Chapter ", "").replace("Appendix ", "").trim(". ", at: end)
  }
  let web-chapters() = query(heading.where(level: 1, outlined: true))
  let web-current() = {
    let next = query(heading.where(level: 1).after(here()))
    if next.len() > 0 { next.first() } else { none }
  }
  show <bm-style>: it => {
    html.elem("link", attrs: (rel: "stylesheet", href: "bookmaster.css"))
    html.elem("header", attrs: (class: "bm-top"), {
      html.elem("nav", attrs: (class: "bm-crumbs", aria-label: "Breadcrumb"), {
        if home != "" {
          html.elem("a", attrs: (href: home), [mvslovers])
          html.elem("span", attrs: (class: "sep"), [›])
        }
        if product != "" {
          html.elem("a", attrs: (href: "../index.html"), product)
          html.elem("span", attrs: (class: "sep"), [›])
          link(<bm-titlepage>, subtitle)
        } else {
          link(<bm-titlepage>, short-title)
        }
      })
      html.elem("span", attrs: (class: "num"), number)
    })
  }
  show <bm-side>: it => context {
    let chs = web-chapters()
    let cur = web-current()
    html.elem("nav", attrs: (class: "bm-side"), html.elem("ul", {
      for (i, c) in chs.enumerate() {
        let is-cur = cur != none and c.location() == cur.location()
        html.elem("li", attrs: if is-cur { (class: "cur") } else { (:) }, {
          link(c.location(), [#html.elem("span", attrs: (class: "num"), web-num(c))#c.body])
          if is-cur {
            let stop = if i + 1 < chs.len() { chs.at(i + 1).location() } else { none }
            let secs = query(heading.where(level: 2).after(c.location()))
            let secs = if stop == none { secs } else { secs.filter(h => query(heading.where(level: 2).before(stop)).map(x => x.location()).contains(h.location())) }
            if secs.len() > 0 {
              html.elem("ul", for s in secs { html.elem("li", link(s.location(), s.body)) })
            }
          }
        })
      }
    }))
  }
  show <bm-pager>: it => context {
    let chs = web-chapters()
    let cur = web-current()
    if cur == none { return }
    let i = chs.position(c => c.location() == cur.location())
    if i == none { return }
    html.elem("nav", attrs: (class: "bm-pager"), {
      if i > 0 { let c = chs.at(i - 1); link(c.location(), [#html.elem("small", [Previous])#c.body]) } else { html.elem("span") }
      if i + 1 < chs.len() { let c = chs.at(i + 1); link(c.location(), [#html.elem("small", [Next])#c.body]) }
    })
  }
  if _bundle {
    for f in ("IBMPlexSerif-Regular", "IBMPlexSerif-Italic", "IBMPlexSerif-Bold",
              "IBMPlexSans-Regular", "IBMPlexSans-Bold",
              "IBMPlexMono-Regular", "IBMPlexMono-Italic", "IBMPlexMono-Bold") {
      asset("fonts/" + f + ".ttf", read("fonts/" + f + ".ttf", encoding: none))
    }
    asset("bookmaster.css", read("web.css", encoding: none))
  }
  if not _bundle { context if _web() {
    html.elem("style", _web-css)
    web-title()
  } else {
  page(footer: none, {
    v(1.4in)
    align(right, {
      text(font: head-font, weight: "bold", size: 21pt, title)
      linebreak()
      text(font: head-font, weight: "bold", size: 21pt, subtitle)
      v(0.8in)
      set text(font: head-font, size: 10.5pt)
      [Document Number #number]
      v(0.35in)
      date
      v(0.35in)
      authors.join(linebreak())
    })
  })

  // ------------------------------------------------------ edition notice --
  page(footer: none, {
    v(1fr)
    set text(size: 9.5pt)
    edition
  })
  } }

  show: body => if _bundle { body } else { context if _web() { body } else {
    counter(page).update(1)
    set page(numbering: "i")
    body
  } }
  body
}

// The switch from front matter to the body: arabic folios from 1.
#let mainmatter() = context if not _web() {
  pagebreak(to: "odd", weak: true)
  counter(page).update(1)
}

#let contents(depth: 3) = {
  heading(numbering: none, outlined: false)[Contents]
  outline(title: none, depth: depth, indent: n => (0em, 6.2em, 7.4em).at(calc.min(n, 2)), target: heading.where(outlined: true))
}

// The appendices: #show: appendices before the first one numbers the
// chapters that follow "Appendix A.", "Appendix B." ...
#let appendices(body) = {
  counter(heading).update(0)
  set heading(numbering: (..n) => if n.pos().len() == 1 {
    "Appendix " + numbering("A", n.pos().first()) + ". " })
  body
}

#let figures() = {
  heading(numbering: none, outlined: true)[Figures]
  outline(title: none, target: figure.where(kind: "fig"))
  context if not _web() { v(1em) }
  heading(level: 2, numbering: none, outlined: false)[Tables]
  outline(title: none, target: figure.where(kind: table))
}

// fig(caption, body) and tab(caption, body): BookMaster figures and tables.
#let fig(caption: [], body) = figure(body, caption: caption, kind: "fig", supplement: [Figure])
#let tab(caption: [], body) = figure(body, caption: caption, kind: table, supplement: [Table])
