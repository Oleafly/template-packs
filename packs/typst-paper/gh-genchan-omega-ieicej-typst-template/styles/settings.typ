// TeX's point is 1/72.27 inch, while Typst's point is 1/72 inch.
#let tex-point = 25.4mm / 72.27
#let q = 0.25mm

#let _tr-body-size = 9 * tex-point
#let _tr-body-leading = 20.5 * q
#let _tr-text-width = 57 * _tr-body-size
#let _tr-side-margin = (210mm - _tr-text-width) / 2
#let _tr-gutter = 2 * _tr-body-size

#let _roman-candidates = ("TeXGyreTermesX", "TeX Gyre Termes", "Times New Roman", "Times")
#let font-config = (
  roman: _roman-candidates,
  mincho: _roman-candidates + ("Harano Aji Mincho", "YuMincho"),
  gothic: _roman-candidates + ("Harano Aji Gothic", "YuMincho"),
  math: "STIX Two Math",
)
#let _roman-fonts = font-config.roman
#let _mincho-fonts = font-config.mincho
#let _gothic-fonts = font-config.gothic

// Japanese bold in the class is Gothic Medium, while Latin bold remains
// Termes X Bold. A single Typst weight would select either regular Latin or
// Harano Aji Gothic Heavy, so style printable ASCII runs independently.
#let _mixed-strong(body) = {
  set text(font: _gothic-fonts, weight: 500)
  show regex("[ -~]+"): it => text(font: _roman-fonts, weight: "bold", it)
  body
}

// ieicej.cls expands Japanese headings of four characters or fewer to 5zw.
// Apply this in the heading style so manuscripts can use ordinary = syntax.
#let _jidori(value, width: 5em) = {
  let chars = value.clusters()
  if chars.len() <= 1 {
    box(width: width, align: center)[#value]
  } else {
    let gap = (width - chars.len() * 1em) / (chars.len() - 1)
    box(width: width)[
      #for (index, char) in chars.enumerate() {
        char
        if index < chars.len() - 1 { h(gap) }
      }
    ]
  }
}

#let _heading-body(body) = {
  if body.func() == text {
    let value = body.fields().text
    if value.contains(regex("[^ -~]")) and value.clusters().len() <= 4 {
      box[#move(dy: -0.58pt)[#_jidori(value)]]
    } else {
      body
    }
  } else {
    body
  }
}

#let _technical-config = (
  paper: "a4",
  // ieicej.cls: textwidth = 57zw; textheight = 49Cvs + topskip.
  // The vertical margins reproduce the class's centered text block and 9.5mm footskip.
  margin: (
    top: 15.63mm,
    bottom: 26.95mm,
    left: _tr-side-margin,
    right: _tr-side-margin,
  ),
  gutter: _tr-gutter,
  body-size: _tr-body-size,
  body-leading: _tr-body-leading,
  small-size: 8 * tex-point,
  small-leading: 18 * q,
  footnote-size: 7 * tex-point,
  footnote-leading: 16 * q,
  section-size: 10.95 * tex-point,
)

#let _technical-footer(cfg, copyright-year) = context {
  set text(
    font: _mincho-fonts,
    size: cfg.body-size,
    top-edge: 0.8em,
    bottom-edge: -0.2em,
  )
  set par(first-line-indent: 0pt, leading: cfg.body-leading - cfg.body-size)

  if counter(page).get().first() == 1 {
    move(dy: -4.58pt)[
      #block(width: 100%)[
        This article is a technical report without peer review, and its polished and/or extended version may be published elsewhere.
        #place(right, dy: 0.35mm)[
          #pad(right: 9 * tex-point)[Copyright ©#copyright-year by IEICE]
        ]
      ]
    ]
  } else {
    move(dx: -1.79pt, dy: -4.58pt)[
      #block(width: 100%)[#align(right)[— #counter(page).display() —]]
    ]
  }
}

#let _heading-number(it) = context {
  if it.numbering != none {
    let numbers = counter(heading).get()
    if numbers.len() == 1 {
      [#(numbers.first()).]
    } else {
      for (index, number) in numbers.enumerate() {
        if index > 0 { [.#h(1.5pt)] }
        str(number)
      }
    }
  }
}

#let _technical-heading(it, cfg) = {
  let level = it.level
  let font-size = if level == 1 { cfg.section-size } else { cfg.body-size }
  let font-family = if level <= 2 { _gothic-fonts } else { _mincho-fonts }
  let font-weight = if level <= 2 { 500 } else { "regular" }
  let above = if level == 1 {
    0.5 * cfg.body-leading
  } else {
    cfg.body-leading - cfg.body-size
  }
  let below = if level == 1 { 0.5 * cfg.body-leading } else { 0pt }
  // Typst's built-in heading recipe has already applied 1.4em/1.2em at
  // levels 1 and 2. Cancel that relative scaling before reproducing the
  // absolute sizes specified by ieicej.cls.
  let default-scale = if level == 1 { 1.4 } else if level == 2 { 1.2 } else { 1.0 }
  let relative-size = font-size / (cfg.body-size * default-scale) * 1em
  let body = _heading-body(it.body)

  block(
    width: 100%,
    height: cfg.body-leading,
    above: above,
    below: below,
    breakable: false,
    sticky: true,
  )[
    #if it.numbering == none {
      align(center + horizon)[
        #move(dy: -2.79pt)[
          #text(
            font: font-family,
            size: relative-size,
            weight: font-weight,
            top-edge: 0.8em,
            bottom-edge: -0.2em,
          )[#if level <= 2 { _mixed-strong(body) } else { body }]
        ]
      ]
    } else {
      align(left + horizon)[
        #move(dy: -2.79pt)[
          #set par(first-line-indent: 0pt)
          // The visible indent also compensates for Termes X's digit bearing.
          #pad(left: if level == 1 { cfg.section-size } else { cfg.body-size })[
            #text(
              font: font-family,
              size: relative-size,
              weight: font-weight,
              top-edge: 0.8em,
              bottom-edge: -0.2em,
            )[#text(font: _roman-fonts, weight: "bold")[#_heading-number(it)]#h(1em)#if level <= 2 { _mixed-strong(body) } else { body }]
          ]
        ]
      ]
    }
  ]
}

#let _technical-list(it, cfg, depth: 0) = block(
  width: 100%,
  above: cfg.body-leading - cfg.body-size,
  below: cfg.body-leading - cfg.body-size,
  breakable: true,
)[
  #let markers = ([•], [–], text("*"), [·])
  #let marker = markers.at(calc.rem(depth, markers.len()))
  #for (index, item) in it.children.enumerate() {
    if index > 0 { v(cfg.body-leading - cfg.body-size) }
    block(width: 100%, above: 0pt, below: 0pt, breakable: true)[
      #set par(first-line-indent: (all: false, amount: 1em))
      #show list: nested => _technical-list(nested, cfg, depth: depth + 1)
      #box(width: 0pt)[#move(dx: 4em / 3)[#marker]]#h(3em)#item.body
    ]
  }
]

#let _technical-enum(it, cfg) = block(
  width: 100%,
  above: 0pt,
  below: cfg.body-leading - cfg.body-size,
  breakable: true,
)[
  #let start = it.fields().at("start", default: 1)
  #for (index, item) in it.children.enumerate() {
    let number = item.fields().at("number", default: start + index)
    if index > 0 { v(cfg.body-leading - cfg.body-size) }
    block(width: 100%, above: 0pt, below: 0pt, breakable: true)[
      #set par(first-line-indent: (all: false, amount: 1em))
      #show list: nested => _technical-list(nested, cfg)
      #box(width: 0pt)[
        #move(dx: 7em / 6)[
          （#h(1.5 * tex-point)#number#h(1.95pt)）
        ]
      ]#h(4em)#item.body
    ]
  }
]

#let _technical-equation(it, cfg) = block(
  width: 100%,
  above: 12.08pt,
  below: 14.66pt,
  breakable: false,
)[
  #block(width: 100%)[
    #set par(first-line-indent: 0pt)
    #if it.numbering != none {
      place(
        right + horizon,
        dx: -(cfg.body-size - 0.46pt),
        dy: 1.74pt,
      )[
        #text(font: _roman-fonts)[
          #context counter(math.equation).display(
            it.numbering,
            at: it.location(),
          )
        ]
      ]
    }
    #pad(left: cfg.body-size)[
      #align(left)[
        #scale(x: 97.1%, reflow: true, origin: left)[#it.body]
      ]
    ]
  ]
]

#let setting(doc, copyright-year: datetime.today().year()) = {
  let cfg = _technical-config

  set page(
    paper: cfg.paper,
    columns: 2,
    margin: cfg.margin,
    numbering: none,
    footer-descent: 30%,
    footer: _technical-footer(cfg, copyright-year),
  )
  set columns(2, gutter: cfg.gutter)

  set text(
    lang: "ja",
    font: _mincho-fonts,
    size: cfg.body-size,
    top-edge: 0.8em,
    bottom-edge: -0.2em,
    cjk-latin-spacing: auto,
    costs: (widow: 0%, orphan: 0%),
  )
  show strong: it => _mixed-strong(it.body)
  set par(
    first-line-indent: (all: true, amount: 1em),
    justify: true,
    justification-limits: (
      tracking: (min: -0.05em, max: 0.1em),
    ),
    leading: cfg.body-leading - cfg.body-size,
    // Typst measures paragraph spacing between glyph bounds. This value keeps
    // consecutive TeX paragraphs on the same 20.5Q baseline grid.
    spacing: cfg.body-leading - cfg.body-size,
  )
  // Reapply these costs to the realized paragraph.
  show par: set text(costs: (widow: 0%, orphan: 0%))

  set footnote(numbering: "1")
  set footnote.entry(
    separator: line(length: 100%, stroke: 0.1mm),
    clearance: cfg.body-leading,
    gap: 0pt,
    indent: 0pt,
  )
  show footnote: it => context {
    text(font: _mincho-fonts, size: 5 * tex-point)[
      （注#counter(footnote).display(at: it.location())）
    ]
  }
  show footnote.entry: it => context {
    let loc = it.note.location()
    block(width: 100%)[
      #set text(
        font: _mincho-fonts,
        size: cfg.footnote-size,
        top-edge: 0.8em,
        bottom-edge: -0.2em,
      )
      #set par(
        first-line-indent: 1em,
        justify: true,
        leading: cfg.footnote-leading - cfg.footnote-size,
      )
      （注#counter(footnote).display(at: loc)）：#it.note.body
    ]
  }

  set heading(numbering: "1.", supplement: none)

  // Keep Typst's CSL/IEEE bibliography engine, while applying the type size
  // and line grid used by ieicej.cls. The manuscript only supplies the data
  // source; the Japanese heading is part of the document style.
  set bibliography(title: "文献")
  show bibliography: set text(
    lang: "en",
    font: _mincho-fonts,
    size: cfg.small-size,
    top-edge: 0.8em,
    bottom-edge: -0.2em,
  )
  show bibliography: set par(
    first-line-indent: 0pt,
    justify: true,
    leading: 15 * q - cfg.small-size,
    spacing: 0pt,
  )

  // ieicej.cls: itemindent=3zw, with the bullet centered in a 1zw box.
  set list(
    indent: 4em / 3,
    body-indent: 5em / 3,
    spacing: cfg.body-leading - cfg.body-size,
  )
  set enum(
    // ieicej.cls: itemindent=4zw and a 2zw label box.
    indent: 7em / 6,
    body-indent: 4em / 3,
    spacing: cfg.body-leading - cfg.body-size,
    numbering: n => [（#n）],
  )

  // Keep Typst's automatic kind-aware supplement: figures become "図" and
  // table figures become "表" under the Japanese document language.
  set figure(supplement: auto)
  set figure.caption(separator: [: ])
  show figure: set text(size: cfg.small-size)
  show figure: set par(leading: cfg.small-leading - cfg.small-size)
  // ieicej.cls uses 1.5\Cvs between a figure and the body.
  show figure: set place(clearance: 1.5 * cfg.body-leading - 2.92pt)

  set math.equation(numbering: "(1)", supplement: "式")
  show math.equation: set text(font: font-config.math)

  show heading.where(level: 1): it => _technical-heading(it, cfg)
  show heading.where(level: 2): it => _technical-heading(it, cfg)
  show heading.where(level: 3): it => _technical-heading(it, cfg)
  show list: it => _technical-list(it, cfg)
  show enum: it => _technical-enum(it, cfg)
  // ieicej.cls uses fleqn with one-zw equation and equation-number indents.
  show math.equation.where(block: true): it => _technical-equation(it, cfg)
  doc
}

#let document-settings = setting
