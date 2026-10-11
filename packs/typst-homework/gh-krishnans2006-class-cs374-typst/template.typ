// CS 374 A homework submissions — Fall 2026
//
//   #import "template.typ": *
//   #show: template.with(solutions: true)  // set false to hide solutions
//
//   #title-page(
//     course: "CS/ECE 374 A",
//     semester: "Fall 2026",
//     homework: 1,
//     date: datetime(month: 9, day: 1, year: 2026),
//   )
//
//   #problem(1, 2, authors: (("Name", "netid"),))[
//     #lemma[...]
//     As shown in @lemma1, ...
//     $ ... && quad #ref(<lemma1>) $   // use #ref in math mode
//     #solution[
//       + part (a)
//       + part (b)
//     ]
//     #sources[None.]
//   ]
//
//   #algo[
//     #ul[#sc[HaHaHa](net):] #indent \
//     $italic("net.found") <- italic("now")$ \
//     in parallel: #indent \
//     for $i <- 1$ to $100$ #outdent \
//   ]

#let brick-red = rgb("#B6321C")
#let olive-green = rgb("#3C8031")
#let pine-green = rgb("#008B72")
#let royal-blue = rgb("#0071BC")
#let navy-blue = rgb("#006EB8")

#let imp(body) = strong(emph(body))

#let hw-context = state("hw-context", none)
#let header-count = state("header-count", 0)
#let solutions-flag = state("solutions", true)
#let algo-depth = state("algo-depth", 0)
#let algo-level = state("algo-level", 0)

// Enum nesting outside a solution/proof; subtracted so lists inside restart at (a).
#let _enum-level-base = state("enum-level-base", none)
#let _in-scoped-enum = state("in-scoped-enum", false)

#let _enum-numbering(..n) = context {
  let nums = n.pos()
  let in-scoped = _in-scoped-enum.get()
  let base = _enum-level-base.get()

  let level = if in-scoped {
    if base == none { 0 } else { calc.max(0, nums.len() - 1 - base) }
  } else {
    nums.len() - 1
  }

  let pattern = ("(a", "i").at(level, default: "i")
  let suffix = ").".at(level, default: ".")
  let label = numbering(pattern, nums.last()) + suffix

  // Capture parent depth on the first label inside a scoped block.
  if in-scoped and base == none {
    _enum-level-base.update(nums.len() - 1) + label
  } else {
    label
  }
}

#let _with-fresh-enum(body) = {
  _enum-level-base.update(none)
  _in-scoped-enum.update(true)
  body
  _in-scoped-enum.update(false)
  _enum-level-base.update(none)
}

#let _author-names(authors) = authors.map(author => author.first()).join(", ")

#let _running-header(ctx) = {
  let names = _author-names(ctx.authors)
  align(bottom)[
    #block(width: 100%, above: 0pt, below: 0pt)[
      #v(10pt)
      #set text(size: 8pt, weight: "bold")
      #grid(
        columns: (1fr, 1fr, 1fr),
        align: (left, center, right),
        [#ctx.class #ctx.semester], [HW #ctx.hw-number.#ctx.problem-number], [#names],
      )
      #line(length: 100%, stroke: 0.55pt)
    ]
  ]
}

#let _problem-header = context {
  let on-title-page = query(<problem-title>).any(
    marker => marker.location().page() == here().page(),
  )
  let on-cover-page = query(<hw-cover>).any(
    marker => marker.location().page() == here().page(),
  )
  let ctx = hw-context.get()
  if ctx != none and ctx.problem-number > 0 and not on-title-page and not on-cover-page {
    _running-header(ctx)
  }
}
#let _title-box(ctx) = block(
  width: 100%,
  stroke: 0.8pt,
  inset: (x: 8pt, y: 11pt),
  breakable: false,
)[
  #metadata(none) <problem-title>
  #set text(size: 12pt)
  #grid(
    columns: (1fr, auto),
    column-gutter: 1em,
    align: (left + horizon, right + horizon),
    [
      #ctx.class #ctx.semester \
      *Homework #ctx.hw-number Problem #ctx.problem-number*
      #if ctx.section != none {
        linebreak()
        [Return section: #ctx.section]
      }
    ],
    grid(
      columns: (auto, auto),
      column-gutter: 0.25em,
      row-gutter: 4pt,
      align: (right, left),
      ..ctx.authors.map(author => (author.first(), [(#author.last())])).flatten(),
    ),
  )
]

#let title-page(
  course: "CS/ECE 374 A",
  semester: "Fall 2026",
  homework: 1,
  date: datetime(month: 9, day: 1, year: 2026),
  full: false,
) = [
  #if full {
    page(header: none, numbering: none)[
      #metadata(none) <hw-cover>
      #set text(size: 10.5pt)
      #set par(first-line-indent: 0pt, justify: true)
      #set list(tight: false)

      #align(center)[
        #text(size: 13pt)[
          *#course ✦ #semester*
        ]
        #v(0.3em)
        #text(size: 16pt)[
          *Homework #homework*
        ]
        #v(0.3em)
        #text(size: 12pt)[
          Due #date.display("[weekday repr:long], [month repr:long] [day padding:none], [year] at 9pm Central Time")
        ]
      ]

      #v(1.25em)
      #line(length: 100%, stroke: 0.55pt)
      #v(1em)

      - *Submit your solutions electronically on Gradescope as PDF files.*
        - Submit a separate PDF file for each numbered problem.
        - Groups of up to three people can submit joint solutions. #imp[Exactly one] student in each group should upload the solution to Gradescope and #imp[indicate their other group members].
        - You can find a LaTeX solution template on the course web site, which we encourage you to use to typeset your homework.
        - If you plan to submit scanned handwritten solutions, please use dark ink (not pencil) on white unlined paper (not notebook or graph paper), and use a scanner or a scanning app to create a high-quality PDF for submission (not a raw photo). We reserve the right to reject submissions that are difficult to read.
        - If you plan to use a tablet and a note-taking app, please make sure your submitted PDF is broken into standard US-letter sized pages (not a long scroll), and that they don't need excessive zooming to be visible.

      - *You may use any source at your disposal*—paper, human, or electronic—but you #imp[must] cite every source that you use, and you #imp[must] write everything yourself in your own words. You are responsible for all errors in your submissions. In particular:
        - Every lettered #imp[part] of every submitted solution #imp[must] include a list of all sources and collaborators (or the whole thing if it doesn't have lettered parts.) If you didn't consult any sources or collaborators, write "Sources and collaborators: None".
        - If you use any large language model for any purpose, you #imp[must] include a brief explanation what you used the LLM to do.

      - #imp[Standard grading rubrics] for many problem types can be found on the course web page.
        For example, most problems in Homework 1 will be graded using our standard induction rubric.
        Please familiarize yourself with these rubrics #emph[before] you submit your solutions.

      - Each homework will include at least one fully #imp[solved problem], similar to that week's assigned problems. These model solutions show the structure, presentation, and level of detail that we recommend in your homework solutions. (So do the lab solutions.)
        #imp[We strongly recommend reading them #emph[before] submitting your homework solutions.]

      #v(0.65em)
      #line(length: 100%, stroke: 0.55pt)
      #v(0.65em)

      #align(center)[
        #text(fill: brick-red, size: 12pt)[*See the course web page for more information.*]
        #v(0.5em)
        If you have any questions about these policies, \
        please don't hesitate to ask in lecture, in labs, in office hours, or online.
      ]

      #v(0.65em)
      #line(length: 100%, stroke: 0.55pt)
    ]
  } else [
    #metadata(none) <hw-cover>
    #set text(size: 10.5pt)
    #set par(first-line-indent: 0pt, justify: true)
    #set list(tight: false)

    #align(center)[
      #text(size: 13pt)[
        *#course ✦ #semester*
      ]
      #v(0.3em)
      #text(size: 16pt)[
        *Homework #homework*
      ]
      #v(0.3em)
      #text(size: 12pt)[
        Due #date.display("[weekday repr:long], [month repr:long] [day padding:none], [year] at 9pm Central Time")
      ]
    ]

    #v(1.25em)
  ]
]

// Auto-generated references for lemmas, theorems, and problems.
// Use @lemma1, @theorem2, @problem1-1 in text, or #ref(<lemma1>) in math mode.
#let lemma-counter = counter("lemma")
#let theorem-counter = counter("theorem")

#let _hw-ref-label(kind, data) = if kind == "problem" {
  label("problem" + str(data.hw-number) + "-" + str(data.problem-number))
} else {
  label(kind + str(data.number))
}

#let _hw-ref-marker(kind, data) = [
  #metadata((
    ref-kind: kind,
    ..data,
  ))
  #_hw-ref-label(kind, data)
]

#let _hw-ref-plain-text(data) = if data.ref-kind == "lemma" {
  "Lemma " + str(data.number)
} else if data.ref-kind == "theorem" {
  "Theorem " + str(data.number)
} else if data.ref-kind == "problem" {
  "Problem " + str(data.hw-number) + "." + str(data.problem-number)
} else {
  none
}

#let _hw-ref-display(it) = {
  let elem = it.element
  if elem == none or elem.func() != metadata {
    return it
  }
  let data = elem.value
  if type(data) != dictionary or data.ref-kind == none {
    return it
  }
  let text = _hw-ref-plain-text(data)
  if text == none {
    return it
  }
  link(it.target)[#text]
}

#let problem(
  hw-number,
  problem-number,
  authors: (("Name", "netid"),),
  section: none,
  class: none,
  semester: none,
  body,
) = context {
  let prev = hw-context.get()
  let class-name = if class != none {
    class
  } else if prev != none {
    prev.class
  } else {
    "CS 374 A"
  }
  let semester-name = if semester != none {
    semester
  } else if prev != none {
    prev.semester
  } else {
    "Fall 2026"
  }
  let author-list = authors
  let ctx = (
    class: class-name,
    semester: semester-name,
    hw-number: hw-number,
    problem-number: problem-number,
    authors: author-list,
    section: section,
  )

  if header-count.get() > 0 {
    pagebreak()
  }
  header-count.update(n => n + 1)
  let names = _author-names(author-list)
  set document(
    title: class-name + " — Homework " + str(hw-number) + " Problem " + str(problem-number),
    author: names,
  )
  counter(page).update(1)
  _hw-ref-marker("problem", (hw-number: hw-number, problem-number: problem-number))
  _title-box(ctx)
  hw-context.update(ctx)
  v(0.75em)
  body
}

#let template(
  class: "CS 374 A",
  semester: "Fall 2026",
  solutions: true,
  body,
) = {
  solutions-flag.update(solutions)

  hw-context.update((
    class: class,
    semester: semester,
    hw-number: 0,
    problem-number: 0,
    authors: (),
    section: none,
  ))

  set page(
    paper: "us-letter",
    margin: (x: 1.25in, y: 1in),
    numbering: "1",
    header-ascent: 10%,
    header: _problem-header,
  )

  set text(
    font: "New Computer Modern",
    region: "US",
  )
  show math.equation.where(block: true): set block(above: 1.2em, below: 1.15em)
  show math.equation: set stack(spacing: 0.5em)
  show raw: set text(font: "Hack", size: 9.5pt)
  show link: set text(fill: navy-blue)

  set par(
    first-line-indent: 1.5em,
    spacing: 0.65em,
    justify: true,
  )

  show enum.where(tight: false): set enum(
    full: true,
    numbering: _enum-numbering,
    spacing: 1.4em,
    indent: 0pt,
    body-indent: 0.45em,
    number-align: end + top,
  )
  show enum.where(tight: false): set par(first-line-indent: 0pt, spacing: 1.4em)
  show enum.where(tight: true): set enum(
    full: true,
    numbering: _enum-numbering,
    spacing: 0.85em,
    indent: 1.45em,
    body-indent: 0.45em,
  )
  show list.where(tight: false): set list(
    spacing: 1.4em,
    indent: 1.45em,
    body-indent: 0.45em,
    marker: ([•], [–]),
  )
  show list.where(tight: false): set par(first-line-indent: 0pt, spacing: 1.4em)
  show list.where(tight: true): set list(
    spacing: 0.85em,
    indent: 1.45em,
    body-indent: 0.45em,
    marker: ([•], [–]),
  )
  show enum: items => block(
    above: enum.spacing,
    below: enum.spacing,
    items,
  )
  show list: items => block(
    above: list.spacing,
    below: list.spacing,
    items,
  )

  show ref: _hw-ref-display

  body
}

#let _proof-block(
  title,
  body,
  note: none,
  mark: none,
  stroke: none,
  fill: none,
  text-fill: black,
  font: "New Computer Modern",
  size: 11pt,
  above: 1.5em,
  below: 0.65em,
  inset: 5pt,
) = {
  let content = [
    #set text(font: font, size: size, fill: text-fill)
    #set par(first-line-indent: 0pt)
    *#title#if note != none { [ (#note)] }:* #body
    #if mark != none {
      h(1fr)
      mark
    }
  ]

  if stroke == none and fill == none {
    block(
      width: 100%,
      breakable: true,
      above: above,
      below: below,
    )[#content]
  } else {
    block(
      width: 100%,
      breakable: true,
      above: above,
      below: below,
      inset: inset,
      stroke: stroke,
      fill: fill,
    )[#content]
  }
}

#let solution(body, by: none, qed: true) = context {
  if solutions-flag.get() {
    _with-fresh-enum[
      #_proof-block(
        "Solution",
        [
          #set enum(tight: false, start: 1)
          #set list(tight: true)
          #body
        ],
        note: by,
        mark: if qed { $square.filled$ },
        above: 1.5em,
        below: 1.9em,
      )
    ]
  }
}

#let solution-box(body, by: none, qed: true) = context {
  if solutions-flag.get() {
    _with-fresh-enum[
      #_proof-block(
        "Solution",
        [
          #set enum(tight: false, start: 1)
          #set list(tight: true)
          #body
        ],
        note: by,
        mark: if qed { $square.filled$ },
        stroke: 1.25pt + olive-green,
        fill: rgb("#FFFEF7"),
        above: 0.45em,
        below: 0.35em,
      )
    ]
  }
}

#let proof(body, of: none, qed: true) = {
  _with-fresh-enum[
    #_proof-block(
      if of == none { "Proof" } else { "Proof of " + str(of) },
      body,
      mark: if qed { $square$ },
    )
  ]
}

#let sources(body) = {
  _proof-block(
    "Collaborators and sources",
    [
      #set list(tight: false)
      #body
    ],
    stroke: 1pt + royal-blue,
    text-fill: royal-blue,
    font: "Noto Sans",
    size: 9pt,
    above: 1.4em,
    below: 1.1em,
    inset: (x: 6pt, y: 8pt),
  )
}

#let rubric(body, title: "Rubric") = {
  _proof-block(
    title,
    body,
    stroke: 1pt + brick-red,
    text-fill: brick-red,
    font: "Noto Sans",
    size: 9pt,
    above: 0.35em,
  )
}

#let theorem(body, name: none) = [
  #context {
    let n = theorem-counter.get().first() + 1
    theorem-counter.step()
    _hw-ref-marker("theorem", (number: n))
  }
  #_proof-block(
    context [
      Theorem #theorem-counter.display("1")#if name != none { [ (#name)] }
    ],
    emph(body),
  )
]

#let lemma(body, name: none) = [
  #context {
    let n = lemma-counter.get().first() + 1
    lemma-counter.step()
    _hw-ref-marker("lemma", (number: n))
  }
  #_proof-block(
    context [
      Lemma #lemma-counter.display("1")#if name != none { [ (#name)] }
    ],
    emph(body),
  )
]

// Unnumbered named statement (e.g. "Zorn's Lemma").
#let oneshot(title, body) = {
  block(
    width: 100%,
    breakable: true,
    above: 1.5em,
    below: 0.65em,
  )[
    #set par(first-line-indent: 0pt)
    *#title.* #emph(body)
  ]
}

// Increase/decrease indentation for following lines inside #algo (like LaTeX \+ / \-).
#let indent = context {
  if algo-depth.get() > 0 {
    algo-level.update(level => level + 1)
  }
}

#let outdent = context {
  if algo-depth.get() > 0 {
    algo-level.update(level => calc.max(0, level - 1))
  }
}

#let _algo-is-layout-marker(elem) = repr(elem).starts-with("context(")
#let _algo-is-smallcaps(elem) = repr(elem).starts-with("smallcaps(")
#let _algo-is-equation(elem) = repr(elem).starts-with("equation(")

#let _algo-needs-space(prev, next) = {
  not _algo-is-layout-marker(next)
}

#let _algo-join-children(children) = {
  let merged = ()
  let i = 0
  while i < children.len() {
    let child = children.at(i)
    if i + 1 < children.len() {
      let next = children.at(i + 1)
      if child != [ ] and next != [ ] and _algo-is-smallcaps(child) and _algo-is-equation(next) {
        merged.push([#child#next])
        i += 2
        continue
      }
    }
    merged.push(child)
    i += 1
  }

  let result = []
  let prev = none
  let had-space = false
  for child in merged {
    if child == [ ] {
      result += [ ]
      had-space = true
      continue
    }
    if prev != none and not had-space and _algo-needs-space(prev, child) {
      result += [ ]
    }
    result += child
    prev = child
    had-space = false
  }
  result
}

#let _algo-get-lines(body) = {
  if not body.has("children") {
    return (body,)
  }

  let joined-children = ()
  let segment = ()
  for child in body.children {
    if child == linebreak() or child == parbreak() {
      if segment.len() > 0 {
        joined-children.push(_algo-join-children(segment))
        segment = ()
      }
      joined-children.push(child)
    } else {
      segment.push(child)
    }
  }
  if segment.len() > 0 {
    joined-children.push(_algo-join-children(segment))
  }

  let text-and-breaks = joined-children.filter(
    elem => elem != [ ] and elem != parbreak(),
  )

  let lines = ()
  let line-parts = []
  let num-linebreaks = 0
  for elem in text-and-breaks {
    if elem == linebreak() {
      if line-parts != [] {
        lines.push(line-parts)
        line-parts = []
      }
      num-linebreaks += 1
      if num-linebreaks > 1 {
        lines.push([])
      }
    } else {
      line-parts += elem
      num-linebreaks = 0
    }
  }
  if line-parts != [] {
    lines.push(line-parts)
  }

  lines
}

#let _algo-render-lines(lines, indent-size, line-leading) = {
  stack(
    spacing: line-leading,
    ..lines.map(line => {
      context {
        pad(left: algo-level.get() * indent-size)[#line]
      }
    }),
  )
}

#let algo(
  body,
  indent-size: 1em,
  line-leading: 0.65em,
) = [
  #algo-depth.update(depth => depth + 1)
  #algo-level.update(_ => 0)
  #align(center)[
    #block(
      stroke: 0.75pt,
      inset: (x: 0.6em, y: 0.5em),
      below: 1.65em,
      breakable: false,
      width: auto,
    )[
      #set align(left)
      #set text(size: 9pt)
      #set par(first-line-indent: 0pt, leading: line-leading, spacing: 0pt)
      #_algo-render-lines(_algo-get-lines(body), indent-size, line-leading)
    ]
  ]
  #algo-depth.update(depth => depth - 1)
]

#let ul(body) = underline(body)
#let sc(body) = smallcaps(body)

#let var(name) = $italic(#name)$

#let hint(body) = emph([\[Hint: #body\]])

#let practice = block(below: 1.15em)[
  #text(fill: pine-green)[#imp[#ul[Practice only. Do not submit solutions.]]]
]

#let comment(body) = text(
  font: "Noto Sans",
  style: "italic",
  fill: brick-red,
  [⟪#body⟫],
)

// Math-mode function names: #let flipodds = func("flipodds"), then flipodds(w) in math.
// For the bare name, use flipodds() (e.g. #def flipodds()).
#let func(name) = {
  let glyph = math.italic(name)
  (..args, body: none) => {
    if body != none and body != [] {
      $italic(#name)(#body)$
    } else if args.pos().len() > 0 {
      $italic(#name)(#args.pos().first())$
    } else {
      glyph
    }
  }
}

// Zero-width gap for math: e.g. $not #zw italic("me")$ or $#zw^c$
#let zw = h(0pt)

#let def = text("def.")
#let ih = text(strong("ind. hypo."))

// LaTeX \Sym{...}: red Hack-font binary symbols/strings.
// Use as #sym[0], #sym[10010], or inside math: $#sym[10010]$.
#let sym(body) = text(font: "Hack", size: 0.9em, fill: brick-red, body)

// Binary alphabet {0, 1} and {0, 1}* (for math mode).
#let bit = ${#sym[0], #sym[1]}$
#let bits = ${#sym[0], #sym[1]}^*$
