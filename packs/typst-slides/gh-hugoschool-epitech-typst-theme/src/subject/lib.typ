#import "../common/lib.typ"

#let subject-decorated-page(
  content,
  show-top-left-logo,
  ..args,
) = {
  set text(fill: white)
  show heading.where(level: 2): set text(size: 20pt, weight: "medium")

  page(
    [
      #if show-top-left-logo {
        lib.utils.colorized-image("/assets/epitech.svg", width: 180pt, original_color: "#013afb", color: white)
      }

      #lib.decoration.block(150pt, 80pt, dx: 40pt, dy: -40pt)
      #lib.decoration.block(80pt, 80pt, dx: -110pt, dy: 40pt)

      #set align(center)

      #content
    ],
    fill: lib.colors.blue,
    margin: 40pt,
    footer: context [
      // Ignore the title page for counting
      #counter(page).update(0)
    ],
    ..args,
  )
}

#let subject-title-page(
  content: context [
    // Correctly set the content to about the middle of the page
    #place(
      center,
      dy: 250pt,
      [
        #lib.epitech-title(document.title)
        #lib.epitech-subtitle(document.description)
      ],
    )
  ],
  ..args,
) = {
  subject-decorated-page(content, true, ..args)
}

#let subject-final-page(content: none, version_text: none, ..args) = {
  if content == none {
    content = [
      #set align(horizon)

      #lib.version-block(version_text: version_text)

      #lib.utils.colorized-image("/assets/epitech.svg", width: 300pt, original_color: "#013afb", color: white)
    ]
  }

  subject-decorated-page(content, false, ..args)
}

#let subject-footer-decoration = {
  box("", width: 45%, height: 2pt, fill: lib.colors.blue-opacity-50, baseline: 100%)
}

#let subject-page(content, ..args) = {
  show heading.where(level: 1): set text(fill: lib.colors.blue)
  show heading.where(level: 2): set text(fill: lib.colors.blue)

  page(
    [
      #content
    ],
    footer: context [
      #subject-footer-decoration
      #h(1fr)
      #counter(page).display()
      #h(1fr)
      #subject-footer-decoration

      #set align(center)
      #lib.utils.colorized-image("/assets/epitech.svg", width: 200pt, original_color: "#013afb", color: lib.colors.blue-opacity-50)
    ],
    margin: 40pt,
    footer-descent: -50pt,
    ..args,
  )
}

#let subject-default(doc) = [
  #show title: set text(size: 3em)
  #set text(size: 12pt)

  // By default heading is same size as text
  // Except for h1, h2, h3
  #show heading.where(level: 1): set text(size: 30pt)
  #show heading.where(level: 2): set text(size: 18pt)

  #show heading.where(level: 3): set text(size: 15pt)
  #show heading.where(level: 3): set block(
    stroke: (bottom: 1pt),
  )
  #show heading.where(level: 3): it => pad(it.body, left: 10pt, bottom: 10pt)

  #lib.THEME_MODE.update(_ => "subject")
  #show: lib.default

  #doc
]
