// main.typ: Example slides
// Compile with:  typst compile --font-path fonts main.typ

#import "@preview/touying:0.8.0": *
#import "sidebar.typ": *
#import "palette.typ": palette, palette-table

#show: sidebar-theme.with(
  config-info(
    title: [Your Deck Title],
    subtitle: [A subtitle, if you like],
    author: [Your Name],
    date: datetime.today(),
    institution: [Your Organization],
    // logo: image("logo.svg", height: 0.5in),  // shows top-right of slides
  ),
)
#title-slide()

#outline-slide(title: [Agenda])

= First Section

== A normal slide

Slides come from `=` sections and `==` headings; the sidebar, header and
footer are automatic.

- Touying handles sections, numbering and animation.
- Use #alert[alert] for emphasis — it picks up the accent color.
- The left margin always clears the 0.7" sidebar graphic.

#pause

- This bullet appears on the next subslide.

#speaker-note[Remember to mention that notes work too.]

== Two columns

#slide(composer: (1fr, 1fr))[
  Left column: the `composer` argument splits the slide body.
][
  Right column: see the Touying docs for all layout options.
]

== Code, math, more

Inline `code`, and equations:

$ E = m c^2 $

#focus-slide[One big idea.]

= Second Section

== Details

- Subsections (`===`) become slides at a deeper level.
- Everything after `#show: appendix` below is appendix material.

== Brand colors

Every color lives in `palette.typ`; use `palette.orange`, `palette.teal`, …
anywhere in the deck. The full palette:

#text(size: 0.62em, palette-table())

#show: appendix

= Appendix

== Backup slide

Appendix slides keep the sidebar; numbering continues and the footer's
total stops advancing, as usual with Touying.
