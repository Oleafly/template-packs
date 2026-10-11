#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *
#import "@preview/headcount:0.1.0": *
#import "@preview/pintorita:0.1.4" as pintorita
#import "@preview/typxidian:0.1.2": make-callout-fn, math-callout, info, faq, tip, success, danger, definition, theorem, proof

#let sizes = (
  chapter: 26pt,
  section: 18pt,
  subsection: 16pt,
  subsubsection: 14pt,
  subsubsubsection: 12pt,
  body: 10pt,
)

#let colors = (
  purple: rgb("7e1dfb"),
  darkgray: rgb("6d6e6d"),
  cyan: rgb("53dfdd"),
  red: rgb("fb464c"),
  orange: rgb("e9973f"),
  green: rgb("44cf6e"),
  info: (
    title: rgb("306bf6"),
    bg: rgb("eaf0fb"),
  ),
  faq: (
    title: rgb("dd7c2e"),
    bg: rgb("fcf2ea"),
  ),
  tip: (
    title: rgb("56bcbb"),
    bg: rgb("eef8f8"),
  ),
  success: (
    title: rgb("54b651"),
    bg: rgb("eef8ec"),
  ),
  danger: (
    title: rgb("d64043"),
    bg: rgb("fbecee"),
  ),
)

#let coverpage(
  title: none,
  subtitle: none,
  logo: none,
  university: none,
  major: none,
  supervisor: none,
  author: none,
  xno: none,
) = {
  set page(numbering: none)
  set align(left + horizon)
  
  set par(leading: 1.5em)

  
  
  text(
    size: 32pt, 
    weight: "bold", 
    lang: "zh",
  )[#title]

  if subtitle != none {
    linebreak()
    v(1em)
    text(18pt)[#subtitle]
  }

  line(length: 75%)

  grid(
    columns: 2,
    gutter: 10pt,
    text(weight: "bold")[姓名],
    author,
    text(weight: "bold")[学号],
    xno,
  )

  v(40%)

  pagebreak()
}

#let contentpage(

) = {
  counter(page).update(1)
  set page(numbering: "I")
  set outline.entry(
    fill: grid(
      columns: 2,
      gutter: 0pt,
      repeat[#h(5pt).], h(11pt),
    ),
  )
  show outline.entry: set text(size: 11pt)
  show outline.entry: set block(above: 10pt)

  show outline.entry.where(level: 1): set outline.entry(fill: none)
  show outline.entry.where(level: 1): set text(weight: "semibold", size: 11pt)
  show outline.entry.where(level: 1): set block(above: 24pt)

  // heading(level: 1, "目录", numbering: none)
  // outline(depth: 3, indent: auto, title: none, target: heading)
  
  outline(
    title: heading[
      目录
      #v(0.4em)
      #line(length: 3em)
    ],
    depth: 3,
    indent: auto,
    target: heading,
  )
}

#let rounded(
  item,
  radius: 10pt
) = {
  block(
    clip: true,
  	radius: radius,
    item
  )
}

#let dvdbr3otypst(
  title: none,
  subtitle: [],
  title_font: none,
  content_font: none,
  code_font: none,
  theme_color: color,
  author: none,
  xno: none,
  bib: [],
  math-font: "new computer modern math",
  citation-style: "alphanumeric",
  cite-color: colors.purple,
  ref-color: colors.purple,
  link-color: colors.purple,
  paper-size: "a4",
  doc,
) = {
  show: codly-init.with()

  show raw: set text(
    font: ("CaskaydiaCove NF", "HarmonyOS Sans SC"),
    size: 1.03em
  )
  
  set text(font: "HarmonyOS Sans SC")
  set page(paper: "a4")
  show raw: set block(
    above: 2.0em,
    below: 2.0em,
  )
  show raw.where(lang: "pintora"): it => pintorita.render(it.text)
  show math.equation: set text(font: math-font)

  coverpage(
    title: title,
    subtitle: subtitle,
    author: author,
    xno: xno,
  )

  contentpage()

  set cite(style: citation-style)

  show cite: set text(fill: cite-color)
  show ref: set text(fill: ref-color)

  show link: it => {
    if type(it.dest) == str {
      // ext link
      text(fill: link-color)[#underline(it.body)]
    } else {
      it
    }
  }

  set page(paper: paper-size, binding: left, margin: (inside: 2.54cm, outside: 3.04cm))

  set par(
    first-line-indent: 0em, 
    spacing: 1.2em, 
    justify: true, 
    linebreaks: "optimized"
  )
  set list(indent: 1em, spacing: 0.85em, marker: ([•], [--]))
  show list: set block(inset: (top: 0.35em, bottom: 0.35em))

  set heading(numbering: "1.1")
  set figure(numbering: dependent-numbering("1.1", levels: 1))
  set math.equation(numbering: dependent-numbering("(1.1)", levels: 1))

  show heading: hd => context {
    if hd.level == 1 {
      let hd-counter = counter(heading).get().first()

      align(left, text(size: sizes.chapter, [
        #stack(
          spacing: 1em,
          line(length: 100%, stroke: 1pt + black),
          box([
            #if hd.numbering != none {
              [#hd-counter]
              h(0.75em)
              box(line(stroke: 1pt + black, angle: 90deg, length: 30pt), baseline: 6pt)
              h(0.75em)
            }
            #hd.body]),
          line(length: 100%, stroke: 1pt + black),
        )
        #v(0.75em)
      ]))
    } else {
      let text-size = if hd.level == 1 {
        sizes.section
      } else if hd.level == 2 {
        sizes.subsection
      } else if hd.level == 3 {
        sizes.subsubsection
      } else {
        sizes.subsubsubsection
      }
      set text(size: text-size)
      block(inset: (top: 0.5em, bottom: 0.5em), {
        context counter(heading).display()
        h(0.75em)
        hd.body
      })
    }
  }

  show ref: it => {
    let el = it.element

    if el != none and el.func() == math.equation {
      [#el.supplement #counter(math.equation).display(dependent-numbering("1.1"))]
    } else {
      it
    }
  }

  codly(
    zebra-fill: none,
    languages: (
      cpp: (
        name: "c++",
        color: rgb("#38a5e4")
      )
    ),
  )

  counter(page).update(1)
  set page(numbering: "1")
  doc

  if bib != none and bib != [] {
    pagebreak()
    show bibliography: set par(spacing: 1.2em)
    show bibliography: set bibliography(
      title: [引用],
      style: "ieee",
    )

  counter(page).update(1)
  set page(numbering: "i")
    bib
  }
}
