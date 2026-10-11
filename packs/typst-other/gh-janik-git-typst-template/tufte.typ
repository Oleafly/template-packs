
#import "@preview/marginalia:0.1.3" as marginalia
#import "@preview/ctheorems:1.1.3": *

#let word-numbers = (
  "one",
  "two",
  "three",
  "four",
  "five",
  "six",
  "seven",
  "eight",
  "nine",
  "ten",
  "eleven",
  "twelve",
  "thirteen",
  "fourteen",
  "fifteen",
  "sixteen",
  "seventeen",
  "eighteen",
  "nineteen",
  "twenty",
)


#let pointsTable(points) = figure([
  #table(
    columns: points + 2,
    [Ex.#h(5pt)], ..(
      range(points).map(ex => [#(ex + 1) #h(10pt)]).flatten()
    ), [$sum$],
    [Pts.#h(5pt)], ..(range(points).map(ex => []).flatten()),
    // [Ex.], [1], [2], [3],[$sum$],
    // [Pts.], [], [], [],
    table.hline()
  )

])
#let template(
  title: "Lecture Notes Title",
  authors: (
    (
      name: "Janik Sperling",
      matrikel: "123456",
    ),
  ),
  onesided: false,
  accent: "#DC143C",
  text_font: "CMU Bright",
  code_font: "BerkeleyMono Nerd Font",
  math_font: "New Computer Modern Math",
  points_table: none,
  toc: true,
  bib: none,
  numbered_sections: true,
  header_content: false,
  doc,
) = {
  show: thmrules.with(qed-symbol: $square.stroked$)

  let accent_color = rgb(accent)
  let config = none

  if onesided {
    config = (
      inner: (far: 16mm, width: 20pt, sep: 20pt),
      outer: (far: 16mm, width: 20pt, sep: 20pt),
      top: 72pt,
      bottom: 64pt,
      book: false,
      numbering: (..i) => super(numbering("1", ..i)),
    )
  } else {
    config = (
      inner: (far: 16mm, width: 20mm, sep: 20pt),
      outer: (far: 16mm, width: 120pt, sep: 20pt),
      top: 72pt,
      bottom: 64pt,
      book: true,
      numbering: (..i) => super(numbering("1", ..i)),
    )
  }
  marginalia.configure(..config)
  // Document metadata
  set document(title: title, author: authors.map(author => author.name))

  // STYLES
  show link: set text(fill: accent_color)
  set text(fill: luma(30))
  set page(
    ..marginalia.page-setup(..config),
    width: 210mm,
    height: 297mm,
    footer: context {
      marginalia.notecounter.update(0)
      align(right, [#counter(page).display()])
    },
    header: context {
      let i = here().page()
      if query(heading.where(level: 1)).any(it => it.location().page() == i) {
        return
      }
      let previous_chapters = query(
        selector(heading.where(level: 1)).before(here()),
      )
      if previous_chapters != () {
        let heading_count = counter(heading).get()
        let chapter = previous_chapters.last()
        let chapter_loc = chapter.location()
        let chapter_header = chapter.body
        let chapter_count = heading_count.at(0)
        let section_counter = none

        let previous_sections = query(
          // selector(heading.where(level: 2)).before(here()),
          heading.where(level: 2),
        ).filter(h => (h.location().page() <= i))
        let sec_count = none
        let section_info = none
        if (previous_sections != ()) {
          let sections_in_chapter = previous_sections.filter(section => (
            section.location().page() >= chapter_loc.page()
          ))

          if sections_in_chapter != () {
            let current_section = sections_in_chapter.last()
            // let section_counter = counter(heading.where(level:2)).display("1")
            if (numbered_sections) {
              section_counter = if (counter(heading).get().len() > 1) {
                heading_count.at(1) + 1
              } else { 1 }
              // section_counter =  counter(heading).display()
              section_info = [#chapter_count.#section_counter #current_section.body]
            } else {
              section_info = [#current_section.body]
            }
          }
        }
        let sec_context = (
          query(selector(heading.where(level: 2)).after(here()))
        )
        if header_content {
          grid(
            columns: (10pt, 5pt, 1fr, 0% + measure(section_info).width),
            [#chapter_count],
            move(
              dy: 4pt,
              line(
                start: (0%, 0pt),
                length: 16pt,
                angle: 90deg,
                stroke: 0.5pt + accent_color,
              ),
            ),
            chapter_header,
            section_info,
          )
          // [#chapter_count.#section_counter]

          line(length: 100%, stroke: 0.5pt + luma(0))
        }
      }
    },
  )

  set text(font: text_font, size: 10pt)
  show raw: set text(font: code_font)
  show math.equation: set text(font: math_font, fallback: false)

  show heading.where(level: 2): set heading(
    numbering: "1.1",
  ) if numbered_sections
  show heading.where(level: 2): it => {
    set text(font: "CMU Bright", weight: 400, size: 18pt)
    let header = it
    if (numbered_sections) {
      let sec_str = it.body
      let count = counter(heading).display()
      // let count =  sec_str.at(2)
      // let content = sec_str.at(1)
      // let content = it.split().at(1)
      header = grid(
        columns: (30pt, 10pt, 1fr),
        [#count],
        move(
          dy: 0pt,
          line(
            start: (0%, 0pt),
            length: 16pt,
            angle: 90deg,
            stroke: 0.5pt + accent_color,
          ),
        ),
        [#sec_str],
      )
    }
    header
    v(1em)
  }

  show heading.where(level: 1): it => {
    pagebreak()
    // set align(left)
    let count = counter(heading).at(it.location()).at(0)
    counter(heading).step()
    // // Get the word representation (with fallback to numbers if beyond our defined words)
    let number-word = if count <= word-numbers.len() {
      upper(word-numbers.at(count))
    } else {
      upper(str(count))
    }
    align(
      right,
      [#text(
          font: text_font,
          weight: 100,
          size: 15pt,
        )[#upper("Chapter") #number-word]],
    )
    set text(font: text_font, weight: "regular", size: 15pt)
    line(length: 100%, stroke: 0.75pt + luma(0))
    it
    line(length: 100%, stroke: 0.75pt + luma(0))
    v(2em, weak: true)
  }


  show table.cell.where(y: 0): strong
  set table(
    stroke: (x, y) => if (y == 0) {
      (top: 0.8pt + black)
      (bottom: 0.7pt + black)
    },
    align: (x, y) => (
      if x > 0 {
        center
      } else {
        left
      }
    ),
  )


  // set par(
  //   // justify: true,
  //   leading: 0.65em,
  //   first-line-indent: 1em
  // )

  // Lists
  set enum(
    indent: 1em,
    body-indent: 1em,
  )
  show enum: set par(justify: false)
  set list(
    indent: 1em,
    body-indent: 1em,
  )
  show list: set par(justify: false)


  let authorblock(authors) = block({
    set text(font: text_font, size: 11pt)
    v(1em)
    for i in range(calc.ceil(authors.len() / 2)) {
      let end = calc.min((i + 1) * 2, authors.len())
      let slice = authors.slice(i * 2, end)
      grid(
        rows: 2,
        gutter: 12pt,
        ..slice.map(author => align(
          left,
          {
            upper(author.name)
            if "matrikel" in author [
              #author.matrikel
            ]
          },
        )),
      )
    }
  })
  let titlepage(title: none, subtitle: none) = page(
    footer: none,
    {
      set text(
        hyphenate: false,
        size: 20pt,
        font: text_font,
      )
      align(
        horizon + center,
        [
          #upper(title)

          #authorblock(authors)
          #if points_table != none [
            #set text(size: 10pt)
            #pointsTable(points_table)

          ]

        ],
      )
    },
  )
  show outline.entry.where(level: 1): it => {
    set text(fill: rgb(accent))
    let count = (
      counter(heading).at(it.element.location()).at(0) + 1
    ) //counter(heading).at(it.location()).at(0)
    // grid(
    //   columns:2,
    //   [#count ], [#it]
    // )
    [#it]
    // it
  }

  let outlinepage() = page(
    footer: none,
    {
      set align(center)
      line(length: 100%, stroke: 0.5pt + luma(0))
      [#text(font: text_font, weight: "regular", size: 15pt, "Contents")]
      line(length: 100%, stroke: 0.5pt + luma(0))
      v(2em)
      outline(title: none, indent: 10pt)
    },
  )

  // Just a suttle lightness to derease the harsh contrast
  // set text(fill: luma(30))

  // title
  titlepage(title: title)
  if (toc) {
    outlinepage()
  }
  counter(page).update(1)
  counter(heading).update(0)


  doc

  show bibliography: set text(font: text_font)
  show bibliography: set par(justify: false)
  set bibliography(title: none)
  if bib != none {
    heading(level: 1, [References])
    bib
  }
}

// Base Env Styles
#let stroked = thmbox(
  "stroked",
  "Stroked",
  stroke: 0.5pt + luma(30),
)

#let theorem = thmbox(
  "theorem",
  "Theorem",
  base: "stroked",
)
#let corollary = thmbox(
  "corollary",
  "Corollary",
  base: "stroked",
)
#let lemma = thmbox(
  "lemma",
  "Lemma",
  base: "stroked",
)
#let prop = thmbox(
  "proposition",
  "Proposition",
  base: "stroked",
)
#let definition = thmbox(
  "definition",
  "Definition",
  base: "stroked",
)


#let exercise = thmbox(
  "exercise",
  "Exercise",
).with(numbering: none)
#let eg = thmplain(
  "example",
  "Example",
).with(numbering: none)

#let remark = thmplain(
  "remark",
  "Remark",
).with(numbering: none)
#let note = thmplain(
  "note",
  "Note",
).with(numbering: none)

#let proof = thmproof(
  "proof",
  "Proof",
)

#let trace = "trace"

#let sidenotemark() = {
  marginalia.notecounter.step()
  let counter_value = context marginalia.notecounter.display()
  [#super(counter_value)]
}
#let sidenotetext(body) = {
  let counter_value = context marginalia.notecounter.display()
  marginalia.note(
    numbered: false,
  )[#super(context marginalia.notecounter.display()) #body]
}
#let sidenote = marginalia.note

#let paragraph(title) = {
  v(10pt)
  text(weight: "bold")[#title]
  h(6pt)
}
#let inner(body) = $lr(angle.l #body angle.r)$
#let myS(sym, body) = $limits(sym)^(body)$

#let grad = $nabla$














// #let inner(body) = $lr(angle.l #text[#body] angle.r)$
// #let inner(value) = $upright(d)#value$

// #let cal(it) = text(
//   size:12.5pt,
//   box($math.cal(it)$),
// )
