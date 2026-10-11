// sentence number substitution marker
#let s = "XXXXXXSENTENCEXXXNUMBERXXXXXX"

// hex-Code for official DLRG-Jugend Farbe
#let jugendBlau = rgb("#013157")

/// Create an unmarkes section, such as a preamble.
/// Usage: `#unnumbered[Preamble]`
#let unnumbered = (it, ..rest) => context (
  {
    // Determine the current heading level to create a heading one level below.
    // Previous heading element
    let h-elem = selector(heading).before(here())

    // Current heading level
    let c = counter(h-elem).get()

    // Depth to use for the new heading
    let depth = if c == none {
      // Unlikely case: No counter found at all
      1
    } else if c.at(0) == 0 {
      // We're before the first sectional level, so use level 1
      1
    } else {
      // Use the current depth + 1 to be one level below the current depth
      c.len() + 1
    }

    // Actually show the heading
    show heading: set text(style: "normal", weight: "bold")
    heading(level: depth, numbering: none, ..rest, it)
    v(5pt)
  }
)


/// Manually create a section. Useful when unsupported characters are used in the heading.
/// Usage: `#section[§ 3][Administrator*innen]`
#let section = (number, it, ..rest) => unnumbered(
  {
    number + " " + it
  },
  ..rest,
)

/// Initialize document.
#let template = (
  title: none,
  title-short: none,
  abbreviation: none,
  draft: false,
  logo: none,
  vereinsname: none,
  straßeHausnummer: none,
  plzOrt: none,
  email: none,
  // Overrides
  size: 12pt,
  heading-size: 18pt,
  font: "Mulish",
  heading-font: "Josefin Sans",
  lang: "de",
  paper: "a4",
  // Content
  body,
) => {
  /// Metadata
  let full-title = if title-short != none {
    title + " (" + title-short + ")"
  } else {
    title
  }
  set document(
    title: full-title,
    keywords: (title, title-short).filter(it => it != none),
    description: full-title,
  )


  set page(
    paper: "a4",
    margin: (top: 4cm, bottom: 3cm, x: 1.6cm),
    header: [
      #grid(
        columns: auto,
        gutter: 10pt,
        [#grid(
          columns: (auto, auto, auto),
          rows: 1.8cm,
          align: horizon,
          grid.cell(
            box(image(logo, alt: "DLRG Jugend Logo")),
          ),
          grid.cell(
            h(1fr),
          ),
          grid.cell(
            box(text(title-short, fill: jugendBlau, size: 18pt)),
          ),
        )],
        [#line(length: 100%, stroke: 3pt + jugendBlau)],
      )


    ],
    footer: context [
      #place(top + right, text(fill: jugendBlau, counter(page).display("1")))
      #grid(
        columns: auto,
        gutter: 10pt,
        [#image("resources/welle-outline-saphir.svg", width: 100%)],
        [#text(
          fill: jugendBlau,
          size: 12pt,
          vereinsname + " | " + straßeHausnummer + " | " + plzOrt + " | " + email,
        )],
      )


    ],
  )
  set text(hyphenate: true, lang: lang, size: size, font: font)

  /// Clause Detection
  show regex("§ ([0-9a-zA-Z]+) (.+)$"): it => {
    let (_, number, ..rest) = it.text.split()

    section("§ " + number, rest.join(" "))
  }

  /// Heading Formatting
  set heading(numbering: "I.")
  show heading: set align(left)
  show heading: set text(fill: jugendBlau, font: heading-font, weight: "bold")

  show heading.where(level: 1): set text(size: heading-size)
  show heading.where(level: 2): set text(size: size)

  // Enumeration numbering
  // 1. -> a) -> aa) -(unofficial)-> (1) -> i. -> i.i. -> ...
  // Handbuch der Rechtsförmlichkeit, Rn. 374
  set enum(
    numbering: (..numbers) => {
      let nums = numbers.pos()
      if (nums.len() == 1) {
        return numbering("(1)", ..nums)
      } else if (nums.len() == 2) {
        return numbering("a)", ..nums.slice(1))
      } else if (nums.len() == 3) {
        let letter = numbering("a", ..nums.slice(2))
        return [ #letter#letter) ]
      } else if (nums.len() == 4) {
        return numbering("(1)", ..nums.slice(3))
      } else {
        return numbering("i.", ..nums.slice(4))
      }
    },
    full: true, // get full number arrays passed into the numbering function
  )

  /// Outlines
  show outline.entry: it => {
    show linebreak: it => {} // disable manual line breaks
    show "\n": " " // disable section number line breaks
    it
  }

  set outline(indent: 1cm)
  show outline: it => {
    it
    pagebreak(weak: true)
  }

  /// Sentence Numbering
  show regex(s): it => {
    counter("sentence").step()
    super(strong(context (counter("sentence").display())))
  }

  show parbreak: it => {
    counter("sentence").update(0)
    it
  }

  //title
  align(center, par(text(font: heading-font, 20pt, fill: jugendBlau, strong(title)), leading: 0.6em))


  // allow footnotes that don't conflict with sentence numbers
  set footnote(numbering: "[1]")

  /// Content
  body
}
