// ============================================================
// Typst Report Kit · Warm Minimal theme
//
// Warm off-white background + ink text + a single green accent (#448361).
// The palette follows the Notion design system (low saturation, editorial,
// quiet). Everything is a token below — swap the colors and nothing else
// needs to change.
//
// Usage: see examples/generic-report.typ
//   #import "theme.typ": *
//   #report(doc-title: [Doc title], doc-date: [2026-01-01])[
//     #cover(kicker: [..], title: [..], sub: [..], core-label: [..], core: [..], meta: [..])
//     #pagebreak()
//     = Chapter one
//     ...
//   ]
// ============================================================

#import "@preview/codly:1.3.0": *
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge

// ---------- Design tokens · warm minimal ----------
#let cover-bg   = rgb("#F7F6F3")   // cover warm off-white
#let ink        = rgb("#37352F")   // body ink
#let muted      = rgb("#7A756E")   // secondary text
#let accent     = rgb("#448361")   // primary accent · green
#let accent-soft = rgb("#E9F0EC")  // pale green fill
#let amber      = rgb("#A98A2E")   // caution / pending
#let warn       = rgb("#C0453D")   // alert
#let muted-blue = rgb("#2E6E8E")   // info card
#let surface    = rgb("#F7F6F3")   // card / surface
#let surface-2  = rgb("#F2F1EE")   // deeper surface (zebra)
#let table-head = rgb("#E9E9E7")   // table header gray
#let border     = rgb("#DEDCD7")   // hairline border

// ---------- Callout card ----------
#let _card-spec(type) = if type == "red" {
    (bg: rgb("#FBEFEB"), fg: warn, bd: rgb("#E8D4D0"))
  } else if type == "blue" {
    (bg: rgb("#EAF1F5"), fg: muted-blue, bd: rgb("#D2DFE6"))
  } else if type == "cream" {
    (bg: rgb("#F7F1E3"), fg: rgb("#8A6D1F"), bd: rgb("#E7DCBE"))
  } else if type == "green" {
    (bg: accent-soft, fg: accent, bd: rgb("#CDE0D4"))
  } else {
    (bg: surface, fg: muted, bd: border)
  }

#let card(title: none, type: "gray", body) = {
  let s = _card-spec(type)
  block(
    width: 100%, fill: s.bg,
    stroke: (left: 2.5pt + s.fg, top: 0.4pt + s.bd, right: 0.4pt + s.bd, bottom: 0.4pt + s.bd),
    radius: 2.5mm, inset: (x: 3.5mm, y: 2.2mm), above: 2mm, below: 2mm,
    [
      #if title != none [
        #block(below: 1.5mm)[#text(size: 11pt, weight: "bold", fill: s.fg)[#title]]
      ]
      #body
    ]
  )
}

// ---------- Verdict strip (pale green fill + green left bar) ----------
#let verdict(body) = block(
  width: 100%, fill: accent-soft,
  stroke: (left: 2.5pt + accent, top: 0.4pt + rgb("#CDE0D4"), right: 0.4pt + rgb("#CDE0D4"), bottom: 0.4pt + rgb("#CDE0D4")),
  radius: 2.5mm, inset: (x: 3.5mm, y: 2.2mm), above: 2mm, below: 2mm,
  text(size: 10.5pt, weight: "bold", fill: accent)[#body]
)

// ---------- Status badge ----------
#let badge(level: "ok", body) = {
  let col = if level == "ok" { accent } else if level == "warn" { amber }
            else if level == "unk" { rgb("#9A968F") } else if level == "red" { warn }
            else { muted-blue }
  box(fill: col, inset: (x: 2.2mm, y: 0.4mm), radius: 1.6mm,
      text(fill: white, size: 8.5pt, weight: "bold")[#body])
}

// ---------- Checkbox list item ----------
#let check-item(checked: false, body) = grid(
  columns: (auto, 1fr), column-gutter: 2.5mm, align: (center, start),
  square(
    size: 3.2mm, radius: 0.8mm,
    fill: if checked { accent } else { white },
    stroke: if checked { none } else { 1.2pt + border },
    if checked [ #text(fill: white, size: 7pt)[✓] ],
  ),
  body,
)

// ---------- Timeline (fletcher; numbered green discs + arrows) ----------
// items: ((date, label), (date, label), ...)
#let timeline(items) = {
  let n = items.len()
  fletcher.diagram(
    node-stroke: 0pt,
    edge-stroke: 0.8pt + accent,
    spacing: 3.5em,
    ..range(n).map(i => {
      let (date, name) = items.at(i)
      fletcher.node((i, 0), block(
        inset: (x: 1mm),
        align(center, [
          #circle(radius: 4mm, fill: accent, stroke: none,
            text(fill: white, weight: "bold", size: 9.5pt)[#(i + 1)])
          #v(1.5mm)
          #text(size: 9.5pt, weight: "bold", fill: ink)[#date]
          #v(0.6mm)
          #text(size: 8.5pt, fill: muted)[#name]
        ])
      ))
    }),
    ..range(n - 1).map(i => fletcher.edge((i, 0), (i + 1, 0), "-|>")),
  )
}

// ---------- Cover page ----------
// decoration: "lines" = three decreasing accent rules (top right, default)
//             "disc"  = one large pale accent disc (top right)
#let cover(kicker: none, title: none, sub: none, core-label: none, core: none, meta: none,
           decoration: "lines") = page(
  paper: "a4", margin: 0pt, fill: cover-bg, header: none, footer: none,
  background: if decoration == "disc" {
    {
      place(top + right, dx: 24mm, dy: -24mm, circle(radius: 40mm, fill: accent.lighten(82%)))
    }
  } else {
    {
      place(top + right, dx: -26mm, dy: 28mm, line(length: 52mm, stroke: 0.9pt + accent))
      place(top + right, dx: -26mm, dy: 34mm, line(length: 40mm, stroke: 0.7pt + accent.lighten(30%)))
      place(top + right, dx: -26mm, dy: 40mm, line(length: 28mm, stroke: 0.5pt + accent.lighten(48%)))
    }
  },
  [
    #block(inset: (top: 36mm, left: 26mm, right: 26mm), [
      #text(size: 12pt, fill: muted)[#kicker]
      #v(13mm)
      #text(size: 34pt, weight: "bold", fill: ink)[#title]
      #v(5mm)
      #line(length: 22mm, stroke: 2.5pt + accent)
      #v(11mm)
      #text(size: 12.5pt, fill: muted)[#sub]
      #v(26mm)
      #block(fill: white, radius: 4mm, inset: (x: 10mm, y: 8mm), width: 100%, stroke: 0.5pt + border, [
        #text(size: 10pt, weight: "bold", fill: accent)[#core-label]
        #v(3mm)
        #text(size: 11pt, fill: ink)[#core]
      ])
    ])
    #place(bottom + left, dx: 26mm, dy: -16mm, block(width: 100%, [
      #text(size: 9pt, fill: muted)[#meta]
    ]))
  ]
)

// ---------- Report template ----------
// doc-title / doc-date : running header (hidden on the cover page)
// doc-footer           : running footer label (none = no footer text)
// numbered             : number level-1 headings (01, 02, ...)
// quote-style          : "amber" = cream left-bar quote, "green" = green callout
#let report(doc-title: none, doc-date: none, doc-footer: none,
            numbered: true, leading: 0.75em, quote-style: "amber", body) = {
  set text(font: ("Microsoft YaHei", "Segoe UI"), size: 9.5pt, fill: ink)
  set par(justify: true, leading: leading)

  set page(
    paper: "a4",
    margin: (top: 17mm, bottom: 17mm, left: 14mm, right: 14mm),
    fill: white,
    header: context {
      if counter(page).get().first() > 1 [
        #block(width: 100%, inset: (x: 14mm, y: 2mm), stroke: (bottom: 0.5pt + border), [
          #set text(fill: muted, size: 8pt)
          #text(weight: "bold", fill: ink)[#doc-title]
          #h(1fr)
          #text(size: 7.5pt)[#doc-date]
        ])
      ]
    },
    footer: context {
      if counter(page).get().first() > 1 [
        #let (p,) = counter(page).get()
        #block(width: 100%, inset: (x: 14mm, y: 2mm), [
          #set text(fill: muted, size: 8pt)
          #text[#doc-footer]
          #h(1fr)
          #align(right)[#(p - 1)]
        ])
      ]
    },
  )

  set heading(numbering: if numbered { "01" } else { none })

  // Level-1 heading: pale green number chip + ink title + hairline rule
  show heading.where(level: 1): it => {
    if numbered {
      context {
        let num = counter(heading.where(level: 1)).display("01")
        block(width: 100%, below: 4mm, [
          #grid(columns: (auto, 1fr), column-gutter: 3.5mm, align: (center, start),
            block(fill: accent-soft, inset: (x: 3.2mm, y: 1.1mm), radius: 1.8mm,
              text(fill: accent, weight: "bold", size: 11pt)[#num]),
            text(size: 16pt, weight: "bold", fill: ink)[#it.body])
          #v(2mm)
          #line(length: 100%, stroke: 0.8pt + border)
        ])
      }
    } else {
      block(width: 100%, below: 4mm, [
        #text(size: 17pt, weight: "bold", fill: ink)[#it.body]
        #v(2mm)
        #line(length: 100%, stroke: 0.8pt + border)
      ])
    }
  }
  // Level-2 heading: pale green band with a green tick
  show heading.where(level: 2): it => block(above: 4mm, below: 1.5mm, fill: accent-soft, inset: (x: 2.5mm, y: 1.4mm), radius: 1.4mm, [
    #grid(columns: (auto, 1fr), column-gutter: 2.5mm, align: (center, start),
      block(width: 2.2mm, height: 4mm, fill: accent, radius: 0.8mm),
      text(size: 11.5pt, weight: "bold", fill: accent)[#it.body])
  ])
  // Level-3 heading: quiet gray band
  show heading.where(level: 3): it => block(above: 3mm, below: 1mm, fill: surface-2, inset: (x: 2mm, y: 0.9mm), radius: 1mm, [
    text(size: 10.5pt, weight: "bold", fill: ink)[#it.body]
  ])

  // Block quotes: cream left-bar, or green callout
  if quote-style == "green" {
    show quote: it => block(
      width: 100%, fill: accent-soft,
      stroke: (left: 2.5pt + accent, top: 0.4pt + rgb("#CDE0D4"), right: 0.4pt + rgb("#CDE0D4"), bottom: 0.4pt + rgb("#CDE0D4")),
      radius: 2.5mm, inset: (x: 3.5mm, y: 2.2mm), above: 2mm, below: 2mm,
      text(size: 9.5pt)[#it]
    )
  } else {
    show quote: it => block(width: 100%, fill: rgb("#FBF9F4"), inset: (x: 2.5mm, y: 1.8mm), radius: 1.2mm, stroke: (left: 3pt + amber), [
      text(fill: ink)[#it.body]
    ])
  }

  // Tables: gray header + ink text + hairline borders + faint zebra
  set table(
    fill: (x, y) => if y == 0 { table-head } else if calc.odd(y) { surface-2 } else { white },
    stroke: (x, y) => if y == 0 {
        (top: 0.4pt + border, right: 0.4pt + border, bottom: 0.8pt + accent, left: 0.4pt + border)
      } else { 0.3pt + border },
    inset: (x: 2mm, y: 1.2mm),
    align: (x, y) => if y == 0 { left } else { top + left },
  )
  show table.cell.where(y: 0): it => {
    set text(fill: ink, weight: "bold", size: 9.5pt)
    it
  }

  // Code blocks (codly: light theme, hairline border, no line numbers)
  show: codly-init.with()
  codly(
    zebra-fill: none,
    stroke: 0.5pt + border,
    radius: 2.5mm,
    number-format: none,
  )

  body
}
