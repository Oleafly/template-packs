// ============================================================
// Example poster — Typst port of the Gemini / beamerposter theme
// Compile with:  typst compile --font-path fonts poster.typ
// Live preview:  typst watch   --font-path fonts poster.typ
// Pick a theme:  typst compile --font-path fonts --input theme=sapienza poster.typ
// ============================================================
#import "lib.typ": *

// Shortcuts (equivalents of LaTeX macros)
#let cite-full(key) = cite(key, form: "full")

// Theme selectable from the CLI (used by `make preview`); defaults to navy.
#let theme-choice = sys.inputs.at("theme", default: "navy")

// ------------------------------------------------------------
// Placeholder figures, drawn in Typst — replace with
// `image("figs/your-figure.png", width: 100%)` in a real poster.
// ------------------------------------------------------------
#let fig-colors = (rgb("#00305A"), rgb("#4A6FA5"), rgb("#9DB4CE"))

#let demo-bars(values: (0.35, 0.6, 0.45, 0.8, 0.95, 0.7), height: 13em) = {
  box(width: 100%, height: height, stroke: 0.05em + luma(60%), inset: 1em,
    align(bottom,
      grid(
        columns: values.map(_ => 1fr),
        column-gutter: 1em,
        align: bottom,
        ..values.enumerate().map(((i, v)) =>
          box(width: 100%, height: v * (height - 3em), fill: fig-colors.at(calc.rem(i, 3)))
        ),
      )
    )
  )
}

#let demo-scatter(height: 13em) = {
  let pts = (
    (6%, 78%), (14%, 70%), (22%, 74%), (30%, 58%), (38%, 52%),
    (48%, 44%), (56%, 48%), (64%, 34%), (74%, 26%), (84%, 20%), (92%, 12%),
  )
  box(width: 100%, height: height, stroke: 0.05em + luma(60%), {
    place(top + left, line(start: (4%, 82%), end: (96%, 10%), stroke: 0.1em + fig-colors.at(1)))
    for (x, y) in pts {
      place(top + left, dx: x, dy: y, circle(radius: 0.24em, fill: fig-colors.at(0)))
    }
  })
}

#show: poster.with(
  title: [A Gemini-Style Academic Poster Template for Typst],
  authors: [Ada Lovelace #h(2em) Charles Babbage],
  institute: [University of Example, Department of Placeholder Studies],
  footer: [#link("mailto:ada.lovelace@example.edu")[ada.lovelace\@example.edu] #h(3em) #link("https://github.com/andrerecio/typst-poster-gemini")[github.com/andrerecio/typst-poster-gemini]],
  // logo-left: image("logos/your-logo.png", height: 3.2cm),
  theme: theme-choice,    // "navy" | "sapienza" | "navy-filled" | "sapienza-filled"
  paper: "a1",
  columns: 2,
  font-size: 20pt,
)

// Bibliography database: loaded but not printed (like \nobibliography).
// Cite with `@key` or print an entry inline with `cite(<key>, form: "full")`.
#show bibliography: none
#bibliography("refs.bib", style: "chicago-author-date")

// ============================================================
// LEFT COLUMN
// ============================================================

#example-block[Motivation][
  - This template is a Typst port of the *Gemini* beamerposter theme (via the
    _gemini-cam_ fork). It reproduces the three block styles, the header and
    footer bands, and the Montserrat + Source Sans 3 typography

  - Typst compiles a full-size poster in milliseconds and hot-reloads with
    `typst watch` --- no more waiting on `pdflatex` for every comma

  - Tinted #accent[*example blocks*] like this one are traditionally used for
    motivation and background; citations work as usual @turing1950
]

#plain-block[Mathematics and Lists][
  Display mathematics uses New Computer Modern Math, so formulas look the way
  they do in the LaTeX original:
  $
    C = W log_2 (1 + S / N),
    quad
    H(X) = -sum_(i=1)^n p(x_i) log_2 p(x_i).
  $

  The channel capacity above is due to @shannon1948. Regular bullet lists get
  the square Gemini marker, while conclusions can use the arrow list:

  #arrows-list[
    *Arrow lists* (`arrows-list`) mirror the "⇒" itemize style used in Gemini
    posters for takeaways and conclusions
  ][
    Inline #accent[*accented text*] (`accent`) picks up the theme's primary
    colour automatically, like `\textcolor{camblue}{...}` in gemini-cam
  ]
]

#alert-block[Results][
  #figure-box(
    demo-bars(),
    caption: [*Placeholder bar chart*, drawn directly in Typst. In a real
      poster, pass `image("figs/your-figure.png", width: 100%)` to
      `figure-box` instead],
  )
  #v(0.5em)
  #figure-box(
    width: 90%,
    demo-scatter(),
    caption: [*Placeholder scatter plot* with a fitted line. The `width`
      parameter of `figure-box` controls the size relative to the column],
  )
  #v(0.5em)
  #arrows-list[
    *Alert blocks* like this one are traditionally reserved for the headline
    results --- the part of the poster a passer-by should read first
  ][
    Figures sit in `figure-box`, which centres the content and typesets the
    caption in small type underneath
  ]
]

#plain-block[Sub-structure Inside Blocks][
  Longer sections can be organised with headings (`= Like This`), set in the
  same heavy Montserrat as the block titles:

  = Data
  Describe the sample, sources, and any preprocessing here --- placeholder
  text standing in for a real methods paragraph.

  = Estimation
  Pair a heading with a formula or a short list when a whole block would be
  too much:
  $ hat(beta) = (X' X)^(-1) X' y $
]

#colbreak()

// ============================================================
// RIGHT COLUMN
// ============================================================

#plain-block[Using the Template][
  - Wrap your document in `#show: poster.with(...)` and set `title`,
    `authors`, `institute`, `footer`, and optionally `logo-left`/`logo-right`
  - Choose a colour theme by name (`"navy"`, `"sapienza"`, or their
    `-filled` variants) or pass a dictionary to override individual colours
  - Content is laid out in balanced columns; use `#colbreak()` to move to the
    next column, and `paper`, `columns`, `font-size` to change the format
  - Structure the poster with `plain-block`, `example-block`, and
    `alert-block` --- the equivalents of `block`, `exampleblock`, and
    `alertblock` in beamer @knuth1984
]

#plain-block[Colour Themes][
  #let swatch(c) = box(width: 1.3em, height: 0.75em, fill: c, stroke: 0.03em + luma(55%), baseline: 0.12em)
  Themes are plain dictionaries of colours (see `themes.typ`); pick one by
  name or override any key inline:

  #v(0.2em)
  #table(
    columns: (auto, auto, 1fr),
    stroke: none,
    inset: (y: 0.3em, x: 0.6em),
    align: (left, center, left),
    table.header([*Theme*], [*Primary*], [*Header and footer*]),
    [`navy`], swatch(themes.navy.primary), [white, black text],
    [`sapienza`], swatch(themes.sapienza.primary), [white, black text],
    [`navy-filled`], swatch(themes.at("navy-filled").primary), [coloured bands, white text],
    [`sapienza-filled`], swatch(themes.at("sapienza-filled").primary), [coloured bands, white text],
  )
  #v(0.2em)

  ```typst
  theme: themes.navy + (primary: rgb("#B31B1B"))
  ```
]

#plain-block[A Second Plain Block][
  The first computer program was written for a machine that was never built
  @lovelace1843. Body text is justified by default and set in Source Sans 3;
  block titles are set in heavy Montserrat, matching the Gemini theme.

  - Blocks are unbreakable, so each block stays within a single column
  - Links are tinted with the theme's primary colour:
    #link("https://typst.app/docs")[typst.app/docs]
  - Headings (`= Like This`) may be used inside blocks for sub-structure

  $ integral_0^oo e^(-x^2) dif x = sqrt(pi) / 2 $
]

#plain-block[Poster Sizes and Layout][
  The template accepts any Typst paper name or an explicit page size:

  - `paper: "a0"` with `font-size: 26pt`, or `paper: "a1"` with `20pt`
  - `flipped: true` for landscape; combine with `columns: 3` for wide venues
  - Custom sizes for US-style boards: `width: 36in, height: 48in`
  - `gutter` controls both the space between columns and the outer margin

  The header reserves symmetric space on both sides whenever a logo is given
  (`logo-width`), so the title stays optically centred even with a single
  logo. The footer band appears only when `footer` is not `none`.
]

#alert-block[Conclusions][
  #arrows-list[
    A familiar beamerposter look with a modern, fast toolchain: one `.typ`
    file, one `make`, one PDF
  ][
    Four built-in colour themes and a small dictionary-based theming system
    make institutional restyling a one-line change
  ][
    Fonts are vendored in `fonts/`, so the poster builds identically on any
    machine and in CI
  ]
]

#plain-block[References][
  #set text(size: 0.7em)
  #set par(leading: 0.5em, spacing: 0.7em, justify: false)
  #cite-full(<turing1950>) \
  #cite-full(<shannon1948>) \
  #cite-full(<knuth1984>) \
  #cite-full(<lovelace1843>)

  #v(0.4em)
  #text(size: 1.25em)[*Contact:* #link("mailto:ada.lovelace@example.edu")[ada.lovelace\@example.edu]]
]
