#import "colors.typ": tum-colors
#import "formats.typ": poster-format

// With the default text edges, Typst's `par.leading` is the gap between one
// line's baseline and the next line's cap height. The LaTeX templates give
// baseline-to-baseline distances instead. Helvetica, Arial and Nimbus Sans
// all have a cap height of about 0.72em, so that is used to convert.
#let _cap-height = 0.72

// Converts a LaTeX baseline skip into a Typst `par.leading`.
#let _leading(size, baseline) = baseline - _cap-height * size

// Vertical space that puts the next baseline `gap` below the previous one,
// assuming the default text edges (cap height on top, baseline at the bottom).
#let _gap(gap, next-size) = gap - _cap-height * next-size

#let _format = state("tum-poster-format", none)

#let _university-names = (
  de: "Technische Universität München",
  en: "Technical University of Munich",
)

#let _header-styles = ("full", "university")
#let _logo-variants = ("blue", "black", "white")

/// Sets text in the size of the main title, as the official templates suggest
/// for posters with little text.
///
/// Only works inside a document styled with `poster`.
///
/// -> content
#let large(body) = context {
  let format = _format.get()
  assert(format != none, message: "tum-poster: `large` can only be used inside `poster`.")
  let (size, leading) = format.titles.first()
  set text(size: size)
  set par(leading: _leading(size, leading), spacing: _gap(2 * leading, size))
  body
}

#let _header(format, style, lines) = {
  let (size, leading) = format.header
  set text(size: size, fill: tum-colors.primary-blue)
  set par(leading: _leading(size, leading))
  let lines = if style == "university" { lines.slice(-1) } else { lines }
  lines.filter(it => it != none).join(linebreak())
}

#let _footer(format, footer, university, faculty, chair) = {
  let (size, leading, columns) = format.footer
  set text(size: size)
  set par(leading: _leading(size, leading), spacing: _gap(2 * leading, size))

  if footer == "sender" {
    (strong(university), faculty, chair).filter(it => it != none).join(linebreak())
  } else if type(footer) == array {
    assert(
      footer.len() <= columns,
      message: "tum-poster: the footer of this format has room for "
        + str(columns) + " columns, got " + str(footer.len()) + ".",
    )
    grid(
      columns: (1fr,) * columns,
      column-gutter: format.gutter,
      align: top,
      ..footer,
    )
  } else {
    footer
  }
}

#let _titles(format, titles) = {
  let present = titles
    .zip(format.titles, range(titles.len()))
    .filter(((body, ..rest)) => body != none)
  if present.len() == 0 { return }

  let blocks = ()
  for (i, (body, style, level)) in present.enumerate() {
    if i > 0 {
      // Gaps are measured to the next title level, so a skipped middle title
      // uses the gap of the level above it.
      let previous-level = present.at(i - 1).at(2)
      blocks.push(v(_gap(format.title-gaps.at(previous-level), style.size)))
    }
    blocks.push({
      set text(size: style.size)
      set par(leading: _leading(style.size, style.leading))
      body
    })
  }

  place(
    top,
    scope: "parent",
    float: true,
    clearance: _gap(format.body-gap, format.body.size),
    block(width: 100%, {
      set par(spacing: 0pt)
      blocks.join()
    }),
  )
}

/// Styles a document as a poster following the TUM corporate design.
///
/// Use it as a show rule at the top of the document:
/// ```typ
/// #show: poster.with(size: "a0", title: [My research])
/// ```
///
/// - size (str): One of the sizes TUM provides a template for: `"a0"`,
///   `"a1"`, `"a2"`, `"a3"` or `"a4"`. Case-insensitive.
/// - orientation (str): `"portrait"` or `"landscape"`.
/// - title (content, none): First-level title, spans the full page width.
/// - subtitle (content, none): Second-level title.
/// - tagline (content, none): Third-level title.
/// - author (str, array): Author(s), only used for the PDF metadata.
/// - university (auto, content): Defaults to the university name in `lang`.
/// - faculty (content, none): Faculty or school shown in header and footer.
/// - chair (content, none): Chair or group shown in header and footer.
/// - header (str, none): `"full"` shows chair, faculty and university above
///   each other, `"university"` only the university, `none` only the logo.
/// - footer (none, str, content, array): `"sender"` prints university,
///   faculty and chair; an array fills the footer column grid of the format;
///   any other content is placed as-is.
/// - logo (auto, str, none, content): `auto` or `"blue"` uses the blue TUM
///   logo, `"black"` and `"white"` the monochrome variants. Content replaces
///   the logo and is aligned to the top right margin corner.
/// - columns (auto, int): Number of body columns. `auto` uses a default
///   per format.
/// - font (str, array): Font family. Helvetica like the LaTeX templates,
///   Arial if Helvetica is not installed.
/// - lang (str): Text language, `"de"` or `"en"` pick the university name.
/// -> content
#let poster(
  size: "a0",
  orientation: "portrait",
  title: none,
  subtitle: none,
  tagline: none,
  author: (),
  university: auto,
  faculty: none,
  chair: none,
  header: "full",
  footer: none,
  logo: auto,
  columns: auto,
  font: ("Helvetica", "Arial"),
  lang: "de",
  body,
) = {
  let format = poster-format(size, orientation)

  assert(
    header == none or header in _header-styles,
    message: "tum-poster: `header` must be none or one of "
      + _header-styles.map(repr).join(", ") + ", got " + repr(header) + ".",
  )
  assert(
    columns == auto or (type(columns) == int and columns >= 1),
    message: "tum-poster: `columns` must be auto or a positive integer, got " + repr(columns) + ".",
  )

  let university = if university == auto {
    _university-names.at(lang, default: _university-names.en)
  } else { university }
  let logo = if logo == auto { "blue" } else { logo }
  if type(logo) == str {
    assert(
      logo in _logo-variants,
      message: "tum-poster: unknown logo variant " + repr(logo) + ", expected one of "
        + _logo-variants.map(repr).join(", ") + ".",
    )
    logo = image("assets/tum-logo-" + logo + ".svg", width: format.logo-width)
  }
  let columns = if columns == auto { format.columns } else { columns }

  let m = format.margin
  let (size: body-size, leading: body-leading) = format.body
  let par-leading = _leading(body-size, body-leading)
  // The LaTeX templates separate paragraphs by one empty line.
  let par-spacing = _gap(2 * body-leading, body-size)

  set document(
    title: if type(title) in (str, content) { title },
    author: author,
  )

  set std.columns(gutter: format.gutter)
  set page(
    paper: format.paper,
    flipped: orientation == "landscape",
    margin: (x: m, top: 3 * m, bottom: format.bottom),
    columns: columns,
    background: {
      if logo != none {
        place(top + right, dx: -m, dy: m, logo)
      }
      if header != none {
        place(top + left, dx: m, box(
          width: 100% - 2 * m,
          height: 2 * m,
          align(bottom, _header(format, header, (chair, faculty, university))),
        ))
      }
      if footer != none {
        place(bottom + left, dx: m, dy: -m, block(
          width: 100% - 2 * m,
          _footer(format, footer, university, faculty, chair),
        ))
      }
    },
  )

  set text(font: font, size: body-size, lang: lang)
  set par(justify: false, leading: par-leading, spacing: par-spacing)

  show heading: set text(size: body-size, weight: "bold")
  show heading: set block(above: par-spacing, below: par-leading)

  set list(
    indent: 0pt,
    body-indent: 0pt,
    spacing: par-spacing,
    // List markers are end-aligned by default, so a fixed-width box with
    // left-aligned content is needed to keep the bullet on the column edge
    // and the item text at the indent the LaTeX templates use. The en dash is
    // about 0.56em wide and would touch the text at the 0.6em indent of A0,
    // so the second level gets a wider box.
    marker: (
      box(width: format.list-indent, align(left, [•])),
      box(width: 1em, align(left, [–])),
    ),
  )
  set enum(spacing: par-spacing)

  set figure(numbering: none, gap: format.caption.leading / 2)
  show figure: set block(spacing: par-spacing)
  show figure.caption: set align(left)
  show figure.caption: set text(size: format.caption.size)
  show figure.caption: set par(leading: _leading(format.caption.size, format.caption.leading))

  _format.update(format)
  _titles(format, (title, subtitle, tagline))
  body
}
