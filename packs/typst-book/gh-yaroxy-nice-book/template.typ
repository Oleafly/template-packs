// #import "template.typ": nice-doc, yaroxy, callout, math-callout, math-callout-kind


// predefined author information
#let yaroxy = (
  (
    name: [Atlas Roxy Sun],
    bs-university: [Harbin Institute of Technology],
    ms-university: [University of Science and Technology of China],
    edu-email: [yaroxy\@mail.ustc.edu.cn],
    google-email: [atlasroxysun\@gmail.com],
    outlook-email: [atlasroxysun\@outlook.com],
    github: [#link("https://github.com/yaroxy")[yaroxy\@github]]
  )
)

// predefined font size
#let font-size = (
  ChuHao: 42pt,
  XiaoChu: 36pt,
  YiHao: 26pt,
  XiaoYi: 24pt,
  ErHao: 22pt,
  XiaoEr: 18pt,
  SanHao: 16pt,
  XiaoSan: 15pt,
  SiHao: 14pt,
  ZhongSi: 13pt,
  XiaoSi: 12pt,
  WuHao: 10.5pt,
  XiaoWu: 9pt,
  LiuHao: 7.5pt,
  XiaoLiu: 6.5pt,
  QiHao: 5.5pt, 
  XiaoQi: 5pt
)

// predefined font style
#let font-style = (
  Code: ("JetBrains Mono", "Noto Serif CJK SC"),
  Book: (
    (name: "Minion Pro", covers: "latin-in-cjk"),
    (name: "Noto Serif CJK SC"),
    // (name: "Noto Serif SC"),
  )
)

// reference: photokit.com
#let callout-color = (
  spanish-carmine: rgb(209,0,71),
  regalia: rgb(82,45,128),
  carrot: rgb(253,111,59),
  marker-blue: rgb(0,134,154),
)

// reference: articulate-coderscompass
/// callout function to create a styled note box.
/// It takes a title, an icon, a color, and the body content. Only
/// the body is required, the rest are optional.
/// -> content
#let callout(
  title: none,             // The title of the callout box. Optional.
  color: callout-color.marker-blue, // The color of the callout box. Optional, defaults to Coders' Compass accent blue.
  par-indent: 0em,             // The indent of the callout box. Optional, defaults to 0em.
  list-indent: 0em,            // The indent of the list in the callout box. Optional, defaults to 0em.
  body                     // The body content of the callout box. This is required.
) = {
  block(
    width: 100%,
    fill: color.lighten(90%),
    stroke: (left: 3pt + color),
    inset: 1em,
    radius: 2pt,
    breakable: true,
  )[
    #set par(
      first-line-indent: 0em,
    )

    #if title != none {
      text(
        weight: "semibold",
        fill: color.darken(25%),
        size: 1em,
      )[#title]
      
      // v(0.3em)
    }

    #set par(
      first-line-indent: (
        amount: par-indent,
        all: true,
      ),
    )
    #set enum(indent: list-indent)
    #set list(indent: list-indent)

    #body
  ]
}

// reference: numbly
#let numbly(..arr, default: "1.") = (..nums) => {
  let arr = arr.pos()
  nums = nums.pos()
  if nums.len() > arr.len() {
    if default == none {
      return none
    }
    if type(default) == function {
      return default(..nums)
    }
    return numbering(default, ..nums)
  }
  let format = arr.at(nums.len() - 1)
  if format == none {
    return none
  }
  if type(format) == function {
    return format(..nums)
  }
  format.replace(
    regex("\{(\d)(:(.+?))?\}"),
    m => {
      let (a, b, c) = m.captures
      if b != none {
        numbering(c, nums.at(int(a) - 1))
      } else {
        str(nums.at(int(a) - 1))
      }
    },
  )
}

#let math-callout-kind = (
  definition: (
    name: "Definition",
    color: callout-color.spanish-carmine,
  ),
  theorem: (
    name: "Theorem",
    color: callout-color.regalia,
  ),
  lemma: (
    name: "Lemma",
    color: callout-color.carrot,
  ),
  corollary: (
    name: "Corollary",
    color: callout-color.marker-blue,
  ),
  axiom: (
    name: "Axiom",
    color: callout-color.marker-blue,
  ),
  postulate: (
    name: "Postulate",
    color: callout-color.marker-blue,
  ),
  proposition: (
    name: "Proposition",
    color: callout-color.marker-blue,
  ),
  proof: (
    name: "Proof",
    color: callout-color.regalia,
  ),
)

#let math-callout-numbering-format(kind) = context {
  let heading-num = counter(heading).get().first()
  let callout-num = counter(kind).get().first()

  numbering("1.1", heading-num, callout-num)
}

#let math-callout(
  kind: math-callout-kind.definition,
  number: true,
  title: [],
  it
) = {
  if number {counter(kind.name).step()}

  let name = emph[#kind.name]+ h(0.5em) + emph[#if number {math-callout-numbering-format(kind.name)}] + h(0.5em) + title
  
  callout(color: kind.color, title: name, par-indent: 2em, it)
}

// book
#let nice-cover(
  main-title: [],
  sub-title: [],
  authors: (),
  date: datetime.today(),
  cover-image: none
) = {

  if type(authors) == dictionary {
    authors = (authors,)
  }

  if type(date) == datetime {
    date = date.display("[year].[month].[day]")
  }

  set page(margin: 0pt)

  if cover-image != none {
    image(cover-image, width: 100%, height: 50%)
    v(3em)
  } else {
    v(10em)
  }

  set align(center)
  text(font: font-style.Book, size: font-size.YiHao)[#main-title]
  v(0.5em)
  h(1em)
  text(font: font-style.Book, size: font-size.ErHao, style: "italic")[#sub-title]
  h(1em)
  v(0.5em)

  let count = authors.len()
  let ncols = calc.min(count, 2)
  grid(
    columns: (1fr,) * ncols,
    row-gutter: 3em,
    ..authors.map(author => {
      for (k, v) in author {
        text(font: font-style.Book, size: font-size.SanHao)[#v]
        linebreak()
      }
    })
  )

  text(font: font-style.Book, size: font-size.SanHao)[#date]

  pagebreak(weak: true)
}

#let nice-preface(it) = {
  set page(numbering: none)

  pagebreak(weak: true)

  // counter(page).update(0)

  align(center)[
    #heading(
      level: 1,
      numbering: none,
      outlined: false
    )[Preface]
  ]

  it

  pagebreak(weak: true)
}

#let nice-outline(
  con-depth: 2,
) = {
  
  // remove footnote from outline
  set footnote.entry(
    separator: ""
  )
  show footnote: none
  show footnote.entry: hide

  counter(page).update(1)
  set page(numbering: "I")

  show outline.entry.where(level: 1): it => {
    set block(above: 1.2em)
    it
  }
  set outline.entry(fill: repeat(" . "))

  // contents
  context if counter("heading").at(<end>).at(0) > 0 {
    show outline.entry.where(level: 1): it => {
      strong(it)
    }
    align(center)[
      #heading(
        numbering: none,
        bookmarked: true,
        outlined: false
      )[Contents]
    ]
    outline(
      title: none,
      indent: 1.8em,
      depth: con-depth
    )
    pagebreak(weak: true)
  }

  // list of figures
  context if counter("image").at(<end>).at(0) > 0 {
    align(center)[
      #heading(
        numbering: none,
        bookmarked: true,
        outlined: false
      )[List of Figures]
    ]
    outline(
      title: none,
      target: figure.where(kind: image)
    )
    pagebreak(weak: true)
  }

  context if counter("table").at(<end>).at(0) > 0 {
    align(center)[
      #heading(
        numbering: none,
        bookmarked: true,
        outlined: false
      )[List of Tables]
    ]
    outline(
      title: none,
      target: figure.where(kind: table)
    )
    pagebreak(weak: true)
  }
}


#let nice-body(
  section-prefix: none, //none, Chapter, Section, Subject
  it
) = {
  let section-name = state("section-name", "")

  // figure
  set figure(
    numbering: it => numbering("1.1", counter(heading).get().first(), it)
  )
  show table: it => {
    if table.hline() in it.children {
      return it
    }
    let children = it.children
    let new_children = ()
    for i in children {
      new_children += (i,)
      if repr(i).starts-with("header") {
        new_children += (table.hline(),)
      }
    }
    let meta = it.fields()
    meta.remove("children")
    return table(..meta, table.hline(),..new_children,table.hline())
  }

  // heading numbering
  set heading(
      numbering: numbly(
      section-prefix.text + " {1}",
      "{1}.{2}",
      "{1}.{2}.{3}",
      "{4:I.}",
      "{5:(1)}",
      "({5:1.}{6:1})",
      "({5:1.}{6:1.}{7:1})",
    )
  )

  show heading.where(level: 1): it => {
    set align(center)
    
    counter(math.equation).update(0)
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)

    for kind in math-callout-kind.keys() {
      counter(math-callout-kind.at(kind).name).update(0)
    }

    section-name.update(it)

    pagebreak(weak: true)

    it
  }

  // math
  set math.equation(
    numbering: it => numbering("(1.1)", counter(heading).get().first(), it)
  )

  // body content
  pagebreak(weak: true)

  counter(page).update(1)
  // set page(numbering: "1")
  set page(
    numbering: "1",
    header: context {
      if calc.odd(counter(page).get().first()) {
        align(right, document.title)
      } else {
        align(left, section-name.get())
      }
      // line(length: 100%)
    }
  )

  it

  pagebreak(weak: true)
}


#let nice-reference(
  path: none,
  style: "american-psychological-association",
  full: true
) = {
  pagebreak(weak: true)

  bibliography(
    title: [References],
    style: style,
    full: full,
    path
  )
  pagebreak(weak: true)
}


#let nice-appendix(it) = {
  set heading(
    numbering: numbly(
      "{1:A}.",
      "{1:A}.{2}",
      "{3:I}",
    )
  )
  counter(heading).update(0)

  set figure(
    numbering: it => numbering("A.1", counter(heading).get().first(), it)
  )
  set math.equation(
    numbering: it => numbering("(A.1)", counter(heading).get().first(), it)
  )

  show heading.where(level: 1): it => {
    pagebreak(weak: true)

    counter(math.equation).update(0)
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)

    it
  }

  pagebreak(weak: true)

  it
  
  pagebreak(weak: true)
}


#let nice-epilogue(it) = {
  
  pagebreak(weak: true)

  align(center)[
    #heading(
      level: 1,
      numbering: none,
      outlined: true
    )[Epilogue]
  ]

  it

  pagebreak(weak: true)
}


#let nice-doc(
  appendix: none,
  authors: (),
  con-depth: 2,
  cover-image: none,
  date: datetime.today(),
  epilogue: none,
  main-title: [],
  margin: (x: 20mm, y: 20mm),
  lang: "en",
  page-fill: none,
  paper: "us-letter",
  preface: none,
  reference: none,
  region: "en",
  section-prefix: [Chapter], //Section, Subject
  smart-quote: true,
  sub-title: [],
  text-fill: none,
  it
) = {

  // set metadate
  set document(
    title: main-title,
    date: date,
    author: "Atlas Roxy Sun",
  )

  // page
  set page(
    paper: paper, 
    margin: margin,
    fill: if page-fill == none {rgb(255, 255, 255)} else {page-fill},
    // fill: rgb("CCE8CF")
    // fill: rgb("000c18"),
    // fill: rgb("fdf6e3")
    // fill: rgb("000000")
  )

  // text
  set text(
    font: font-style.Book,
    size: font-size.WuHao,
    lang: lang,
    region: region,
    fill: if text-fill == none {rgb(0, 0, 0)} else {text-fill},
    // fill: rgb("6283c4")
  )

  // cover
  nice-cover(
    main-title: main-title,
    sub-title: sub-title,
    authors: authors,
    date: date,
    cover-image: cover-image
  )

  set page(
    background: rotate(
      24deg,
      text(18pt, fill: rgb("FFCBC4"))[
        *ATLAS ROXY SUN*
      ]
    )
  )

  // global style settings
  set quote(block: true)
  set smartquote(enabled: smart-quote)
  set footnote(numbering: "[1]")
  show heading: set block( above: 1em, below: 1em)
  set list(indent: 0em) // 1.15em
  set enum(full: true, indent: 0em)
  set underline(offset: .15em, stroke: .05em, evade: false)
  show link: set text(fill: rgb(127, 0, 0))
  // show math.equation.where(block: false): math.display
  set math.vec(delim: "[")
  set figure.caption(separator: " ")
  set table(align: center + horizon)
  set table(stroke: none)
  show figure: it => {
    set block(breakable: true)
    it
  }
  show figure.where(
    kind: table
  ): it => {
    set figure.caption(position: top)
    it
  }
  show table: it => {
    counter("table").step() // create table of contents
    it
  }
  show image: it => {
    counter("image").step() // create table of contents
    it
  }
  show heading: it => {
    counter("heading").step() // create table of contents
    if it.level == 1 {
      counter(footnote).update(0)
    }
    it
  }

  // code
  show raw.where(block: false): it => {
    text(fill: rgb(127, 0, 0), font: font-style.Code)[#it]
  }
  show raw.where(block: true): it => {
    set par(justify: false)
    set text(font: font-style.Code)

    block(
      fill: luma(245),
      inset: (top: 4pt, bottom: 4pt),
      radius: 4pt,
      width: 100%,
      breakable: true,
      stack(
        ..it.lines.map(raw_line => block(
          inset: 3pt,
          width: 100%,
          grid(
            columns: (1em + 4pt, 1fr),
            align: (right + horizon, left),
            column-gutter: 0.7em,
            row-gutter: 0.6em,
            text(gray, [#raw_line.number]), raw_line,
          ),
        )),
      ),
    )
  }

  // paragraph
  set par(
    first-line-indent: (
      amount: 2em,
      all: true,
    ),
    justify: true,
    leading: 1em,
    spacing: 1em,
    linebreaks: "optimized"
  )

  // preface
  if preface != none {
    nice-preface()[#preface]
  }

  // outline
  nice-outline(
    con-depth: con-depth
  )

  // body
  nice-body(
    section-prefix: section-prefix
  )[#it]

  if reference != none {
    nice-reference(path: reference)
  }

  if appendix != none {
    nice-appendix()[#appendix]
  }

  if epilogue != none {
    nice-epilogue()[#epilogue]
  }

  pagebreak(weak: true)

  set align(center + horizon)

  text(size: font-size.YiHao)[
    The End <end>
  ]
}

// no numbering equation
#let nnmath(it) = math.equation(block: true, numbering: none, it)

// color box
#let cbox(color: callout-color.spanish-carmine, it) = {
  box(
    fill: color,
    inset: (x: 3pt, y: 0pt),
    outset: (y: 3pt),
    radius: 2pt,
  )[#it]
}