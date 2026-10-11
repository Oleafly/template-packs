// Theme entry point: wires tokens and slide functions into Touying.

#import "@preview/touying:0.7.4": *
#import "tokens.typ": *
#import "slides.typ": new-section-slide, slide
#import "components.typ": accent-state
#import "figures.typ": fit-figure

// Typst's predefined text operators, which stay in the math font.
#let _math-operators = (
  "arccos", "arcsin", "arctan", "arg", "cos", "cosh", "cot", "coth", "csc",
  "csch", "ctg", "deg", "det", "dim", "exp", "gcd", "lcm", "hom", "id", "im",
  "inf", "ker", "lg", "lim", "liminf", "limsup", "ln", "log", "max", "min",
  "mod", "Pr", "sec", "sech", "sin", "sinc", "sinh", "sup", "tan", "tanh",
  "tg", "tr",
)

// A cell such as `0.412`, `(0.087)`, `48,210`, `−1.0`, `0.41***` or `12%`.
#let _numeric-cell = regex("^[-−+±()\[\]\d.,*%\s]*\d[-−+±()\[\]\d.,*%\s]*$")

// The text of simple content, or `none` if it holds anything but text.
#let _plain-text(body) = {
  if body.has("text") {
    body.text
  } else if body.has("children") {
    let parts = body.children.map(_plain-text)
    if none in parts { none } else { parts.join("") }
  } else if body == [ ] {
    " "
  } else {
    none
  }
}

#let _resolve-accent(accent) = {
  if type(accent) == color {
    accent
  } else {
    assert(
      accent in accents,
      message: "Unknown accent " + repr(accent) + ". Use a color or one of: " + accents.keys().join(", "),
    )
    accents.at(accent)
  }
}

/// Minimal academic theme.
///
/// ```typst
/// #show: brownbag-theme.with(
///   accent: "blue",
///   config-info(title: [..], author: [..]),
/// )
/// ```
///
/// - accent (str, color): The deck's single accent. A preset name
///   ("blue", "green", "burgundy", "purple", "orange", "mono") or any color.
/// - aspect-ratio (str): "16-9" or "4-3".
/// - footer (auto, none, content, function): Left side of the footer. `auto`
///   shows the short title, `none` leaves only the slide counter.
/// - text-size (length): Body text size, 20pt by default. Tables, captions,
///   labels and notes scale with it; slide titles and the footer do not. For
///   one dense slide, scope it: `#[ #set text(size: 17pt) .. ]`. A bare
///   `#set text` is not confined to its slide and shrinks all that follow.
/// - ..args: Touying `config-*` dictionaries, applied after the theme's own.
#let brownbag-theme(
  accent: "blue",
  aspect-ratio: "16-9",
  footer: auto,
  text-size: size.body,
  ..args,
  body,
) = {
  show: touying-slides.with(
    config-page(
      ..utils.page-args-from-aspect-ratio(aspect-ratio),
      margin: (x: space.page-x, top: space.page-top, bottom: space.page-bottom),
      header-ascent: space.title-gap,
      footer-descent: space.footer-gap,
      fill: paper,
    ),
    config-common(
      slide-fn: slide,
      new-section-slide-fn: new-section-slide,
      slide-level: 2,
      // An overfull slide stays on one page and raises a compile warning,
      // rather than silently spilling onto extra pages during a talk.
      breakable: false,
      // `*strong*` is weight only; the accent is opt-in through `#alert`.
      show-strong-with-alert: false,
      datetime-format: "[month repr:long] [day padding:none], [year]",
      zero-margin-header: false,
      zero-margin-footer: false,
    ),
    config-colors(
      primary: _resolve-accent(accent),
      neutral-lightest: paper,
      neutral-light: rule,
      neutral-dark: ink-muted,
      neutral-darkest: ink,
    ),
    config-methods(
      init: (self: none, body) => {
        set text(font: font-sans, size: text-size, fill: ink, number-type: "lining")
        set par(leading: 0.62em, spacing: 1.1em)
        // More than the leading, so that a new item is told apart from the
        // wrapped line of the previous one.
        let item-spacing = 0.95em

        show math.equation: set text(font: font-math, size: math-scale)
        show math.equation.where(block: true): set block(above: 1.3em, below: 1.3em)
        // An inline formula moves to the next line whole rather than breaking
        // at a relation sign.
        show math.equation.where(block: false): box

        // Words inside math ("direct effect", "if treated", a "val" subscript)
        // are set in the text font, as `\text{}` is in a sans-serif beamer
        // deck. Operator names stay in the math font.
        show math.equation: it => {
          show regex("\p{L}{2,}"): word => if word.text in _math-operators { word } else {
            text(font: font-sans, size: 1em / 1.1, word)
          }
          it
        }

        // Typst already sets raw text to 0.8em; 1.15em lands at ~0.92em.
        show raw: set text(font: font-mono, size: 1.15em)

        set list(
          marker: (text(fill: ink-subtle, [•]), text(fill: ink-subtle, [–])),
          indent: 0.2em,
          body-indent: 0.7em,
          spacing: item-spacing,
        )
        set enum(
          numbering: n => text(fill: ink-muted, weight: 500, str(n) + "."),
          indent: 0.2em,
          body-indent: 0.7em,
          spacing: item-spacing,
        )

        show link: set text(fill: self.colors.primary)
        set highlight(fill: marker, extent: 0.08em, top-edge: "ascender", bottom-edge: "descender")

        // Code blocks are the one filled container in the theme.
        show raw.where(block: true): it => block(
          width: 100%,
          fill: surface,
          radius: 4pt,
          inset: (x: 14pt, y: 12pt),
          text(size: 0.85em, it),
        )

        show quote.where(block: true): it => block(
          width: 100%,
          inset: (left: 16pt, y: 4pt),
          stroke: (left: 1.5pt + rule),
          {
            set text(fill: ink-muted)
            it.body
            if it.attribution != none {
              block(above: 0.8em, text(size: size.small, fill: ink-subtle, [— ] + it.attribution))
            }
          },
        )

        set footnote.entry(
          separator: line(length: 18%, stroke: 0.5pt + rule),
          gap: 0.5em,
          clearance: 0.8em,
          indent: 0pt,
        )
        show footnote.entry: set text(size: size.note, fill: ink-muted)

        // Figures: unnumbered, since a talk refers to "this figure".
        set figure(numbering: none, gap: 0.9em)
        show figure.caption: set text(size: size.note, fill: ink-muted)

        // Unsized images take the slide's remaining height; see figures.typ.
        show figure.where(kind: image): fit-figure

        // Tables, booktabs-style: heavy rules above and below, a light rule
        // under the first row, no vertical lines. For a multi-row header pass
        // `stroke: none` and place `table.hline()` by hand.
        set table(
          stroke: (_, y) => if y == 0 { (bottom: 0.5pt + ink-muted) },
          inset: (x: 11pt, y: 6pt),
          align: (x, _) => if x == 0 { left + horizon } else { center + horizon },
        )
        show table: set text(size: size.small)
        // Tabular figures so coefficients line up, but only in numeric cells:
        // Inter's `tnum` also widens hyphens, which disfigures text cells.
        // Such cells also get a true minus sign (R and Stata export a hyphen).
        // Significance stars are balanced by an invisible copy on the left, so
        // that `0.41***` stays centred over the `(0.09)` beneath it while the
        // stars still reserve their width.
        // The cell is rebuilt from its plain text, because each escaped `\*`
        // is a separate text node and could not be boxed as a group.
        show table.cell: it => {
          let plain = _plain-text(it.body)
          if plain == none or plain.match(_numeric-cell) == none { return it }
          //
          // A cell show rule that does not return `it` must re-apply the
          // cell's inset and alignment, as Typst's own cell rendering does.
          let parts = plain.trim().match(regex("^(.*?)\s*(\**)$")).captures
          let body = {
            set text(number-width: "tabular")
            hide(parts.at(1))
            parts.at(0).replace("-", "−")
            parts.at(1)
          }
          let inset = it.inset
          let padded = if type(inset) == dictionary {
            pad(..inset, body)
          } else {
            pad(inset, body)
          }
          if it.align == auto { padded } else { align(it.align, padded) }
        }
        // A table that declares its own top rule, `table.hline(y: 0)`, draws
        // its own frame: tables exported by R's tinytable/modelsummary do.
        show table: it => {
          let own-frame = it.children.any(c => (
            c.func() == table.hline and c.has("y") and c.y == 0
          ))
          if own-frame { it } else {
            box(stroke: (top: 1pt + ink, bottom: 1pt + ink), inset: (y: 2pt), it)
          }
        }

        // Roadmap: `#outline()` lists the sections, numbered like the section
        // slides, without leaders or page numbers. Backup sections are left
        // out. Placed inside a section, it highlights that section.
        set outline(title: none, depth: 1)
        show outline.entry: it => context {
          let target = it.element.location()
          let main-slides = utils.last-slide-counter.final().first()
          if utils.slide-counter.at(target).first() > main-slides { return }
          let sections = heading.where(level: 1)
          let index = query(sections.before(target)).len()
          let current = query(sections.before(here())).len()
          let dimmed = current > 0 and current != index
          block(above: 1em, below: 1em, link(target, grid(
            columns: (2.4em, 1fr),
            align: (left + horizon, left + horizon),
            text(
              font: font-mono,
              size: size.small,
              fill: if dimmed { ink-subtle } else { self.colors.primary },
              if index < 10 { "0" } + str(index),
            ),
            text(
              fill: if dimmed { ink-subtle } else { ink },
              weight: if current == index { 600 } else { 400 },
              it.element.body,
            ),
          )))
        }

        // Author-year citations, as in the economics journals.
        set cite(style: "chicago-author-date")
        set bibliography(style: "chicago-author-date", title: none)
        show bibliography: set text(size: size.small)
        show bibliography: set par(leading: 0.5em, spacing: 0.9em)

        accent-state.update(self.colors.primary)

        body
      },
      alert: utils.alert-with-primary-color,
    ),
    config-store(footer: footer),
    ..args,
  )

  body
}
