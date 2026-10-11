// Class Note Typst Template
// Clean, modern, and rich academic note-taking template for Typst.

// Internal counters
#let theorem-counter = counter("classnote-theorem")
#let question-counter = counter("classnote-question")
#let example-counter = counter("classnote-example")

// Helper function to safely parse color inputs (strings or color objects)
#let parse-color(c, default: rgb("#1e3a8a")) = {
  if type(c) == color {
    c
  } else if type(c) == str {
    rgb(c)
  } else {
    default
  }
}

// Predefined callout styles
#let callout-styles = (
  info: (
    fill: rgb("#eff6ff"),
    stroke: rgb("#bfdbfe"),
    title-color: rgb("#1e40af"),
    icon: "ℹ"
  ),
  tip: (
    fill: rgb("#f0fdf4"),
    stroke: rgb("#bbf7d0"),
    title-color: rgb("#166534"),
    icon: "💡"
  ),
  warning: (
    fill: rgb("#fffbeb"),
    stroke: rgb("#fde68a"),
    title-color: rgb("#92400e"),
    icon: "⚠️"
  ),
  important: (
    fill: rgb("#fef2f2"),
    stroke: rgb("#fecaca"),
    title-color: rgb("#991b1b"),
    icon: "🚨"
  ),
  note: (
    fill: rgb("#f8fafc"),
    stroke: rgb("#e2e8f0"),
    title-color: rgb("#334155"),
    icon: "📌"
  )
)

// Bloom's Taxonomy color palettes & labels
#let bloom-levels = (
  L1: (name: "Remember", color: rgb("#0284c7"), bg: rgb("#e0f2fe"), border: rgb("#bae6fd")),
  L2: (name: "Understand", color: rgb("#0d9488"), bg: rgb("#ccfbf1"), border: rgb("#99f6e4")),
  L3: (name: "Apply", color: rgb("#16a34a"), bg: rgb("#dcfce7"), border: rgb("#bbf7d0")),
  L4: (name: "Analyze", color: rgb("#ca8a04"), bg: rgb("#fef9c3"), border: rgb("#fef08a")),
  L5: (name: "Evaluate", color: rgb("#ea580c"), bg: rgb("#ffedd5"), border: rgb("#fed7aa")),
  L6: (name: "Create", color: rgb("#dc2626"), bg: rgb("#fee2e2"), border: rgb("#fca5a5")),
)

// Internal helper to parse Bloom's taxonomy input
#let parse-bloom(val) = {
  if val == none { return none }
  let str-val = lower(str(val).trim())
  if str-val.starts-with("l1") or str-val.contains("remember") or str-val == "1" {
    ("key": "L1", "name": "Remember", ..bloom-levels.L1)
  } else if str-val.starts-with("l2") or str-val.contains("understand") or str-val == "2" {
    ("key": "L2", "name": "Understand", ..bloom-levels.L2)
  } else if str-val.starts-with("l3") or str-val.contains("apply") or str-val == "3" {
    ("key": "L3", "name": "Apply", ..bloom-levels.L3)
  } else if str-val.starts-with("l4") or str-val.contains("analyze") or str-val == "4" {
    ("key": "L4", "name": "Analyze", ..bloom-levels.L4)
  } else if str-val.starts-with("l5") or str-val.contains("evaluat") or str-val == "5" {
    ("key": "L5", "name": "Evaluate", ..bloom-levels.L5)
  } else if str-val.starts-with("l6") or str-val.contains("create") or str-val == "6" {
    ("key": "L6", "name": "Create", ..bloom-levels.L6)
  } else {
    ("key": "OBE", "name": str(val), color: rgb("#475569"), bg: rgb("#f1f5f9"), border: rgb("#cbd5e1"))
  }
}

// Visual Bloom's Taxonomy Badge (Sleek Dual-Chip Capsule design)
#let bloom-badge(level, compact: false) = {
  let info = parse-bloom(level)
  if info == none { return [] }
  
  if compact {
    box(
      fill: info.color,
      radius: 3pt,
      inset: (x: 5.5pt, y: 2.5pt),
      baseline: 0%,
      text(size: 8pt, weight: "bold", fill: white)[#info.key]
    )
  } else {
    box(
      stroke: 0.5pt + info.color.lighten(30%),
      radius: 4pt,
      inset: 0pt,
      baseline: 0%,
      clip: true,
      [#box(
        fill: info.color,
        inset: (x: 5.5pt, y: 2.5pt),
        text(size: 8pt, weight: "bold", fill: white)[#info.key]
      )#box(
        fill: info.bg,
        inset: (x: 6.5pt, y: 2.5pt),
        text(size: 8pt, weight: "bold", fill: info.color.darken(20%))[#info.name]
      )]
    )
  }
}

// OBE Meta Badge (combining CO, Bloom's level, PO)
#let obe-tag(co: none, bloom: none, po: none) = {
  let items = ()
  if co != none {
    let co-str = if type(co) == array { co.join(", ") } else { str(co) }
    items.push(
      box(
        fill: rgb("#1e3a8a"),
        radius: 4pt,
        inset: (x: 6pt, y: 2.5pt),
        baseline: 0%,
        text(size: 8pt, weight: "bold", fill: white)[#co-str]
      )
    )
  }
  if bloom != none {
    items.push(bloom-badge(bloom))
  }
  if po != none {
    let po-str = if type(po) == array { po.join(", ") } else { str(po) }
    items.push(
      box(
        fill: rgb("#6b21a8"),
        radius: 4pt,
        inset: (x: 6pt, y: 2.5pt),
        baseline: 0%,
        text(size: 8pt, weight: "bold", fill: white)[#po-str]
      )
    )
  }
  if items.len() > 0 {
    items.join(h(4pt))
  }
}

// Predefined font family presets
#let font-presets = (
  sans: ("DejaVu Sans", "Liberation Sans", "Ubuntu Sans", "Nimbus Sans", "Noto Sans"),
  serif: ("DejaVu Serif", "Liberation Serif", "Nimbus Roman", "Noto Serif", "Times New Roman"),
)

// Main template function
#let classnote(
  title: "",
  subtitle: "",
  faculty: "",
  semester: "",
  dept_short: "",
  dept: "",
  subject: "",
  code: "",
  date: "",
  program: "",
  academic_year: "",
  accent: rgb("#1e3a8a"),
  paper: "a4",
  margin: (x: 2cm, y: 2.5cm),
  font_style: "sans", // "sans" or "serif"
  font: auto,
  body
) = {
  let accent-color = parse-color(accent, default: rgb("#1e3a8a"))
  
  // Resolve font selection (supports font_style: "sans"/"serif" or font: "serif"/"sans" or custom font array)
  let selected-font = if font != auto and font != none {
    if font == "sans" {
      font-presets.sans
    } else if font == "serif" {
      font-presets.serif
    } else {
      font
    }
  } else if font_style == "serif" {
    font-presets.serif
  } else {
    font-presets.sans
  }

  // Document metadata
  set document(
    author: if faculty != "" { (faculty,) } else { () },
    title: title
  )
  
  // Set font family and text settings
  set text(font: selected-font, size: 10.5pt, fill: rgb("#1f2937"))
  set par(justify: true, leading: 0.65em)
  
  // Heading styling
  show heading: it => {
    set text(fill: accent-color, weight: "bold")
    if it.level == 1 {
      v(1.2em)
      block(
        width: 100%,
        stroke: (bottom: 1.5pt + accent-color),
        inset: (bottom: 0.4em),
        [#it.body]
      )
      v(0.6em)
    } else if it.level == 2 {
      v(1em)
      [#it.body]
      v(0.4em)
    } else {
      v(0.8em)
      [#it.body]
      v(0.3em)
    }
  }

  // Code block styling
  show raw.where(block: true): it => {
    block(
      width: 100%,
      fill: rgb("#f8fafc"),
      stroke: 1pt + rgb("#e2e8f0"),
      radius: 6pt,
      inset: 10pt,
      outset: 0pt,
      [
        #set text(font: ("DejaVu Sans Mono", "Ubuntu Mono", "Noto Sans Mono"), size: 9pt)
        #it
      ]
    )
  }

  // Inline code styling
  show raw.where(block: false): it => {
    box(
      fill: rgb("#f1f5f9"),
      radius: 3pt,
      inset: (x: 4pt, y: 2pt),
      outset: 0pt,
      text(font: ("DejaVu Sans Mono", "Ubuntu Mono", "Noto Sans Mono"), size: 9pt, fill: rgb("#0f172a"), it)
    )
  }

  // Table styling
  show table: set table(
    stroke: 0.5pt + rgb("#cbd5e1"),
    fill: (x, y) => if y == 0 { accent-color.lighten(90%) } else if calc.odd(y) { rgb("#f8fafc") } else { none }
  )

  // Page layout
  set page(
    paper: paper,
    margin: margin,
    header: context {
      let page-num = counter(page).get().first()
      if page-num > 1 [
        #grid(
          columns: (1fr, 1fr),
          align: (left, right),
          [
            #text(size: 8.5pt, fill: rgb("#64748b"), weight: "medium")[
              #if dept_short != "" [#smallcaps[Dept. of #dept_short] • ]
              #if subject != "" [#subject]
              #if code != "" [ (#code)]
            ]
          ],
          [
            #text(size: 8.5pt, fill: rgb("#64748b"), weight: "medium")[
              #if semester != "" [Semester #semester ] else [Class Notes]
            ]
          ]
        )
        #v(-4pt)
        #line(length: 100%, stroke: 0.5pt + rgb("#cbd5e1"))
      ]
    },
    footer: context {
      grid(
        columns: (1fr, 1fr, 1fr),
        align: (left, center, right),
        [#text(size: 8.5pt, fill: rgb("#64748b"))[#smallcaps[#title]]],
        [#text(size: 8.5pt, fill: rgb("#475569"), weight: "bold")[#counter(page).display()]],
        [#text(size: 8.5pt, fill: rgb("#64748b"))[#date]]
      )
    }
  )

  // Title Banner / Hero Card
  block(
    width: 100%,
    fill: accent-color,
    radius: 8pt,
    inset: (x: 18pt, y: 16pt),
    [
      #align(center)[
        #text(title, weight: "bold", size: 20pt, fill: white)
        #if subtitle != "" [
          #v(4pt)
          #text(subtitle, style: "italic", size: 11pt, fill: white.darken(10%))
        ]
      ]
      
      #let meta-items = ()
      #if subject != "" { meta-items.push([*Subject:* #subject #if code != "" [(#code)]]) }
      #if program != "" { meta-items.push([*Program:* #program]) }
      #if semester != "" { meta-items.push([*Semester:* #semester]) }
      #if dept != "" { meta-items.push([*Department:* #dept]) } else if dept_short != "" { meta-items.push([*Dept:* #dept_short]) }
      #if faculty != "" { meta-items.push([*Faculty:* #faculty]) }
      #if academic_year != "" { meta-items.push([*AY:* #academic_year]) }
      #if date != "" { meta-items.push([*Date:* #date]) }

      #if meta-items.len() > 0 [
        #v(10pt)
        #line(length: 100%, stroke: 0.5pt + white.transparentize(60%))
        #v(6pt)
        #align(center)[
          #text(size: 9.5pt, fill: white.darken(5%))[
            #meta-items.join([ #h(8pt) • #h(8pt) ])
          ]
        ]
      ]
    ]
  )

  v(12pt)
  body
}

// Flexible Callout function supporting both positional (legacy) and named parameters
#let callout(
  ..args,
  title: "",
  head: "",
  type: "info",
  icon: none,
  fill: none,
  stroke: none
) = {
  let pos = args.pos()
  let body = []
  let custom-fill = fill
  
  if pos.len() == 1 {
    body = pos.at(0)
  } else if pos.len() >= 2 {
    custom-fill = pos.at(0)
    body = pos.at(1)
  }
  
  let header-title = if title != "" { title } else { head }
  let style = callout-styles.at(type, default: callout-styles.info)
  
  let bg-color = if custom-fill != none { parse-color(custom-fill) } else { style.fill }
  let border-color = if stroke != none { parse-color(stroke) } else if custom-fill != none { parse-color(custom-fill).darken(20%) } else { style.stroke }
  let icon-text = if icon != none { icon } else { style.icon }

  block(
    width: 100%,
    fill: bg-color,
    stroke: (left: 4pt + border-color, rest: 1pt + border-color.lighten(40%)),
    radius: (right: 6pt),
    inset: (x: 12pt, y: 10pt),
    above: 0.8em,
    below: 0.8em,
    [
      #grid(
        columns: (auto, 1fr),
        gutter: 8pt,
        align: (left + top, left),
        [#text(size: 12pt)[#icon-text]],
        [
          #if header-title != "" [
            #text(weight: "bold", size: 10.5pt, fill: style.title-color)[#header-title]
            #v(2pt)
          ]
          #text(size: 10pt)[#body]
        ]
      )
    ]
  )
}

// Definition block
#let definition(
  body,
  term: "",
  topic: "",
  fill: rgb("#f0fdf4"),
  stroke: rgb("#86efac")
) = {
  let title-text = if term != "" { term } else { topic }
  let fill-color = parse-color(fill)
  let stroke-color = parse-color(stroke)

  block(
    width: 100%,
    fill: fill-color,
    stroke: (left: 4pt + stroke-color.darken(20%), rest: 1pt + stroke-color),
    radius: (right: 6pt),
    inset: (x: 12pt, y: 10pt),
    above: 0.8em,
    below: 0.8em,
    [
      #text(weight: "bold", size: 10.5pt, fill: stroke-color.darken(40%))[
        Definition#if title-text != "" [ (#title-text)]:
      ]
      #v(2pt)
      #text(style: "italic", size: 10pt)[#body]
    ]
  )
}

// Theorem block
#let theorem(
  body,
  title: "",
  reset: false,
  fill: rgb("#eff6ff"),
  stroke: rgb("#93c5fd")
) = [
  #if reset { theorem-counter.update(0) }
  #theorem-counter.step()
  #let fill-color = parse-color(fill)
  #let stroke-color = parse-color(stroke)
  #block(
    width: 100%,
    fill: fill-color,
    stroke: (left: 4pt + stroke-color.darken(20%), rest: 1pt + stroke-color),
    radius: (right: 6pt),
    inset: (x: 12pt, y: 10pt),
    above: 0.8em,
    below: 0.8em,
    [
      #text(weight: "bold", size: 10.5pt, fill: stroke-color.darken(40%))[
        Theorem #context theorem-counter.display()#if title != "" [ (#title)]:
      ]
      #v(2pt)
      #text(style: "italic", size: 10pt)[#body]
    ]
  )
]

// Lemma block
#let lemma(
  body,
  title: "",
  fill: rgb("#f5f3ff"),
  stroke: rgb("#c4b5fd")
) = {
  let fill-color = parse-color(fill)
  let stroke-color = parse-color(stroke)
  block(
    width: 100%,
    fill: fill-color,
    stroke: (left: 4pt + stroke-color.darken(20%), rest: 1pt + stroke-color),
    radius: (right: 6pt),
    inset: (x: 12pt, y: 10pt),
    above: 0.8em,
    below: 0.8em,
    [
      #text(weight: "bold", size: 10.5pt, fill: stroke-color.darken(40%))[
        Lemma#if title != "" [ (#title)]:
      ]
      #v(2pt)
      #text(style: "italic", size: 10pt)[#body]
    ]
  )
}

// Corollary block
#let corollary(
  body,
  title: "",
  fill: rgb("#f8fafc"),
  stroke: rgb("#cbd5e1")
) = {
  let fill-color = parse-color(fill)
  let stroke-color = parse-color(stroke)
  block(
    width: 100%,
    fill: fill-color,
    stroke: (left: 4pt + stroke-color.darken(20%), rest: 1pt + stroke-color),
    radius: (right: 6pt),
    inset: (x: 12pt, y: 10pt),
    above: 0.8em,
    below: 0.8em,
    [
      #text(weight: "bold", size: 10.5pt, fill: stroke-color.darken(40%))[
        Corollary#if title != "" [ (#title)]:
      ]
      #v(2pt)
      #text(style: "italic", size: 10pt)[#body]
    ]
  )
}

// Proposition block
#let proposition(
  body,
  title: "",
  fill: rgb("#f0fdfa"),
  stroke: rgb("#99f6e4")
) = {
  let fill-color = parse-color(fill)
  let stroke-color = parse-color(stroke)
  block(
    width: 100%,
    fill: fill-color,
    stroke: (left: 4pt + stroke-color.darken(20%), rest: 1pt + stroke-color),
    radius: (right: 6pt),
    inset: (x: 12pt, y: 10pt),
    above: 0.8em,
    below: 0.8em,
    [
      #text(weight: "bold", size: 10.5pt, fill: stroke-color.darken(40%))[
        Proposition#if title != "" [ (#title)]:
      ]
      #v(2pt)
      #text(style: "italic", size: 10pt)[#body]
    ]
  )
}

// Proof block
#let proof(
  body,
  title: "Proof"
) = block(
  width: 100%,
  stroke: (left: 2.5pt + rgb("#94a3b8")),
  inset: (left: 10pt, top: 4pt, bottom: 4pt),
  above: 0.8em,
  below: 0.8em,
  [
    #text(weight: "bold", style: "italic", size: 10pt, fill: rgb("#475569"))[#title:]
    #h(6pt)
    #body
    #align(right)[#text(fill: rgb("#64748b"))[$square$]]
  ]
)

// Example block
#let example(
  body,
  title: "",
  reset: false,
  fill: rgb("#fff7ed"),
  stroke: rgb("#ffedd5")
) = [
  #if reset { example-counter.update(0) }
  #example-counter.step()
  #let fill-color = parse-color(fill)
  #let stroke-color = parse-color(stroke)
  #block(
    width: 100%,
    fill: fill-color,
    stroke: (left: 4pt + rgb("#f97316"), rest: 1pt + stroke-color),
    radius: (right: 6pt),
    inset: (x: 12pt, y: 10pt),
    above: 0.8em,
    below: 0.8em,
    [
      #text(weight: "bold", size: 10.5pt, fill: rgb("#c2410c"))[
        Example #context example-counter.display()#if title != "" [ (#title)]:
      ]
      #v(2pt)
      #text(size: 10pt)[#body]
    ]
  )
]

// Single Question block with optional OBE tagging
#let question(
  body,
  answer: "",
  points: none,
  co: none,
  bloom: none,
  po: none,
  reset: false,
  fill: rgb("#fafafa"),
  stroke: rgb("#e4e4e7")
) = [
  #if reset { question-counter.update(0) }
  #question-counter.step()
  #let fill-color = parse-color(fill)
  #let stroke-color = parse-color(stroke)
  #block(
    width: 100%,
    fill: fill-color,
    stroke: 1pt + stroke-color,
    radius: 6pt,
    inset: (x: 14pt, y: 12pt),
    above: 0.8em,
    below: 0.8em,
    [
      #grid(
        columns: (1fr, auto),
        align: (left, right + horizon),
        [
          #text(weight: "bold", size: 10.5pt, fill: rgb("#09090b"))[
            Question #context question-counter.display()
          ]
        ],
        [
          #let has-obe = co != none or bloom != none or po != none
          #if has-obe [
            #obe-tag(co: co, bloom: bloom, po: po)
          ]
          #if points != none [
            #if has-obe [#h(4pt)]
            #box(
              fill: rgb("#e0e7ff"),
              radius: 10pt,
              inset: (x: 8pt, y: 3pt),
              text(size: 8.5pt, weight: "bold", fill: rgb("#3730a3"))[#points #if type(points) == int or type(points) == float [pt#if points != 1 [s]]]
            )
          ]
        ]
      )
      #v(4pt)
      #text(size: 10pt)[#body]
      #if answer != "" [
        #v(6pt)
        #line(length: 100%, stroke: 0.5pt + stroke-color)
        #v(4pt)
        #text(weight: "bold", size: 9.5pt, fill: rgb("#27272a"))[Answer:]
        #v(2pt)
        #text(size: 10pt, fill: rgb("#3f3f46"))[#answer]
      ]
    ]
  )
]

// Q&A List helper
#let qna(items: ()) = {
  let item-list = if type(items) == array { items } else { () }
  for (i, item) in item-list.enumerate() [
    #block(
      width: 100%,
      fill: rgb("#f8fafc"),
      stroke: 1pt + rgb("#e2e8f0"),
      radius: 6pt,
      inset: 12pt,
      above: 0.5em,
      below: 0.5em,
      [
        #text(weight: "bold", fill: rgb("#1e293b"))[Q#str(i + 1): #item.at("question", default: "")]
        #if "answer" in item [
          #v(4pt)
          #text(style: "italic", fill: rgb("#475569"))[A: #item.answer]
        ]
      ]
    )
  ]
}

// Key Takeaway banner
#let keypoint(body, title: "Key Takeaway") = [
  #block(
    width: 100%,
    fill: rgb("#fef3c7"),
    stroke: 1pt + rgb("#fde047"),
    radius: 6pt,
    inset: (x: 12pt, y: 10pt),
    above: 0.8em,
    below: 0.8em,
    [
      #text(weight: "bold", size: 10pt, fill: rgb("#854d0e"))[⭐ #title:]
      #h(6pt)
      #text(size: 10pt, fill: rgb("#713f12"))[#body]
    ]
  )
]

// Inline TODO badge
#let todo(body) = [
  #box(
    fill: rgb("#fee2e2"),
    stroke: 0.5pt + rgb("#fca5a5"),
    radius: 4pt,
    inset: (x: 6pt, y: 3pt),
    text(size: 9pt, weight: "bold", fill: rgb("#991b1b"))[📌 TODO: #body]
  )
]

// ==========================================
// Outcome-Based Education (OBE) Components
// ==========================================

// Course Outcomes Box
#let course-outcomes(
  title: "Course Outcomes (COs)",
  cos: ()
) = {
  block(
    width: 100%,
    fill: rgb("#f8fafc"),
    stroke: (left: 4pt + rgb("#1e3a8a"), rest: 1pt + rgb("#e2e8f0")),
    radius: (right: 6pt),
    inset: (x: 14pt, y: 12pt),
    above: 1em,
    below: 1em,
    [
      #text(weight: "bold", size: 11pt, fill: rgb("#1e3a8a"))[#title]
      #v(6pt)
      #stack(
        spacing: 8pt,
        ..cos.map(item => {
          let co-id = item.at("code", default: item.at("id", default: "CO"))
          let co-desc = item.at("desc", default: item.at("description", default: ""))
          let co-bloom = item.at("bloom", default: item.at("level", default: none))
          let co-po = item.at("po", default: none)
          
          grid(
            columns: (auto, 1fr, auto),
            gutter: 10pt,
            align: (left + top, left + top, right + top),
            [
              #box(
                fill: rgb("#1e3a8a"),
                radius: 4pt,
                inset: (x: 6pt, y: 3pt),
                text(size: 8.5pt, weight: "bold", fill: white)[#co-id]
              )
            ],
            [
              #text(size: 9.5pt, fill: rgb("#334155"))[#co-desc]
            ],
            [
              #if co-bloom != none or co-po != none [
                #obe-tag(bloom: co-bloom, po: co-po)
              ]
            ]
          )
        })
      )
    ]
  )
}

// CO-PO Matrix / Articulation Table
#let co-po-matrix(
  cos: (),
  pos: ("PO1", "PO2", "PO3", "PO4", "PO5", "PO6"),
  mapping: ()
) = {
  let co-keys = cos.map(c => if type(c) == dictionary { c.at("code", default: c.at("id", default: "")) } else { str(c) })
  let po-keys = pos.map(p => str(p))
  
  let header-row = ([*CO / PO*], ..po-keys.map(p => align(center, [*#p*])))
  
  let rows = ()
  for (i, co) in co-keys.enumerate() {
    let row-cells = ([*#co*],)
    let co-map = mapping.at(i, default: ())
    for (j, po) in po-keys.enumerate() {
      let val = if type(co-map) == dictionary {
        co-map.at(po, default: "-")
      } else if type(co-map) == array and j < co-map.len() {
        co-map.at(j)
      } else {
        "-"
      }
      let cell-fill = if str(val) == "3" { rgb("#dcfce7") } else if str(val) == "2" { rgb("#fef9c3") } else if str(val) == "1" { rgb("#eff6ff") } else { none }
      let cell-content = align(center)[
        #if cell-fill != none [
          #box(fill: cell-fill, radius: 3pt, inset: (x: 5pt, y: 2pt), text(weight: "bold", size: 9pt)[#val])
        ] else [
          #text(fill: rgb("#94a3b8"), size: 9pt)[#val]
        ]
      ]
      row-cells.push(cell-content)
    }
    rows.push(row-cells)
  }

  block(
    width: 100%,
    above: 1em,
    below: 1em,
    [
      #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[CO-PO Articulation Matrix]
      #v(4pt)
      #table(
        columns: (1.2fr, ..po-keys.map(_ => 1fr)),
        align: (x, y) => if x == 0 { left } else { center },
        ..header-row,
        ..rows.flatten()
      )
      #v(2pt)
      #text(size: 8pt, fill: rgb("#64748b"), style: "italic")[
        Legend: 3 - High / Substantial Correlation, 2 - Medium / Moderate Correlation, 1 - Low / Slight Correlation
      ]
    ]
  )
}

// Bloom's Taxonomy Visual Legend
#let bloom-legend(title: "Bloom's Taxonomy Cognitive Levels") = {
  let levels-data = (
    (level: "L1", name: "Remember", color: rgb("#0284c7"), bg: rgb("#e0f2fe"), verbs: "Define, List, State, Recall, Identify"),
    (level: "L2", name: "Understand", color: rgb("#0d9488"), bg: rgb("#ccfbf1"), verbs: "Explain, Describe, Classify, Discuss, Summarize"),
    (level: "L3", name: "Apply", color: rgb("#16a34a"), bg: rgb("#dcfce7"), verbs: "Solve, Calculate, Demonstrate, Implement, Use"),
    (level: "L4", name: "Analyze", color: rgb("#ca8a04"), bg: rgb("#fef9c3"), verbs: "Differentiate, Compare, Contrast, Examine, Deconstruct"),
    (level: "L5", name: "Evaluate", color: rgb("#ea580c"), bg: rgb("#ffedd5"), verbs: "Assess, Judge, Critique, Justify, Validate"),
    (level: "L6", name: "Create", color: rgb("#dc2626"), bg: rgb("#fee2e2"), verbs: "Design, Construct, Formulate, Develop, Synthesize"),
  )

  block(
    width: 100%,
    fill: rgb("#f8fafc"),
    stroke: 1pt + rgb("#e2e8f0"),
    radius: 6pt,
    inset: 12pt,
    above: 1em,
    below: 1em,
    [
      #text(weight: "bold", size: 10.5pt, fill: rgb("#1e293b"))[#title]
      #v(6pt)
      #grid(
        columns: (1fr, 1fr),
        gutter: 8pt,
        ..levels-data.map(item => {
          box(
            width: 100%,
            fill: item.bg,
            stroke: 0.5pt + item.color.lighten(50%),
            radius: 4pt,
            inset: 8pt,
            [
              #grid(
                columns: (auto, 1fr),
                gutter: 6pt,
                align: (left + top, left),
                [
                  #box(
                    fill: item.color,
                    radius: 3pt,
                    inset: (x: 5pt, y: 2pt),
                    text(size: 8pt, weight: "bold", fill: white)[#item.level]
                  )
                ],
                [
                  #text(weight: "bold", size: 9.5pt, fill: item.color.darken(20%))[#item.name]
                  #v(2pt)
                  #text(size: 8pt, fill: rgb("#475569"))[*Verbs:* #item.verbs]
                ]
              )
            ]
          )
        })
      )
    ]
  )
}

// Dedicated OBE Question with Marking Rubric
#let obe-question(
  body,
  co: "CO1",
  bloom: "L2",
  po: none,
  points: 5,
  rubric: "",
  answer: "",
  reset: false
) = {
  question(
    body,
    answer: answer,
    points: points,
    co: co,
    bloom: bloom,
    po: po,
    reset: reset
  )
  if rubric != "" [
    #v(-4pt)
    #block(
      width: 100%,
      fill: rgb("#f8fafc"),
      stroke: (left: 2.5pt + rgb("#64748b"), rest: 0.5pt + rgb("#e2e8f0")),
      radius: (right: 4pt),
      inset: (x: 10pt, y: 6pt),
      below: 0.8em,
      [
        #text(weight: "bold", size: 8.5pt, fill: rgb("#475569"))[Evaluation Rubric / Marking Scheme:]
        #v(2pt)
        #text(size: 9pt, fill: rgb("#334155"))[#rubric]
      ]
    )
  ]
}

// OBE Assessment Summary / Coverage Breakdown
#let obe-summary(
  items: ()
) = {
  block(
    width: 100%,
    above: 1em,
    below: 1em,
    [
      #text(weight: "bold", size: 10.5pt, fill: rgb("#1e3a8a"))[OBE Assessment Outcome Summary]
      #v(4pt)
      #table(
        columns: (1fr, 2.5fr, 1.5fr, 1fr, 1fr),
        [*CO Code*], [*Course Outcome Description*], [*Bloom's Level*], [*Questions*], [*Weightage*],
        ..items.map(item => (
          align(center, [*#item.at("co", default: "CO")*]),
          [#item.at("desc", default: "")],
          align(center, [#bloom-badge(item.at("bloom", default: "L1"))]),
          align(center, [#str(item.at("questions", default: 1))]),
          align(center, [#str(item.at("marks", default: 0)) pt#if item.at("marks", default: 0) != 1 [s]])
        )).flatten()
      )
    ]
  )
}