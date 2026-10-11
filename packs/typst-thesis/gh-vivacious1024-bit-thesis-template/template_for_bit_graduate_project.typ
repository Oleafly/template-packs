// template_for_bit_graduate_project.typ

#let project(
  title: "",
  authors: (),
  date: none,
  body,
) = {
  set document(author: authors, title: title)

  set page(
    paper: "a4",
    margin: (left: 30mm, right: 26mm, top: 35mm, bottom: 26mm),
    header: {
      set text(font: "SimSun", size: 14pt, tracking: 0.5pt)
      set align(center)
      block(width: 100%, inset: (bottom: 5pt), stroke: (bottom: 0.5pt))[
        北京理工大学本科生毕业设计（论文）
      ]
    },
    footer: {
      set text(font: "SimSun", size: 10.5pt)
      set align(center)
      context counter(page).display("1")
    },
  )

  set text(font: ("SimSun", "Times New Roman"), lang: "zh", size: 12pt)
  set par(
    leading: 10pt,
    justify: true,
    first-line-indent: (amount: 2em, all: true),
  )

  set list(indent: 2em)
  set enum(indent: 2em)

  set heading(numbering: (..nums) => {
    let nums = nums.pos()
    if nums.len() == 1 {
      "第" + str(nums.first()) + "章"
    } else {
      nums.map(str).join(".")
    }
  })

  show heading: it => {
    set text(font: "SimHei", weight: "bold", tracking: 0pt)
    set par(leading: 0.5em, first-line-indent: 0pt)

    if it.level == 1 {
      counter(math.equation).update(0)
    }

    let size-l1 = 16pt
    let size-l2 = 14pt
    let size-l3 = 12pt

    let base-leading = 10pt
    let line-height = 22pt

    let spacing-below-0 = base-leading
    let spacing-below-1 = base-leading + 1 * line-height
    let spacing-above-05 = base-leading + 0.5 * line-height

    let (font-size, spacing-above, spacing-below, alignment) = if it.level == 1 {
      (size-l1, spacing-above-05, spacing-below-1, center)
    } else if it.level == 2 {
      (size-l2, spacing-above-05, spacing-below-0, left)
    } else {
      (size-l3, spacing-above-05, spacing-below-0, left)
    }

    set text(size: font-size)
    set align(alignment)

    block(
      above: spacing-above,
      below: spacing-below,
      sticky: true,
      it,
    )
  }

  show outline.entry: it => {
    if it.element.func() == heading {
      let indent = (it.level - 1) * 2em
      h(indent)
      link(it.element.location(), it.indented(
        it.prefix(),
        it.body() + box(width: 1fr, repeat[.]) + str(it.page()),
      ))
    } else {
      it
    }
  }
  set outline(indent: 1em)

  set figure(numbering: "1-1")

  show figure: it => {
    set align(center)
    set text(font: "SimSun", size: 10.5pt)
    block(above: 32pt, below: 32pt, it)
  }

  show figure.where(kind: image): set figure(supplement: "图")
  show figure.where(kind: table): set figure(supplement: "表")
  show figure.where(kind: table): set figure.caption(position: top)
  show figure.caption: set text(font: "SimSun", size: 10.5pt, weight: "regular")

  set math.equation(numbering: (..nums) => {
    let all = nums.pos()
    let chapter = counter(heading).get().first()
    let eq-num = all.last()
    "(" + str(chapter) + "-" + str(eq-num) + ")"
  })

  show ref: it => {
    let el = it.element
    if el != none and el.func() == math.equation {
      link(
        el.location(),
        "式"
          + numbering(
            el.numbering,
            ..counter(heading).at(el.location()),
            counter(math.equation).at(el.location()).first(),
          ),
      )
    } else {
      it
    }
  }

  if title != "" {
    align(center)[
      #block(text(font: "SimHei", weight: "bold", size: 20pt, title))
      #v(2em)
      #if date != none {
        text(size: 14pt, date)
      }
    ]
    // 不强制换页，标题后正文直接继续
  }

  counter(page).update(1)

  set bibliography(style: "china-national-standard-gb-t-7714-2015-numeric.csl", title: text(
    font: "SimHei",
    weight: "bold",
    size: 16pt,
  )[参考文献])

  body
}

#let appendix(body) = {
  counter(heading).update(0)
  counter(figure).update(0)

  set heading(numbering: (..nums) => {
    let nums = nums.pos()
    if nums.len() == 1 {
      "附录" + numbering("A", nums.first())
    } else {
      numbering("A.1", ..nums)
    }
  })

  set figure(numbering: (..nums) => {
    let chapter = numbering("A", counter(heading).get().first())
    let fig-num = nums.pos().last()
    chapter + "-" + str(fig-num)
  })

  set math.equation(numbering: (..nums) => {
    let chapter = numbering("A", counter(heading).get().first())
    let eq-num = nums.pos().last()
    "(" + chapter + "-" + str(eq-num) + ")"
  })

  body
}

// 默认三线表：上/下线 1.5pt，表头下线 0.75pt
#let bit_three_line_table(columns: 3, header: (), body: (), caption: none) = {
  let row-count = if columns > 0 { calc.floor(body.len() / columns) } else { 0 }

  figure(
    table(
      columns: columns,
      align: center + horizon,
      stroke: none,
      table.hline(y: 0, stroke: 1.5pt),
      table.hline(y: 1, stroke: 0.75pt),
      table.hline(y: row-count + 1, stroke: 1.5pt),
      table.header(..header),
      ..body,
    ),
    kind: table,
    caption: caption,
  )
}
