#import "@preview/drafting:0.2.2": margin-note

// Possible states: others, front_matter, chapters, back_matter
#let doc_state = state("doc_state", "others")

#let blue_poli = cmyk(40%, 10%, 0%, 40%)

#let text_size = 12pt
#let text_sizes = (
  large: 1.44em,
  title: 2em,
  heading_lvl_1: 1.3em,
  heading_lvl_others: 1.2em,
)

#let polimi_title_page(
  title: "Title",
  author: "Name Surname",
  course: "Xxxxxxx Engineering - Ingegneria Xxxxxxx",
  person_code: "00000000",
  advisor: "Prof. Name Surname",
  coadvisor: "Name Surname",
  academic_year: "20XX-XX",
) = {
  set page(background: place(dx: 288pt, dy: -116pt, image(
    "/images/raggiera.svg",
    height: 417pt,
  )))
  set page(foreground: place(dx: 87pt, dy: 133pt, image(
    "/images/logo_deib.svg",
    width: 264pt,
  )))

  v(276pt)
  text(size: text_sizes.title, fill: blue_poli, weight: 700, title)
  v(1.5cm)
  par(leading: 6pt, text(
    size: text_sizes.large,
    fill: blue_poli,
    weight: 600,
    smallcaps[Tesi di Laurea Magistrale in #linebreak() #course],
  ))
  v(1.5cm)
  text(size: text_sizes.large)[Author: *#author*]

  let add_line(before, string, after: none) = {
    if (string != none and string != "") {
      return before + sym.space.nobreak + string + after + linebreak()
    } else {
      return none
    }
  }

  align(bottom, {
    add_line("Student ID:", person_code)
    add_line("Advisor:", advisor)
    add_line("Co-advisors:", coadvisor)
    add_line("Academic Year:", academic_year)
  })
}

#let polimi_thesis(
  title: "Title",
  author: "Name Surname",
  course: "Xxxxxxx Engineering - Ingegneria Xxxxxxx",
  person_code: "00000000",
  advisor: "Prof. Name Surname",
  coadvisor: "Name Surname",
  academic_year: "20XX-XX",
  language: "en",
  body,
) = {
  set document(title: title, author: author)
  set text(font: "New Computer Modern", size: text_size, lang: "en")
  set par(justify: true, linebreaks: "optimized", spacing: 1.7em)
  set page(
    paper: "a4",
    margin: (
      top: 4cm,
      bottom: 2.5cm,
      inside: 3.0cm,
      outside: 2.0cm,
    ),
    header: context if doc_state.get() != "others" {
      let is_chapter_first_page = (
        query(heading.where(level: 1))
          .filter(h => h.location().page() == here().page())
          .len()
          != 0
      )

      let chapter_title = if not is_chapter_first_page {
        set text(weight: "bold")
        text(fill: blue_poli, {
          if (heading.numbering != none) {
            str(counter(heading).display()).split(".").at(0)
          }
          "| "
        })
        query(selector(heading.where(level: 1)).before(here())).last().body
      }

      // Page number is always on the outer edge of the page (right on even pages, left on odd pages)
      place(dy: 75pt, if calc.even(here().page()) {
        counter(page).display()
        h(1fr)
        chapter_title
      } else {
        chapter_title
        h(1fr)
        counter(page).display()
      })
    },
    footer: {},
    numbering: none,
  )
  set math.equation(numbering: "1.")
  show math.equation: set text(font: "New Computer Modern Math")

  show heading: it => {
    set text(
      fill: blue_poli,
      size: text_sizes.heading_lvl_others,
      weight: "semibold",
    )
    if it.level == 1 {
      let state = doc_state.get()
      let heading_num = counter(heading).display()

      v(67pt)
      block(below: 32pt, {
        if state == "chapters" {
          grid(
            columns: (auto, 1fr),
            column-gutter: 7mm,
            align: (top, bottom),
            {
              set text(size: 50pt)
              text(weight: "bold", heading_num)
              h(2mm)
              text(weight: "regular", "|")
            },
            {
              v(18pt)
              text(size: text_sizes.heading_lvl_1, it.body)
            },
          )
        } else {
          text(size: text_sizes.heading_lvl_1, it.body)
        }
      })
    } else {
      block(above: 32pt, below: 20pt, {
        counter(heading).display()
        h(8mm)
        it.body
      })
    }
  }
  show heading.where(level: 1): it => context {
    if calc.odd(here().page()) {
      set page(
        background: place(bottom, dx: -106pt, dy: 33pt, image(
          "/images/raggiera.svg",
          height: 508pt,
        )),
        header: {},
      )
      pagebreak(to: "odd", weak: true)
    }
    it
  }
  show heading.where(level: 1): set heading(supplement: heading => "Chapter")

  polimi_title_page(
    title: title,
    author: author,
    course: course,
    person_code: person_code,
    advisor: advisor,
    coadvisor: coadvisor,
    academic_year: academic_year,
  )

  body
}

#let polimi_outline(title: "Contents", target: heading) = [
  = #title

  #set outline(
    depth: 3,
    indent: n => {
      if n == 2 {
        17pt
      } else if n > 2 {
        17pt + 27pt * (n - 1)
      } else {
        0pt
      }
    },
  )
  #show outline.entry.where(level: 1): it => context {
    v(19pt, weak: true)
    link(it.element.location(), strong(it.indented(
      it.prefix(),
      it.body() + h(1fr) + it.page(),
    )))
  }
  #show outline.entry: it => context {
    let space_above = if it.level == 1 and target == heading { 22pt } else {
      10pt
    }
    block(above: space_above, {
      link(it.element.location(), it.indented(it.prefix(), {
        set text(weight: if it.level == 1 and target == heading {
          "bold"
        } else { "regular" })
        it.body()
        if it.level == 1 and target == heading {
          h(1fr)
        } else {
          box(width: 1fr, repeat([. \u{0009} \u{0009}]))
        }
        it.page()
      }))
    })
  }

  #outline(
    title: none,
    depth: 3,
    indent: 1.2em,
    target: target,
  )
]

#let start_front_matter(body) = {
  doc_state.update("front_matter")
  set page(numbering: "i")
  counter(page).update(0)
  body
}

#let start_chapters(body) = {
  doc_state.update("chapters")
  set page(numbering: "1")
  set heading(numbering: (..nums) => {
    let string = nums.pos().map(str).join(".")
    if nums.pos().len() > 1 { string = string + "." }
    string
  })
  counter(page).update(0)
  counter(heading).update(0)
  body
}

#let start_back_matter(body) = {
  doc_state.update("back_matter")
  set heading(numbering: none)
  body
}

#let last_page() = context {
  pagebreak()
  set page(
    background: place(bottom, dx: -106pt, dy: 33pt, image(
      "./images/raggiera.svg",
      height: 508pt,
    )),
    header: {},
  )
}
