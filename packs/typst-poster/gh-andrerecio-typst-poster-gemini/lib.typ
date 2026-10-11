// ============================================================
// gemini-typst — academic poster template for Typst
// A port of the "Gemini" beamerposter theme (Anish Athalye, MIT)
// ------------------------------------------------------------
// Public API:
//   poster(...)[body]          – document wrapper (page, fonts, header, footer)
//   plain-block(title)[body]   – white block, rule under the title
//   example-block(title)[body] – tinted block (motivation, background, ...)
//   alert-block(title)[body]   – tinted block (results, takeaways, ...)
//   figure-box(image, caption) – centred figure with a small caption
//   arrows-list[..]            – bullet list using "⇒" as marker
//   themes                     – dictionary of colour themes (see themes.typ)
// ============================================================

#import "themes.typ": themes

// The active theme is stored in a state so that blocks can read it.
#let _theme = state("poster-theme", themes.navy)

// ------------------------------------------------------------
// Helpers
// ------------------------------------------------------------

#let _resolve-theme(theme) = {
  if type(theme) == str {
    assert(theme in themes, message: "Unknown theme '" + theme + "'. Available: " + themes.keys().join(", "))
    themes.at(theme)
  } else {
    // A user-supplied dictionary: fill missing keys from the navy theme.
    themes.navy + theme
  }
}

/// Generic block. `kind` is one of "plain", "example", "alert".
#let poster-block(title, kind: "plain", body) = context {
  let t = _theme.get()
  let (bg, title-color) = if kind == "example" {
    (t.example-bg, t.example-title)
  } else if kind == "alert" {
    (t.alert-bg, t.alert-title)
  } else {
    (t.block-bg, t.block-title)
  }

  block(
    width: 100%,
    fill: bg,
    inset: (x: 0.8em, top: 0.6em, bottom: 0.9em),
    below: 1.3em,
    breakable: false,
    {
      // Title
      set par(justify: false)
      align(center)[
        #text(
          font: "Montserrat",
          weight: 900,
          size: 1.45em,
          fill: title-color,
          hyphenate: false,
        )[#title]
      ]
      v(-0.35em)
      // Thin rule
      line(length: 100%, stroke: 0.06em + t.block-rule)
      v(0.4em)
      // Body
      set par(justify: true)
      body
    },
  )
}

#let plain-block(title, body) = poster-block(title, kind: "plain", body)
#let example-block(title, body) = poster-block(title, kind: "example", body)
#let alert-block(title, body) = poster-block(title, kind: "alert", body)

/// Centred figure with a caption in small type.
/// `width` is relative to the enclosing column.
#let figure-box(img, caption: none, width: 80%) = {
  align(center)[
    #box(width: width)[
      #img
      #if caption != none {
        v(0.2em)
        text(size: 0.8em)[#caption]
      }
    ]
  ]
}

/// A list whose marker is "⇒" (used in Gemini posters for conclusions).
#let arrows-list(..items) = context {
  set list(marker: text(fill: _theme.get().primary)[$arrow.r.double$], indent: 0.4em, body-indent: 0.6em)
  list(..items)
}

/// Text in the theme's primary colour (like `\textcolor{camblue}{...}`).
#let accent(body) = context text(fill: _theme.get().primary)[#body]

// ------------------------------------------------------------
// Main wrapper
// ------------------------------------------------------------

/// Poster document.
///
/// - title: poster title (content)
/// - authors: content, e.g. [Ada Lovelace #h(1.5em) Charles Babbage]
/// - institute: content
/// - footer: content shown in the footer band (or `none`)
/// - logo-left / logo-right: content (e.g. `image("logos/x.png", height: 4cm)`) or `none`
/// - logo-width: width reserved on *both* sides of the title when at least one logo is given (keeps the title centred)
/// - theme: theme name ("navy", "sapienza", "navy-filled", "sapienza-filled") or a dictionary
/// - paper: any Typst paper name ("a0", "a1", "a2", ...) — ignored if `width`/`height` are given
/// - width / height: custom page size (e.g. 36in × 48in)
/// - flipped: landscape orientation
/// - columns: number of body columns
/// - gutter: horizontal space between columns (and outer margin)
/// - font-size: base body size
/// - body-font / title-font / math-font: font families (must be reachable by Typst)
#let poster(
  title: [Poster title],
  authors: none,
  institute: none,
  footer: none,
  logo-left: none,
  logo-right: none,
  logo-width: 14%,
  theme: "navy",
  paper: "a1",
  width: none,
  height: none,
  flipped: false,
  columns: 2,
  gutter: 2.5%,
  font-size: 20pt,
  body-font: "Source Sans 3",
  title-font: "Montserrat",
  math-font: "New Computer Modern Math",
  title-size: 1.8em,
  authors-size: 1.55em,
  institute-size: 1.25em,
  body,
) = {
  let t = _resolve-theme(theme)
  _theme.update(t)

  // ---- Page --------------------------------------------------------
  let page-args = if width != none and height != none {
    (width: width, height: height)
  } else {
    (paper: paper, flipped: flipped)
  }
  // ---- Footer ------------------------------------------------------
  let footer-height = if footer != none { 2.8 * font-size } else { 0pt }
  let footer-block = if footer != none {
    block(
      width: 100%,
      height: footer-height,
      fill: t.footer-bg,
      inset: (x: 3%),
      {
        if t.footer-rule != none { place(top, block(width: 100%, height: 0.15em, fill: t.footer-rule)) }
        set text(fill: t.footer-fg, size: 0.9em)
        align(center + horizon)[#footer]
      },
    )
  } else { none }

  set page(
    ..page-args,
    margin: (top: 0pt, left: 0pt, right: 0pt, bottom: footer-height),
    fill: white,
    footer: footer-block,
    footer-descent: 0pt,
  )

  // ---- Typography --------------------------------------------------
  set text(font: body-font, size: font-size, fill: t.text, lang: "en")
  show math.equation: set text(font: math-font)
  set par(leading: 0.65em, spacing: 1em, justify: true)
  // Gemini-style square marker (drawn, so no font fallback is needed)
  set list(marker: box(width: 0.42em, height: 0.42em, fill: t.primary, baseline: -0.12em), indent: 0.4em, body-indent: 0.6em, spacing: 0.7em)
  set enum(indent: 0.4em, body-indent: 0.6em)
  show link: set text(fill: t.primary)
  show strong: set text(weight: "bold")

  // Headings inside blocks (optional use of `= Heading`)
  show heading: it => {
    set text(font: title-font, weight: "bold", size: 1.1em)
    block(above: 1em, below: 0.6em, it.body)
  }

  // ---- Header ------------------------------------------------------
  let header = block(
    width: 100%,
    fill: t.header-bg,
    inset: (x: 3%, y: 1.6em),
    {
      let side = if logo-left != none or logo-right != none { logo-width } else { 0pt }
      grid(
        columns: (side, 1fr, side),
        column-gutter: if side == 0pt { 0pt } else { 2em },
        align: (left + horizon, center + horizon, right + horizon),
        if logo-left != none { logo-left } else { none },
        {
          set text(fill: t.header-fg, hyphenate: false)
          set par(justify: false, leading: 0.5em)
          text(font: title-font, weight: 900, size: title-size)[#title]
          if authors != none {
            v(0.6em)
            text(weight: "bold", size: authors-size)[#authors]
          }
          if institute != none {
            v(0.5em)
            text(size: institute-size, fill: if t.header-bg == white { t.muted } else { t.header-fg })[#institute]
          }
        },
        if logo-right != none { logo-right } else { none },
      )
    },
  )

  // ---- Layout ------------------------------------------------------
  header
  if t.header-rule != none {
    block(width: 100%, height: 0.35em, fill: t.header-rule)
  }
  block(
    width: 100%,
    inset: (x: gutter, top: 0.4em, bottom: 0.5em),
    {
      show: std.columns.with(columns, gutter: gutter)
      body
    },
  )
}
