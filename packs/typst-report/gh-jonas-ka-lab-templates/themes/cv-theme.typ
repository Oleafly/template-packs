// CV theme: the Karthein Lab style (STIX Two Text, brand maroon, the lab palette) for a
// US Letter document. Compile with `--pdf-standard ua-1`: every heading is a real heading,
// links carry text, the document has title and language.
#import "tokens.typ": ink, muted, band, brand, link-text

#let cv-doc(title: "", author: "", lang: "en", paper: "us-letter", body) = {
  set document(title: title, author: author)
  set page(paper: paper, margin: (x: 0.8in, top: 0.7in, bottom: 0.75in),
    footer: context [
      #set text(size: 8.5pt, fill: muted)
      #grid(columns: (1fr, auto), [#author · Curriculum Vitae], [#counter(page).display() / #counter(page).final().first()])
    ])
  set text(font: ("STIX Two Text", "Helvetica Neue"), size: 10pt, fill: ink, lang: lang)
  show math.equation: set text(font: "STIX Two Math")
  set par(leading: 0.5em, spacing: 0.5em, justify: false)
  set block(spacing: 0.5em)
  // Level 1: the name (not outlined) in its own look; sections in maroon capitals with a rule.
  show heading.where(level: 1): it => if not it.outlined {
    block(above: 0pt, below: 0.3em, text(size: 21pt, weight: "bold", fill: ink, it.body))
  } else {
    block(above: 1.25em, below: 0.6em, sticky: true, {
      text(size: 11.5pt, weight: "bold", fill: brand, tracking: 0.4pt, upper(it.body))
      v(-0.45em)
      line(length: 100%, stroke: 0.6pt + band.darken(25%))
    })
  }
  show heading.where(level: 2): it => block(above: 0.9em, below: 0.4em, sticky: true,
    text(size: 10.5pt, weight: "bold", fill: ink, it.body))
  show link: set text(fill: link-text)
  body
}

/// One dated line: a narrow date column, then the text.
#let dated(when, body) = grid(columns: (6.4em, 1fr), column-gutter: 0.8em,
  text(fill: muted, when), body)

/// A span of years as the Doc writes it: 2021 – 2024, 2025 – now, or a single year.
#let years(start, end) = if start == none { "" } else if end == none { str(start) + " – now" } else if end == start { str(start) } else { str(start) + " – " + str(end) }

/// Numbered list entry (publications, presentations): number in the margin, body beside it.
#let numbered(n, body) = grid(columns: (1.9em, 1fr), column-gutter: 0.6em,
  align(right, text(fill: muted, str(n) + ".")), body)

/// Numbered and dated (mentees): number, years, text in three aligned columns.
#let numbered-dated(n, when, body, date-width: 6.0em) = grid(columns: (1.9em, date-width, 1fr), column-gutter: 0.6em,
  align(right, text(fill: muted, str(n) + ".")), text(fill: muted, when), body)

/// A small tag after a reference (Editors' Suggestion, invited).
#let tag(body) = box(inset: (x: 4pt, y: 1.2pt), radius: 2pt, fill: brand.lighten(88%), baseline: 1.2pt,
  text(size: 8pt, weight: "bold", fill: brand, body))
