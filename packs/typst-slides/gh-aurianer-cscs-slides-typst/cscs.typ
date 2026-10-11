// CSCS Typst presentation template
// © ETH Zürich, 2026.

#let images = "images"

#let cscs-red    = rgb(172, 27, 38)
#let cscs-grey   = rgb(64, 64, 64)
#let cscs-green  = rgb(114, 121, 28)
#let cscs-blue   = rgb(0, 122, 150)
#let cscs-brown  = rgb(151, 72, 6)
#let cscs-purple = rgb(128, 0, 128)
#let cscs-yellow = rgb(167, 135, 32)
#let cscs-black  = rgb(0, 0, 0)
#let cscs-white  = rgb(255, 255, 255)

// Beamer 4:3 default page size
#let slide-width  = 12.8cm
#let slide-height = 9.6cm

// Per-slide state for footer numbering
#let footer-text = state("footer-text", "Insert_Footer")
#let plain-frame = state("plain-frame", false)

// ---------------------------------------------------------------------------
// Top header row used by title / chapter / thank-you slides.
#let cscs-header() = {
  place(top + left, dx: 4mm, dy: 4mm,
    image(images + "/image4.pdf", height: 6mm))
  place(top + right, dx: -6mm, dy: 5mm,
    image(images + "/image1.pdf", height: 3mm))
}

// Footer used by ordinary content slides.
#let cscs-footer(page-num) = {
  place(bottom + left, dx: 4mm, dy: -3mm,
    image(images + "/image2.pdf", height: 4mm))
  place(bottom + center, dy: -4.5mm,
    text(size: 4.5pt, fill: gray)[
      #footer-text.get() #h(2pt) #text(fill: black)[|] #h(2pt) #page-num
    ])
  place(bottom + right, dx: -6mm, dy: -4mm,
    image(images + "/image1.pdf", height: 2.2mm))
}

// ---------------------------------------------------------------------------
// Document setup. Call this once at the top of the slides file.
#let cscs-presentation(
  title: "Presentation Title",
  subtitle: "Event",
  author: "Author, CSCS",
  date: datetime.today().display("[month repr:long] [day padding:none], [year]"),
  footer: "Insert_Footer",
  body,
) = {
  set document(title: title, author: author)
  set page(
    width: slide-width,
    height: slide-height,
    margin: (left: 8mm, right: 8mm, top: 7mm, bottom: 10mm),
    background: context {
      // Ordinary slides: footer with page number; plain frames omit it.
      if not plain-frame.get() {
        cscs-footer(counter(page).get().first())
      }
    },
  )
  // Closest free Helvetica clone first; falls back to other Helvetica-metric fonts.
  set text(font: ("TeX Gyre Heros", "Nimbus Sans", "Liberation Sans"),
           size: 9pt)
  set par(leading: 0.55em)

  footer-text.update(footer)

  // Stash the title metadata so the title slide can render it.
  metadata((title: title, subtitle: subtitle, author: author, date: date))

  body
}

// ---------------------------------------------------------------------------
// Frame title for ordinary slides.
#let frametitle(title) = {
  // Shrink the title to fit one line if it would otherwise overflow the
  // content width. `measure` reports the natural (unbroken) width; `layout`
  // gives the available width after page margins. Short titles are untouched.
  layout(size => {
    let make = sz => text(weight: "bold", size: sz, fill: cscs-grey, title)
    let base = make(14pt)
    let w = measure(base).width
    if w > size.width {
      make(14pt * size.width / w)
    } else {
      base
    }
  })
  v(1mm)
}

// Helper: render a content slide (title + body) constrained to a single page.
// Beamer's behaviour is one frame == one page, so this enforces that.
#let cscs-slide(title: none, body) = {
  pagebreak(weak: true)
  if title != none {
    frametitle(title)
    // Tracked for the auto-generated outline; invisible on the page.
    place(hide(heading(level: 2, outlined: true, bookmarked: false, title)))
  }
  body
}

// ---------------------------------------------------------------------------
// Title slide: hero image, red rule, title block.
#let cscs-title(picture: images + "/alps_smaller.jpg",
                title: "Presentation Title",
                subtitle: "Event",
                author: "Author, CSCS",
                date: none) = {
  plain-frame.update(true)
  page(margin: 0pt)[
    #cscs-header()
    #place(top + left, dy: 13mm,
      image(picture, width: slide-width, height: 32mm))
    #place(top + left, dy: 45mm,
      rect(width: slide-width, height: 0.4mm, fill: cscs-red, stroke: none))
    #place(top + left, dx: 6mm, dy: 55mm,
      text(weight: "bold", size: 15pt, fill: cscs-grey, title))
    #place(top + left, dx: 6mm, dy: 63mm,
      text(size: 9pt, fill: gray)[
        #subtitle \
        #author \
        #if date != none { date }
      ])
  ]
  plain-frame.update(false)
}

// Chapter divider slide.
#let cscs-chapter(title) = {
  plain-frame.update(true)
  page(margin: 0pt)[
    #cscs-header()
    #place(top + left, dx: 6mm, dy: 47mm,
      text(weight: "bold", size: 17pt, fill: cscs-grey, title))
    #place(top + left, dy: 55mm,
      rect(width: slide-width, height: 0.4mm, fill: cscs-red, stroke: none))
    // Tracked for the auto-generated outline; invisible on the page.
    #place(hide(heading(level: 1, outlined: true, bookmarked: false, title)))
  ]
  plain-frame.update(false)
}

// Thank-you slide (mirrors \cscsthankyou).
#let cscs-thankyou(message: "Thank you for your attention.",
                   picture: images + "/image7.pdf") = {
  plain-frame.update(true)
  page(margin: 0pt)[
    #cscs-header()
    #place(top + left, dy: 13mm,
      image(picture, width: slide-width, height: 32mm))
    #place(top + left, dy: 45mm,
      rect(width: slide-width, height: 0.4mm, fill: cscs-red, stroke: none))
    #place(top + left, dx: 6mm, dy: 55mm,
      text(weight: "bold", size: 15pt, fill: cscs-grey, message))
  ]
  plain-frame.update(false)
}

// Auto-fit content to a target height by shrinking the text size in 0.5pt
// steps. Uses Typst's measure() to predict layout, so it converges in a
// single pass without rendering the body multiple times on the page.
#let cscs-fit-to-height(content, target-height: 6cm, target-width: 5.3cm,
                       max-size: 9pt, min-size: 4.5pt) = context {
  let size = max-size
  while size > min-size {
    let h = measure(block(width: target-width,
                          text(size: size, content))).height
    if h <= target-height { break }
    size -= 0.5pt
  }
  text(size: size, content)
}

// Table-of-contents-like layout: image on the left, outline on the right.
// The body is auto-shrunk to fit the 6 cm column without overflowing.
#let cscs-toc(title: "Title", body) = {
  pagebreak(weak: true)
  frametitle(title)
  grid(
    columns: (1fr, 1fr),
    column-gutter: 6mm,
    align: (left + top, left + top),
    rows: slide-height * 0.625,
    image(images + "/image8.jpeg", height: slide-height * 0.625),
    pad(top: slide-height * 0.01,
        cscs-fit-to-height(body, target-height: slide-height * 0.615)),
  )
}

// ---------------------------------------------------------------------------
// Color blocks: matches the {color}{0,1,2}block environments from the .sty.
//   variant 0: empty title bar (white background, colored frame)
//   variant 1: title bar filled with the accent color, white text
//   variant 2: title bar tinted (50% accent + white), black text
#let cscs-block(color: cscs-blue, variant: 1, title: none, body) = {
  let title-bg = if variant == 0 { white }
                 else if variant == 1 { color }
                 else { color.mix((color, 50%), (white, 50%)) }
  let title-fg = if variant == 1 { white } else { black }
  block(width: 100%, breakable: false, stroke: 0.2mm + color, inset: 0pt)[
    #if title != none [
      #block(width: 100%, fill: title-bg,
             stroke: (bottom: 0.2mm + color),
             inset: (x: 4pt, y: 2pt))[
        #text(fill: title-fg, weight: "bold", size: 8pt, title)
      ]
    ]
    #block(width: 100%, inset: (x: 4pt, top: -4pt, bottom: 8pt), body)
  ]
}

// Convenience wrappers so call sites read like the .sty environments.
#let red0block(title, body)    = cscs-block(color: cscs-red,    variant: 0, title: title, body)
#let red1block(title, body)    = cscs-block(color: cscs-red,    variant: 1, title: title, body)
#let red2block(title, body)    = cscs-block(color: cscs-red,    variant: 2, title: title, body)
#let blue0block(title, body)   = cscs-block(color: cscs-blue,   variant: 0, title: title, body)
#let blue1block(title, body)   = cscs-block(color: cscs-blue,   variant: 1, title: title, body)
#let blue2block(title, body)   = cscs-block(color: cscs-blue,   variant: 2, title: title, body)
#let green0block(title, body)  = cscs-block(color: cscs-green,  variant: 0, title: title, body)
#let green1block(title, body)  = cscs-block(color: cscs-green,  variant: 1, title: title, body)
#let green2block(title, body)  = cscs-block(color: cscs-green,  variant: 2, title: title, body)
#let brown0block(title, body)  = cscs-block(color: cscs-brown,  variant: 0, title: title, body)
#let brown1block(title, body)  = cscs-block(color: cscs-brown,  variant: 1, title: title, body)
#let brown2block(title, body)  = cscs-block(color: cscs-brown,  variant: 2, title: title, body)
#let purple0block(title, body) = cscs-block(color: cscs-purple, variant: 0, title: title, body)
#let purple1block(title, body) = cscs-block(color: cscs-purple, variant: 1, title: title, body)
#let purple2block(title, body) = cscs-block(color: cscs-purple, variant: 2, title: title, body)
#let yellow0block(title, body) = cscs-block(color: cscs-yellow, variant: 0, title: title, body)
#let yellow1block(title, body) = cscs-block(color: cscs-yellow, variant: 1, title: title, body)
#let yellow2block(title, body) = cscs-block(color: cscs-yellow, variant: 2, title: title, body)
#let black0block(title, body)  = cscs-block(color: black,       variant: 0, title: title, body)
#let black1block(title, body)  = cscs-block(color: black,       variant: 1, title: title, body)
#let black2block(title, body)  = cscs-block(color: black,       variant: 2, title: title, body)

// ---------------------------------------------------------------------------
// CSCS-style itemize markers: red square / grey dash / black dot.
// Each nested level shrinks to 0.9× its parent, so subsections are smaller.
//
// `baseline: -0.5pt` lowers the marker so the square sits on the text
// x-height instead of riding above the cap height.
#let cscs-list(body) = {
  // Same red square marker at every nesting level (sub-lists included).
  set list(spacing: 1.5em,
    marker: box(inset: (top: 0.7mm), box(width: 1mm, height: 1mm, fill: cscs-red)))
  show list: set text(size: 0.9em)
  body
}

// CSCS-style enumerate (1. / 1.1 / 1.1.1) in cscs-grey.
// Each nested level shrinks to 0.9× its parent.
#let cscs-enum(body) = {
  set enum(numbering: (..n) => text(fill: cscs-grey, n.pos().map(str).join(".") + "."),
           full: true)
  show enum: set text(size: 0.9em)
  body
}

// ---------------------------------------------------------------------------
// Map a human-readable language label to the identifier syntect expects.
#let _lang-map = (
  "C/C++":   "cpp",
  "C++":     "cpp",
  "C":       "c",
  "Fortran": "fortran",
  "Python":  "python",
  "Bash":    "bash",
  "Rust":    "rust",
)

// Code listing block: a title bar + a tinted background wrapping a `raw`
// block. Syntax highlighting comes from Typst's built-in syntect scheme.
#let cscs-listing(language: "C/C++", title: "", code) = {
  let lang-id = _lang-map.at(language, default: lower(language))
  block(width: 100%, breakable: false, spacing: 0pt)[
    // Title bar — like a column header. spacing:0 sticks it to the code body.
    #block(width: 100%,
           fill: cscs-white.mix((cscs-black, 12%)),
           inset: (x: 4pt, y: 2pt),
           spacing: 0pt, above: 0pt, below: 0pt)[
      #text(font: ("Latin Modern Mono", "DejaVu Sans Mono"), size: 6pt, fill: black, weight: "bold")[
        #language : #title
      ]
    ]
    // Code body — light grey background; default Typst highlighting on top.
    #block(width: 100%,
           fill: rgb("#f5f5f5"),
           inset: (x: 4pt, y: 3pt),
           spacing: 0pt, above: 0pt, below: 0pt)[
      #set text(font: ("Latin Modern Mono", "DejaVu Sans Mono"), size: 7pt)
      #set par(leading: 0.45em)
      #raw(code, lang: lang-id)
    ]
  ]
}

// Inline code (one of the lstinline* variants). Accepts a language so
// Typst's built-in syntax highlighter can color the snippet.
#let cscs-inline-code(code, language: "C/C++") = {
  let lang-id = _lang-map.at(language, default: lower(language))
  box(fill: rgb("#f5f5f5"), inset: (x: 2pt, y: 0.5pt),
    text(font: ("Latin Modern Mono", "DejaVu Sans Mono"), size: 7pt, raw(code, lang: lang-id)))
}

// ---------------------------------------------------------------------------
// References frame: print a numbered list of bib entries (manual, since
// Typst's native bibliography uses a separate flow).
#let cscs-references(title: "References", entries) = {
  frametitle[#title #text(fill: cscs-blue)[I]]
  for (i, e) in entries.enumerate() [
    [#(i + 1)] #h(4mm) #emph(e.title). #text(fill: cscs-blue, e.url). \
  ]
}
