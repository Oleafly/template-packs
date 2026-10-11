#let agh(
  titles: (),
  bibliography-content: none,
  author: [Author],
  supervisor: [Supervisor],
  course: [Course],
  masters: bool,
  department: [Department],
  acknowledgements: (),
  ai-statement: none,
  abstract: none,
  sans-font: "Liberation Sans",
  body,
) = {

  // global settings {{{

  let sans(..args) = text(font: sans-font, ..args)
  // let sans(..args) = if sans-font == none {
  //   text(..args)
  // } else {
  //   text(font: sans-font, ..args)
  // }

  set document(title: titles.join(" "), author: author)
  set page(
    paper: "a4",
    margin: (top: 30mm, bottom: 50mm, left: 15mm, right: 15mm),
  )

  set par(
    linebreaks: "optimized",
    first-line-indent: (all: true, amount: 0.5cm),
    leading: 0.55em,
    spacing: 0.8em,
    justify: true,
  )
  set text(size: 12pt)

  //  }}}

  // title page {{{

  set align(center)

  image("agh.svg", width: 11.7%)
  v(1.5cm)
  text(
    "Akademia Górniczo-Hutnicza im. Stanisława Staszica w Krakowie",
    weight: 700,
    size: 14pt,
  )

  v(0.2em)
  text(
    department,
    weight: 200,
    size: 14pt,
  )

  v(1.25cm)
  text(
    if masters [PRACA DYPLOMOWA] else [PROJEKT DYPLOMOWY],
    weight: 300,
    size: 13pt,
  )

  v(0.9cm)
  text(
    titles.at(0),
    weight: 800,
    size: 17pt,
  )
  if titles.len() > 1 {
    parbreak()
    text(
      titles.at(1),
      weight: 800,
      size: 11pt,
    )
  }

  align(bottom)[
    #set text(size: 12pt)
    #align(left)[
      #h(1.0cm)
      #box(table(
        stroke: (bottom: 0pt, left: 0pt, right: 0pt, top: 0pt),
        align: left,
        row-gutter: -0.1em,
        column-gutter: 1.0em,
        columns: (auto, auto),
        [Autor:], text(weight: 700, author),
        [Kierunek:], text(weight: 700, course),
        [Opiekun pracy:], text(weight: 700, supervisor),
      ))
    ]

    #v(1.2cm)
    #let today = datetime.today()
    Kraków, #today.year()
    #v(0.8cm)
  ]

  if acknowledgements.len() > 0 {
    pagebreak(to: "odd")
    align(bottom + right)[
      #block(width: 70%)[
        #set align(right)
        #for a in acknowledgements [
          #a
          #v(0cm)
        ]
      ]
    ]
  }

  // needed only after here
  set page(margin: (outside: 30mm, inside: 15mm))

  //  }}}

  // AI and abstract {{{

  if ai-statement != none {
    pagebreak(to: "odd")
    {
      set align(left + bottom)
      set par(justify: true)
      set text(size: 1em, style: "italic")
      grid(
        columns: (3.5cm, auto),
        [], ai-statement,
      )
      v(1.0cm)
    }
  }

  if abstract != none {
    pagebreak(to: "odd")
    v(-4.0cm)
    align(
      center + horizon,
      heading(level: 3, [Streszczenie], outlined: false, bookmarked: false),
    )
    {
      v(0.8em)
      set align(left)
      set par(justify: true)
      abstract
    }
  }

  //  }}}

  // index {{{

  pagebreak(to: "odd")
  set page(numbering: "i")
  set align(left)

  show outline.entry: it => {
    let gap_size = 0.5em
    let ref_name = it.prefix() + h(0.5em) + it.body() + h(gap_size)
    // TODO align dots (hard with almost no gain)
    let ref_fill = box(width: 1fr, repeat(gap: gap_size, [.]))
    let ref_page = context {
      let first_page = query(selector(heading).after(here())).first().location().page()
      1 + it.element.location().page() - first_page
    }
    let ref_link = (
      h(0.8em)
        + link(
          it.element.location(),
          text(
            fill: rgb("#0000FF"),
            [#ref_page],
          ),
        )
    )

    if it.element.level == 1 {
      ref_name = text(weight: 900, ref_name)
      ref_fill = box(width: 1fr, repeat(gap: gap_size, [ ]))
      ref_link = text(weight: 900, ref_link)
      v(0.8em)
    }
    it.indented(ref_name + ref_fill, ref_link)
  }

  outline(
    title: [
      #set text(size: 1.4em, weight: 900)
      #v(1.5cm)
      #sans(size: 1.1em, weight: 700, [Spis treści])
      #v(0.6em)
    ],
    indent: 18pt,
  )

  set page(numbering: none)
  pagebreak(to: "odd")

  //  }}}

  // document settings {{{

  // TEXT
  set heading(numbering: "1.1.")
  show heading: body => sans(weight: 600, body) // weight just in case
  show heading.where(level: 1): body => {
    pagebreak(weak: true)
    v(2.4cm)
    text(size: 1.5em, body)
    v(0.5cm)
  }
  show heading.where(level: 2): body => {
    v(0.22cm)
    text(size: 1.25em, body)
    v(0.2cm)
  }
  show heading.where(level: 3): body => {
    v(0.25em)
    text(size: 1.25em, body)
  }


  // LISTS
  set list(
    spacing: 1.3em,
    body-indent: 0.3em,
    marker: text(size: 0.75em, baseline: -0.24em, sym.circle.filled),
  )
  show list: body => v(0.4em) + body
  show list.item: body => block(breakable: false, body)

  // FIGURES
  let figure_supplement(text) = {
    text
    str(counter(heading).get().at(0))
    "."
    h(-measure([#" "]).width)
  }
  set figure.caption(separator: none)
  set figure(numbering: "1.: ")
  show figure: body => {
    v(0.5em)
    body
    v(0.5em)
  }
  show figure.where(kind: image): set figure(
    supplement: n => context figure_supplement("Rysunek "),
  )
  show figure.where(kind: table): set figure(
    supplement: n => context figure_supplement("Tabela "),
  )
  show figure.where(kind: raw): set figure(
    supplement: n => context figure_supplement("Kod "),
  )
  show figure.where(kind: raw): set block(breakable: true)

  // CODE
  let numbered_code(lang: "", code) = {
    let contents
    if type(code) == content {
      contents = code.text
    } else if type(code) == str {
      contents = code
      code = raw(block: true, lang: lang, code)
    }

    let inset = 0.5em
    let stroke = 0.5pt
    let numbers = ""
    let cur = 1
    // TODO padding
    for line in contents.split("\n") {
      numbers += str(cur) + "\n"
      cur += 1
    }

    grid(
      columns: (auto, auto),
      column-gutter: 0.4em,
      block(
        inset: (y: inset + stroke),
        if contents != "" {
          if lang != "" {
            // safer ???
            context {
              let raw_size = measure(```python def```).height
              set par(leading: 0.6505em)
              set text(2.3535 * raw_size)
              raw(block: true, lang: "", numbers)
            }
            // set par(leading: 0.6505em)
            // set text(1.15em)
            // raw(block: true, lang: "", numbers)
          } else {
            raw(block: true, lang: "", numbers)
          }
        },
      ),

      block(
        inset: inset,
        stroke: stroke,
        width: 100%,
        code,
      ),
    )
  }

  // TODO `context` disable recursion
  show raw.where(block: true): body => {
    if body.lang == none or body.lang == "" { return body }
    // for some reason this isn't default
    set align(left)
    numbered_code(lang: body.lang, body)
  }

  // BIBLIOGRAHY
  // https://github.com/typst/typst/discussions/4143
  show cite: it => {
    // Only color the number, not the brackets.
    show regex("\d+"): set text(fill: rgb("#00FF00"))
    // or regex("[\p{L}\d+]+") when using the alpha-numerical style
    it
  }

  // (neo)vim syntax highlight breaks with this just passed as an
  // function argument
  let colon_regex = ": "
  set bibliography(title: "Bibliografia", style: "bib_format.csl")
  show bibliography: body => {
    set text(weight: 100, spacing: 150%, size: 1.0em)
    show regex("URL"): it => text(size: 0.75em, it)
    show regex(colon_regex): it => text(size: 1.05em, it)
    show link: it => text(
      fill: rgb("#00ADEF"),
      // TODO monospace font
      font: sans-font,
      size: 0.85em,
      it,
    )
    body
  }

  //  }}}

  set page(numbering: "1")
  counter(page).update(1)
  body
  pagebreak(to: "odd")
  bibliography-content
}
