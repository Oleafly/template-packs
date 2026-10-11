// HUST thesis Typst port of HUSTthesis.cls V3.2.
// Original contributors: Feng Jiang, Huikan Liu, Xinze Zhang,
// Lianghao Li and Jianqing Lin. Original Perl Artistic License retained.
// TeX pt is 1/72.27 inch; Typst pt and TeX bp are 1/72 inch.
#let texpt = 72 / 72.27 * 1pt
#let song = ("Times New Roman", "SimSun")
#let hei = ("Times New Roman", "SimHei")
#let kai = ("Times New Roman", "KaiTi")
#let theorem-kinds = ("lemma", "theorem", "corollary", "definition", "proposition")
#let appendix-mode = state("hust-appendix", false)
#let chapter-num() = counter(heading).get().first()
#let hust-inlinecite(key) = {
  show cite: it => it
  cite(key)
}
#let hust-subref(parent, suffix) = [#ref(parent, supplement: none)#suffix]
#let hust-number(..n) = context str(chapter-num()) + "." + str(n.pos().first())
#let hust-equation-number(..n) = context "(" + str(chapter-num()) + (if appendix-mode.get() { "-" } else { "." }) + str(n.pos().first()) + ")"
#let hust-algorithm-number(..n) = context str(chapter-num()) + "-" + str(n.pos().first())
#let reset-chapter-counters() = {
  counter(footnote).update(0)
  counter(math.equation).update(0)
  counter(figure.where(kind: image)).update(0)
  counter(figure.where(kind: table)).update(0)
  counter(figure.where(kind: "algorithm")).update(0)
  for kind in theorem-kinds { counter(figure.where(kind: kind)).update(0) }
}
#let hust-chapter(body) = {
  pagebreak(weak: true)
  reset-chapter-counters()
  heading(level: 1, body)
}
#let hust-unnumbered(body, outlined: true) = {
  pagebreak(weak: true)
  heading(level: 1, numbering: none, outlined: outlined, body)
}
#let hust-appendices() = {
  appendix-mode.update(true)
  counter(heading).update(0)
}
#let hust-theorem(kind, title, body) = figure(
  body, kind: kind, supplement: title, numbering: hust-number,
)
#let hust-proof(body) = block(breakable: true, above: 6pt, below: 6pt)[
  #text(font: hei, weight: "bold")[证明：]#body#h(1fr)■
]
#let hust-algorithm(caption: [], body) = figure(
  body, kind: "algorithm", supplement: [算法], caption: caption,
  numbering: hust-algorithm-number,
)
#let algo-line(n, indent: 0, body) = block(above: 0pt, below: 0pt)[
  #grid(columns: (1.8em, 1fr), align: (right, left),
    text(size: 10 * texpt)[#n:~], pad(left: indent * 1em, body))
]
#let subfigure(file, caption, width: 100%) = align(center)[
  #image(file.replace("../assets/", "assets/"), width: width)
  #v(4pt)
  #text(size: 10.5 * texpt, caption)
]
// Word stores solid FF0000 for both the header text and its double rule.
#let hust-header-red = rgb("#ff0000")
#let hust-header() = {
  set par(first-line-indent: 0pt, leading: 0pt, spacing: 0pt)
  // Retain Word's header face and literal spaces; use the LaTeX 0.8em
  // inter-character distance. Fixed space boxes avoid show-rule tracking loss.
  align(center, text(font: "STKaiti", size: 16.5 * texpt,
    weight: "bold", fill: hust-header-red,
    stroke: (paint: hust-header-red, thickness: 0.0225 * 16.5pt))[
    #for (i, char) in "华中科技大学硕士学位论文".clusters().enumerate() {
      if i > 0 { box(width: 0.8em)[ ] }
      char
    }
  ])
  v(8 * texpt)
  // HUSTthesis.cls: 0.4 TeX pt rules, separated by 1 TeX pt.
  move(dx: -4mm, block(width: 104%, height: 1.8 * texpt)[
    #place(top, line(length: 100%, stroke: (paint: hust-header-red, thickness: 0.4 * texpt)))
    #place(top, dy: 1.4 * texpt, line(length: 100%, stroke: (paint: hust-header-red, thickness: 0.4 * texpt)))
  ])
}
#let hust-footer(final: false) = context {
  set par(first-line-indent: 0pt, leading: 0pt, spacing: 0pt)
  if not final {
    move(dx: -4mm, line(length: 104%, stroke: (paint: hust-header-red, thickness: 0.4 * texpt)))
    v(5.34pt)
  }
  align(center, text(size: 10.5 * texpt, counter(page).display()))
}
#let hust-thesis(final: false, body) = {
  set document(title: "硕士学位论文")
  set text(font: song, size: 12 * texpt, lang: "zh", region: "CN", cjk-latin-spacing: auto, top-edge: 0.88em, bottom-edge: 0.12em)
  // With the 0.88em glyph box, 12.94 TeX pt of gap gives exactly
  // the LaTeX 23.5 TeX pt baseline (0.88 * 12 + 12.94 = 23.5).
  set par(justify: true, first-line-indent: (amount: 2em, all: true), spacing: 12.94 * texpt,
    leading: 12.94 * texpt)
  set page(paper: "a4", margin: (left: 2.8cm, right: 2.8cm, top: 4.4cm, bottom: 3.4cm),
    header: if final { none } else { hust-header() }, header-ascent: 5mm,
    footer: hust-footer(final: final), footer-descent: 1.8cm - 14.55pt,
    numbering: "1")
  set heading(numbering: "1.1", supplement: none)
  // Zero-size markers distinguish ordinary paragraphs from consecutive
  // headings and blocks, which TeX treats differently after a heading.
  show par: it => context {
    if text.size == 12 * texpt and text.font != hei { metadata("hust-body-par") }
    it
  }
  show list: it => [#metadata("hust-body-block")#it]
  show enum: it => [#metadata("hust-body-block")#it]
  show table: it => [#metadata("hust-body-block")#it]
  show heading: it => context {
    let level = it.level
    let size = (16, 14, 13, 12).at(calc.min(level - 1, 3)) * texpt
    let before = if level == 1 and appendix-mode.get() { 24pt }
      else { (15.5, 10, 7, 16).at(calc.min(level - 1, 3)) * 1pt }
    let after = if level == 1 and appendix-mode.get() { 20pt }
      else if level == 1 and it.numbering == none { 14pt }
      else { (15, 7, 4, 6).at(calc.min(level - 1, 3)) * 1pt }
    let siblings = query(selector(heading).or(metadata.where(value: "hust-body-par")).or(metadata.where(value: "hust-body-block")).or(figure))
    let index = siblings.position(node => node.location() == it.location())
    let previous = if index != none and index > 0 { siblings.at(index - 1) } else { none }
    let next = if index != none and index + 1 < siblings.len() { siblings.at(index + 1) } else { none }
    let consecutive = previous != none and previous.func() == heading
    let paragraph-next = next != none and next.func() == metadata and next.value == "hust-body-par"
    let baseline-before = if level == 1 { 0.12 * size } else { 0.62 * size }
    let baseline-after = if paragraph-next { 12.94 * texpt } else { 0pt }
    block(width: 100%, above: 0pt, below: 0pt, sticky: true)[
      #v((if level > 1 and consecutive { 0pt } else { before }) + baseline-before, weak: false)
      #set text(font: hei, size: size, weight: if level <= 3 and not (level == 1 and appendix-mode.get()) { "bold" } else { "regular" })
      #set par(first-line-indent: 0pt, leading: if level == 1 { 0.12em } else { 0.62em })
      #let contents = context {
        if it.numbering != none {
          if appendix-mode.get() and level == 1 { [附录~] }
          counter(heading).display(it.numbering)
          h(1em)
        }
        it.body
      }
      #if level == 1 { align(center, contents) } else { contents }
      #v(after + baseline-after, weak: false)
    ]
  }
  // Chinese fonts bundled with the template have no bold face. Match XeCJK's
  // AutoFakeBold=2.25 (stroke = TeX字号 * 2.25%) without changing advances.
  // Latin text uses its real bold face and must not receive an extra stroke.
  show strong: it => text(weight: "bold", it.body)
  show regex("[\\p{Han}、。，：；！？“”‘’（）《》【】]+"): it => context {
    let bold = if type(text.weight) == int { text.weight >= 600 }
      else { ("semibold", "bold", "extrabold", "black").contains(text.weight) }
    if bold { text(stroke: (paint: text.fill, thickness: 0.0225 * 72.27 / 72 * 1em), it) } else { it }
  }
  show emph: set text(font: ("Times New Roman", "KaiTi"))
  set math.equation(numbering: none, supplement: none)
  show math.equation: set text(font: ("New Computer Modern Math", "SimSun"), weight: 400, stroke: none)
  show math.equation.where(block: true): set block(above: 10pt, below: 10pt, breakable: false)
  set figure(numbering: hust-number, supplement: [图], gap: 12pt)
  // LaTeX intextsep = 0.7 baselineskip; belowcaptionskip = 12bp.
  show figure: set block(above: 0.7 * 23.5 * texpt, below: 12pt + 0.7 * 23.5 * texpt)
  show figure.caption: set text(size: 11 * texpt)
  show figure.caption: set par(first-line-indent: 0pt, leading: 0.12em)
  show figure.where(kind: table): set figure(supplement: [表])
  show figure.where(kind: table): set figure.caption(position: top)
  // With a top caption, abovecaptionskip belongs outside the figure;
  // belowcaptionskip is the internal caption-to-table gap.
  show figure.where(kind: table): set block(above: 12pt + 0.7 * 23.5 * texpt, below: 0.7 * 23.5 * texpt)
  show figure.where(kind: "algorithm"): it => block(breakable: false, above: 8pt, below: 8pt)[
    #set par(first-line-indent: 0pt, leading: 3pt)
    #line(length: 100%, stroke: 0.8pt)
    #v(4pt)
    #context [#text(weight: "bold")[算法 #it.counter.display(it.numbering)]~#it.caption.body]
    #v(4pt)
    #line(length: 100%, stroke: 0.4pt)
    #v(4pt)
    #it.body
    #v(4pt)
    #line(length: 100%, stroke: 0.8pt)
  ]
  let render-theorem(it) = block(width: 100%, breakable: true, above: 6pt, below: 6pt)[
    #set align(left)
    #set par(first-line-indent: 0pt)
    #context text(font: hei, weight: "bold")[#it.supplement #it.counter.display(it.numbering)：]#it.body
  ]
  show figure.where(kind: "lemma"): render-theorem
  show figure.where(kind: "theorem"): render-theorem
  show figure.where(kind: "corollary"): render-theorem
  show figure.where(kind: "definition"): render-theorem
  show figure.where(kind: "proposition"): render-theorem
  set list(indent: 1.6em, body-indent: 0.3em, spacing: 23 * texpt, tight: false)
  show list: set block(above: 13 * texpt, below: 13 * texpt)
  set enum(numbering: "(1)", indent: 2em, body-indent: 0.3em, spacing: 11.5 * texpt, tight: false)
  set table(inset: 5pt)
  show table: set text(size: 11 * texpt)
  show table: set par(first-line-indent: 0pt, leading: 0.52em)
  // The class comment says "perpage", but the active code follows the
  // book class counter: circled numbers reset on a new chapter.
  set footnote(numbering: "①")
  set footnote.entry(separator: line(length: 30%, stroke: 0.4 * texpt))
  show footnote.entry: set text(size: 9 * texpt)
  show footnote.entry: set par(first-line-indent: 0pt, leading: 0.42em)
  show bibliography: set par(first-line-indent: 0pt, leading: 0.62em)
  set cite(style: "gb-7714-2015-numeric")
  show cite: it => text(fill: rgb("#0000ff"), super(it))
  set ref(supplement: none)
  body
}

#let hust-outline() = {
  hust-unnumbered([目#h(2em)录], outlined: false)
  context {
    v(8.75 * texpt)
    set text(size: 14 * texpt)
    set par(first-line-indent: 0pt, leading: 0.12em, spacing: 0pt)
    for entry in query(heading.where(outlined: true)) {
      if entry.level <= 2 {
        let n = counter(heading).at(entry.location())
        let app = appendix-mode.at(entry.location())
        let numbered = entry.numbering != none
        block(above: 5pt, below: 5pt)[
          #set text(font: if entry.level == 1 { hei } else { song }, weight: if entry.level == 1 { "bold" } else { "regular" })
          #let appendix-label = app and entry.level == 1
          #let label-width = if not numbered { 0pt } else if appendix-label { 3.75em } else if entry.level == 2 { 2.76em } else { 1.76em }
          #pad(left: if entry.level == 2 { 0.48em } else if numbered and not app { 0.34em } else { 0em })[
            // Separate columns keep all wrapped title lines aligned.
            #grid(columns: (label-width, 1fr), column-gutter: 0pt,
              if numbered { link(entry.location())[
                #if appendix-label { [附录~] }
                #numbering(entry.numbering, ..n)
              ] } else { [] },
              [
                #link(entry.location(), entry.body)
                #if not numbered or app or entry.level == 2 {
                  text(weight: "regular", box(width: 1fr, repeat[.]))
                  let p = counter(page).at(entry.location()).first()
                  let format = entry.location().page-numbering()
                  let roman = format == "I"
                  text(font: "Times New Roman", weight: if roman { "bold" } else { "regular" })[
                    #if roman { numbering(format, p) } else { [(#numbering(format, p))] }
                  ]
                }
              ])
          ]
        ]
      }
    }
  }
}
