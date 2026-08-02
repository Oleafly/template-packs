#let cam-dark-blue = rgb(19, 56, 68)
#let cam-blue = rgb(142, 232, 216)
#let cam-light-blue = rgb(209, 249, 241)
#let cam-warm-blue = rgb(0, 189, 182)
#let cam-slate-1 = rgb(236, 238, 241)
#let cam-slate-2 = rgb(181, 189, 200)
#let cam-slate-3 = rgb(84, 96, 114)
#let cam-slate-4 = rgb(35, 40, 48)



#let _author-state = state("author", "")
#let _date-state = state("date", "")
#let _mode_state = state("mode", "light")

#let _emphasis-text-colour(mode: "light") = if (mode == "light") {
  cam-dark-blue
} else {
  cam-blue
}
#let _main-text-colour(mode: "light") = if (mode == "light") {
  cam-slate-4
} else {
  white
}

#let cam-theisis-text(mode: "light", body) = {
  set text(font: "Open Sans", size: 1em, fill: _main-text-colour(mode: mode))
  set par(justify: true)
  show heading: set text(
    font: "Feijoa Bold-Cambridge",
    fill: _emphasis-text-colour(mode: mode),
    hyphenate: false,
  )


  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    counter(math.equation).update(0)
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)
    counter(figure.where(kind: raw)).update(0)
    if (it.numbering == none) {
      align(center, text(
        font: "Feijoa Bold-Cambridge",
        size: 2em,
        fill: _emphasis-text-colour(mode: mode),
        it,
      ))
      v(1em)
      return
    }
    let supp-text = it.supplement.text
    let supp-text = upper(supp-text.at(0)) + supp-text.slice(1)
    set par(justify: false)
    v(6em)
    block(spacing: 4em, {
      text(
        font: "Feijoa Medium-Cambridge",
        size: 1.5em,
        fill: _main-text-colour(mode: mode),
        supp-text + [ ] + counter(heading).display(it.numbering),
      )
      linebreak()
      linebreak()
      text(
        font: "Feijoa Bold-Cambridge",
        size: 2em,
        fill: _emphasis-text-colour(mode: mode),
        it.body,
      )
    })
  }
  show heading.where(level: 2): set text(size: 1.5em)
  show heading.where(level: 3): set text(size: 1.5em)

  show heading.where(level: 2): it => {
    v(0.5em)
    it
    v(0.2em)
  }

  show emph: set text(fill: _emphasis-text-colour(mode: mode))
  show strong: set text(fill: _emphasis-text-colour(mode: mode))

  set math.equation(numbering: n => {
    let chapter = counter(heading).at(here()).at(0)
    numbering("1.1", chapter, n)
  })
  show math.equation: set text(
    font: "New Computer Modern Math",
    fallback: false,
  )
  show math.equation.where(block: true): set text(
    fill: _emphasis-text-colour(mode: mode),
    font: "New Computer Modern Math",
    fallback: false,
  )
  set figure(
    numbering: (..n) => {
      let chapter = counter(heading).at(here()).at(0)
      numbering("1.1", chapter, ..n)
    },
  )
  set figure(placement: auto)
  show figure.caption: set block(inset: 1em)


  let fig-depth = counter("figure-depth")

  show figure: it => {
    fig-depth.step() // Move deeper

    context {
      let depth = fig-depth.get().at(0)

      if depth == 1 {
        it
        // block(inset: 1em, it)
      } else {
        // Sub-figure: No extra padding
        // pad(bottom: 0.5em, it)
        it
      }
    }

    fig-depth.update(n => n - 1) // Move back up after processing
  }
  // TODO: we also want to add line to top and bottom of the table
  show table.cell.where(y: 0): set text(weight: "bold")
  set table(
    stroke: (x, y) => if y == 0 {
      (bottom: 0.7pt + _emphasis-text-colour(mode: mode))
    },
  )
  set table.hline(stroke: _emphasis-text-colour(mode: mode))


  set page(
    paper: "a4",
    fill: if (mode == "light") { auto } else { cam-slate-4 },
    margin: (left: 3cm, right: 3cm, top: 3cm + 2em, bottom: 3cm),
    numbering: none,
    header-ascent: 2em,
    header: context {
      // Look for a heading on the current page
      // If a heading exists on this page, return nothing (skip header)
      let headings = query(heading.where(level: 1)).filter(h => (
        h.location().page() == here().page()
      ))
      if headings.len() > 0 {
        return none
      }

      // Otherwise, find the "active" heading to display
      let before = query(heading.where(level: 1).before(here()))
      let current_title = if before.len() > 0 { before.last().body } else { "" }

      grid(
        columns: (5em, 1fr),
        align(left)[
          #text(
            weight: "bold",
            fill: _emphasis-text-colour(mode: mode),
            font: "Open Sans",
            counter(page).display(),
          )
        ],
        align(right)[
          #set par(justify: false)
          #text(
            font: "Feijoa Bold-Cambridge",
            fill: _emphasis-text-colour(mode: mode),
            [#current_title],
          )
        ],
      )
      v(-8pt)
      line(length: 100%, stroke: 1pt + _emphasis-text-colour(mode: mode))
    },
  )

  show outline.entry.where(level: 1): it => {
    v(1.5em, weak: true)
    show: strong
    set text(fill: _emphasis-text-colour(mode: mode))
    it
  }

  body
}

#let title-page(
  title: "",
  subtitle: none,
  author: "",
  crest: none,
  college-crest: none,
  department: "",
  university: "University of Cambridge",
  college: "",
  submission-text: "This dissertation is submitted for the degree of",
  degree-title: "Doctor of Philosophy",
  date: datetime.today().display("[month repr:long] [year]"),
  mode: "light",
) = {
  _author-state.update(author)
  _date-state.update(date)
  _mode_state.update(mode)

  // Set page properties for the title page
  set page(
    paper: "a4",
    margin: (left: 3cm, right: 3cm, top: 3cm, bottom: 3cm),
    numbering: none,
    fill: if (mode == "light") { auto } else { cam-slate-4 },
  )
  set text(fill: _main-text-colour(mode: mode))

  set align(center)

  // 1. University Crest (if college crest exists, university crest goes at the top)
  if college-crest != none and crest != none {
    box(width: 10cm, crest)
    v(2fr)
  }

  // 2. Title and Subtitle
  block(spacing: 2em, {
    text(
      font: "Feijoa Bold-Cambridge",
      weight: "bold",
      fill: _emphasis-text-colour(mode: mode),
      size: 2.5em,
      title,
    )
    if subtitle != none {
      parbreak()
      text(
        font: "Feijoa Medium-Cambridge",
        weight: "medium",
        size: 1.5em,
        subtitle,
      )
    }
  })

  v(3fr)

  // 3. Crest Logic (if no college crest, university crest goes here)
  if college-crest != none {
    box(width: 5cm, college-crest)
  } else if crest != none {
    box(width: 5cm, crest)
  }

  v(3fr)

  text(
    font: "Feijoa Bold-Cambridge",
    size: 1.5em,
    fill: _emphasis-text-colour(mode: mode),
    author,
  )
  v(1em)

  // 6. Department and University
  text(
    font: "Open Sans",
    size: 1.2em,
    department,
  )
  parbreak()
  text(
    font: "Open Sans",
    size: 1.2em,
    university,
  )

  v(2fr)

  // 7. Submission Text
  block(width: 80%, {
    text(
      font: "Open Sans",
      submission-text,
    )
    parbreak()
    text(
      font: "Open Sans",
      weight: "bold",
      fill: _emphasis-text-colour(mode: mode),
      degree-title,
    )
  })

  v(1fr)

  grid(
    columns: (1fr, 1fr),
    align: (left + bottom, right + bottom),
    text(font: "Open Sans", college), text(font: "Open Sans", date),
  )
  pagebreak(weak: true)
}

#let cam-theisis(
  title: "",
  subtitle: none,
  author: "",
  crest: none,
  college-crest: none,
  department: "",
  university: "University of Cambridge",
  college: "",
  submission-text: "This dissertation is submitted for the degree of",
  degree-title: "Doctor of Philosophy",
  date: datetime.today().display("[month repr:long] [year]"),
  mode: "light",
  body,
) = {
  _author-state.update(author)
  _date-state.update(date)

  title-page(
    author: author,
    crest: crest,
    college: college,
    college-crest: college-crest,
    date: date,
    degree-title: degree-title,
    department: department,
    university: university,
    submission-text: submission-text,
    subtitle: subtitle,
    title: title,
    mode: mode,
  )
  show: cam-theisis-text.with(mode: mode)
  body
}




#let preamble(body) = {
  set heading(outlined: false)
  body
}


#let main-body(body) = {
  set heading(numbering: "1.1.1", supplement: it => if it.depth == 1 {
    "chapter"
  } else { "section" })
  counter(heading).update(0)
  body
}

#let appendix(body) = {
  set heading(numbering: "A.1.1", supplement: "appendix")
  counter(heading).update(0)
  body
}


#let declaration() = {
  [
    = Declaration
    This thesis is the result of my own work and includes nothing which is the
    outcome of work done in collaboration except as declared in the preface and
    specified in the text. It is not substantially the same as any work that has
    already been submitted, or is being concurrently submitted, for any degree,
    diploma or other qualification at the University of Cambridge or any other
    University or similar institution except as declared in the preface and
    specified in the text. It does not exceed the prescribed word limit for the
    relevant Degree Committee.
    #align(right, context [
      #text(
        font: "Feijoa Bold-Cambridge",
        fill: _emphasis-text-colour(mode: _mode_state.get()),
        context _author-state.get(),
      )
      \
      #_date-state.get()
    ])
  ]
}



