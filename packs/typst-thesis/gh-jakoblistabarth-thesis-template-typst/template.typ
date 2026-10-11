#let frontmatter-section = (section-title, it) => {
  set align(center)
  heading(outlined: false, text(tracking: 0.3em, size: 0.5em, upper(section-title)))
  it
}

#let appendix(body) = {
  set heading(numbering: "A.1.", supplement: [Appendix])
  // Reset heading counter
  counter(heading).update(0)

  // Figure and Table numbering
  let numbering-fig = n => {
    let h1 = counter(heading).get().first()
    numbering("A.1", h1, n)
  }

  set figure(numbering: numbering-fig)

  // isappendix.update(true)

  body
}

#let bib-state = state("bib-config", none)

#let print-bibliography() = context {
  let cfg = bib-state.get()
  if cfg.path != none {
    pagebreak(weak: true)
    heading[List of References]
    set text(font: "Alegreya Sans")
    columns(2, std.bibliography(cfg.path, style: cfg.style, title: none))
  }
}

#let bibliography-here(body) = {
  print-bibliography()
  body
}

#let master-thesis-template = (
  title: none,
  author: none,
  subtitle: none,
  date: datetime.today(),
  place: none,
  thesis-type: "Master's Thesis",
  duration: none,
  bibliography: none,
  bibliography-style: "apa",
  abstract: none,
  keywords: none,
  supervisor: none,
  thesis-assessment-board: none,
  submitted-at: (:),
  acknowledgements: none,
  line-numbering: false,
  body,
) => {
  set document(
    title: title,
  )

  bib-state.update((path: bibliography, style: bibliography-style))

  set text(lang: "en", font: "Alegreya", size: 10pt)

  show heading: set text(font: "Alegreya Sans")

  set par.line(
    numbering: i => if line-numbering == true { if calc.rem(i, 5) == 0 or i == 1 { text(fill: gray, str(i)) } } else {
      none
    },
  )

  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    set text(size: 1.5em)
    set block(below: 1em)
    it
  }

  show link: it => {
    if type(it.dest) == str { text(fill: blue, underline(it)) } else {
      it
    }
  }

  align(horizon, {
    show title: set text(font: "Alegreya Sans", size: 1.75em)
    show title: set par(leading: .35em)
    std.title()

    text(font: "Alegreya Sans", weight: 300, size: 1.5em, subtitle)
    v(5em)

    thesis-type
    v(1em)
    emph(author)
    linebreak()
    duration
  })

  set page(
    margin: (top: 2.5cm, bottom: 5cm, x: 3.5cm),
  )

  pagebreak()

  align(horizon, {
    [Thesis submitted to the #submitted-at.faculty of #submitted-at.university in partial fulfillment of the requirements for the joint Master of Science in Cartography.]

    v(3em)

    [
      _Supervisor_\
      #supervisor
    ]

    v(1em)

    [
      _Thesis Assessment Board_\
      #thesis-assessment-board.join(linebreak())
    ]
  })

  pagebreak()

  counter(page).update(1)
  set page(numbering: "i", number-align: left)

  align(horizon, frontmatter-section("Statement of Authorship")[
    #set align(left)
    Herewith I declare that I am the sole author of the submitted Master's thesis entitled: #title. I have fully referenced the ideas and work of others, whether published or unpublished. Literal or
    analogous citations are clearly marked as such.

    #place, #date.display()\
    #author
  ])

  pagebreak()

  align(bottom, frontmatter-section(
    "Disclaimer",
  )[This document describes work undertaken as part of a programme of study at the #submitted-at.faculty
    of the #submitted-at.university. All views and opinions expressed therein remain the sole
    responsibility of the author, and do not necessarily represent those of the Faculty.])

  heading(outlined: false, numbering: none)[Abstract]

  abstract

  v(1em)

  [*Keywords:* #keywords]

  {
    if acknowledgements != none {
      heading(outlined: false, numbering: none)[Acknowledgements]
      acknowledgements
    }
  }

  {
    show outline.entry.where(level: 1): it => link(
      it.element.location(),
      {
        set text(size: 1em, weight: "bold", font: "Alegreya Sans")
        set block(above: 2em, below: 1em)
        it.indented(
          none,
          [
            #it.prefix() #it.body() #h(1fr) #it.page()
          ],
        )
      },
    )
    outline()
  }

  outline(
    title: [List of Figures],
    target: figure.where(kind: image),
  )

  outline(
    title: [List of Tables],
    target: figure.where(kind: table),
  )

  pagebreak()

  set par(justify: true)
  set heading(numbering: "1.1")
  counter(page).update(1)
  set page(
    header: context [
      #let h = (
        query(heading.where(level: 1).after(here()))
          .filter(h => h.location().page() == here().page())
          .at(
            0,
            default: {
              query(heading.where(level: 1).before(here())).at(-1, default: none)
            },
          )
      )

      #set text(size: 6pt)
      #if h != none {
        let nums = counter(heading).at(h.location())
        let number = numbering(h.numbering, ..nums)
        align(center, text(size: 1em, font: "Alegreya Sans", {
          number + sym.space.third + h.body
        }))
      }
    ],
    footer-descent: 3.5em,
    footer: context {
      set text(size: 6pt, font: "Alegreya Sans")
      grid(
        align: (left, right),
        columns: (1fr, 1fr),
      )[

        #counter(page).display("1 of 1", both: true)
      ][
        #strong(document.title)
      ]
    },
    numbering: "1",
  )

  body
}
