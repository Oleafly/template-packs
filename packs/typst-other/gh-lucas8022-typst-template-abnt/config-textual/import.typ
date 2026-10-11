#import "const.typ": *

/// The main function for easy typography setup.
///
/// - body-size (): The size of body text (default 10pt).
/// - fonts (): A dictionary specifying heading/body fonts.
/// - paper (str): The paper size to use (none to skip).
/// - margin (): Margin for the page (none to skip).
/// -> content
#let easy-typography(
  body-size: 12pt,
  fonts: (heading: "Libertinus Sans", body: "Libertinus Serif"),
  paper: none,
  margin: none,
  body
) = {
  // Optional page setup
  if paper != none {
    set page(paper: paper)
  }
  if margin != none {
    set page(margin: margin)
  }

  // Paragraphs
  set page()

  set par(
    first-line-indent: (amount: 1cm, all: true),
    // leading: line-spacing * 0.5em,
    // spacing: paragraph-spacing * 0.5em,
    justify: true,
    //linebreaks: "optimized",
  )
  
  // Body text
  set text(
    region: "BR"
,    lang: "pt",
    font: fonts.heading,
    fallback: false,
    style: "normal",
    weight: body-weight,
    stretch: 100%,
    size: body-size,
    tracking: 0pt,
    spacing: 100% + 0pt,
    baseline: 0pt,
    overhang: true,
    hyphenate: true,
    kerning: true,
    ligatures: true,
    // number-width: "proportional",
    // number-type: "lining", // commented: intentionally left up to the font to choose
  )

  show table: set text(number-width: "tabular")

  /// Top-heavy easing function for heading sizes/spacing.
  ///
  /// `sqrt(t)` gives biggest decrease at top, gentlest at bottom.
  ///
  /// - max (length): Biggest size (H1)
  /// - min (length): Smallest size (H5)
  /// - level (length): From 1 to 5
  /// -> length
  let compute-size(max, min, level) = {
    if level <= 1 {
      max
    } else if level >= 5 {
      min
    } else {
      let t = (level - 1) / 4
      max - (max - min) * calc.sqrt(t)
    }
  }

  // Heading weight logic
  let compute-weight(level) = {
    if level <= 1 {
      "bold"
    } else if level == 2 {
      "regular"
    } else if level == 3 {
      return "regular"
    } else {
      "regular"
    }
  }

  let compute-style(level) = {
    if level <= 1 {
      "normal"
    } else if level == 2 {
      "normal"
    } else if level == 3 {
      "italic"
    } else if level == 4 {
      "normal"
    }
  }

  set heading(supplement: "Seção")

// Show headings using computed size/spacing values
  show heading: it => block(
    // fill: aqua,
    breakable: false,
    sticky: true,
    above: 0pt,
    below: 0pt,
    text(
      region: "BR",
      lang: "pt",
      font: fonts.heading,
      style: compute-style(it.level),
      size: 12pt,
      weight: compute-weight(it.level),
      it
    )
  )
  
  show heading.where(level: 1): set heading(numbering: "1.1.1.1      ")
  show heading.where(level: 1): it => block(it, above: 18pt, below: 18pt)
  show heading.where(level: 2): set heading(numbering: "1.1.1.1   ")
  show heading.where(level: 2): it => block(it, above: 12pt, below: 12pt)
  show heading.where(level: 3): set heading(numbering: "1.1.1.1")
  show heading.where(level: 3): it => block(it, above: 12pt, below: 12pt)
  show heading.where(level: 4): underline

// OUTLINE CONFIG -+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
  
let gap(it, style: none) = {
  link(
    it.element.location(),
    it.indented(style(it.prefix()), style(it.body()) + box(width: 1fr, it.fill) + it.page()),
  )
}

show outline.entry.where(level: 1): it => gap(it, style: strong)
show outline.entry.where(level: 2): it => gap(it, style: text)
show outline.entry.where(level: 3): it => gap(it, style: emph)
show outline.entry.where(level: 4): it => gap(it, style: text)

  // Finally, render the body
  body
}
