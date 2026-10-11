#import "config.typ": *
#import "utils.typ": font_size, font_type
#import "@preview/hydra:0.6.2": hydra
#import "@preview/cuti:0.4.0": show-cn-fakebold, show-cn-fakeitalic
#import "theorem-env.typ": theorem-rules

#let _no-table-style = state("_no-table-style", false)

#let template(body) = {
  // 页眉与页码
  set page(
    header: context {
      set text(size: font_size.小五)
      if counter(page).get().first() >= 1 {
        grid(
          columns: (1fr, auto),
          align(left, title), align(right, hydra(1, skip-starting: false)),
        )
        v(-0.85em)
        line(length: 100%, stroke: 0.7pt)
        v(2.25pt)
      }
    },
    footer: context {
      set text(size: font_size.小五)
      let page-num = counter(page).display(here().page-numbering())
      align(center, page-num)
    },
    paper: "a4",
    margin: (x: 3.17cm, y: 2.92cm),
  )
  set page(numbering: "I")

  // 按章编号
  set figure(numbering: n => context {
    let chapter = counter(heading.where(level: 1)).get().first()
    if chapter > 0 {
      str(chapter) + "-" + str(n)
    } else {
      str(n)
    }
  })
  set math.equation(numbering: n => context {
    let chapter = counter(heading.where(level: 1)).get().first()
    if chapter > 0 {
      "(" + str(chapter) + "-" + str(n) + ")"
    } else {
      "(" + str(n) + ")"
    }
  })

  // 标题
  set heading(numbering: (..n) => {
    let pos = n.pos()
    if pos.len() == 1 {
      "第" + numbering("一", pos.at(0)) + "章"
    } else {
      pos.map(str).join(".") + sym.space.quad + h(-.3em)
    }
  })
  show heading.where(level: 1): set text(font: font_type.黑体, size: font_size.小二, weight: "regular")
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)
    counter(figure.where(kind: raw)).update(0)
    counter(math.equation).update(0)
    block()[#v(-4pt)]
    align(center, it)
    v(36.5pt, weak: true)
  }
  show heading.where(depth: 2): set text(size: font_size.三号)
  show heading.where(depth: 3): set text(size: font_size.小三)

  // 图表
  show figure.where(kind: table): set figure.caption(position: top)
  show figure.where(kind: table): set block(breakable: true)
  show figure: set text(size: font_size.五号)
  set figure.caption(separator: "　")
  show table: set math.equation(numbering: none)
  let table-starts = state("table-starts", (:))
  let sys-table-counter = counter("sys-table-counter")
  show table: it => context {
    if _no-table-style.get() {
      return it
    }

    if it.children.len() > 0 and it.children.last().func() == table.hline {
      return it
    }

    let original-args = (:)
    for (k, v) in it.fields() {
      if k not in ("children", "stroke") {
        original-args.insert(k, v)
      }
    }
    let has-header = it.children.any(c => c.func() == table.header)
    if not has-header {
      return table(
        ..original-args,
        stroke: none,
        table.hline(stroke: 1pt), ..it.children, table.hline(stroke: 1pt)
      )
    }

    let col-count = if type(it.columns) == array { it.columns.len() } else if type(it.columns) == int {
      it.columns
    } else { 1 }
    let ghost-row = table.cell(
      colspan: col-count,
      fill: none,
      inset: 0pt,
      stroke: none,
      context {
        let idx = sys-table-counter.get().first()
        let starts = table-starts.get()
        let start-page = starts.at(str(idx), default: none)
        let current-page = here().page()

        if start-page == none {
          table-starts.update(s => {
            s.insert(str(idx), current-page)
            s
          })
        } else if current-page != start-page {
          pad(bottom: 0.5em)[
            #set text(font: font_type.宋体, size: font_size.五号)
            #align(right)[续表 #counter(figure.where(kind: table)).display()]
          ]
        }
      },
    )

    let new-children = ()
    for child in it.children {
      if child.func() == table.header {
        new-children.push(table.header(
          repeat: true,
          ghost-row,
          table.hline(stroke: 1pt),
          ..child.children,
          table.hline(stroke: 0.5pt),
        ))
      } else {
        new-children.push(child)
      }
    }
    (
      sys-table-counter.step()
        + table(
          ..original-args,
          stroke: none,
          ..new-children,
          table.hline(stroke: 1pt)
        )
    )
  }
  show grid: set figure(numbering: none)

  // 正文字体
  set text(font: font_type.宋体, size: font_size.小四, lang: "zh", region: "cn", costs: (orphan: 0%))
  show smartquote: set text(font: "Times New Roman")
  set par(
    first-line-indent: (amount: 2em, all: true),
    leading: (20pt - font_size.小四) * 1.475,
    spacing: (20pt - font_size.小四) * 1.475,
    justify: true,
  )
  // 脚注字体
  show footnote.entry: set text(size: font_size.小五)

  show: show-cn-fakebold
  show: show-cn-fakeitalic

  show underline: it => context {
    let line_width = measure(it.body).width
    box[
      #set par(first-line-indent: 0em)
      #it.body
      #place(
        bottom + left,
        dy: 0.15em,
        line(length: line_width, stroke: 0.05em),
      )
    ]
  }

  // 设置 thmbox 显示格式
  show: theorem-rules

  body
}
