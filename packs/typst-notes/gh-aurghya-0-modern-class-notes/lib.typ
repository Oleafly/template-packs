// modern-class-notes
// A modern, publication-grade Typst template & callout suite for university class notes.

// Counters
#let lecture-counter = counter("lecture-counter")
#let theorem-counter = counter("theorem-counter")
#let definition-counter = counter("definition-counter")
#let example-counter = counter("example-counter")
#let exercise-counter = counter("exercise-counter")

// Global configuration state
#let _class-notes-state = state("class-notes-state", (
  mode: "student",
  accent-color: rgb("#1d4ed8"),
  course-code: ""
))

// Base Callout Box Component
#let callout-box(
  title: none,
  icon: none,
  accent: rgb("#1d4ed8"),
  bg-color: none,
  body
) = {
  let bg = if bg-color != none { bg-color } else { accent.lighten(92%) }

  block(
    width: 100%,
    stroke: (left: 3.5pt + accent, rest: 0.5pt + accent.lighten(70%)),
    fill: bg,
    radius: (right: 4pt),
    inset: (x: 12pt, y: 10pt),
    above: 0.8em,
    below: 0.8em,
    [
      #if title != none or icon != none [
        #block(below: 0.6em)[
          #text(weight: "bold", fill: accent.darken(25%))[
            #if icon != none [ #icon #h(4pt) ]
            #title
          ]
        ]
      ]
      #body
    ]
  )
}

// Environments / Callouts
#let definition(title: none, body) = {
  definition-counter.step()
  context {
    let num = definition-counter.get().first()
    let display-title = [Definition #num] + if title != none [ (#title)] else []
    callout-box(
      title: display-title,
      icon: "📐",
      accent: rgb("#0284c7"), // Sky Blue
      body
    )
  }
}

#let theorem(title: none, body) = {
  theorem-counter.step()
  context {
    let num = theorem-counter.get().first()
    let display-title = [Theorem #num] + if title != none [ (#title)] else []
    callout-box(
      title: display-title,
      icon: "🏛️",
      accent: rgb("#4f46e5"), // Indigo
      body
    )
  }
}

#let lemma(title: none, body) = {
  callout-box(
    title: [Lemma] + if title != none [ (#title)] else [],
    icon: "🧩",
    accent: rgb("#6366f1"),
    body
  )
}

#let corollary(title: none, body) = {
  callout-box(
    title: [Corollary] + if title != none [ (#title)] else [],
    icon: "🔗",
    accent: rgb("#7c3aed"),
    body
  )
}

#let proof(title: "Proof", body) = {
  block(
    width: 100%,
    above: 0.8em,
    below: 0.8em,
    inset: (left: 8pt),
    stroke: (left: 1.5pt + rgb("#94a3b8")),
    [
      #text(style: "italic", weight: "medium", fill: rgb("#475569"))[#title:]
      #v(2pt)
      #body
      #align(right)[#text(fill: rgb("#64748b"))[$square.square$]]
    ]
  )
}

#let example(title: none, body) = {
  example-counter.step()
  context {
    let num = example-counter.get().first()
    let display-title = [Example #num] + if title != none [ (#title)] else []
    callout-box(
      title: display-title,
      icon: "🔍",
      accent: rgb("#059669"), // Emerald
      body
    )
  }
}

#let exercise(title: none, solution: none, body) = {
  exercise-counter.step()
  context {
    let num = exercise-counter.get().first()
    let display-title = [Exercise #num] + if title != none [ (#title)] else []
    let state-val = _class-notes-state.get()
    let current-mode = state-val.at("mode", default: "student")

    callout-box(
      title: display-title,
      icon: "✏️",
      accent: rgb("#d97706"), // Amber
      [
        #body
        #if solution != none [
          #v(6pt)
          #if current-mode == "instructor" [
            #block(
              width: 100%,
              fill: rgb("#fef3c7"),
              stroke: 0.5pt + rgb("#f59e0b"),
              inset: 8pt,
              radius: 3pt,
              [
                #text(weight: "bold", fill: rgb("#b45309"))[Instructor Solution:] \
                #solution
              ]
            )
          ] else [
            #block(
              width: 100%,
              fill: rgb("#f8fafc"),
              stroke: (dash: "dashed", paint: rgb("#cbd5e1"), thickness: 0.8pt),
              inset: 10pt,
              radius: 3pt,
              align(center)[
                #text(style: "italic", fill: rgb("#94a3b8"))[Solution space / Refer to course portal]
              ]
            )
          ]
        ]
      ]
    )
  }
}

#let note(title: "Note", body) = {
  callout-box(
    title: title,
    icon: "📌",
    accent: rgb("#2563eb"),
    body
  )
}

#let important(title: "Important", body) = {
  callout-box(
    title: title,
    icon: "🌟",
    accent: rgb("#ea580c"), // Orange
    body
  )
}

#let warning(title: "Warning", body) = {
  callout-box(
    title: title,
    icon: "⚠️",
    accent: rgb("#dc2626"), // Red
    body
  )
}

#let tip(title: "Tip", body) = {
  callout-box(
    title: title,
    icon: "💡",
    accent: rgb("#16a34a"), // Green
    body
  )
}

#let instructor-note(body) = {
  context {
    let state-val = _class-notes-state.get()
    if state-val.at("mode", default: "student") == "instructor" {
      callout-box(
        title: "Teaching Note (Instructor Only)",
        icon: "🎓",
        accent: rgb("#9333ea"), // Purple
        bg-color: rgb("#faf5ff"),
        body
      )
    }
  }
}

// Lecture Header Helper
#let lecture(
  number: auto,
  title: "",
  date: none,
  topics: ()
) = {
  lecture-counter.step()
  context {
    let lec-num = if number == auto { lecture-counter.get().first() } else { number }
    let accent = _class-notes-state.get().at("accent-color", default: rgb("#1d4ed8"))
    
    v(1.2em)
    block(
      width: 100%,
      fill: accent.lighten(94%),
      stroke: (bottom: 2pt + accent),
      inset: (x: 12pt, y: 10pt),
      radius: (top: 4pt),
      [
        #grid(
          columns: (1fr, auto),
          align: (left + horizon, right + horizon),
          [
            #text(size: 0.85em, weight: "bold", fill: accent)[LECTURE #lec-num]
            #v(-2pt)
            #text(size: 1.35em, weight: "bold", fill: rgb("#0f172a"))[#title]
          ],
          [
            #if date != none [
              #rect(
                fill: accent,
                radius: 12pt,
                inset: (x: 10pt, y: 4pt),
                text(fill: white, size: 0.8em, weight: "medium")[#date]
              )
            ]
          ]
        )
        #if topics.len() > 0 [
          #v(4pt)
          #text(size: 0.8em, fill: rgb("#475569"))[
            #text(weight: "bold")[Topics:] #topics.join(" • ")
          ]
        ]
      ]
    )
    v(0.6em)
  }
}

// Learning Objectives Box
#let learning-objectives(title: "Learning Objectives", items) = {
  callout-box(
    title: title,
    icon: "🎯",
    accent: rgb("#0d9488"), // Teal
    [
      #list(
        ..items.map(it => [ #it ])
      )
    ]
  )
}

// Key Terms List/Grid Box
#let key-terms(terms) = {
  callout-box(
    title: "Key Concepts & Vocabulary",
    icon: "🗝️",
    accent: rgb("#475569"),
    [
      #grid(
        columns: (auto, 1fr),
        column-gutter: 12pt,
        row-gutter: 8pt,
        ..terms.pairs().map(((term, def)) => (
          rect(
            fill: rgb("#f1f5f9"),
            radius: 3pt,
            inset: (x: 6pt, y: 3pt),
            text(weight: "bold", fill: rgb("#1e293b"), size: 0.9em)[#term]
          ),
          text(size: 0.95em, fill: rgb("#334155"))[#def]
        )).flatten()
      )
    ]
  )
}

// Main Template Function
#let class-notes(
  title: "Class Notes",
  subtitle: none,
  course: "COURSE 101: Introduction to Subject",
  course-code: "CS 101",
  semester: "Fall 2026",
  university: "Department of Computer Science",
  author: "Prof. Jane Doe",
  instructor-email: none,
  office-hours: none,
  date: datetime.today().display("[Month repr:long] [Day], [Year]"),
  accent-color: rgb("#1d4ed8"),
  mode: "student", // "student" or "instructor"
  paper: "a4",
  font-body: "Times New Roman",
  font-header: "Times New Roman",
  show-outline: true,
  show-title-banner: true,
  body
) = {
  // Update state
  _class-notes-state.update((
    mode: mode,
    accent-color: accent-color,
    course-code: course-code
  ))

  // Page setup
  set page(
    paper: paper,
    margin: (top: 2.5cm, bottom: 2.5cm, x: 2.2cm),
    header: context {
      let page-num = counter(page).get().first()
      if page-num > 1 [
        #grid(
          columns: (1fr, auto),
          align: (left, right),
          text(size: 0.85em, fill: rgb("#64748b"))[
            #text(weight: "bold", fill: accent-color)[#course-code] #h(4pt) | #h(4pt) #title
          ],
          text(size: 0.85em, fill: rgb("#64748b"))[#semester]
        )
        #v(-4pt)
        #line(length: 100%, stroke: 0.5pt + rgb("#e2e8f0"))
      ]
    },
    footer: context {
      let page-num = counter(page).get().first()
      let total-pages = counter(page).final().first()
      grid(
        columns: (1fr, auto),
        align: (left, right),
        text(size: 0.85em, fill: rgb("#94a3b8"))[
          #university #if mode == "instructor" [ #h(6pt) • #text(fill: rgb("#9333ea"), weight: "bold")[INSTRUCTOR EDITION] ]
        ],
        text(size: 0.85em, fill: rgb("#64748b"), weight: "medium")[
          Page #page-num of #total-pages
        ]
      )
    }
  )

  // Typography rules
  set text(
    font: font-body,
    size: 10.5pt,
    fill: rgb("#1e293b"),
    lang: "en"
  )
  set par(justify: true, leading: 0.65em)

  // Heading Styling
  show heading: it => block(below: 0.8em, above: 1.2em)[
    #set text(font: font-header)
    #if it.level == 1 [
      #v(0.5em)
      #rect(
        fill: accent-color,
        width: 100%,
        radius: 3pt,
        inset: (x: 10pt, y: 8pt),
        text(fill: white, size: 1.25em, weight: "bold")[#it.body]
      )
    ] else if it.level == 2 [
      #text(fill: accent-color.darken(15%), size: 1.15em, weight: "bold")[
        #it.body
      ]
      #v(-4pt)
      #line(length: 100%, stroke: 1pt + accent-color.lighten(60%))
    ] else if it.level == 3 [
      #text(fill: rgb("#334155"), size: 1.05em, weight: "bold")[
        #it.body
      ]
    ] else [
      #text(fill: rgb("#475569"), weight: "bold")[
        #it.body
      ]
    ]
  ]

  // Code Block Styling
  show raw.where(block: true): code-block => block(
    width: 100%,
    fill: rgb("#f8fafc"),
    stroke: 0.5pt + rgb("#e2e8f0"),
    inset: 10pt,
    radius: 4pt,
    above: 0.8em,
    below: 0.8em,
    text(font: ("Consolas", "Courier New"), size: 0.9em)[
      #code-block
    ]
  )

  // Inline Code Styling
  show raw.where(block: false): code-inline => box(
    fill: rgb("#f1f5f9"),
    inset: (x: 3pt, y: 1pt),
    outset: (y: 1.5pt),
    radius: 2pt,
    text(font: ("Consolas", "Courier New"), size: 0.88em, fill: rgb("#0f172a"))[#code-inline]
  )

  // Title Banner / Cover Block
  if show-title-banner [
    #block(
      width: 100%,
      fill: rgb("#f8fafc"),
      stroke: (left: 4pt + accent-color, rest: 1pt + rgb("#e2e8f0")),
      inset: 16pt,
      radius: (right: 6pt),
      below: 1.5em,
      [
        #grid(
          columns: (1fr, auto),
          align: (left, right + top),
          [
            #text(size: 0.9em, weight: "bold", fill: accent-color)[#upper(course)]
            #v(2pt)
            #text(size: 1.8em, weight: "bold", fill: rgb("#0f172a"))[#title]
            #if subtitle != none [
              #v(-2pt)
              #text(size: 1.1em, style: "italic", fill: rgb("#475569"))[#subtitle]
            ]
          ],
          [
            #rect(
              fill: accent-color.lighten(90%),
              stroke: 0.5pt + accent-color.lighten(40%),
              radius: 4pt,
              inset: (x: 8pt, y: 5pt),
              text(size: 0.85em, weight: "bold", fill: accent-color.darken(20%))[#semester]
            )
          ]
        )
        #v(10pt)
        #line(length: 100%, stroke: 0.5pt + rgb("#cbd5e1"))
        #v(8pt)
        #grid(
          columns: (1fr, 1fr, 1fr),
          align: (left, center, right),
          [
            #text(size: 0.85em, fill: rgb("#64748b"))[Instructor:] \
            #text(size: 0.9em, weight: "medium", fill: rgb("#1e293b"))[#author]
            #if instructor-email != none [ #v(-2pt) #text(size: 0.8em, fill: accent-color)[#instructor-email] ]
          ],
          [
            #text(size: 0.85em, fill: rgb("#64748b"))[Institution:] \
            #text(size: 0.9em, weight: "medium", fill: rgb("#1e293b"))[#university]
          ],
          [
            #text(size: 0.85em, fill: rgb("#64748b"))[Last Updated:] \
            #text(size: 0.9em, weight: "medium", fill: rgb("#1e293b"))[#date]
          ]
        )
        #if mode == "instructor" [
          #v(8pt)
          #align(center)[
            #rect(
              fill: rgb("#fae8ff"),
              stroke: 1pt + rgb("#d8b4fe"),
              radius: 4pt,
              inset: (x: 12pt, y: 4pt),
              text(weight: "bold", fill: rgb("#7e22ce"), size: 0.85em)[
                🔒 INSTRUCTOR EDITION — Includes Solutions & Teaching Notes
              ]
            )
          ]
        ]
      ]
    )
  ]

  // Outline / Table of Contents
  if show-outline [
    #block(
      width: 100%,
      fill: rgb("#ffffff"),
      stroke: 0.5pt + rgb("#cbd5e1"),
      inset: 12pt,
      radius: 4pt,
      below: 1.5em,
      [
        #text(size: 1.1em, weight: "bold", fill: accent-color)[Contents & Roadmap]
        #v(6pt)
        #outline(
          title: none,
          indent: 1.5em
        )
      ]
    )
  ]

  // Body content
  body
}
