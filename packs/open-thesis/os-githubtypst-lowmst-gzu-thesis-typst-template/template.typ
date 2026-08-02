#let template(
  western_font: "Times New Roman",
  doc
) = {
  set page(
    margin: (top: 30mm, right: 25mm, bottom: 25mm, left: 25mm),
    header-ascent: 0.5em,
    header: [
      #set text(font: (western_font, "SimHei"))
      #set align(center)
      #box(width: 90%, inset: 0pt)[
        #grid(
          columns: (1fr, auto, 1fr),
          align: (left+horizon, center+horizon, right+horizon),
          image("logo.png", width: 1.2cm),
          [贵州大学本科毕业论文（设计）],
          context counter(page).display("第1页")
        )
      ]
      #v(-0.5em)
      #line(length: 100%, stroke: 0.75pt)
    ]
  )

  set text(font: (western_font, "SimSun"), size: 12pt, top-edge: 1em, lang: "zh")

  set par(first-line-indent: 2em, leading: 22pt - 1em, spacing: 22pt - 1em, justify: true)
  let fakepar = context {
      let b=par(box());
      b;
      v(-measure(b+b).height)
  }
  show heading: it => it + fakepar

  set heading(numbering: "1.1")
  show heading: set text(font: (western_font, "SimHei"), weight: "regular")
  show heading: set block(spacing: 22pt) // ?
  show heading.where(level: 1): set text(size: 16pt)
  show heading.where(level: 2): set text(size: 14pt)

  show figure: set text(size: 10.5pt)
  show figure.where(kind: table): set figure.caption(position: top)

  show strong: set text(font: (western_font, "SimHei"))
  show emph: set text(font: (western_font, "KaiTi"))

  set table(stroke: none)
  
  doc
}

#let linetable(..content) = {
  table(
    table.hline(stroke: 1.5pt),
    ..content,
    table.hline(stroke: 1.5pt)
  )
}

#let ud = math.class(
  "normal",
  $upright(d)$
)

#let ue = math.class(
  "normal",
  $upright(e)$
)

#let uexp(content) = math.class(
  "normal",
  $upright(e)^#content$
)