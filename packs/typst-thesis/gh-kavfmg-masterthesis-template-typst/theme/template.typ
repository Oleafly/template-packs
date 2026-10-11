#import "header_components.typ"

#let outline-header(doc) = {
  set page(
    numbering: "i",
    footer: none,
    header: context {
      if header_components.is_even_page() {
        box([
          #header_components.page_display()
          #h(1fr)
        ])
        line(length: 100%, stroke: header_components.header_line_style)
      } else {
        box([
          #h(1fr)
          #header_components.page_display()
        ])
        line(length: 100%, stroke: header_components.header_line_style)
      }
    },
  )
  doc
}

#let main-template(doc) = [
  #set page(
    paper: "a4",
    margin: (top: 25mm, bottom: 10mm, inside: 25mm, outside: 15mm),
    columns: 1,
    numbering: "1",
    number-align: top + right,
    header: context {
      if header_components.is_even_page() {
        if header_components.is_chapter_page() {
          header_components.header_even_h1()
        } else {
          header_components.header_even_noh1()
        }
      } else {
        if header_components.is_chapter_page() {
          header_components.header_odd_h1()
        } else {
          header_components.header_odd_noh1()
        }
      }
      counter(footnote).update(0)
    },
  )
  #set par(
    spacing: 0.65em,
    first-line-indent: (amount: 1em, all: true),
    justify: true,
  )
  #set math.equation(numbering: it => {
    let count = counter(heading.where(level: 1)).at(here()).first()
    numbering("(1.1)", count, it)
  })
  #show math.equation.where(block: true): set block(breakable: true)
  #show math.equation.where(block: false): set math.frac(style: "horizontal")
  #show math.equation: set text(font: ("New Computer Modern Math", "Hiragino Mincho ProN"))
  #show ref: set text(fill: blue)

  #set figure(numbering: it => {
    let hdr = counter(heading).get().at(0)
    [#hdr.#it]
  })
  #show figure: set block(above: 30pt, below: 30pt)
  #show figure.where(kind: table): set figure.caption(position: top)

  #show heading.where(level: 1): it => {
    pagebreak(weak: true, to: "odd")
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)
    counter(math.equation).update(0)
    let hdr = counter(heading).get().at(0)
    let title-content = [#text(30pt, font: "Hiragino Kaku Gothic ProN")[第#str(hdr)章 \ #v(0em) #it.body] \ ]
    block(title-content, below: 1.5em)
  }
  #show heading.where(level: 2): set text(17pt)
  #show heading.where(level: 3): set text(15pt)
  #show heading.where(level: 4): set text(12pt)

  #set heading(numbering: (..num) => {
    if num.pos().len() == 1 { "第" + str(num.pos().at(0)) + "章" } else { num.pos().map(str).join(".") + " " }
  })

  #show ref: it => {
    let el = it.element
    if el != none and el.func() == heading and el.level == 1 {
      link(el.location(), numbering(el.numbering, ..counter(heading).at(el.location())))
    } else {
      it
    }
  }

  #show raw.where(block: true): it => {
    block(inset: 5pt, fill: silver.lighten(30%), radius: 3pt)[#it]
  }

  #show link: it => {
    underline[#text(blue, it)]
  }

  #doc
]

#let appendix-template(doc) = {
  show: main-template
  pagebreak(weak: true, to: "even")
  [
    #set page(header: none)
    #show heading.where(level: 1): it => {
      align(center + horizon, text(30pt, font: "Hiragino Kaku Gothic ProN")[#it.body])
    }
    #heading(level: 1, numbering: none, outlined: true)[Appendix]
  ]
  counter(heading).update(0)

  set heading(numbering: "A.1")
  show heading.where(level: 1): it => {
    pagebreak(weak: true, to: "odd")
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)
    counter(math.equation).update(0)
    let hdr = counter(heading).get().at(0)
    let title-content = [#text(30pt, font: "Hiragino Kaku Gothic ProN", [#h(5pt)#str(numbering("A", hdr)) \ #it.body])]
    block(title-content, below: 1.5em)
  }
  set figure(numbering: it => {
    let hdr = counter(heading).get().at(0)
    [#numbering("A", hdr).#it]
  })

  doc
}

#let acbib-template(title, doc) = {
  set page(
    numbering: "1",
    number-align: top + right,
    header: context {
      if header_components.is_even_page() {
        if header_components.is_chapter_page() {
          header_components.header_even_AB()
        } else {
          header_components.header_even_AB_second(title)
        }
      } else {
        if header_components.is_chapter_page() {
          header_components.header_odd_AB()
        } else {
          header_components.header_odd_AB_second(title)
        }
      }
    },
  )
  doc
}

// 図のキャプションと図目次のタイトルを別々に指定
#let in-outline = state("in-outline", false)
#let flex_caption(short, long) = context {
  if in-outline.get() [#short] else [#long]
}

// 進んだ注
#let advanced_footnote = body => footnote([*進んだ注：*] + body)

// メモ書きブロック
#let mymemo(body) = {
  block(fill: aqua, inset: 10pt)[#body]
}
// 要確認事項ブロック
#let TBC(body) = {
  block(fill: orange.lighten(10%), inset: 10pt)[#body]
}
// 透明コメント
#let comment_trans(body) = {
  set text(fill: black.transparentize(100%))
  body
}

// show normal comments by default.
// $ typst compile main.typ M.pdf --input hide=true
//  -> hide comments.
#let hide_comment(body, fill: green) = context {
  let hidecomment = sys.inputs.at("hide", default: "false") == "true"
  if not hidecomment {
    block(fill: fill, inset: 5pt)[#body]
    // body
  }
}


// to do list
#let todo(body, ..kw) = [
  #set text(fill: maroon, weight: "medium")
  #set highlight(fill: orange.lighten(30%).transparentize(50%))
  #highlight(..kw, body) <todo>
]

#let show_todo(body) = [
  #block(inset: 5pt, fill: green.lighten(50%))[
    To Do List: \
    #context for it in query(<todo>) {
      let pos = it.location()
      link(it.location(), "p." + repr(pos.position().page))
      [: ]
      // highlight(it.body, fill: orange.lighten(30%).transparentize(50%))
      it.body
      linebreak()
    }
  ]

  #body
]

#let pbox(pos, width: auto, dx: 0pt, dy: 0pt, alignment: left, ..arg, body) = {
  place(pos, dx: dx, dy: dy)[
    #set align(alignment)
    #block(
      width: width,
      ..arg,
    )[#body]
  ]
}

#let depth = counter("list_depth")
#let smaller_list(dd: .9em, ddd: .85em) = it => {
  let is_dd_em = dd.abs == 0pt
  let is_ddd_em = ddd.abs == 0pt
  let current_d_size = text.size

  let size_depth2 = if is_dd_em { current_d_size * dd.em } else { dd.abs }
  let size_depth3 = if is_dd_em { current_d_size * ddd.em / dd.em } else { ddd.abs }

  depth.step()
  context {
    let d = depth.get().first()
    if d == 2 {
      set text(size_depth2)
      it
    } else if d == 3 {
      set text(size_depth3)
      it
    } else { it }
    // depth4以上も対応させたかったら適宜else ifを追加して貰えば
  }
  depth.update(i => i - 1)
}

#let math-ul(doc) = box(stroke: (bottom: 1.2pt), outset: (bottom: 4pt), doc)
