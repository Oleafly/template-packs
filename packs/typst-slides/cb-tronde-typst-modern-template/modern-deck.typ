// Modern Polylux presentation template — import with:
//   #import "modern-deck.typ": *
//   #show: deck-setup
// Overlays wie in `slides.typ`: zusätzlich z. B.
//   #import "@preview/polylux:0.4.0": item-by-item, uncover
#import "@preview/polylux:0.4.0": *

// --- Design tokens (tweak for your brand) ---
#let c-bg = rgb("#f4f6f8")
#let c-surface = white
#let c-ink = rgb("#12151a")
#let c-muted = rgb("#5c6570")
#let c-accent = rgb("#cc0000")
#let c-accent-soft = c-accent.lighten(88%)
#let c-bar = rgb("#1e2430")

// Add e.g. "Source Sans 3" or "IBM Plex Sans" here if the families are installed locally.
#let font-stack = ("Liberation Sans", "DejaVu Sans")

#let deck-setup(body) = {
  set page(
    paper: "presentation-16-9",
    margin: (x: 2.4cm, y: 1.75cm),
    fill: c-bg,
    numbering: "1 / 1",
    number-align: bottom + right,
  )
  set text(size: 22pt, font: font-stack, fill: c-ink, weight: 400)
  set par(justify: false, leading: 0.65em)
  set heading(numbering: none)

  show heading.where(level: 1): it => {
    set text(weight: 700, size: 1.35em)
    block(inset: (bottom: 0.35em), stroke: (bottom: 3pt + c-accent), width: 100%, it)
  }
  show heading.where(level: 2): it => {
    set text(weight: 600, size: 1.05em, fill: c-muted)
    block(inset: (bottom: 0.55em), it)
  }

  body
}

/// Full-bleed title slide with accent bar and optional subtitle.
#let title-slide(
  title,
  subtitle: none,
  author: none,
  date: none,
  tagline: none,
) = slide[
  #set page(margin: 0pt, fill: c-bg)
  #block(width: 100%, height: 100%, inset: 0pt)[
    #place(top + left, dx: 0pt, dy: 0pt)[
      #box(width: 100%, height: 0.42em, fill: c-bar)
    ]
    #place(
      horizon + left,
      dx: 8%,
      dy: -3%,
    )[
      #stack(
        spacing: 1.1em,
        if tagline != none {
          set text(size: 0.72em, weight: 600, fill: c-accent)
          tagline
        },
        {
          set text(size: 1.65em, weight: 800, fill: c-ink)
          title
        },
        if subtitle != none {
          set text(size: 0.95em, fill: c-muted, weight: 500)
          subtitle
        },
      )
    ]
    #place(bottom + left, dx: 8%, dy: -10%)[
      #stack(
        spacing: 0.45em,
        if author != none {
          set text(size: 0.82em, weight: 600)
          author
        },
        if date != none {
          set text(size: 0.72em, fill: c-muted)
          date
        },
      )
    ]
    #place(bottom + right, dx: -8%, dy: -8%)[
      #box(
        width: 2.6em,
        height: 2.6em,
        radius: 0.35em,
        fill: c-accent-soft,
        stroke: 1pt + c-accent.lighten(40%),
      )
    ]
  ]
]

/// Section break — large label on tinted panel.
#let section-slide(label) = slide[
  #set page(fill: c-bar)
  #set align(horizon + left)
  #block(width: 100%, inset: (left: 8%))[
    #stack(
      spacing: 0.5em,
      {
        set text(size: 0.75em, weight: 700, fill: c-accent.lighten(15%))
        [Abschnitt]
      },
      {
        set text(size: 1.55em, weight: 800, fill: white)
        label
      },
    )
  ]
]

/// Two-column layout: headline + optional side rail (e.g. icon / quote).
#let split-slide(title, left, rail: none) = slide[
  #if rail == none {
    grid(
      columns: (1fr,),
      {
        set align(top)
        stack(spacing: 0.85em, title, left)
      },
    )
  } else {
    grid(
      columns: (1.15fr, 0.85fr),
      column-gutter: 1.4em,
      {
        set align(top)
        stack(spacing: 0.85em, title, left)
      },
      align(horizon + right)[
        box(
          width: 100%,
          inset: 1em,
          radius: 0.5em,
          fill: c-surface,
          stroke: 0.7pt + c-accent.lighten(70%),
          rail,
        )
      ],
    )
  }
]

/// Career / timeline: `entries` is an array of (period, role, detail) content.
#let timeline-slide(title, entries) = slide[
  #title
  #v(0.6em)
  #stack(
    spacing: 0.85em,
    ..entries.map(((period, role, detail)) => {
      block(width: 100%, inset: (y: 0.55em, x: 0.75em), radius: 0.45em, fill: c-surface, stroke: 0.55pt + rgb("#e1e6eb"))[
        #grid(
          columns: (22%, 1fr),
          column-gutter: 1em,
          align: top + left,
          {
            set text(size: 0.72em, weight: 700, fill: c-accent)
            period
          },
          stack(
            spacing: 0.25em,
            { set text(weight: 700); role },
            { set text(size: 0.82em, fill: c-muted); detail },
          ),
        )
      ]
    }),
  )
]

/// Simple agenda from section titles (plain strings or content).
#let agenda-slide(items, title: [Überblick]) = slide[
  #heading(level: 1, title)
  #v(0.5em)
  #grid(
    columns: 1,
    row-gutter: 0.55em,
    ..items.enumerate().map(((i, it)) => {
      block(width: 100%, inset: (y: 0.45em, x: 0.65em), radius: 0.4em, fill: c-surface)[
        #grid(
          columns: (1.8em, 1fr),
          column-gutter: 0.6em,
          align: horizon + left,
          text(weight: 800, fill: c-accent, str(i + 1)),
          it,
        )
      ]
    }),
  )
]

/// Closing slide.
#let closing-slide(message: [Vielen Dank.], sub: [Fragen?]) = slide[
  #set align(horizon + center)
  #stack(
    spacing: 0.6em,
    { set text(size: 1.45em, weight: 800); message },
    { set text(size: 0.95em, fill: c-muted); sub },
  )
]
