#import "./lib.typ"
#import "@preview/hydra:0.6.2": hydra
#import "@preview/numblex:0.2.0": numblex

#let thesis(
  author: none,
  title: none,
  subtitle: none,
  venue: none,
  date: none,
  affiliation: "大阪大学 大学院人文学研究科 言語文化学専攻",
  status: none,
  supervisors: none,
  font-size: 11pt,
  bibliography-file: none,
  bibliography-style: "apa",
  bibliography-size: 11pt,
  language: "ja",
  abstract: none,
  dedication: none,
  publishing-info: none,
  appendix: none,
  body
) = {
  // Settings

  // Creates a pagebreak to the given parity where empty pages
  // can be detected via `is-page-empty`.
  let detectable-pagebreak(to: "odd") = {
    [#metadata(none) <empty-page-start>]
    pagebreak(to: to)
    [#metadata(none) <empty-page-end>]
  }

  // Workaround for https://github.com/typst/typst/issues/2722
  let is-page-empty() = {
    let page-num = here().page()
    query(<empty-page-start>)
      .zip(query(<empty-page-end>))
      .any(((start, end)) => {
        (start.location().page() < page-num
          and page-num < end.location().page())
      })
  }

  let is-page-i-empty(i) = {
    let page-num = i
    query(<empty-page-start>)
      .zip(query(<empty-page-end>))
      .any(((start, end)) => {
        (start.location().page() < page-num
          and page-num < end.location().page())
      })
  }

  set document(title: title, author: author)

  set text(
    lang: language,
    size: font-size,
    font: lib.default_serif + lib.japanese_serif
  )

  set page(
    paper: "a4",
    margin: (inside: 3.5cm, outside: 2.5cm, bottom: 3cm, top: 3cm),
  )

  set heading(
    hanging-indent: 0pt,
    numbering: (..nums) => {
      let vals = nums.pos()
      let pattern = if vals.len() == 1 { "1." }
                    else if vals.len() <= 4 { "1.1" }
      if pattern != none { numbering(pattern, ..nums) }
    }
  )

  set math.equation(numbering: num =>
    numbering("(1.1)", counter(heading).get().first(), num)
  )

  set figure(numbering: num =>
    numbering("1.1", counter(heading).get().first(), num)
  )

  set page(numbering: none)
  counter(page).update(0)

  // The first page.
  page(align(center + horizon)[
    #text(2em)[*#title*]
    #v(2em, weak: true)
    #text(1.6em, author)
  ])

  // Display publisher info at the bottom of the second page.
  if publishing-info != none {
    align(center + bottom, text(0.8em, publishing-info))
  }

  // pagebreak()

  set page(numbering: "I")

  // Display the dedication at the top of the third page.
  if dedication != none {
    v(15%)
    align(center, strong(dedication))
  }

  // Books like their empty pages.
  pagebreak(to: "odd")

  // Configure paragraph properties.
  //
  // For Japanese:
  let fli = if language == "ja" {1em} else {0em}
  let par-spacing = if language == "ja" {0.68em} else {1.2em}
  set par(justify: true, first-line-indent: fli, spacing: par-spacing)
  // set par(spacing: 0.78em, leading: 0.78em, first-line-indent: 1em, justify: true)

  outline()

  pagebreak(to: "odd", weak: true)

  // Configure page properties.
  set page(
    // The header always contains the book title on odd pages and
    // the author on even pages, unless
    // - we are on an empty page
    // - we are on a page that starts a chapter
    header: context {
    // FIXME broken
    // hydra(1)
      // // Is this an empty page inserted to keep page parity?
      // if is-page-empty() or is-page-i-empty(here().page() - 1) {
      //   return
      // }

      // // Are we on a page that starts a chapter?
      // let i = here().page()
      // if query(heading).any(it => it.location().page() == i and it.level == 1) {
      //   return
      // }
      // let all = query(heading.where(level: 1))
      // if all.any(it => it.location().page() == i) {
      //   return
      // }

      // // Find the heading of the section we are currently in.
      // let before = query(selector(heading).before(here()))
      // if before != () {
      //   set text(0.95em)
      //   let header = smallcaps(before.last().body)
      //   let counterInt = counter(heading).at(here())
      //   let title = smallcaps(title)
      //   let author = text(style: "italic", author)

      //   if calc.even(i) { title } else {
      //     set align(right)
      //     numbering("1.1", ..counterInt.slice(0,1)) + ". " + header
      //   }

      //   line(length: 100%, stroke: 0.5pt)
      // }
    },
    footer: context {
      // FIXME the page numbering is also broken from interaction with our counter reset logic
      let i = here().page()
      if calc.even(i) {
        set align(left)
        [#i]
      } else {
        set align(right)
        [#i]
      }
    },
  )

  // Configure chapter headings.
  show heading.where(level: 1): it => {
    // Always start on odd pages.
    detectable-pagebreak(to: "odd")

    // Create the heading numbering.
    let number = if it.numbering != none {
      counter(heading).display(it.numbering)
      h(7pt, weak: true)
    }

    v(5%)
    text(lib.title1, weight: 700, block([#number #it.body]))
    v(1.25em)
  }
  show heading: it => {
    if it.level == 1 {
      set text(lib.title1, weight: 700)
    } else if it.level == 2 {
      set text(lib.title2, weight: 700)
    } else if it.level == 3 {
      set text(lib.title3, weight: 700)
    } else if it.level == 4 {
      set text(lib.title4, weight: 700)
    } else if it.level == 5 {
      set text(lib.title5, weight: 700)
    }
    v(5%)
    it
    v(1.25em)
  }

  set page(numbering: "1")
  counter(page).update(1)

  body

  // TODO: Need to adjust non-CJK text size here as well
  if bibliography-file != none {
    // Remove first-line-indent from the bibliography
    set par(first-line-indent: 0em, hanging-indent: 1em)
    set text(size: bibliography-size)
    bibliography(bibliography-file, style: bibliography-style)
  }

  let appendix-render(s) = {
    let appendix-format = if language == "ja" [付録] else [Appendix]
    set heading(numbering: "A", supplement: appendix-format)
    counter(heading).update(0)
    s
  }
  if appendix != ""{
    appendix-render(appendix)
  }
}
