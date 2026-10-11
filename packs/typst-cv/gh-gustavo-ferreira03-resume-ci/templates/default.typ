#import "@preview/fontawesome:0.6.1": fa-icon

#let data = json(bytes(sys.inputs.at("data", default: "{}")))

#let rich(parts) = {
  for part in parts {
    let text = part.at("text", default: "")
    let style = part.at("style", default: "")
    if style == "strong" { strong(text) }
    else if style == "emph" { emph(text) }
    else { text }
  }
}

#let sep() = [#h(0.45em)|#h(0.45em)]
#let icon(name, solid: false) = fa-icon(name, solid: solid, size: 10pt, top-edge: "baseline")

#let contact(items) = {
  let first = true
  for item in items {
    if not first { sep() }
    first = false
    let icon-name = item.at("icon", default: "")
    let href = item.at("href", default: "")
    let label = item.at("text", default: "")
    let visible-label = if href != "" { underline(offset: 4pt, label) } else { label }
    let body = box[
      #if icon-name != "" [#icon(icon-name, solid: item.at("solid", default: false))#h(0.25em)]
      #visible-label
    ]
    if href != "" { link(href)[#body] } else { body }
  }
}

#let maybe-link(url, body) = {
  if url == "" { body } else { link(url)[#body] }
}

#let section(name) = {
  v(3pt)
  text(size: 14pt, weight: "bold")[#name]
  v(2pt)
  line(length: 100%, stroke: 0.4pt)
  v(2pt)
}

#let bullet-list(items) = {
  list(
    tight: false,
    spacing: 4pt,
    body-indent: 0.45em,
    ..items.map(item => [#rich(item)]),
  )
}

#let entry(item) = {
  let title = item.at("title", default: item.at("company", default: item.at("institution", default: ())))
  let subtitle = item.at("subtitle", default: item.at("role", default: item.at("degree", default: ())))
  let period = item.at("period", default: "")
  let url = item.at("url", default: "")
  let domain = item.at("domain", default: "")
  let location = item.at("location", default: ())
  let description = item.at("description", default: ())
  let summary = item.at("summary", default: ())
  let keywords = item.at("keywords", default: ())
  let score = item.at("score", default: ())
  let courses = item.at("courses", default: ())
  let bullets = item.at("bullets", default: ())
  let side = if domain != "" {
    if url != "" { link(url)[#domain] } else { domain }
  } else if location.len() > 0 {
    rich(location)
  } else {
    []
  }

  grid(
    columns: (1fr, auto),
    column-gutter: 0.5em,
    strong(maybe-link(url, rich(title))),
    align(right)[#strong(period)],
  )
  if subtitle.len() > 0 or domain != "" or location.len() > 0 {
    grid(
      columns: (1fr, auto),
      column-gutter: 0.5em,
      emph(rich(subtitle)),
      emph(align(right)[#side]),
    )
  }
  v(4pt)
  if description.len() > 0 [
    #rich(description)
    #v(2pt)
  ]
  if score.len() > 0 [
    #emph("Score: ")#rich(score)
    #v(2pt)
  ]
  if summary.len() > 0 [
    #rich(summary)
    #v(2pt)
  ]
  if keywords.len() > 0 [
    #emph("Keywords: ")#rich(keywords)
    #v(2pt)
  ]
  if courses.len() > 0 [
    #bullet-list(courses)
  ]
  if bullets.len() > 0 [
    #bullet-list(bullets)
  ]
  v(6pt)
}

#let tag-entry(item) = {
  let label = item.at("label", default: ())
  let level = item.at("level", default: ())
  let items = item.at("items", default: ())
  [
    #if label.len() > 0 [#strong(rich(label))]
    #if level.len() > 0 [ (#emph(rich(level)))]
    #if items.len() > 0 [: #rich(items)]
    \
  ]
}

#let reference-entry(item) = {
  let name = item.at("name", default: ())
  let reference = item.at("reference", default: ())
  if name.len() > 0 [
    #strong(rich(name))
    #v(1pt)
  ]
  if reference.len() > 0 [#rich(reference)]
  v(4pt)
}

#let renderers = (
  work: entry,
  volunteer: entry,
  projects: entry,
  awards: entry,
  certificates: entry,
  publications: entry,
  education: entry,
  skills: tag-entry,
  languages: tag-entry,
  interests: tag-entry,
  references: reference-entry,
)

#let render-section(key, title) = {
  if key == "summary" {
    if data.at("summary", default: ()).len() > 0 {
      section(title)
      rich(data.summary)
      v(2pt)
    }
  } else {
    let items = data.at(key, default: ())
    if items.len() > 0 {
      section(title)
      let render = renderers.at(key, default: none)
      if render != none {
        for item in items { render(item) }
      }
    }
  }
}

#let meta = data.at("meta", default: (:))
#set page(width: 210mm, height: auto, margin: (left: 0.7cm, top: 0.5cm, right: 0.7cm, bottom: 0.5cm))
#set text(font: meta.at("font", default: "New Computer Modern"), size: 10pt, fill: rgb("000000"))
#set par(leading: 0.48em, spacing: 0.35em, justify: false)
#show link: set text(fill: rgb("000000"))

#let personal = data.at("personal", default: (:))
#let section-order = meta.at("section_order", default: ())

#align(center)[
  #text(size: 24pt, weight: "bold")[#rich(personal.at("name", default: ()))] \
  #v(8pt)
  #text(size: 12pt)[#rich(personal.at("title", default: ()))] \
  #v(8pt)
  #text(size: 10pt)[#contact(data.at("contact", default: ()))]
]

#v(10pt)

#for sec in section-order [
  #render-section(sec.at("key", default: ""), sec.at("title", default: ""))
]

#context {
  let pos = here().position()
  v(calc.max(0pt, 297mm - 0.5cm - pos.y))
}
