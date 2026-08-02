#let default-color = rgb("#A4123F")
#let logo-path = "amrita-logo.svg"
#let bar-height = 1.33em
#let layouts = (
  "small": ("height": 9cm, "space": 1.4cm),
  "medium": ("height": 10.5cm, "space": 1.6cm),
  "large": ("height": 12cm, "space": 1.8cm),
)
#let layout-space = state("space", v(-0.8cm))

// Helper to normalize authors input into an array of dictionaries
#let to-author-array(authors) = {
  if type(authors) == str {
    ((name: authors),)
  } else if type(authors) == array and authors.len() > 0 and type(authors.at(0)) == str {
    authors.map(a => (name: a))
  } else {
    authors
  }
}

#let slide-header(space, dense-mode, title, date, title-color) = {
  let margin = 0.5 * space

  // Static top bar
  place(
    top + left,
    dx: -1.6 * margin,
    dy: 0em,
    rect(
      fill: default-color,
      width: 100% + 3.2 * margin,
      height: bar-height,
      stroke: none,
      inset: (x: 1em),
    )[
      #set text(fill: white, size: 0.8em)
      #if dense-mode == true {
        align(horizon)[
          #grid(
            columns: (1fr, auto),
            align: (left, right),
            if title != none { title }, if date != none { date },
          )
        ]
      }
    ],
  )

  // Dynamic running header: shows the current section (Level 2 heading)
  let page = here().page()
  let all-headings = query(heading)
  let last-heading = all-headings.rev().find(x => x.location().page() <= page and x.level <= 2)

  if last-heading != none and last-heading.level == 2 {
    set align(top)
    set text(1.4em, weight: "bold", fill: title-color)

    v(bar-height + 0.5em)

    block(
      last-heading.body
        + if not last-heading.location().page() == page [
          #{ numbering("(i)", page - last-heading.location().page() + 1) }
        ],
    )
  }
}

#let slide-footer(space, dense-mode, event) = {
  let margin = 0.5 * space
  place(
    bottom + left,
    dx: -1.6 * margin,
    rect(
      fill: default-color,
      width: 100% + 3.2 * margin,
      height: bar-height,
      stroke: none,
      inset: (x: 1em, y: 0em),
    )[
      #set text(fill: white)
      #align(horizon)[
        #grid(
          columns: (1fr, auto, 1fr),
          align: (left, center, right),

          counter(page).display("1/1", both: false),

          if dense-mode == true and event != none {
            text(event, size: 0.85em)
          },

          image(logo-path, width: 4.25em),
        )
      ]
    ],
  )
}
#let render-authors(authors, affiliations, color: white) = {
  set text(fill: color)

  // Render author names with superscript affiliation indices
  let author-list = authors
    .enumerate()
    .map(((i, author)) => {
      let affil-num = if author.at("affiliation", default: none) != none {
        let idx = affiliations.position(a => a == author.affiliation)
        if idx != none { super(str(idx + 1)) } else { none }
      } else if affiliations.len() > 0 and i < affiliations.len() {
        super(str(i + 1))
      } else { none }
      [#author.name#affil-num]
    })
  box(author-list.join(h(1.5em)))

  // Render emails
  let emails = authors
    .filter(a => a.at("email", default: a.at("contact", default: none)) != none)
    .map(a => a.at("email", default: a.at("contact", default: none)))

  if emails.len() > 0 {
    v(0.3em)
    set text(0.8em, fill: color.darken(10%))
    emails.join([ #sym.dot.c ])
  }

  v(0.8em)
}

// Default title slide layout
#let title-slide-default(
  body,
  title: none,
  subtitle: none,
  date: none,
  authors: (),
  affiliations: (),
  event: none,
  layout: "medium",
  ratio: 4 / 3,
  title-color: default-color,
  team-logo: none,
  title-theme: none,
) = {
  let (height, space) = layouts.at(layout)

  authors = to-author-array(authors)

  set page(
    header: place(dx: -2em, dy: 0em, rect(
      fill: white,
      width: 200%,
      height: bar-height,
    )),
    footer: {
      place(dx: -2em, dy: -0.5em, rect(
        fill: white,
        width: 100% + space,
        height: 3em,
        inset: (x: 1em, y: 0.35em),
      )[
        #set text(fill: white)
        #if event != none or date != none {
          box(width: 100%)[
            #if event != none {
              text(0.9em, fill: default-color, weight: "bold", event)
            }
            #h(1fr)
            #if date != none {
              place(right + horizon, text(0.9em, fill: default-color, date))
            }
          ]
        }
      ])
    },
    fill: default-color,
    margin: (left: 1.25em, right: 1.25em, top: 3em, bottom: 1em),
  )
  place(bottom + right, dy: -0.7em, image(logo-path, width: 13em))
  if team-logo != none {
    place(bottom + left, dy: -0.7em, dx: -0em, team-logo)
  }
  set align(left + horizon)
  context layout-space.get()

  place(dy: 5em)[
    #if title != none {
      v(0.5em, weak: false)
      text(2.0em, weight: "bold", fill: white, title)
      v(1em, weak: true)

      if subtitle != none {
        text(1.21em, fill: white.darken(90%), subtitle)
        v(1em, weak: true)
      }

      v(1em)

      // Render authors using the helper
      set text(fill: white)
      {
        let author-list = authors
          .enumerate()
          .map(((i, author)) => {
            let affil-num = if author.at("affiliation", default: none) != none {
              let idx = affiliations.position(a => a == author.affiliation)
              if idx != none { super(str(idx + 1)) } else { none }
            } else if affiliations.len() > 0 and i < affiliations.len() {
              super(str(i + 1))
            } else { none }

            let name-text = author.name
            [#name-text#affil-num]
          })
        author-list.join(h(1.5em))
      }

      {
        let emails = authors
          .filter(a => a.at("email", default: a.at("contact", default: none)) != none)
          .map(a => a.at("email", default: a.at("contact", default: none)))
        if emails.len() > 0 {
          v(0.3em)
          set text(0.8em, fill: white.darken(90%))
          emails.join([ #sym.dot.c ])
        }
      }

      v(0.8em)

      if affiliations.len() > 0 {
        set text(0.7em, fill: white.darken(10%))
        for (i, affil) in affiliations.enumerate() {
          [#super(str(i + 1))#affil \ ]
        }
      }
    }

    #if body != none {
      body
    }
  ]
  pagebreak(weak: true)
}

#let title-slide-minimal(
  title: none,
  subtitle: none,
  date: none,
  authors: (),
  affiliations: (),
  event: none,
  layout-data: (:),
  team-logo: none,
  ..args,
) = {
  set page(
    margin: 2em,
    fill: default-color,
    header: none,
    footer: none,
  )

  // Bottom Section (Logo + Metadata)
  place(bottom + left, dx: 0em, dy: 0em)[
    #set text(fill: white)
    #grid(
      columns: (1fr, auto),
      align: (bottom + left, bottom + right),

      // Left: Metadata
      if event != none or date != none {
        block(inset: (bottom: 0.5em))[
          #if event != none { text(weight: "bold", size: 0.9em, event) }
          #if event != none and date != none { [ \ ] }
          #if date != none { text(size: 0.8em, fill: white.darken(10%), date) }
        ]
      },

      // Right: Logo
      image(logo-path, width: 10em),
    )
  ]

  // Main Content (Centered)
  set align(left)

  if team-logo != none {
    image(team-logo, width: 4em)
    v(1em)
  }

  if title != none {
    text(2em, weight: "bold", fill: white, title)
    if subtitle != none {
      v(0.5em)
      text(1.4em, weight: "regular", fill: white.darken(10%), subtitle)
    }
    v(2em)
    render-authors(authors, affiliations, color: white)
  }

  pagebreak(weak: true)
}

#let title-slide(..args) = {
  if args.named().at("title-theme", default: none) == "minimal" {
    title-slide-minimal(..args)
  } else {
    title-slide-default(..args)
  }
}
#let slides(
  content,
  title: none,
  subtitle: none,
  date: none,
  authors: (),
  affiliations: (),
  event: none,
  layout: "medium",
  ratio: 4 / 3,
  title-color: default-color,
  team-logo: none,
  dense-mode: false,
  title-theme: none,
) = {
  if layout not in layouts {
    panic("Unknown layout " + layout)
  }
  let (height, space) = layouts.at(layout)
  let width = ratio * height
  layout-space.update(v(-space / 2))

  if title-color == none {
    title-color = default-color
  }

  authors = to-author-array(authors)

  let author-names = authors.map(a => a.name).join(", ")
  set document(title: title, author: author-names)


  set page(
    width: width,
    height: height,
    header-ascent: 0%,
    margin: (top: 4.5em),
    header: context slide-header(space, dense-mode, title, date, title-color),
    footer: context slide-footer(space, dense-mode, event),
  )
  set outline(title: none, target: heading.where(level: 1))
  set bibliography(title: none)

  show heading.where(level: 1): h1 => {
    pagebreak()
    v(-space / 2)
    align(center + horizon, text(h1.body, size: 1.5em))
  }
  show heading.where(level: 2): it => {
    pagebreak(weak: true)
    v(0.5em)
  }
  show heading: set text(1.1em, fill: title-color)

  if title != none {
    title-slide(
      none,
      title: title,
      subtitle: subtitle,
      date: date,
      authors: authors,
      affiliations: affiliations,
      event: event,
      layout: layout,
      ratio: ratio,
      title-color: title-color,
      team-logo: team-logo,
      title-theme: title-theme,
    )
  }

  content
}


// Generic framed box for theorems, definitions, etc.
#let frame(content, counter: none, title: none, fill-body: none, fill-header: none, radius: 0.2em) = {
  let header = none

  if fill-header == none and fill-body == none {
    fill-header = default-color.lighten(75%)
    fill-body = default-color.lighten(85%)
  } else if fill-header == none {
    fill-header = fill-body.darken(10%)
  } else if fill-body == none {
    fill-body = fill-header.lighten(50%)
  }

  if radius == none {
    radius = 0pt
  }

  if counter == none and title != none {
    header = [*#title.*]
  } else if counter != none and title == none {
    header = [*#counter.*]
  } else {
    header = [*#counter:* #title.]
  }

  show stack: set block(breakable: false, above: 0.8em, below: 0.5em)

  stack(
    block(
      width: 100%,
      inset: (x: 0.4em, top: 0.35em, bottom: 0.45em),
      fill: fill-header,
      radius: (top: radius, bottom: 0cm),
      header,
    ),
    block(
      width: 100%,
      inset: (x: 0.4em, top: 0.35em, bottom: 0.45em),
      fill: fill-body,
      radius: (top: 0cm, bottom: radius),
      content,
    ),
  )
}

// Helper for creating numbered environments (Theorem 1, Definition 2, etc.)
#let numbered-frame(c, label, content, title, ..options) = {
  c.step()
  frame(
    counter: context c.display(x => label + " " + str(x)),
    title: title,
    content,
    ..options,
  )
}

#let d = counter("definition")
#let definition(content, title: none, ..options) = numbered-frame(d, "Definition", content, title, ..options)

#let t = counter("theorem")
#let theorem(content, title: none, ..options) = numbered-frame(t, "Theorem", content, title, ..options)

#let l = counter("lemma")
#let lemma(content, title: none, ..options) = numbered-frame(l, "Lemma", content, title, ..options)

#let c = counter("corollary")
#let corollary(content, title: none, ..options) = numbered-frame(c, "Corollary", content, title, ..options)

#let a = counter("algorithm")
#let algorithm(content, title: none, ..options) = numbered-frame(a, "Algorithm", content, title, ..options)
