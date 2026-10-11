// ============================================================
// TEMPLATE.typ
// Local presentation framework + user DSL
// Use with:
//   #import "TEMPLATE.typ": *
//   #show: setup
//   #tp("Title", "Date")
// ============================================================


// Default metadata
#let default-title = "Untitled Presentation"
#let default-subtitle = none
#let default-date = "2026.5.28"
#let default-author = "梁子轩"
#let default-institute = "暨南大学 信息科学技术学院"


// Colors
#let colors = (
  primary: rgb("#3333B3"),
  block_background: rgb("#E2E2E2"),
  text_title: white,
  text_body: black,
  text_titlepage: rgb("#646464"),
  slides_background: white,
)

#let beamer-blue = colors.primary
// Fonts
#let fonts = (
  body: ("Microsoft YaHei", "Arial"),
  title: ("Arial", "Microsoft YaHei"),
  mono: ("Consolas", "Microsoft YaHei"),
)

// Global states
#let priv-primary = state("primary", colors.primary)
#let priv-title = state("title", default-title)
#let priv-subtitle = state("subtitle", default-subtitle)
#let priv-date = state("date", default-date)
#let priv-author = state("author", default-author)
#let priv-institute = state("institute", default-institute)
#let priv-content = state("priv-content", ())


// Dynamic slide counters
#let slide-ctr = counter("slide-ctr")
#let later-ctr = counter("later-ctr")
#let pos-ctr = counter("pos-ctr")
#let sub-ctr = counter("sub-ctr")

#let later(body) = [
  #later-ctr.step()
  #pos-ctr.step()
  #context {
    if pos-ctr.get().first() < sub-ctr.get().first() {
      body
    } else {
      hide(body)
    }
  }
]


// Setup
#let setup(
  ratio: "16-9",
  primary: colors.primary,
  subtitle: default-subtitle,
  author: default-author,
  institute: default-institute,
  body,
) = {
  priv-primary.update(primary)
  priv-subtitle.update(subtitle)
  priv-author.update(author)
  priv-institute.update(institute)

  set align(horizon)

  set text(
  font: fonts.body,
  fill: colors.text_body,
  size: 16pt,
  )

  set page(
    paper: "presentation-" + ratio,
    fill: colors.slides_background,
    numbering: none,
    header: none,
    footer: none,
  )

  show ref: it => text(fill: primary)[#it]
  show link: it => text(fill: primary)[#it]
  show footnote: it => text(fill: primary)[#it]

  body
}


// Title page
#let titlepage(
  title: none,
  date: none,
  subtitle: none,
  author: none,
  institute: none,
) = {
  if title != none {
    priv-title.update(title)
  }

  if date != none {
    priv-date.update(date)
  }

  if subtitle != none {
    priv-subtitle.update(subtitle)
  }

  if author != none {
    priv-author.update(author)
  }

  if institute != none {
    priv-institute.update(institute)
  }

  context {
    let title-final = priv-title.get()
    let date-final = priv-date.get()
    let subtitle-final = priv-subtitle.get()
    let author-final = priv-author.get()
    let institute-final = priv-institute.get()

    set align(center + horizon)

    box(
      width: 80%,
      height: auto,
      fill: priv-primary.get(),
      radius: 10pt,
      inset: 1em,
      outset: 1em,
    )[
      #text(size: 24pt, fill: colors.text_title)[#title-final]

      #if subtitle-final != none [
        #v(0.2cm)
        #text(size: 16pt, fill: colors.text_title)[#subtitle-final]
      ]
    ]

    let information = []
    information += v(1cm)

    if author-final != none {
      information += text(size: 16pt, fill: colors.text_titlepage)[#author-final]
    }

    if institute-final != none {
      information += v(.2cm)
      information += text(size: 16pt, fill: colors.text_titlepage)[#institute-final]
    }

    if date-final != none {
      information += v(.2cm)
      information += text(size: 18pt, fill: colors.text_titlepage)[#date-final]
    }

    information
  }
}


// Title page alias
#let tp(
  title,
  date,
  subtitle: none,
  author: none,
  institute: none,
) = titlepage(
  title: title,
  date: date,
  subtitle: subtitle,
  author: author,
  institute: institute,
)


// Blocks
#let my-block(
  title: none,
  body,
) = context (
  stack(
    dir: ttb,
    spacing: 0pt,

    block(
      width: 100%,
      height: auto,
      fill: priv-primary.get(),
      radius: (top: 10pt),
      inset: .59cm,
    )[
      #text(size: 16pt, fill: colors.text_title)[#title]
    ],

    block(
      width: 100%,
      height: auto,
      fill: colors.block_background,
      radius: (bottom: 10pt),
      inset: .59cm,
    )[
      #body
    ],
  )
)

#let blk(title, body) = my-block(title: title)[
  #body
]


// Layout helpers
#let twocol(
  left,
  right,
  ratio: (1fr, 2fr),
  gutter: 1cm,
) = grid(
  columns: ratio,
  gutter: gutter,

  [
    #left
  ],

  [
    #right
  ],
)

#let threecol(
  a,
  b,
  c,
  ratio: (1fr, 1fr, 1fr),
  gutter: 0.6cm,
) = grid(
  columns: ratio,
  gutter: gutter,

  [#a],
  [#b],
  [#c],
)


// Image helper
#let img(
  path,
  w,
  h,
) = image(
  path,
  width: w,
  height: h,
)


// Content registry
#let register(name) = context {
  let loc = here()

  priv-content.update(old => old + ((title: name, loc: loc),))
}


// Slide primitives
#let inner-slide(
  title: none,
  ctr: counter(page),
  body,
) = {
  pagebreak()

  set page(
    background: context {
      place(top + left)[
        #block(
          width: 100%,
          height: auto,
          fill: priv-primary.get(),
          inset: .59cm,
        )[
          #text(
            font: fonts.title,
            size: 20pt,
            weight: "bold",
            fill: colors.text_title,
          )[
            #title
          ]
        ]
      ]

      place(bottom + left)[
        #block(
          width: 100%,
          height: auto,
          fill: priv-primary.get(),
          inset: .2cm,
        )[
          #text(size: 10pt, fill: colors.text_title)[
            #priv-date.get(): #priv-title.get()
            #h(1fr)
            #priv-author.get()
            #h(1fr)
            #ctr.display("1/1", both: true)
          ]
        ]
      ]
    },
  )

  body
}

#let slide(
  title: none,
  body,
) = {
  slide-ctr.step()

  let inner = inner-slide(title: title, ctr: slide-ctr)[#body]

  later-ctr.update(0)
  pos-ctr.update(0)
  sub-ctr.update(1)

  inner

  context {
    for _ in range(later-ctr.get().first()) {
      sub-ctr.step()
      pos-ctr.update(0)
      inner
    }
  }
}


// Short slide aliases
#let s(title, body) = slide(title: title)[
  #body
]

#let s2(
  title,
  left,
  right,
  ratio: (1fr, 2fr),
  gutter: 1cm,
  width: 100%,
  height: auto,
) = s(title)[
  #block(width: width, height: height)[
    #twocol(
      left,
      right,
      ratio: ratio,
      gutter: gutter,
    )
  ]
]

#let s3(
  title,
  a,
  b,
  c,
  ratio: (1fr, 1fr, 1fr),
  gutter: 0.6cm,
  width: 100%,
  height: auto,
) = s(title)[
  #block(width: width, height: height)[
    #threecol(
      a,
      b,
      c,
      ratio: ratio,
      gutter: gutter,
    )
  ]
]


// Section / toc / references
#let section(title: none) = context {
  pagebreak()

  set align(center + horizon)

  block(
    width: 80%,
    height: auto,
    fill: priv-primary.get(),
    radius: 10pt,
    inset: 1em,
    outset: 1em,
  )[
    #text(
      font: fonts.title,
      size: 24pt,
      weight: "bold",
      fill: colors.text_title,
    )[
      #title
    ]
  ]

  register(title)
}

#let sec(title) = section(title: title)

#let references(
  title: "References",
  bib,
) = {
  set bibliography(
    title: none,
    style: "ieee",
  )

  slide(title: title)[
    #bib
  ]
}

#let content(
  title: "Table of contents",
) = {
  slide(title: title)[
    #context {
      let registered = priv-content.final()

      if registered.len() == 0 {
        [No sections registered.]
      } else {
        enum(..registered.map(section => link(section.loc, section.title)))
      }
    }
  ]
}

#let cot(title) = content(title: title)


// Table DSL
#let row(..cells) = cells.pos()

#let r = row

#let tbl(
  ..rows,
  columns: auto,
  inset: 4pt,
  stroke: 0.5pt + rgb("#6b7280"),
  align: left,
  width: 100%,
) = {
  let rs = rows.pos()

  if rs.len() == 0 {
    return []
  }

  let ncols = rs.first().len()

  for current-row in rs {
    if current-row.len() != ncols {
      panic("tbl: every row must have the same number of cells")
    }
  }

  let colspec = if columns == auto {
    ncols
  } else {
    columns
  }

  block(width: width)[
    #table(
      columns: colspec,
      inset: inset,
      stroke: stroke,
      align: align,
      ..rs.flatten(),
    )
  ]
}

#let tbl2(
  ..rows,
  columns: (38%, 62%),
  inset: 4pt,
  stroke: 0.5pt + rgb("#6b7280"),
  align: left,
  width: 100%,
) = tbl(
  ..rows.pos(),
  columns: columns,
  inset: inset,
  stroke: stroke,
  align: align,
  width: width,
)


// Backward-compatible table name
#let small-table(cols, rows) = table(
  columns: cols,
  inset: 4pt,
  stroke: 0.5pt + rgb("#6b7280"),
  align: left,
  ..rows,
)