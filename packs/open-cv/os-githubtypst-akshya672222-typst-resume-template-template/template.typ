#let contact(text: "", link: none, icon: none) = {
  (text: text, link: link, icon: icon)
}

#let subSection(title: "", titleEnd: none, subTitle: none, subTitleEnd: none, content: []) = {
  (title: title, titleEnd: titleEnd, subTitle: subTitle, subTitleEnd: subTitleEnd, content: content)
}

#let section(title: "", content: subSection()) = {
  (title: title, content: content)
}

#let project(
  theme: rgb("#4273B0"),
  accent: rgb("#2D5F8A"),
  name: "",
  email: none,
  title: none,
  summary: none,
  contact: ((text: [], link: "")),
  skills: none,
  main: (
    (title: "", content: [])
  ),
  sidebar: (),
  body) = {

  // --- Style Definitions ---

  let backgroundTitle(content) = {
    align(center, box(
      fill: theme,
      text(white, size: 1.05em, weight: "bold", upper(content)),
      width: 1fr,
      inset: (x: 0.3em, y: 0.2em),
      radius: 2pt,
    ))
  }

  let secondaryTitle(content) = {
    text(weight: "bold", size: 1.0em, upper(content))
  }

  let italicColorTitle(content) = {
    text(weight: "bold", style: "italic", size: 0.95em, theme, content)
  }

  // --- Skill chip ---
  let skillChip(content) = {
    box(
      fill: theme.lighten(88%),
      stroke: 0.4pt + theme.lighten(50%),
      radius: 3pt,
      inset: (x: 3.5pt, y: 1.2pt),
      text(size: 0.73em, weight: "medium", theme.darken(20%), content)
    )
  }

  // --- Skill category with label ---
  let skillCategory(label, items) = {
    text(weight: "bold", size: 0.78em, theme, upper(label) + ": ")
    items.map(s => skillChip(s)).join(h(2pt))
  }

  // --- Header ---
  let formattedName = block(
    above: 0pt,
    below: 3pt,
    text(2.2em, weight: "bold", theme, upper(name))
  )

  let contactLine = contact.map(c => {
    let display = if c.icon != none {
      c.icon + " " + c.text
    } else {
      c.text
    }
    if c.link == none [
      #text(size: 0.85em, display)
    ] else [
      #link(c.link, text(size: 0.85em, theme, display))
    ]
  }).join([ #h(2pt) #text(theme.lighten(30%), "|") #h(2pt) ])

  align(center)[
    #formattedName
    #contactLine
  ]

  // --- Summary ---
  if summary != none {
    v(6pt)
    block(
      width: 100%,
      inset: (x: 6pt, y: 6pt),
      stroke: (left: 2.5pt + theme),
      fill: theme.lighten(95%),
      radius: (right: 3pt),
      text(size: 0.84em, summary)
    )
  }

  // --- Skills Section ---
  if skills != none {
    v(2pt)
    backgroundTitle("Skills")
    v(0pt)
    block(
      width: 100%,
      inset: (x: 2pt, y: 0pt),
      {
        for (label, items) in skills {
          skillCategory(label, items)
          v(0pt)
        }
      }
    )
  }

  set par(justify: true)

  // --- Content Parsing ---
  let createLeftRight(left: [], right: none) = {
    if (right == none) {
      align(start, text(left))
    } else {
      grid(
        columns: (1fr, auto),
        align(start, text(left)),
        align(end, right),
      )
    }
  }

  let parseSubSections(subSections) = {
    subSections.map(s => {
      [
        #createLeftRight(
          left: secondaryTitle(s.title),
          right: if s.titleEnd != none {
            italicColorTitle(s.titleEnd)
          }
        )
        #if s.subTitle != none or s.subTitleEnd != none [
          #v(-0.5pt)
          #createLeftRight(
            left: italicColorTitle(s.subTitle),
            right: s.subTitleEnd
          )
        ]
        #s.content
      ]
    }).join()
  }

  let parseSection(section) = {
    section.map(m => {
      [
        #v(5pt)
        #backgroundTitle(m.title)
        #parseSubSections(m.content)
      ]
    }).join()
  }

  let mainSection = parseSection(main)
  let sidebarSection = parseSection(sidebar)

  mainSection
}
