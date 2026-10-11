#import "symbols.typ": *
#import "@preview/ctheorems:1.1.3": *

#let todo = highlight(text(size: 20pt, weight: "bold", "TODO"))

#let __display = state("__display", ())
#let __prob_active = state("__problem_active", false)
#let __points = state("__points", (:))
#let __setbrk = state("__setbrk", false)


#let problem(points: none, coalesce: false, title, question: none, body, solution_spacing: 1.5em) = {
  counter(heading).update(u => u + 1)
  context {
    let num = counter(heading).get().at(0)
    if num > 1 {
      pagebreak(weak: true)
    }

    if points == none {
      // initialize points
      __points.update(x => {
        x.insert(str(num), ())
        x
      })
    }
    let hdr = if points == none {
      context {
        let s = __points.final().at(str(num))
        if s.len() == 0 {
          [#title.]
        } else {
          let pr = if coalesce {
            s.sum()
          } else {
            s.map(x => str(x)).join("+")
          }
          [#title (#pr points).]
        }
      }
    } else {
      [#title (#points points).]
    }
    __prob_active.update(points == none)
    enum.item(num)[
      #set enum(numbering: "(a)")
      #if question == none {
        [#strong(hdr) #body]
      } else {
        [
          #strong(hdr) #question
          #v(solution_spacing)
          #strong[Solution.] #body
        ]
      }
    ]
    __prob_active.update(false)
  }
}

#let brk() = [
  #__setbrk.update(true)
  #colbreak(weak: true)
]

#let part(points, question, body, pb: false, solution_spacing: 1.5em, show_points: true) = {
  context {
    assert(
      __prob_active.get(),
      message: "No problem is active! Cannot declare part.",
    )
    let prob_num = counter(heading).get().at(0)
    let prob_count = __points.get().at(str(prob_num)).len() + 1
    __points.update(x => {
      let _ = x.at(str(prob_num)).push(points)
      x
    })

    if not __setbrk.get() {
      v(.75em)
    }
    __setbrk.update(false)
    enum.item(prob_count)[
      #if show_points {
        strong[(#points points).]
      }
      #question
      #v(solution_spacing)
      #strong[Solution.] #body
    ]
    v(1fr)
  }
}


// Initiate the document title, author...
#let assignment_class(
  title,
  author,
  course_id,
  semester,
  collaborators,
  collaborator_top: true,
  body,
  margin: 1.75in,
  draft: true,
) = {
  set text(size: 11pt)
  set document(title: title, author: author)

  show: thmrules.with(qed-symbol: $square$)
  set par(
    leading: .7em,
    spacing: 1.2em,
    justify: true,
  )
  set text(font: "New Computer Modern")
  show heading: set block(above: 1.4em, below: 1em)
  let width = 8.5in
  let height = 11in
  set page(
    margin: margin,
    width: width,
    height: height,
    header: box(
      inset: (bottom: 4pt, x: 2pt),
      stroke: (bottom: 0.5pt + black),
    )[#course_id, #semester #h(1fr) Name: #author],
    footer: align(
      center,
      context counter(page).get().first(),
    ),
    background: if draft {
      box(
        width: width - 2 * margin,
        height: height - 2 * margin,
        stroke: 0.8pt + gray.lighten(50%),
        outset: 4pt,
        box(
          width: width - 2 * margin,
          height: height - 2 * margin,
          stroke: 0.3pt + gray.lighten(50%),
          outset: 0pt,
          text(size: 5em, fill: gray.lighten(60%))[*DRAFT*],
        ),
      )
    } else { none },
  )


  // use parentheses as delimiters for
  // matrices/vectors
  set math.mat(delim: "(")
  set math.vec(delim: "(")
  show heading.where(level: 1): set text(20pt)
  show heading.where(level: 2): set text(16pt)
  show math.equation: set block(breakable: true)

  show link: set text(fill: rgb(0, 0, 100%).darken(30%), weight: "bold")

  let collaborators = {
    [*Collaborators: *]
    if collaborators.len() == 0 {
      [_none_.]
    } else {
      set list(indent: 1em)
      for collaborator in collaborators {
        list.item(collaborator)
      }
    }
  }
  v(2em)
  align(center, text(16pt, title))
  v(2em)
  if collaborator_top {
    collaborators
  }
  v(1em)
  body
  if collaborator_top == false {
    pagebreak(weak: true)
    collaborators
  }
}
