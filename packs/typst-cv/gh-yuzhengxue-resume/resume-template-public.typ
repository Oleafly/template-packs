// A clean, text-first Typst resume template for A4 PDF output.
// Edit resume-public.typ for content; edit this file for typography and spacing.

// The template uses black by default for a formal academic/professional look.
#let accent = black
#let muted = black
#let hairline = black

// Global document wrapper. The main file must include `#show: resume`.
#let resume(body) = [
  // Page setup.
  #set page(
    // A4 paper is suitable for PDF applications and printing.
    paper: "a4",
    // Narrow margins help dense resumes fit on one page.
    margin: (top: 0.6cm, bottom: 0.5cm, left: 1cm, right: 1cm),
  )

  // Global font setup.
  #set text(
    // English/numbers use Times New Roman first; Chinese falls back to KaiTi.
    // Change "KaiTi" to "SimSun", "Microsoft YaHei", or another installed CJK font if needed.
    font: ("Times New Roman", "KaiTi"),
    // Adjust this to fit more or less content on one page.
    size: 8.5pt,
    // Chinese language settings improve CJK line breaking.
    lang: "zh",
    region: "cn",
  )

  // Paragraph rhythm.
  #set par(
    // Larger values create looser line spacing; smaller values make the resume denser.
    leading: 0.5em,
    // Extra spacing between paragraphs.
    spacing: 4pt,
    // Justified text keeps long paragraphs visually tidy.
    justify: true,
  )

  // Bullet list spacing.
  #set list(
    // Overall bullet indentation.
    indent: 0.5em,
    // Hanging indent for wrapped bullet lines.
    body-indent: 0.5em,
    // Space between bullet items.
    spacing: 0.5em,
  )

  // Render the document body from the main file.
  #body
]

// Resume header: name and contact line.
#let resume-header(name, contacts) = [
  #align(center)[
    #text(size: 12pt, weight: "bold")[#name]
    #v(0.4em)
    #text(size: 8.5pt, fill: muted)[#contacts]
  ]
  #v(0.4em)
]

// Section title with a thin divider.
#let section(title) = [
  #v(0.4em)
  #text(size: 10pt, weight: "bold", fill: accent)[#title]
  #v(0.05em)
  #line(length: 100%, stroke: 0.32pt + hairline)
  #v(0.05em)
]

// Metadata line under each entry title.
#let meta-line(date, detail, role) = [
  #text(size: 8.5pt, fill: muted)[
    #date
    #if role != "" [，#role]
    #if detail != "" [，#detail]
  ]
]

// Full entry: title + metadata + bullet body.
#let cv-entry(date, title, detail, role, body) = [
  #block(above: 1em, below: 0.5em, breakable: true)[
    #text(size: 8.5pt, weight: "bold")[#title]
    #v(0.05em)
    #meta-line(date, detail, role)
    #v(0.05em)
    #body
  ]
]

// Compact entry: title + metadata only.
#let compact-entry(date, title, detail, role) = [
  #block(above: 1em, below: 0.5em, breakable: false)[
    #text(size: 8.5pt, weight: "bold")[#title]
    #v(0.05em)
    #meta-line(date, detail, role)
  ]
]

// Note line for awards, skills, and other short sections.
#let note-line(body) = [
  - #body
]
