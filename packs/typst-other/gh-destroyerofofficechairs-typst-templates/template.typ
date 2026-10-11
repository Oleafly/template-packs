// --- Callout Boxes ---
// Reusable admonitions for the body. Usage: #pitfall[...], #note[...], #tip[...]
#let callout(kind, accent, bg, title: none, body) = block(
  fill: bg,
  stroke: (left: 3pt + accent),
  inset: (x: 12pt, y: 10pt),
  radius: 2pt,
  width: 100%,
  breakable: false,
  [
    #text(size: 9pt, weight: "bold", fill: accent)[#upper(if title != none { title } else { kind })]
    #v(-4pt)
    #body
  ]
)

#let warn(title: none, body) = callout("Warning", rgb("#b23b2e"), rgb("#f9e9e7"), title: title, body)
#let note(title: none, body) = callout("Note", rgb("#0b4c8c"), rgb("#e7f0f9"), title: title, body)
#let tip(title: none, body)  = callout("Tip", rgb("#2e7d32"), rgb("#e8f3e9"), title: title, body)

// --- Signature Block ---
// A formal closing for a signed letter. Usage:
//   #signature(name: "Jane Doe", title: "Director of Operations")
// For a jointly-signed letter, pass arrays and each signer gets their own
// line, laid out side by side:
//   #signature(name: ("Jane Doe", "John Smith"), title: ("CEO", "CTO"))
#let signature(
  closing: "Sincerely,",
  name: none,
  title: none,
  date: none,
  gap: 3em,
  line-width: 2.5in,
) = {
  // Accept either a single signer or an array of co-signers through the
  // same `name`/`title` parameters, so the common one-signer case stays simple.
  let names = if type(name) == array { name } else { (name,) }
  let titles = if type(title) == array { title } else { (title,) }

  v(2em)
  if closing != none and closing != "" [#closing]

  let sig-block(n, t) = [
    #v(gap)
    #line(length: line-width, stroke: 0.5pt + black)
    #if n != none and n != "" [#n \ ]
    #if t != none and t != "" [#text(size: 10pt, fill: luma(80))[#t]]
  ]

  if names.len() <= 1 {
    sig-block(names.at(0, default: none), titles.at(0, default: none))
  } else {
    grid(
      columns: names.len(),
      column-gutter: 1em,
      ..range(names.len()).map(i => sig-block(names.at(i), titles.at(i, default: none)))
    )
  }

  if date != none and date != "" [
    #v(1em)
    #date
  ]
}

#let init(title, subtitle, font: none, author: "", date: "", logo: "", paper: "us-letter", body) = {

  // --- 1. Basic Document Settings ---
  set text(size: 11pt, ..if font != none { (font: font) })
  set page(margin: .75in, paper: paper)

  // --- Headings ---
  // L1 headers get a bold accent bar, a subtle tinted background, and their
  // own number, so each idea reads as a distinct "card start". L2/L3 are
  // lighter, colored, and auto-numbered under their parent.
  set heading(numbering: "1.1")

  show heading.where(level: 1): it => {
    v(0.6em)
    block(
      fill: rgb("#eef2f7"),
      stroke: (left: 4pt + rgb("#0b4c8c")),
      inset: (x: 12pt, y: 10pt),
      radius: 2pt,
      width: 100%,
      breakable: false,
      text(size: 16pt, weight: "bold", fill: rgb("#0b3a6b"))[
        #counter(heading).display("1.")#h(6pt)#it.body
      ],
    )
    v(0.4em)
  }

  show heading.where(level: 2): it => {
    v(0.3em)
    text(size: 12pt, weight: "bold", fill: rgb("#0b4c8c"))[
      #counter(heading).display("1.1")#h(6pt)#it.body
    ]
    v(0.2em)
  }

  show heading.where(level: 3): it => {
    text(size: 11pt, weight: "bold", fill: luma(60))[#it.body]
  }

  // --- 2. Juicy Inline Code ---
  show raw.where(block: false): box.with(
    fill: luma(200),
    inset: (x: 3pt),
    outset: (y: 3pt),
    radius: 2pt,
  )

  // --- 3. Professional Code Blocks ---
  show raw.where(block: true): code => {
    block(
      fill: luma(220),
      stroke: luma(100),
      inset: 14pt,
      radius: 4pt,
      width: 100%,
      breakable: false,
      [
        #if code.lang != none [
          #place(
            top + left,
            dx: -14pt,
            dy: -14pt,
            block(
              fill: luma(100),
              inset: (x: 8pt, y: 4pt),
              radius: (top-left: 3pt, bottom-right: 3pt),
              text(
                size: 9pt,
                weight: "bold",
                fill: luma(220),
                upper(code.lang)
              )
            )
          )
          #v(12pt)
        ]
        #code
      ]
    )
  }

  // --- 4. Tech Pill Links ---
  show link: it => box(
    fill: rgb("#d1e6f9"),
    inset: (x: 4pt),
    outset: (y: 3pt),
    radius: 3pt,
    [
      #set text(fill: rgb("#0b4c8c"))
      #it
    ]
  )

  // --- Header ---
  // Each of logo, author, and date is optional. The header row is laid out in
  // normal flow (not with `place`), so whatever is present gets its own space
  // and the title below never overlaps it. If nothing is present, no header
  // row is emitted at all. The logo cell is built lazily inside the branches
  // that use it, so an empty `logo` is never handed to `image`.
  let has-logo = logo != ""
  let has-meta = author != "" or date != ""

  let logo-cell() = box(width: 2.5in, height: 1in)[
    #image(logo, width: 100%, height: 100%, fit: "contain")
  ]

  let meta-cell = align(right)[
    #text(size: 10pt, fill: luma(80))[
      #if author != "" [#author]
      #if author != "" and date != "" [\ ]
      #if date != "" [#date]
    ]
  ]

  if has-logo and has-meta {
    // Logo left, author/date right, vertically centered against each other.
    grid(
      columns: (auto, 1fr),
      align: (left + horizon, right + horizon),
      logo-cell(),
      meta-cell,
    )
  } else if has-logo {
    // Logo only, on the left.
    align(left)[#logo-cell()]
  } else if has-meta {
    // Author/date only, on the right.
    meta-cell
  }

  if has-logo or has-meta {
    v(0.5em)
  }

  // --- Title ---
  align(center)[
    #text(size: 18pt, weight: "bold")[#title]
    #v(0.5em)
    #text(size: 12pt, style: "italic")[#subtitle]
  ]

  line(length: 100%, stroke: 1pt + gray)
  v(1em)

  // --- Render the Document Body ---
  body
}
