// ─────────────────────────────────────────────────────────────────────────
//  folio — a personal-introduction template for Typst
//  Teal & ink · hard borders · classical book typography meets the terminal
// ─────────────────────────────────────────────────────────────────────────

#import "@preview/droplet:0.3.1": dropcap
#import "@preview/tiaoma:0.3.0"

// CJK font roles. Han characters fall back to these from the Latin fonts.
#let zh-song = ("Songti SC",)
#let zh-kai = ("Kaiti SC", "STKaiti")
#let zh-hei = ("PingFang SC",)

// Edit this dictionary to retheme the whole document.
#let theme = (
  teal: rgb("#0E6F6A"),
  teal-deep: rgb("#0A4643"),
  teal-pale: rgb("#DCEAE5"),
  ink: rgb("#141A19"),
  paper: rgb("#F7F4EC"),
  muted: rgb("#5D6A68"),
  serif: ("Hoefler Text", "Baskerville", "Libertinus Serif", ..zh-song, "Zapf Dingbats", "Apple Symbols"),
  display: ("Didot", "Bodoni 72", "Libertinus Serif", ..zh-song),
  mono: ("Menlo", "DejaVu Sans Mono", ..zh-hei, "Apple Symbols"),
  zh-song: zh-song,
  zh-kai: zh-kai,
  zh-hei: zh-hei,
  rule: 1.2pt, // weight of the hard borders
  shadow: 4pt, // offset of the solid teal drop shadow
  side: 5.2cm, // right margin, home of the marginalia
)

// ── primitives ───────────────────────────────────────────────────────────

#let mono(body, size: 7.5pt, fill: theme.ink, tracking: 0.04em, weight: "regular") = text(
  font: theme.mono,
  size: size,
  fill: fill,
  tracking: tracking,
  weight: weight,
  body,
)

// Small, letter-spaced, uppercase mono label.
#let label-text(body, fill: theme.teal, size: 6.8pt) = mono(upper(body), size: size, fill: fill, tracking: 0.16em)

// Width that reaches from the left text edge into the marginalia column.
#let wide-width = 100% + theme.side - 1.5cm
#let wide(body) = block(width: wide-width, body)

// Flatten content to a plain string (for slugs and file names).
#let plain(it) = {
  if type(it) == str { it } else if it == none { "" } else if it.has("text") { it.text } else if it.has("children") {
    it.children.map(plain).join()
  } else if it.has("body") { plain(it.body) } else if it == [ ] { " " } else { "" }
}
#let slug(it) = {
  let s = lower(plain(it)).replace(regex("[\\s\\p{P}]+"), "-").trim("-")
  if s == "" { "chapter" } else { s }
}

// A bordered block with a solid, un-blurred offset shadow.
#let hard(
  body,
  width: 100%,
  inset: 10pt,
  fill: theme.paper,
  stroke: theme.rule + theme.ink,
  shadow: theme.teal,
  offset: theme.shadow,
) = layout(size => {
  let w = if type(width) == ratio { width * size.width } else { width }
  let bw = w - offset
  let b = block(width: bw, fill: fill, stroke: stroke, inset: inset, breakable: false, body)
  let h = measure(b).height
  block(width: w, height: h + offset, breakable: false, {
    place(top + left, dx: offset, dy: offset, block(width: bw, height: h, fill: shadow))
    place(top + left, b)
  })
})

// Hatched stand-in for an image you have not added yet.
#let placeholder(label: "image", height: 5cm) = block(
  width: 100%,
  height: height,
  fill: tiling(size: (7pt, 7pt), line(start: (0pt, 7pt), end: (7pt, 0pt), stroke: 0.6pt + theme.teal-pale.darken(12%))),
  align(center + horizon, box(fill: theme.paper, stroke: 0.8pt + theme.ink, inset: (x: 6pt, y: 4pt), mono(
    "[ " + label + " ]",
  ))),
)

// ── Chinese typography ───────────────────────────────────────────────────

// A passage set in Chinese: lang/region for punctuation compression, Latin
// kept in Hoefler but CJK-ambiguous punctuation (“” ‘’ …) taken from Songti,
// two-character indent on every paragraph, and looser leading for Han text.
#let zh(body, indent: true) = {
  set text(
    lang: "zh",
    region: "cn",
    font: ((name: "Hoefler Text", covers: "latin-in-cjk"), "Baskerville", ..theme.zh-song),
  )
  set par(
    first-line-indent: if indent { (amount: 2em, all: true) } else { 0pt },
    leading: 0.95em,
    spacing: 1.1em,
    justify: true,
  )
  body
}

// Kaiti for quoted or emphasised Chinese (a gentler register than Songti).
#let kai(body) = text(font: theme.zh-kai, style: "normal", body)

// ── literary furniture ───────────────────────────────────────────────────

#let epigraph(body, by: none, source: none, width: 74%) = align(right, block(
  width: width,
  inset: (left: 12pt, y: 3pt),
  stroke: (left: 2pt + theme.teal),
  align(left, {
    set par(first-line-indent: 0pt, justify: false)
    text(style: "italic", size: 10.5pt, body)
    if by != none {
      v(5pt)
      align(right, {
        mono("— " + by, fill: theme.muted)
        if source != none { text(size: 9pt, fill: theme.muted)[, #emph(source)] }
      })
    }
  }),
))

// Opening paragraph of a chapter with a teal drop capital.
#let opening(body) = dropcap(height: 3, gap: 5pt, font: theme.display, fill: theme.teal, body)

// Larger italic stand-first.
#let lede(body) = {
  set par(first-line-indent: 0pt, justify: false, leading: 0.6em)
  text(size: 13.5pt, style: "italic", fill: theme.teal-deep, body)
}

#let pullquote(body, by: none) = block(
  width: 100%,
  above: 1.8em,
  below: 1.8em,
  stroke: (top: 2.5pt + theme.ink, bottom: 0.8pt + theme.ink),
  inset: (top: 14pt, bottom: 12pt),
  {
    set par(first-line-indent: 0pt, justify: false, leading: 0.55em)
    grid(
      columns: (auto, 1fr),
      column-gutter: 10pt,
      box(height: 26pt, text(font: theme.display, size: 58pt, fill: theme.teal, top-edge: "cap-height", "“")),
      {
        text(size: 16pt, style: "italic", body)
        if by != none {
          v(8pt)
          label-text(by, fill: theme.muted)
        }
      },
    )
  },
)

// Section break: ── ❦ ──
#let fleuron(glyph: "❦") = block(above: 1.6em, below: 1.6em, grid(
  columns: (1fr, auto, 1fr),
  column-gutter: 10pt,
  align: horizon,
  line(length: 100%, stroke: 0.5pt + theme.muted),
  text(fill: theme.teal, size: 13pt, glyph),
  line(length: 100%, stroke: 0.5pt + theme.muted),
))

// Numbered margin note, Tufte-style, anchored to the line it is called on.
#let sidenote-counter = counter("sidenote")
#let sidenote(body, numbered: true, dy: -0.75em) = {
  if numbered { sidenote-counter.step() }
  context {
    let n = str(sidenote-counter.get().first())
    let x = here().position().x
    let target = page.width - theme.side + 0.7cm
    if numbered { super(mono(n, fill: theme.teal, size: 7pt)) }
    box(width: 0pt, place(top + left, dx: target - x, dy: dy, block(width: theme.side - 1.9cm, {
      set par(justify: false, first-line-indent: 0pt, leading: 0.5em, spacing: 0.6em)
      set text(size: 7.8pt, fill: theme.muted)
      if numbered { mono(n, fill: theme.teal, weight: "bold") + h(4pt) }
      body
    })))
  }
}
#let marginnote(body, dy: -0.75em) = sidenote(body, numbered: false, dy: dy)

#let signoff(closing: [Yours, in good faith,], name: none, name-zh: none, place: none, date: none, note: none) = block(
  above: 2.4em,
  breakable: false,
  {
    set par(first-line-indent: 0pt)
    emph(closing)
    v(12pt)
    text(font: theme.display, size: 24pt, style: "italic", fill: theme.teal-deep, name)
    if name-zh != none {
      h(10pt)
      text(font: theme.zh-kai, size: 17pt, fill: theme.teal-deep, name-zh)
    }
    v(2pt)
    line(length: 5cm, stroke: 0.6pt + theme.ink)
    v(2pt)
    mono(
      "// " + (place, date, note).filter(x => x != none).join("  ·  "),
      fill: theme.muted,
    )
  },
)

// ── figures & media ──────────────────────────────────────────────────────

#let plate-counter = counter("plate")

// A framed figure, numbered "Plate I, II, …" as in old books.
#let plate(body, caption: none, credit: none) = {
  plate-counter.step()
  block(breakable: false, above: 1.6em, below: 1.6em, {
    hard(inset: 0pt, {
      set image(width: 100%)
      body
    })
    v(7pt)
    grid(
      columns: (auto, 1fr),
      column-gutter: 10pt,
      context label-text("Plate " + numbering("I", plate-counter.get().first())),
      {
        set par(first-line-indent: 0pt, justify: false, leading: 0.5em)
        text(size: 8.8pt, style: "italic", caption)
        if credit != none {
          h(6pt)
          mono(credit, fill: theme.muted, size: 6.8pt)
        }
      },
    )
  })
}

// Grid of small figures. Items: content, or (content, caption).
#let gallery(columns: 3, height: 3.4cm, ..items) = grid(
  columns: (1fr,) * columns,
  column-gutter: 12pt,
  row-gutter: 14pt,
  ..items
    .pos()
    .enumerate()
    .map(((i, item)) => {
      let (img, cap) = if type(item) == array { item } else { (item, none) }
      block(breakable: false, {
        block(width: 100%, height: height, stroke: theme.rule + theme.ink, clip: true, {
          set image(width: 100%, height: 100%, fit: "cover")
          img
        })
        v(4pt)
        set par(first-line-indent: 0pt, justify: false, leading: 0.45em)
        mono("FIG." + (if i < 9 { "0" } else { "" }) + str(i + 1), fill: theme.teal, size: 6.5pt)
        if cap != none {
          h(5pt)
          text(size: 8pt, style: "italic", cap)
        }
      })
    }),
)

// An image, or a hatched placeholder when none is given yet.
#let fill-image(img, label: "image") = {
  set image(width: 100%, height: 100%, fit: "cover")
  if img != none { img } else { placeholder(label: label, height: 100%) }
}

#let exhibit-counter = counter("exhibit")
#let fig-counter = counter("gallery-fig")

// A full-bleed hero image spanning text and marginalia, with an index card
// pinned to its corner.
//   featured(image("a.jpg"), title: [Night Market], meta: ("2025", "Kyoto", "35mm"))[Caption…]
#let featured(img, title: none, meta: (), height: 10cm, caption) = {
  exhibit-counter.step()
  block(above: 1.6em, below: 1.8em, breakable: false, wide({
    hard(inset: 0pt, {
      block(width: 100%, height: height, clip: true, fill-image(img, label: "featured image"))
      block(width: 100%, above: 0pt, stroke: (top: theme.rule + theme.ink), inset: (x: 12pt, y: 8pt), {
        set par(first-line-indent: 0pt, justify: false)
        grid(
          columns: (auto, 1fr),
          column-gutter: 12pt,
          align: horizon,
          context box(fill: theme.teal, inset: (x: 6pt, y: 3pt),
            label-text("Featured · No. " + numbering("I", exhibit-counter.get().first()), fill: theme.paper)),
          if title != none { text(font: theme.display, size: 17pt, title) },
        )
      })
    })
    v(8pt)
    grid(
      columns: (1fr, auto),
      column-gutter: 16pt,
      {
        set par(first-line-indent: 0pt, justify: false, leading: 0.55em)
        text(size: 9pt, style: "italic", caption)
      },
      if meta.len() > 0 { mono(meta.join("  ·  "), fill: theme.muted, size: 6.8pt) },
    )
  }))
}

// A contact sheet with mixed tile sizes. Each item is a dictionary:
//   (img: image("b.jpg"), caption: [Hutong, dusk], cols: 2, rows: 2)
// `img` may be none for a placeholder; cols/rows default to 1.
#let mosaic(columns: 4, row-height: 3.2cm, ..items) = block(above: 1.4em, below: 1.4em, breakable: false, wide(context {
  let base = fig-counter.get().first()
  fig-counter.update(n => n + items.pos().len())
  grid(
  columns: (1fr,) * columns,
  rows: row-height,
  gutter: 8pt,
  ..items.pos().enumerate().map(((i, it)) => {
    grid.cell(colspan: it.at("cols", default: 1), rowspan: it.at("rows", default: 1), block(
      width: 100%,
      height: 100%,
      stroke: theme.rule + theme.ink,
      clip: true,
      grid(
        rows: (1fr, auto),
        block(width: 100%, height: 100%, clip: true, fill-image(it.at("img", default: none), label: "image")),
        block(
          width: 100%,
          fill: theme.paper,
          stroke: (top: theme.rule + theme.ink),
          inset: (x: 6pt, y: 4pt),
          {
            set par(first-line-indent: 0pt, justify: false)
            mono(
              "FIG." + (if base + i + 1 < 10 { "0" } else { "" }) + str(base + i + 1),
              fill: theme.teal, size: 6.2pt, weight: "bold",
            )
            let cap = it.at("caption", default: none)
            if cap != none { h(5pt); text(size: 7.6pt, style: "italic", cap) }
          },
        ),
      ),
    ))
  }),
)}))

// A card that points to video / audio / anything online, with a QR code
// so the printed page still "plays".
#let media(body, kind: "video", title: none, url: none, duration: none) = {
  let glyph = (video: "▶", audio: "♫", link: "↗", repo: "⌥", talk: "◉", essay: "¶").at(kind, default: "↗")
  let shown = if url != none { url.replace(regex("^https?://"), "").trim("/") } else { "" }
  block(above: 1.4em, below: 1.4em, hard(inset: 0pt, grid(
    columns: if url != none { (1fr, 2.7cm) } else { (1fr,) },
    inset: (x, _) => if x == 0 { 12pt } else { 9pt },
    fill: (x, _) => if x == 1 { theme.teal-pale },
    stroke: (x, _) => if x == 1 { (left: theme.rule + theme.ink) },
    {
      set par(first-line-indent: 0pt, justify: false, leading: 0.55em)
      grid(
        columns: (auto, 1fr, auto),
        align: horizon,
        box(fill: theme.teal, inset: (x: 5pt, y: 3pt), mono(
          glyph + "  " + upper(kind),
          fill: theme.paper,
          size: 6.6pt,
          tracking: 0.16em,
        )),
        [],
        if duration != none { mono(duration, fill: theme.muted) },
      )
      v(7pt)
      text(font: theme.display, size: 16pt, title)
      v(4pt)
      text(size: 9pt, body)
      if url != none {
        v(6pt)
        link(url, mono(shown, fill: theme.teal, size: 7pt))
      }
    },
    ..if url != none {
      (
        align(center + horizon, {
          link(url, tiaoma.qrcode(url, width: 100%))
          v(3pt)
          label-text("scan", fill: theme.ink, size: 6pt)
        }),
      )
    },
  )))
}

// ── tech furniture ───────────────────────────────────────────────────────

// Terminal window. Lines are (command, output) pairs; output may be none.
#let terminal(title: "zsh — ~", ..lines) = block(above: 1.4em, below: 1.4em, hard(
  inset: 0pt,
  fill: theme.ink,
  {
    block(width: 100%, fill: theme.teal-deep, inset: (x: 9pt, y: 6pt), stroke: (bottom: theme.rule + theme.ink), grid(
      columns: (auto, 1fr),
      column-gutter: 10pt,
      align: horizon,
      text(size: 6pt, fill: theme.teal-pale, "■ ■ ■"), align(center, mono(title, fill: theme.teal-pale, size: 7pt)),
    ))
    block(width: 100%, inset: (x: 12pt, top: 10pt, bottom: 12pt), {
      set par(first-line-indent: 0pt, justify: false, leading: 0.55em, spacing: 0.55em)
      for (cmd, out) in lines.pos() {
        mono("❯ ", fill: rgb("#5FC4B8"), size: 8pt, weight: "bold")
        mono(cmd, fill: theme.paper, size: 8pt)
        if out != none {
          linebreak()
          mono(out, fill: rgb("#A7B8B5"), size: 8pt)
        }
        v(5pt)
      }
      mono("❯ ", fill: rgb("#5FC4B8"), size: 8pt, weight: "bold")
      box(width: 5pt, height: 9pt, fill: theme.teal-pale, baseline: 1.5pt)
    })
  },
))

// A key = value spec sheet, like a config file about yourself.
#let manifest(file: "profile.toml", ..pairs) = block(above: 1.4em, below: 1.4em, hard(inset: 0pt, {
  block(width: 100%, inset: (x: 10pt, y: 5pt), fill: theme.teal, mono(
    file,
    fill: theme.paper,
    size: 7pt,
    tracking: 0.08em,
  ))
  block(width: 100%, inset: (x: 12pt, y: 10pt), {
    set par(first-line-indent: 0pt, justify: false)
    grid(
      columns: (auto, auto, 1fr),
      column-gutter: 8pt,
      row-gutter: 7pt,
      ..pairs
        .named()
        .pairs()
        .map(((k, v)) => (
          mono(k, fill: theme.teal, size: 8pt, weight: "bold"),
          mono("=", fill: theme.muted, size: 8pt),
          text(size: 9.5pt, v),
        ))
        .flatten()
    )
  })
}))

// A row of figures: stats(("12", "years"), ("3", "languages"), …)
#let stats(..items) = block(above: 1.4em, below: 1.4em, hard(inset: 0pt, grid(
  columns: (1fr,) * items.pos().len(),
  inset: 11pt,
  stroke: (x, _) => if x > 0 { (left: theme.rule + theme.ink) },
  ..items
    .pos()
    .map(((value, label)) => {
      set par(first-line-indent: 0pt, justify: false)
      text(font: theme.display, size: 28pt, fill: theme.teal, value)
      linebreak()
      label-text(label, fill: theme.ink, size: 6.4pt)
    }),
)))

// Chronology: timeline(("2014", [Title], [Body]), …)
#let timeline(..entries) = block(above: 1.4em, below: 1.4em, grid(
  columns: (auto, 1fr),
  ..entries
    .pos()
    .map(((when, what, body)) => (
      block(inset: (top: 2pt, right: 10pt), mono(when, fill: theme.teal, size: 8pt, weight: "bold")),
      block(stroke: (left: theme.rule + theme.ink), inset: (left: 14pt, bottom: 13pt), width: 100%, {
        set par(first-line-indent: 0pt, justify: false, leading: 0.55em)
        place(top + left, dx: -14pt - 4pt, dy: 3pt, rect(
          width: 6.8pt,
          height: 6.8pt,
          fill: theme.teal,
          stroke: 1pt + theme.ink,
        ))
        text(font: theme.display, size: 13pt, what)
        parbreak()
        v(-4pt)
        text(size: 9.3pt, body)
      }),
    ))
    .flatten()
))

#let tag(t, filled: false) = box(
  stroke: 0.9pt + theme.ink,
  fill: if filled { theme.teal } else { none },
  inset: (x: 5pt, y: 3pt),
  outset: (y: 1pt),
  mono(t, size: 7pt, fill: if filled { theme.paper } else { theme.ink }),
)
#let tags(..items) = items.pos().enumerate().map(((i, t)) => tag(t, filled: i == 0)).join(h(4pt))

// ── CV features ──────────────────────────────────────────────────────────

// Contact / identity card: contact(email: "...", web: "...", github: "...")
#let contact(..fields) = {
  let icons = (email: "@", web: "↗", github: "⌥", phone: "☏", location: "⌖", linkedin: "in", orcid: "iD")
  let href(k, v) = if k == "email" { "mailto:" + v } else if k == "phone" { "tel:" + v.replace(" ", "") } else if (
    k == "github"
  ) { "https://github.com/" + v } else if k == "web" or k == "linkedin" or k == "orcid" {
    if v.starts-with("http") { v } else { "https://" + v }
  } else { none }
  block(above: 1.2em, below: 1.2em, hard(inset: 0pt, grid(
    columns: (1fr, 1fr),
    inset: (x: 10pt, y: 7pt),
    stroke: (x, y) => (left: if x > 0 { theme.rule + theme.ink }, top: if y > 0 { 0.5pt + theme.muted }),
    ..fields
      .named()
      .pairs()
      .map(((k, v)) => {
        set par(first-line-indent: 0pt, justify: false)
        box(width: 1.6em, mono(icons.at(k, default: "·"), fill: theme.teal, size: 8pt, weight: "bold"))
        label-text(k, fill: theme.muted, size: 6pt)
        h(6pt)
        let u = href(k, v)
        if u != none { link(u, mono(v, size: 7.8pt, fill: theme.ink)) } else { mono(v, size: 7.8pt) }
      }),
  )))
}

// A role, degree, award, project …  The date runs in the marginalia column.
//   entry(title: [Senior Engineer], org: [Acme], when: "2021 — now", where: "Berlin")[ - bullet … ]
#let entry(title: none, org: none, when: none, where: none, tags: (), body) = block(
  above: 1.3em,
  below: 1.3em,
  breakable: true,
  width: 100%,
  {
    set par(first-line-indent: 0pt, justify: false, leading: 0.6em)
    if when != none {
      marginnote(dy: 0.15em, {
        mono(when, fill: theme.teal, size: 7.6pt, weight: "bold")
        if where != none {
          linebreak()
          mono(where, fill: theme.muted, size: 7pt)
        }
      })
    }
    block(below: 6pt, sticky: true, {
      text(font: theme.display, size: 14pt, title)
      if org != none {
        h(6pt)
        text(fill: theme.muted, "—")
        h(6pt)
        text(style: "italic", size: 10.5pt, org)
      }
    })
    set text(size: 9.6pt)
    set list(spacing: 0.55em)
    body
    if tags.len() > 0 {
      v(4pt)
      tags.map(tag).join(h(4pt))
    }
  },
)

// Skill meter with hard square cells:  skills(("Typst", 4), ("Rust", 3), …)
#let skills(max: 5, columns: 2, ..items) = block(above: 1.2em, below: 1.2em, grid(
  columns: (1fr,) * columns,
  column-gutter: 18pt,
  row-gutter: 8pt,
  ..items
    .pos()
    .map(((name, level)) => grid(
      columns: (1fr, auto),
      align: horizon,
      text(size: 9.4pt, name),
      stack(
        dir: ltr,
        spacing: 2pt,
        ..range(max).map(i => rect(
          width: 7pt,
          height: 7pt,
          stroke: 0.9pt + theme.ink,
          fill: if i < level { theme.teal } else { none },
        )),
      ),
    )),
))

// Bibliography-style list: publications(([Title], [Venue], "2024", url), …)
#let publications(..items) = block(above: 1.2em, below: 1.2em, {
  set par(first-line-indent: 0pt, justify: false, leading: 0.55em)
  grid(
    columns: (2.4em, 1fr),
    row-gutter: 10pt,
    ..items
      .pos()
      .enumerate()
      .map(((i, it)) => {
        let (title, venue, year, url) = if it.len() == 4 { it } else { (..it, none) }
        (
          mono("[" + str(i + 1) + "]", fill: theme.teal, size: 8pt, weight: "bold"),
          {
            text(style: "italic", title)
            [. ]
            text(size: 9pt, venue)
            [, ]
            mono(year, size: 7.6pt)
            if url != none {
              h(5pt)
              link(url, mono("↗ link", size: 7pt, fill: theme.teal))
            }
          },
        )
      })
      .flatten()
  )
})

// Compact, one-page résumé appendix, laid out as a ledger.
//   resume(title: [Curriculum Vitae])[ …any content… ]
#let resume(title: [Curriculum Vitae], body) = {
  pagebreak(weak: true)
  block(width: wide-width, {
    grid(
      columns: (auto, 1fr, auto),
      column-gutter: 8pt,
      align: horizon,
      box(fill: theme.ink, inset: (x: 7pt, y: 4pt), mono(
        "APPENDIX · CV",
        fill: theme.paper,
        size: 7pt,
        tracking: 0.18em,
      )),
      line(length: 100%, stroke: 0.8pt + theme.ink),
      mono("resume.pdf", fill: theme.muted, size: 7pt),
    )
    v(12pt)
    text(font: theme.display, size: 30pt, title)
    v(4pt)
    line(length: 100%, stroke: 3pt + theme.teal)
  })
  v(8pt)
  body
}

// A small heading for use inside resume() — not numbered, not in contents.
#let cv-heading(body) = block(above: 1.6em, below: 0.8em, sticky: true, grid(
  columns: (auto, 1fr),
  column-gutter: 8pt,
  align: horizon,
  label-text(body, fill: theme.teal-deep, size: 7.6pt), line(length: 100%, stroke: 0.6pt + theme.ink),
))

// ── contents & colophon ──────────────────────────────────────────────────

#let contents(title: "Contents") = page({
  set par(first-line-indent: 0pt)
  label-text("Index · " + "contents.md")
  v(6pt)
  text(font: theme.display, size: 40pt, title)
  v(4pt)
  line(length: 100%, stroke: 3pt + theme.teal)
  v(-8pt)
  line(length: 100%, stroke: 0.6pt + theme.ink)
  v(1.2cm)
  show outline.entry.where(level: 1): it => context {
    let n = counter(heading).at(it.element.location()).first()
    v(14pt, weak: true)
    link(it.element.location(), grid(
      columns: (3.2em, 1fr, auto),
      align: bottom,
      mono(numbering("I", n), fill: theme.teal, size: 9pt, weight: "bold"),
      text(font: theme.display, size: 16pt, it.element.body)
        + h(6pt)
        + box(width: 1fr, repeat(gap: 2.5pt, mono(".", fill: theme.muted)))
        + h(6pt),
      mono(it.page(), size: 9pt),
    ))
  }
  show outline.entry.where(level: 2): it => {
    v(5pt, weak: true)
    link(it.element.location(), grid(
      columns: (3.2em, 1fr, auto),
      [],
      text(size: 10pt, style: "italic", fill: theme.muted, it.element.body),
      mono(it.page(), size: 7.5pt, fill: theme.muted),
    ))
  }
  outline(title: none, depth: 2)
})

#let colophon(body) = block(above: 2.4em, breakable: false, {
  line(length: 100%, stroke: 0.6pt + theme.ink)
  v(4pt)
  label-text("Colophon")
  v(4pt)
  set par(first-line-indent: 0pt, justify: false, leading: 0.5em)
  text(size: 8pt, fill: theme.muted, body)
})

// ── cover ────────────────────────────────────────────────────────────────

#let cover(name, name-zh, role, tagline, portrait, epigraph-body, epigraph-by, facts, date, version) = page(
  margin: (x: 1.9cm, top: 1.9cm, bottom: 1.8cm),
  header: none,
  footer: none,
  background: {
    place(top + left, dx: 0.9cm, dy: 0.9cm, rect(width: 100% - 1.8cm, height: 100% - 1.8cm, stroke: 1.6pt + theme.ink))
    place(top + left, dx: 0.9cm, dy: 0.9cm, rect(
      width: 0.42cm,
      height: 100% - 1.8cm,
      fill: theme.teal,
      stroke: 1.6pt + theme.ink,
    ))
  },
  {
    set par(first-line-indent: 0pt, justify: false)
    pad(left: 0.3cm, {
      grid(
        columns: (1fr, auto),
        label-text("A Personal Introduction"), mono(date.display("[year].[month].[day]"), fill: theme.muted),
      )
      v(-4pt)
      line(length: 100%, stroke: 0.8pt + theme.ink)
      v(1.1cm)
      grid(
        columns: (1fr, 6.3cm),
        column-gutter: 0.9cm,
        {
          mono("$ cat ./introduction.md", fill: theme.teal, size: 8pt)
          v(10pt)
          set par(leading: 0.22em)
          text(font: theme.display, size: 52pt, fill: theme.ink, name)
          text(font: theme.display, size: 52pt, fill: theme.teal, ".")
          if name-zh != none {
            v(14pt)
            grid(
              columns: (auto, 1fr),
              column-gutter: 10pt,
              align: horizon,
              text(font: theme.zh-song, size: 24pt, tracking: 0.32em, fill: theme.teal-deep, name-zh),
              line(length: 100%, stroke: 0.6pt + theme.ink),
            )
          }
          v(16pt)
          if role != none {
            label-text(role, fill: theme.ink, size: 7.5pt)
            v(10pt)
          }
          set par(leading: 0.5em)
          if tagline != none { text(size: 15pt, style: "italic", fill: theme.teal-deep, tagline) }
        },
        {
          hard(inset: 0pt, if portrait != none {
            set image(width: 100%, height: 8.2cm, fit: "cover")
            portrait
          } else { placeholder(label: "portrait", height: 8.2cm) })
        },
      )
      v(1fr)
      if epigraph-body != none {
        block(width: 82%, {
          text(font: theme.display, size: 40pt, fill: theme.teal, "“")
          v(-26pt)
          pad(left: 22pt, {
            set par(leading: 0.55em)
            text(size: 16pt, style: "italic", epigraph-body)
            if epigraph-by != none {
              v(8pt)
              mono("— " + epigraph-by, fill: theme.muted)
            }
          })
        })
        v(1cm)
      }
      if facts.len() > 0 {
        let cols = calc.min(facts.len(), 4)
        hard(inset: 0pt, grid(
          columns: (1fr,) * cols,
          inset: 9pt,
          stroke: (x, y) => (
            left: if x > 0 { theme.rule + theme.ink },
            top: if y > 0 { theme.rule + theme.ink },
          ),
          ..facts
            .pairs()
            .map(((k, val)) => {
              label-text(k, size: 6.2pt)
              v(3pt)
              text(size: 10pt, val)
            })
        ))
      }
      v(10pt)
      grid(
        columns: (1fr, auto),
        mono("README", fill: theme.muted, size: 6.6pt), mono("vol. " + version, fill: theme.muted, size: 6.6pt),
      )
    })
  },
)

// ── the template ─────────────────────────────────────────────────────────

#let intro(
  name: "Your Name",
  name-zh: none, // e.g. "林知远"; shown on the cover and sign-off
  role: none,
  tagline: none,
  portrait: none,
  epigraph: none, // (body, by) or none
  facts: (:), // shown as a bordered strip on the cover
  date: datetime.today(),
  version: "I",
  lang: "en",
  show-contents: true,
  body,
) = {
  let full-name = if name-zh != none { plain(name) + " (" + plain(name-zh) + ")" } else { plain(name) }
  set document(title: full-name + " — A Personal Introduction", author: full-name)
  set text(font: theme.serif, size: 10.4pt, fill: theme.ink, lang: lang)
  set par(justify: true, leading: 0.72em, spacing: 0.72em, first-line-indent: 1.3em)
  set block(spacing: 1.3em)
  set list(marker: text(fill: theme.teal, size: 0.8em, "■"), indent: 2pt, body-indent: 7pt)
  set enum(numbering: n => mono(str(n) + ".", fill: theme.teal, size: 8pt, weight: "bold"))
  set heading(numbering: "I.1")
  // CJK fonts have no italic: wherever Latin is italic, set Han in Kaiti.
  show regex("[\p{Han}\u3000-\u303F\uFF00-\uFFEF]+"): it => context {
    if text.style == "italic" { text(font: theme.zh-kai, style: "normal", it) } else { it }
  }
  show link: set text(fill: theme.teal)
  show strong: set text(fill: theme.teal-deep)
  show raw: set text(font: theme.mono, size: 8.4pt)
  show raw.where(block: false): it => box(fill: theme.teal-pale, inset: (x: 3pt), outset: (y: 2.5pt), it)
  show raw.where(block: true): it => block(
    width: 100%,
    inset: 10pt,
    fill: theme.teal-pale,
    stroke: (left: 3pt + theme.teal),
    it,
  )

  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    sidenote-counter.update(0)
    context {
      let n = counter(heading).get().first()
      block(width: wide-width, above: 0pt, below: 1.8em, {
        grid(
          columns: (auto, 1fr, auto),
          column-gutter: 8pt,
          align: horizon,
          box(fill: theme.teal, inset: (x: 7pt, y: 4pt), mono(
            "CHAPTER " + numbering("I", n),
            fill: theme.paper,
            size: 7pt,
            tracking: 0.18em,
          )),
          line(length: 100%, stroke: 0.8pt + theme.ink),
          mono("0" + str(n) + "-" + slug(it.body) + ".md", fill: theme.muted, size: 7pt),
        )
        v(18pt)
        block(width: 100% - theme.side + 1.5cm, {
          set par(justify: false, leading: 0.3em, first-line-indent: 0pt)
          text(font: theme.display, size: 36pt, weight: "regular", it.body)
        })
        v(10pt)
        line(length: 100%, stroke: 3pt + theme.teal)
        v(-8pt)
        line(length: 100%, stroke: 0.6pt + theme.ink)
      })
    }
  }
  show heading.where(level: 2): it => block(above: 2em, below: 1em, sticky: true, {
    context mono("§ " + numbering("I.1", ..counter(heading).get()), fill: theme.teal, size: 7.5pt, weight: "bold")
    h(9pt)
    text(size: 14.5pt, style: "italic", weight: "regular", it.body)
  })
  show heading.where(level: 3): it => block(above: 1.6em, below: 0.8em, sticky: true, text(
    size: 8.4pt,
    weight: "bold",
    tracking: 0.12em,
    fill: theme.teal-deep,
    upper(it.body),
  ))

  set page(
    paper: "a4",
    fill: theme.paper,
    margin: (left: 2.3cm, right: theme.side, top: 2.9cm, bottom: 2.7cm),
    background: {
      place(top + left, dx: 0.9cm, dy: 0.9cm, rect(
        width: 100% - 1.8cm,
        height: 100% - 1.8cm,
        stroke: 0.9pt + theme.ink,
      ))
      place(top + right, dx: -theme.side + 0.35cm, dy: 2.9cm, line(angle: 90deg, length: 100% - 5.6cm, stroke: (
        paint: theme.teal,
        thickness: 0.4pt,
        dash: "dotted",
      )))
    },
    header-ascent: 35%,
    header: context {
      let here-page = here().page()
      let opens = query(heading.where(level: 1)).any(h => h.location().page() == here-page)
      if not opens {
        let prev = query(heading.where(level: 1).before(here()))
        block(width: wide-width, grid(
          columns: (1fr, auto),
          mono(upper(plain(name)), size: 6.6pt, tracking: 0.16em, fill: theme.muted),
          if prev.len() > 0 {
            let h = prev.last()
            mono(
              numbering("I", counter(heading).at(h.location()).first()) + "  ·  ",
              fill: theme.teal,
              size: 6.6pt,
              weight: "bold",
            )
            text(size: 8.5pt, style: "italic", h.body)
          },
        ))
      }
    },
    footer-descent: 40%,
    footer: context {
      let prev = query(heading.where(level: 1).before(here()))
      let path = if prev.len() > 0 { "~/introduction/" + slug(prev.last().body) } else { "~/introduction" }
      let p = counter(page).get().first()
      let total = counter(page).final().first()
      block(width: wide-width, grid(
        columns: (1fr, auto),
        align: horizon,
        mono(path, fill: theme.muted, size: 6.6pt),
        box(fill: theme.teal, stroke: 1pt + theme.ink, inset: (x: 7pt, y: 4pt), mono(
          str(p) + " / " + str(total),
          fill: theme.paper,
          size: 7pt,
          weight: "bold",
        )),
      ))
    },
  )

  let (ep-body, ep-by) = if epigraph != none { epigraph } else { (none, none) }
  cover(name, name-zh, role, tagline, portrait, ep-body, ep-by, facts, date, version)
  if show-contents { contents() }
  body
}
