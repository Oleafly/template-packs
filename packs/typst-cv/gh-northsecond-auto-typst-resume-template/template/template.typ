// Typst 0.15.1+. Apply with `#show: resume.with("Your Name", ...)`.
#let resume(
  name,
  lang: "en",
  font: "Libertinus Serif",
  photo: none,
  contacts: (),
  body,
) = {
  set document(
    title: if lang == "zh" { name + "的简历" } else { name + "'s Resume" },
    author: name,
  )
  set page(paper: "a4", margin: (x: 0.9cm, y: 1.3cm))
  set text(font: font, size: 11pt, lang: lang)
  set par(justify: true, leading: 0.65em)
  set list(indent: 0pt, body-indent: 0.8em)
  set heading(numbering: none)
  show title: set text(size: 20pt, weight: "bold")
  show title: set block(above: 0pt, below: 0.5em)
  show heading.where(level: 1): set text(size: 12pt)
  show heading.where(level: 1): set block(
    width: 100%,
    above: 1em,
    below: 0.6em,
    inset: (bottom: 0.25em),
    stroke: (bottom: 0.5pt),
  )

  let header = align(center, {
    set par(justify: false)
    title(name)
    contacts.join(h(0.5em) + pdf.artifact[·] + h(0.5em))
  })
  block(width: 100%, breakable: false, below: 0.5em, {
    if photo == none {
      header
    } else {
      grid(
        // Equal side columns keep the header on the page centerline.
        columns: (25mm, 1fr, 25mm),
        column-gutter: 1em,
        align: (left + horizon, center + horizon, right + horizon),
        [],
        header,
        image(photo, width: 25mm, height: 33mm, fit: "cover", alt: name),
      )
    }
  })
  body
}

// Pass rendered icon content; link destinations and display text stay separate.
#let contact(body, icon: none, dest: none) = {
  if icon != none {
    icon
    h(0.2em)
  }
  if dest == none { body } else { link(dest, body) }
}

// Two rows, in reading order: title / role, then details / date.
#let entry(title, role: none, details: none, date: none) = context block(
  width: 100%,
  breakable: false,
  sticky: true,
  above: 0.65em,
  below: par.leading,
  {
    set par(justify: false)
    grid(
      columns: (3fr, 2fr),
      column-gutter: 1em,
      row-gutter: par.leading,
      align: (left, right),
      strong(title), role,
      ..if details != none or date != none { (details, date) } else { () },
    )
  },
)
