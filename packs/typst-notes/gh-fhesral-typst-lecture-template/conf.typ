// TODO:
// -> Make mybox() more variable: e.g. dont make header obligatory for remarks and make more extra-boxes possible
// -> Work on Outline spacing
// convert 0-level-headings to level-1-headings


//default cover-func called in default-argument for coverfunc() in conf()
#let cover-default() = {
  return none // a basic cover example is found in cover.typ
}

// chapter definition for 0-level headlines
#let chapter = figure.with(
  kind: "chapter",
  // same as heading
  numbering: "I",
  // this cannot use auto to translate this automatically as headings can, auto also means something different for figures
  supplement: "Chapter",
  // empty caption required to be included in outline
  caption: [],
)

// mybox() provides colorboxes with styled titlebox and more
#let mybox(
  title,
  content,
  color: rgb(180, 220, 250),
  num: 0,
  supp: "Theorem",
  extra: "",
) = {
  let edge = color.darken(30%)
  let xpad = 4pt
  let chapter = context counter(figure.where(kind: "chapter")).display("I")
  let header = context counter(heading).get().first()
  //let thrm-numbering = numbering("I.1.1", 1, 2, 3) how!? //This is not very nice...
  let titlestyle(thrm, num, contents) = [
    *#thrm #chapter.#num*: _#contents _ // *#thrm #chapter.#header.#num*: _#contents _
  ]
  context {
    let linewidth = 210pt
    let width-title = measure(titlestyle(supp, num, title)).width + xpad
    let max-width = page.width / page.columns / 1.6
    if width-title > max-width {
      width-title = max-width
    }
    let titlebox = box(
      fill: color,
      stroke: (right: none, bottom: none, rest: edge),
      inset: (x: xpad, y: 4pt),
      clip: true,
      radius: (top-left: 5pt),
      width: width-title + xpad,
    )[
      #titlestyle(supp, num, title)
    ]
    let titleboxheight = measure(titlebox).height
    let bezierA = (10pt, 0pt)
    let bezierB = (0pt, titleboxheight)
    let btmR = (10pt, titleboxheight)
    let kurve = curve(
      stroke: edge,
      curve.move((-0.1pt, 0pt)),
      curve.cubic(
        bezierA,
        bezierB,
        btmR,
      ),
    )
    let kurvefill = curve(
      fill: color,
      curve.move((-0.1pt, 0pt)),
      curve.cubic(
        bezierA,
        bezierB,
        btmR,
      ),
      curve.line((-0.1pt, btmR.last())),
      curve.close(mode: "straight"),
    )
    let titleend = box(
      fill: none,
    )[
      #kurvefill
      #place(horizon + left)[
        #kurve
      ]
    ]
    let contentbox = block(
      fill: color,
      stroke: (top: (paint: edge, thickness: 1pt, dash: none), rest: edge),
      inset: 5pt,
      width: 100%,
      radius: if extra == "" { (top-left: 0pt, rest: 5pt) } else { (top-right: 5pt, rest: 0pt) },
      breakable: true,
      content,
    )
    let extrabox = block(
      fill: color.darken(10%),
      stroke: (top: (paint: edge, thickness: 1pt, dash: none), rest: edge),
      inset: 5pt,
      width: 100%,
      radius: (top-left: 0pt, top-right: 0pt, rest: 5pt),
      breakable: true,
      emph(extra),
    )
    block(
      breakable: true,
      below: 1.5em,
      align(
        left,
        stack(
          dir: ttb,
          stack(
            dir: ltr,
            titlebox,
            titleend,
          ),
          contentbox,
          if extra != "" { extrabox },
        ),
      ),
    )
  }
}
// The wrapper for creating theorem-environments with certain parameters out of mybox()
#let theorem-env(
  title,
  content,
  color,
  kind: "theorem",
  supp: "Theorem",
  extra: "",
) = {
  let thm-in-heading = context counter(figure.where(kind: kind)).display()
  figure(
    mybox(
      num: thm-in-heading,
      color: color,
      extra: extra,
      supp: supp,
    )[#title][#content],
    kind: kind,
    supplement: supp,
    caption: [#title],
  )
}

//template/config
#let conf(
  cols: 2,
  lecture-name: [Lecture Name],
  author-name: [fhesral],
  theorem-config: (
    theorem: (
      link-color: blue,
      show-in-outline: true,
      abbreviation: "thrm.",
    ),
  ),
  img-tab-eq-link-color: (green, orange, blue),
  show-dates: true,
  abbreviate-links: true,
  chapter-color: rgb(7, 16, 73),
  chapter-number-color: rgb("#80808097"),
  shadow-color: rgb(0, 0, 0, int(255 * 0.3)),
  coverfunc: cover-default.with(),
  language: "en",
  breakable-thrms: true,
  doc,
) = {
  // ++++++ Global Preamble and Cover-page settings ++++++ \\
  set text(size: 8pt, lang: language)
  set page(
    paper: "a4",
    columns: 1,
    binding: left,
    margin: (inside: 2.5cm, outside: 2cm, top: 3cm, bottom: 3cm), // different margins for even/odd page (book)
  )
  set par(justify: true)
  set heading(numbering: "1.1.")
  // Setting equation numbering to respect the chapter
  set math.equation(
    numbering: n => [#context (
      numbering("(I.1)", counter(figure.where(kind: "chapter")).at(here()).first(), n)
    )],
    supplement: none,
  ) // Heading numberings could be edited the same way


  let theorem-envs = theorem-config.keys()
  let resp = theorem-envs.map(k => figure.where(kind: k))
  let env-selector = selector.or(..resp)
  // make thrm-envs breakable
  show env-selector: set block(breakable: breakable-thrms)
  // Turn off captions for all theorem envs
  show env-selector: it => context { it.body } //Here you could also turn off environments which are not inside the thrm-config dict

  // arrays with the different environments for looping later
  let theorem-envs-and-image = (..theorem-envs, image, table)
  let env-select-arr = theorem-envs-and-image.map(x => figure.where(kind: x))

  // styling of Chapter title, resetting counters etc.
  show figure.where(kind: "chapter"): it => {
    set text(18pt, chapter-color)
    set par(justify: false)
    // reset theorem-env counters, headings, equations, images and tables after new chapter
    let reset-envs = (..env-select-arr, heading, math.equation)
    for name in reset-envs {
      counter(name).update(0)
    }
    // styling the chapter title and number
    if it.numbering != none {
      let ttext = align(left, text()[#it.body])
      let tnumber = text(size: 42pt, chapter-number-color)[
        #strong(it.counter.display(it.numbering))
      ]
      box(
        fill: none,
        width: 1fr,
      )[
        // shadow
        #place(
          top + left,
          dx: 0.6pt,
          dy: 0.6pt,
          text(shadow-color)[
            #strong(ttext)
          ],
        )
        // chapter number
        #place(
          horizon + right, //horizon or top
          dx: -5pt,
          dy: 0.6pt,
          tnumber,
        )
        // chapter title
        #strong(
          ttext,
        )
      ]
    }
  }

  //styling the outline and adding CHAPTERS and also if wanted theorem-envs
  show outline.entry: it => {
    let el = it.element
    if el.func() == figure {
      let art = el.kind
      // show thrm-envs that are supposed to be shown
      for i in range(0, theorem-envs.len()) {
        if art == theorem-envs.at(i) {
          let show-in-outline = theorem-config.at(theorem-envs.at(i)).at("show-in-outline")
          if show-in-outline {
            let abbr = theorem-config.at(theorem-envs.at(i)).at("abbreviation")
            let link-color = theorem-config.at(theorem-envs.at(i)).at("link-color")
            let chapter-here = numbering("I", ..counter(figure.where(kind: "chapter")).at(it.element.location()))
            let level = counter(heading).at(it.element.location()).len() + 0
            //let indent = h(2em * level) //or constantly high?
            let indent = 5em
            set text(6pt)
            let res = link(
              it.element.location(),
              box(
                fill: none,
                width: indent,
                height: 4pt,
              )[
                #align(
                  right,
                  text(link-color)[
                    $arrow.r$ #h(2pt)
                  ],
                )
              ]
                + text(link-color)[#abbr #chapter-here.]
                + if it.element.numbering != none {
                  text(link-color, [#numbering(it.element.numbering, ..it.element.counter.at(it.element.location())). ])
                }
                + text(link-color, it.element.caption.body),
            )
            if it.fill != none {
              res += [ ] + box(width: 1fr, it.fill) + [ #it.page() #h(1pt) \ #v(0em) ]
            }
            text(blue, res)
          }
        }
      }
      // show chapters in outline
      if art == "chapter" {
        let res = link(
          el.location(),
          if el.numbering != none {
            numbering(el.numbering, ..el.counter.at(el.location()))
          }
            + [. #el.body]
            + text(blue, el.caption.body),
        )

        if it.fill != none {
          res += [ ] + box(width: 1fr, it.fill) + [ #it.page() #h(0.75em)] + [ \ #v(-0.5em) ]
        } else {
          // do i need this case!?
          res += h(1fr) // ?
        } // ?
        text(blue, strong(res))
        v(0.5em)
      } else {
        // dont show figures that arent chapters
      }
    } else {
      // styling the normal (sub-)headings
      let arr = counter(heading).at(el.location())
      let level = it.level - 1
      link(el.location(), [
        #h(1em * level + 0.5em)
        #numbering(el.numbering, ..arr)
        #h(2pt)
        #el.body
        #box(width: 1fr, it.fill)
        #it.page()
      ])
      v(-0.1em)
    }
  }

  // new target selector for default outline
  let base = heading.where(outlined: true).or(figure.where(kind: "chapter", outlined: true))
  // add all outlined figure kinds from theorem-envs
  let outline-targets = theorem-envs.fold(
    base,
    (sel, k) => sel.or(figure.where(kind: k, outlined: true)),
  ) // I dont remember why I did this. In the end I hide all theorems again if I dont want them shown in the outline. I am confused wth what I did here..

  // Custom reference link appearances. Equations are a bit clunky but rest works fine :)
  show ref: it => {
    if it.element == none {
      return it
    }
    let current-chap = numbering("I", counter(figure.where(kind: "chapter")).at(it.target).first())
    let el = it.element
    if el.func() == figure {
      let counter-here = el.counter.at(it.target).first()
      let link-caption = [#current-chap.#counter-here]
      let link-colors = (for i in theorem-envs { (theorem-config.at(i).at("link-color"),) })
      let all-link-colors = (..link-colors, ..img-tab-eq-link-color.slice(0, 2))
      // change ref-link appearance fig.kind-wise
      if abbreviate-links {
        for i in range(0, theorem-envs-and-image.len()) {
          if el.kind == theorem-envs-and-image.at(i) {
            if i < theorem-envs-and-image.len() - 2 {
              return link(
                el.location(),
                text(
                  all-link-colors.at(i),
                  [#theorem-config.at(theorem-envs.at(i)).at("abbreviation")~#link-caption],
                ),
              )
            } else {
              let abb = ("img.", "tab.")
              return link(
                el.location(),
                text(
                  all-link-colors.at(i),
                  [#abb.at(i - (theorem-envs-and-image.len() - 2))~#link-caption],
                ),
              )
            }
          }
        }
      } else {
        for i in range(0, theorem-envs-and-image.len()) {
          if el.kind == theorem-envs-and-image.at(i) {
            return link(
              el.location(),
              text(
                all-link-colors.at(i),
                [#el.supplement~#link-caption],
              ),
            )
          }
        }
      }
      if el.kind == math.equation {
        //these are the equations labeled inside of a math block with the package equate.
        return link(el.location(), text(img-tab-eq-link-color.at(-1))[#it])
      }
      if el.kind == "chapter" {
        return text(chapter-color)[*#it*]
      } else {
        return it // if it's another kind of figure, just return its ref.
      }
    }
    if el.func() == math.equation {
      // normal equation refs
      return text(img-tab-eq-link-color.at(-1), it)
    }
    if el.func() == heading {
      // Heading refs
      let current-head = numbering(el.numbering, ..counter(heading).at(it.target))
      let link-caption = [*#el.supplement~#current-chap.#current-head*]
      return link(el.location(), text(chapter-color, link-caption))
    } else {
      return it
    }
  }

  //make image/tables-figures display chapter number in caption & dont count unlabeled images/tables
  show selector.or(..env-select-arr.slice(-2)): it => context {
    if it.caption != none {
      let current-chap = counter(figure.where(kind: "chapter")).display("I")
      let current-fig = counter(figure.where(kind: image)).display()
      set text(8pt, style: "italic")
      if it.kind == image {
        stack(spacing: 1.2em, it.body, strong("Figure " + current-chap + "." + current-fig + " ") + it.caption.body)
      } else {
        stack(spacing: 1.1em, strong("Table " + current-chap + "." + current-fig + " ") + it.caption.body, it.body)
      }
    } else {
      it.body // Dont count figures without labels =)
      it.counter.update(n => n - 1)
    }
  }


  //cover
  coverfunc()

  // outline styling
  set page(columns: 2, header: {
    grid(
      columns: (1fr, 1fr, 1fr),
      align(left, author-name),
      align(center, lecture-name),
      align(right, datetime.today().display("[day]. [month repr:long] [year]")),
    )
    line(length: 100%)
  })

  // Outline
  outline(
    target: outline-targets,
    title: [#lecture-name - Contents \ #v(1em)],
  )
  // pagebreak styling
  set page(header: align(center, line(length: 30%)))
  if coverfunc() == none {
    pagebreak(to: "odd")
  } else {
    pagebreak(to: "even")
  }
  counter(page).update(1) // ..

  // get last chapter and header on page for styling the header (not very nice code)
  let get-current-chapter() = context {
    let page = here().page()
    let qu = query(selector(figure.where(kind: "chapter"))).filter(x => x.location().page() == page)
    if qu == () {
      let lastqu = query(selector(figure.where(kind: "chapter"))).filter(x => x.location().page() < page)
      if lastqu == () { none } else { lastqu.last().body }
    } else {
      qu.last().body
    }
  }
  let get-current-header() = context {
    let page = here().page()
    let qu = query(selector(heading.where(level: 1))).filter(x => x.location().page() == page)
    if qu == () {
      query(selector(heading.where(level: 1))).filter(x => x.location().page() < page).last().body
    } else {
      qu.last().body
    }
  }
  // column and Header settings
  // set page alternating header for even/odd
  set page(
    columns: cols, // 2 columns for text, 1 is also supported, 3 should be fine too on a4 paper but #new-lecture() wont work
    numbering: none,
    header: context {
      if calc.odd(here().page()) {
        //left page
        grid(
          columns: (1fr, 1fr, 1fr),
          align(left, [_#get-current-header() _]), align(center, []), align(right, [#counter(page).display()]),
        )
      } else {
        // right page
        grid(
          columns: (1fr, 1fr),
          align(left, [#counter(page).display()]), align(right, [_*#get-current-chapter() *_]),
        )
      }
      line(length: 100%)
    },
  )

  // Start of the document
  doc
  // End of doc
  // pagebreak style
  set page(header: align(center + bottom, line(length: 30%)))
  pagebreak(to: "even")
}

// add date of lecture in margin (I gave up on 3+ columns)
#let new-lecture(day, month, year: 2025, show-dates: true, repr: "[day].[month].[year]", content) = context {
  if show-dates {
    let odd = calc.odd(here().page())
    let date = datetime(year: year, month: month, day: day).display(repr)
    let x = measure(date).width + 6pt
    let indent = 0cm
    if odd {
      let indent = 2.5cm
    } else {
      let indent = 2cm
    }
    if page.columns == 2 {
      if here().position().x > page.width / 2 - indent {
        place(right, dx: x)[_#date _]
      } else {
        place(left, dx: -x)[_#date _]
      }
    }
    if page.columns == 1 {
      if odd {
        place(right, dx: x)[_#date _]
      } else {
        place(left, dx: -x)[_#date _]
      }
    } else {
      //cols 3,4,5,...
      // no support for displaying lecture date
      // stylistic choice
    }
    content
  } else {
    content
  }
}

// wrapper for ending column for stylistic purposes
#let endcol(height) = {
  block(width: 100%, height: height)
}

