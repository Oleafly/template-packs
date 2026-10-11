#import "utils.typ": date-fmt, ref-date-fmt

#let project(
  title: "", author: "",
  show-name: true, body
) = {
  // set the document's basic properties
  set document(author: author, title: title)
  set text(hyphenate: false, size: 15pt, lang: "zh")
  set text(font: ("Linux Libertine", "Noto Serif CJK SC"))
  set page(numbering: "i", footer: none)
  set par(justify: true, spacing: 1.5em)

  // init states: date counter, show name
  state("date").update(none) // none or yyyymmdd
  state("show-name").update(show-name) // true or false
  state("todo").update(()) // array of dict
  
  // heading rules
  set heading(numbering: "壹点壹") // chinese chapter number
  show heading: it => {
    if (it.level >= 2) { // clear date counter
      state("date").update(none)
    }
    if (it.level == 1) [
      #counter(footnote).update(0)
      #align(center)[
        #pagebreak(weak: true)
        --- *#it.body* ---
      ]
    ] else [
      *#it.body*
    ]
  }

  // title page
  v(1fr)
  block(text(weight: "bold", 32pt, title))
  v(1em)
  block(text(weight: "bold", 20pt, author))

  // outline page
  set outline.entry(fill: repeat[$dot$])
  show outline.entry: it => link(
    it.element.location(),
    it.indented([*#it.prefix()*], it.inner()),
  )
  outline(depth: 1)

  // main body style
  set page(
    numbering: "壹",
    footer: context [
      #align(center)[
        #counter(page).display("/ 壹 /")
      ]
    ]
  )
  counter(page).update(1)

  // display rules
  show link: set text(fill: blue, weight: "bold")
  set quote(block: true)
  show quote: set pad(x: 1em)
  set list(marker: [--], indent: 1em)
  set enum(indent: 1em)

  // main body
  body
}

// diary entry and ref
#let diary-entry(date, ..additional) = [
  #let conn = " " + sym.dot + " "
  #let heading-text = date-fmt(date)
  #if additional.pos() != () {
    heading-text += conn + additional.pos().join(conn)
  }
  #heading(
    level: 2,
    heading-text
  )
  #label("diary:" + date)
  #state("date").update(date)
]

#let diary-ref(date-dst) = context {
  let res = query(
    label("diary:" + date-dst)
  )
  assert(
    res.len() != 0,
    message: "no such diary entry: " + date-dst
  )
  let date-src = state("date").get()
  assert(
    date-src != none,
    message: "need to be in a diary entry"
  )
  link(
    res.at(0).location(),
    ref-date-fmt(date-dst, date-src)
  )
}

// todo
#let todo(body) = [
  #context [
    #text(
      fill: red, weight: "bold"
    )[TODO: #body]
    #label("todo:" + str( // <todo:1>, ...
      state("todo").get().len() + 1
    ))
  ]
  #state("todo").update(
    it => it + (body, )
  )
]

#let show-todo() = context {
  let todo-list = state("todo").final()
  for i in range(todo-list.len()) {
    list.item({
      link(
        label("todo:" + str(i + 1)),
        todo-list.at(i)
      )
    })
  }
}

// hide one's name
#let name(body) = context {
  text(
    fill: purple, weight: "bold",
    if (state("show-name").get()) {
      body
    } else {
      "＊" * body.codepoints().len()
    }
  )
}

#let poem(body) = align(center)[
  #line(length: 80%)
  *#body*
  #line(length: 80%)
]

#let qa(q, a) = table(
  columns: (auto, 1fr),
  stroke: none,
  [#text(fill: red)[*Q*]], q,
  [#text(fill: blue)[*A*]], a,
  table.vline(
    stroke: 1.2pt + red,
    x: 1, start: 0, end: 1
  ),
  table.vline(
    stroke: 1.2pt + blue,
    x: 1, start: 1, end: 2
  ),
)
