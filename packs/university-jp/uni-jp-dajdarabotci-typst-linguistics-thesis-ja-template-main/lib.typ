#import "package/leipzig-glossing/leipzig-gloss.typ": example, abbreviations
#import abbreviations: *
#import "@preview/cjk-unbreak:0.2.2": remove-cjk-break-space

#let kintou(width, s) = box(width: width, s.text.clusters().join(h(1fr)))

#let noindent(body) = {
  set par(first-line-indent: 0em)
  body
}

#let bookmark(title) = { // pdf のしおり生成関数
  context {
    let dx = page.margin.left
    let dy = page.margin.top
    place(dx: -dx, dy: -dy , {
      show heading: none
      heading(numbering: none, bookmarked: true, outlined: false, title)
    })
  }
}

#let make-cover(class, title, subtitle, school, lab, author, id, mentor) = {
  bookmark("表紙")
  set align(center)
  v(1fr)
  text(size: 20pt, weight: "bold")[
    #class
    #v(3em)
    #title
    #v(1.5em)
    #if subtitle != "" {
      set par(leading: 1em)
      set text(size: 18pt)
      grid(
        columns: 3,
        gutter: 0.3em,
        align: horizon,
        [---], subtitle, [---]
      )
    }
  ]
  v(3fr)
  {
    set text(size: 16pt)
    context {
      let labels = (school, "学生番号")
      let label-widths = labels.map(l => measure(l).width)
      let max-w = calc.max(..label-widths)
      grid(
        columns: 2,
        rows: 4,
        stroke: (bottom: 0.5pt),
        align: left + bottom,
        inset: ((left: 0.2em, top: 1.3em, bottom: 0.5em),(left: 2em, top: 1em, bottom: 0.5em)),
        kintou(max-w)[#school], lab,
        kintou(max-w)[指導教員], mentor,
        kintou(max-w)[学生番号], id,
        kintou(max-w)[氏名], author,
      )
    }
  }
  v(1fr)
  pagebreak()
}

#let abstract(..items) = {
  bookmark("要旨")
  show heading: set align(center)
  set heading(numbering: none, outlined: false)
  let pairs = items.pos()
  for pair in pairs {
    let (title, body) = pair
    heading(title)
    body
    if pair != pairs.last() {
      v(1em)
    } else {
      pagebreak()
    }
  }
}

#let toc() = {
  show heading: set align(center)
  outline()
  pagebreak()
}

#let toc-fig() = {
  show heading: set align(center)
  set heading(numbering: none, outlined: true)
  heading[図目次]
  outline(
    title: none,
    target: std.figure.where(kind: image),
  )
  v(3em)
  heading[表目次]
  outline(
    title: none,
    target: figure.where(kind: table),
  )
  pagebreak()
}

#let list-abbr() = {
  show heading: set align(center)
  set heading(numbering: none, outlined: true)
  heading[略語一覧]
  let print_usage_chart = with-used-abbreviations(final-used-abbreviations => {
    let abbr-chart = ()
    let abbrevs = final-used-abbreviations.keys().sorted()
    for abbr in abbrevs {
      let explanation = if abbr in standard-abbreviations {
        standard-abbreviations.at(abbr)
      } else {
        custom-abbreviations.at(abbr)
      }
      abbr-chart.push((abbr, explanation))
    }
    grid(
      columns: 2,
      column-gutter: 2em,
      row-gutter: 1em,
      ..abbr-chart.flatten()
    )
  })
  print_usage_chart
  pagebreak()
}
#let acknowledgment() = {}

#let ling-thesis(
  lang: "ja",
  title: "[題目]",
  subtitle: "[副題]",
  author: "[氏名]",
  class: "[論文の種類]",
  id: "[学生番号]",
  school: "[所属]",
  lab: "[研究室]",
  mentor: "[指導教員]",
  description: none,
  keywords: (),
  date: datetime.today(),
  seriffont: "New Computer Modern", // or "Libertinus Serif" or "Source Serif Pro"
  seriffont-cjk: "Harano Aji Mincho", // or "Yu Mincho" or "Hiragino Mincho ProN"
  sansfont: "Source Sans Pro", // or "Arial" or "New Computer Modern Sans" or "Libertinus Sans"
  sansfont-cjk: "Harano Aji Gothic", // or "Yu Gothic" or "Hiragino Kaku Gothic ProN"
  paper: "a4", // "a*", "b*", or (paperwidth, paperheight) e.g. (210mm, 297mm)
  fontsize: 10.5pt,
  baselineskip: auto,
  textwidth: auto, // or 40em etc. (include 2em column gutter)
  lines-per-page: auto,
  cover: true, // false if unnecessary
  cols: 1,
  non-cjk: regex("[\u0000-\u2023]"), // or "latin-in-cjk"
  cjkheight: 0.88, // height of CJK in em
  body
) = {
  set document(title: title, author: author, description: description, keywords: keywords)
  if paper == "a3" { paper = (297mm, 420mm) }
  if paper == "a4" { paper = (210mm, 297mm) }
  if paper == "a5" { paper = (148mm, 210mm) }
  if paper == "a6" { paper = (105mm, 148mm) }
  if paper == "b4" { paper = (257mm, 364mm) }
  if paper == "b5" { paper = (182mm, 257mm) }
  if paper == "b6" { paper = (128mm, 182mm) }
  let (paperwidth, paperheight) = paper
  if textwidth == auto {
    textwidth = (int(0.76 * paperwidth / (cols * fontsize)) * cols + 2 * (cols - 1)) * fontsize
  }
  if baselineskip == auto { baselineskip = 1.73 * fontsize }
  let xmargin = (paperwidth - textwidth) / 2
  let ymargin = if lines-per-page == auto {
    (paperheight - (int((0.83 * paperheight - fontsize) / baselineskip)
                    * baselineskip + fontsize)) / 2
  } else {
    (paperheight - (baselineskip * (lines-per-page - 1) + fontsize)) / 2
  }
  set columns(gutter: 2em)
  set page(
    width: paperwidth,
    height: paperheight,
    margin: (
      x: xmargin,
      top: ymargin,
      bottom: ymargin,
    ),
    columns: cols,
    footer: auto,
    header:
      {
        context {
          let n = if page.numbering == none { "" } else {
            counter(page).display()  // logical page number
          }
          let p = here().page()  // physical page number
          let h1 = heading.where(level: 1)
          let h1p = query(h1).map(it => it.location().page())
          if p > 1 and not p in h1p {
            if calc.odd(p) {
              let h2 = heading.where(level: 2)
              let h2last = query(h2.before(here())).at(-1, default: none)
              let h2next = query(h2.after(here())).at(0, default: none)
              if h2next != none and h2next.location().page() == p { h2last = h2next }
              if h2last != none {
                let c = counter(heading).at(h2last.location())
                stack(
                  spacing: 0.2em,
                  if h2last.numbering == none {
                    [ #h2last.body #h(1fr) #n ]
                  } else {
                    [ #{c.at(0)}.#{c.at(1)}#h(1em)#h2last.body #h(1fr) #n ]
                  },
                  line(stroke: 0.4pt, length: 100%),
                )
              }
            } else {
              let h1last = query(h1.before(here())).at(-1, default: none)
              let h1next = query(h1.after(here())).at(0, default: none)
              if h1next != none and h1next.location().page() == p { h1last = h1next }
              if h1last != none {
                let c = counter(heading).at(h1last.location())
                stack(
                  spacing: 0.2em,
                  if h1last.numbering == none {
                    [ #n #h(1fr) #h1last.body ]
                  } else {
                    [ #n #h(1fr) 第#{c.at(0)}章#h(1em)#h1last.body ]
                  },
                  line(stroke: 0.4pt, length: 100%),
                )
              }
            }
          }
        }
    },
  )
  set text(
    lang: lang,
    font: ((name: seriffont, covers: non-cjk), seriffont-cjk),
    weight: 450,
    size: fontsize,
    top-edge: cjkheight * fontsize,
    costs: (widow: if cols == 1 { 100% } else { 0% },
            orphan: if cols == 1 { 100% } else { 0% })
  )
  set par(
    first-line-indent: (amount: 1em, all: true),
    justify: true,
    spacing: baselineskip - cjkheight * fontsize, // space between paragraphs
    leading: baselineskip - cjkheight * fontsize, // space between lines
  )
  set heading(numbering: "1.1")
  show heading: set text(
    font: ((name: sansfont, covers: non-cjk), sansfont-cjk),
    weight: "bold",
  )
  show heading: it => block(
    above: baselineskip - cjkheight * fontsize,
    below: baselineskip - cjkheight * fontsize,
    breakable: false,
    sticky: true,
  )[
    #if it.numbering != none {
      counter(heading).display()
      h(1em)
    }
    #it.body
  ]
  show heading.where(level: 1): it => {
    block(
      above: baselineskip - cjkheight * fontsize,
      below: baselineskip - cjkheight * fontsize,
      breakable: false,
      sticky: true,
    )[
      #set par(first-line-indent: 0em)
      #set text(size: 1.4 * fontsize)
      #v(baselineskip / 2 + 0.2 * fontsize)
      #if it.numbering != none {
        counter(heading).display()
        h(1em)
      }
      #it.body
      #v(baselineskip / 2 - 0.2 * fontsize)
    ]
  }
  show heading.where(level: 2): it => block(
    above: baselineskip - cjkheight * fontsize,
    below: baselineskip - cjkheight * fontsize,
    breakable: false,
    sticky: true,
  )[
    #set par(first-line-indent: 0em)
    #set text(size: 1.2 * fontsize)
    #v(baselineskip / 2 + 0.1 * fontsize)
    #if it.numbering != none {
      counter(heading).display()
      h(1em)
    }
    #it.body
    #v(baselineskip / 2 - 0.1 * fontsize)
  ]
  show: remove-cjk-break-space 
  show link: underline
  set list(indent: 1.2em)
  set quote(block: true)
  show quote.where(block: true): set pad(left: 2em, right: 0em)
  show quote.where(block: true): set block(spacing: 1.5 * baselineskip - cjkheight * fontsize)
  show list: set block(spacing: 1.5 * baselineskip - cjkheight * fontsize)
  show enum: set block(spacing: 1.5 * baselineskip - cjkheight * fontsize)
  show terms: set block(spacing: 1.5 * baselineskip - cjkheight * fontsize)
  show math.equation.where(block: true): set block(spacing: 1.5 * baselineskip - cjkheight * fontsize)
  // set block(spacing: 1.5 * baselineskip - cjkheight * fontsize) // affects all blocks
  set terms(indent: 2em, separator: h(1em, weak: true))
  set enum(indent: 0.722em)
  set list(indent: 0.722em)
  show raw.where(block: true): set block(width: 100%, fill: luma(240), inset: 1em)
  show raw.where(block: true): set par(
    justify: false,
    leading: 0.8 * baselineskip - cjkheight * fontsize,
  )
  set table(stroke: 0.04em)
  show table: set text(top-edge: (2 * cjkheight - 1) * fontsize)
  set footnote.entry(indent: 1.6em)
  show figure.where(kind: table): set figure.caption(position: std.top)
  //set ref(supplement: none)
  // finally
  if cover {make-cover(class, title, subtitle, school, lab, author, id, mentor)}
  body
}

// miscellaneous definitions
#let ex = example.with(numbering: true, label-supplement: none)

#let TeX = box[T#h(-0.2em)#text(baseline: 0.2em)[E]#h(-0.1em)X]
#let LaTeX = box[L#h(-0.3em)#text(size: 0.7em, baseline: -0.3em)[A]#h(-0.1em)#TeX]

#let scatter(s) = h(1fr) + s.text.clusters().join(h(2fr)) + h(1fr)
#let ruby(kanji, yomi) = box[
  #context {
    set par(first-line-indent: 0em)
    set text(top-edge: "ascender")
    let w = measure(kanji).width
    let x = measure(yomi).width / 2
    if w < x { w = x }
    box(width: w, h(1fr) + kanji + h(1fr)) // or scatter(kanji)
    place(std.top + center, dy: -0.5em, box(width: w, text(0.5em, scatter(yomi))))
  }
]

#let boxtable(x) = {
  if type(x) == array {
    box(baseline: 100%-1.16em,  // 100% - (2 * cjkheight - 1.4) * 1em,
        table(stroke: 0pt, inset: 0.4em, columns: 1, align: center, ..x))
  } else {
    box(x)
  }
}

#let array2text(x) = {
  while type(x) == array { x = x.at(0, default: "") }
  x
}
