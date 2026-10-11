// Define global WUR colors for reuse
#let warm-bg = rgb("#FAF9F6")
#let wur-green = rgb("#02a73e")
#let wur-blue = rgb("#054972")
#let text-box-bg = rgb("#FAF9F6E6")
#let guide-gray = rgb("#9E9E9E")

// Guideline hint block — renders in grey italic for the writer
#let guide(body) = {
  set text(fill: guide-gray, style: "italic", size: 10pt)
  block(
    inset: (left: 0.8em, top: 0.4em, bottom: 0.4em),
    stroke: (left: 2pt + guide-gray.lighten(40%)),
    body,
  )
}

// Inline guide for short notes within prose
#let guide-inline(body) = {
  text(fill: guide-gray, style: "italic", size: 10pt, body)
}

// ----------------------------------------------------------------------
// 1. MAIN THESIS TEMPLATE
// ----------------------------------------------------------------------
#let wur-thesis(
  title: "",
  subtitle: "",
  author: "",
  degree: "",
  date: "",
  cover-image: none,
  cover-style: "full",
  paper-texture: none,
  chapter-pagebreaks: true,
  body,
) = {
  set document(author: author, title: title)
  
  let texture-wash = rgb("#faf9f6e7")

  // Global page setup
  set page(
    paper: "a4",
    fill: warm-bg, 
    background: if paper-texture != none [
      #place(top + left, image(paper-texture, width: 100%, height: 100%, fit: "cover"))
      #place(top + left, rect(width: 100%, height: 100%, fill: texture-wash, stroke: none))
    ],
    margin: (inside: 3cm, outside: 2cm, top: 2.5cm, bottom: 2.5cm),
    numbering: "1",
  )

  // Typography basics — Libertinus Serif
  set text(font: "Libertinus Serif", size: 11pt, lang: "en")
  set par(justify: true, leading: 0.65em)
  set heading(numbering: "1.1")

  // Heading styling & pagebreak logic
  show heading.where(level: 1): it => {
    if chapter-pagebreaks { pagebreak(weak: true) }
    set text(fill: wur-green)
    v(1em)
    it
    v(0.5em)
  }
  
  show heading.where(level: 2): set text(fill: wur-blue)
  show heading.where(level: 3): set text(fill: wur-blue.lighten(20%))

  // Title Page
  let cover-bg = none
  let title-margin = auto
  
  if cover-image != none {
    if cover-style == "full" {
      cover-bg = image(cover-image, width: 100%, height: 100%, fit: "cover")
    } else if cover-style == "banner" {
      cover-bg = place(top, image(cover-image, width: 100%, height: 35%, fit: "cover"))
      title-margin = (top: 25%) 
    }
  }

  page(
    background: cover-bg,
    margin: title-margin,
    align(center + horizon)[
      #block(
        fill: text-box-bg, 
        inset: 3em,
        radius: 0.5em,
        [
          #text(3em, weight: 900, smallcaps(title)) \
          #v(1em)
          #text(1.5em, subtitle) \
          #v(3em)
          #text(1.3em)[*#author*] \
          #v(1.5em)
          #text(1.1em)[#degree] \
          #v(0.5em)
          #text(1.1em)[Wageningen University & Research] \
          #v(0.5em)
          #text(1.1em)[Agricultural Biosystems Engineering] \
          #v(2em)
          #text(1.1em)[#date]
        ]
      )
    ]
  )

  // Frontmatter setup
  set page(numbering: "i")
  counter(page).update(1)
  
  body
}

// ----------------------------------------------------------------------
// 2. STYLIZED PAGE FUNCTION (Acknowledgements, etc.)
// ----------------------------------------------------------------------
#let stylized-page(title: "", body) = {
  page(
    align(center + horizon)[
      #block(
        fill: text-box-bg, 
        inset: 3em,
        radius: 0.5em,
        [
          #text(3em, weight: 900, smallcaps(title)) \
          #v(2em)
          #text(1.2em, align(left, body))
        ]
      )
    ]
  )
}
