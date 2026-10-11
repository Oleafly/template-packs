// ============================================================
// Template CV — legge data/cv.yaml e la variante scelta.
// Uso:  typst compile --root . --font-path fonts \
//         --input variant=data-it templates/cv.typ build/cv-data-it.pdf
// Solo layout: nessun contenuto qui dentro.
// ============================================================

#import "lib.typ": *

// ---------- palette e misure ----------
#let accent = rgb("#1f4e79")
#let muted = rgb("#5a5a5a")
#let rule-c = rgb("#c9d3dd")


#let section(title) = {
  v(6pt)
  text(size: 10.5pt, weight: "bold", fill: accent, tracking: 0.6pt, upper(title))
  v(-6pt)
  line(length: 100%, stroke: 0.6pt + rule-c)
  v(1pt)
}

#let bullets(items) = {
  let bs = items.filter(included).map(b => show-t(b)).filter(x => x != none)
  if bs.len() > 0 {
    set list(indent: 2pt, body-indent: 6pt, spacing: 3.5pt, marker: text(fill: accent, "•"))
    list(..bs)
  }
}

#let entry(title, sub, dates, body: none) = {
  block(breakable: false, below: 8pt)[
    #grid(columns: (1fr, auto), gutter: 6pt,
      text(weight: "semibold", size: 10pt, title),
      text(size: 9pt, fill: muted, dates))
    #if sub != none { v(-4pt); text(size: 9.2pt, fill: muted, sub) }
    #if body != none { v(-1pt); body }
  ]
}

// ---------- pagina ----------
#set document(title: cv.personal.name + " — CV", author: cv.personal.name)
#set page(paper: "a4", margin: (x: 1.6cm, top: 1.1cm, bottom: 1.0cm))
#set text(font: ("Inter", "Helvetica Neue", "Libertinus Serif"), size: 9.3pt, lang: lang, fill: rgb("#1a1a1a"))
#set par(justify: false, leading: 0.55em)

// ---------- intestazione ----------
#{
  text(size: 22pt, weight: "bold", cv.personal.name)
  linebreak()
  v(-2pt)
  text(size: 11.5pt, fill: accent, weight: "medium", headline())
  v(2pt)
  let contacts = (
    t(cv.personal.location),
    cv.personal.at("email", default: none),
    cv.personal.at("phone", default: none),
  ).filter(x => x != none and not is-todo(x))
  let links = cv.personal.at("links", default: ())
    .filter(l => not is-todo(l.url))
    .map(l => link(l.url, l.label))
  text(size: 9pt, fill: muted, (contacts + links).map(x => box(x)).join("  ·  "))
}

// ---------- sezioni ----------
#let render-summary() = {
  let items = cv.summary.filter(included).map(s => show-t(s)).filter(x => x != none)
  if items.len() > 0 { section(L.summary); items.join(parbreak()) }
}

#let render-experience() = {
  let items = experience-items()
  if items.len() == 0 { return }
  section(L.experience)
  let prev = none
  for e in items {
    let org = e.org
    if e.at("show_via", default: false) and e.at("via", default: none) != none {
      org = org + " (" + e.via + ")"
    }
    let sub = if e.org == prev { none } else { org + if e.at("location", default: none) != none { " · " + e.location } }
    entry(show-t(e.role), sub, date-range(e.start, e.end), body: bullets(e.at("bullets", default: ())))
    prev = e.org
  }
}

#let render-education() = {
  let items = cv.education.filter(included)
  if items.len() == 0 { return }
  section(L.education)
  for e in items {
    let dates = if e.at("hide_dates", default: false) { none } else { date-range(e.start, e.end) }
    entry(show-t(e.title), t(e.org), dates, body: bullets(e.at("bullets", default: ())))
  }
}

#let render-skills() = {
  let groups = cv.skills.filter(included)
  if groups.len() == 0 { return }
  section(L.skills)
  grid(columns: (auto, 1fr), column-gutter: 10pt, row-gutter: 4pt,
    ..groups.map(g => (
      text(weight: "semibold", t(g.group)),
      g.items.map(i => t(i)).join("  ·  "),
    )).flatten())
}

#let render-certifications() = {
  let items = cv.at("certifications", default: ()).filter(included)
  if items.len() == 0 { return }
  section(L.certifications)
  for c in items {
    block(below: 4pt, grid(columns: (1fr, auto),
      [#text(weight: "semibold", t(c.title)) #text(fill: muted)[— #show-t(c.org)]],
      text(size: 9pt, fill: muted, show-t(c.year))))
  }
  v(2pt)
}

#let render-languages() = {
  section(L.languages)
  cv.languages.map(l => [#text(weight: "semibold", t(l.name)) — #show-t(l.level)]).join("   ·   ")
}

#let render-interests() = {
  let items = cv.at("interests", default: ())
  if items.len() == 0 { return }
  section(L.interests)
  items.map(i => show-t(i)).filter(x => x != none).join("  ·  ")
}

#let renderers = (
  summary: render-summary, experience: render-experience, education: render-education,
  skills: render-skills, certifications: render-certifications,
  languages: render-languages, interests: render-interests,
)

#for s in variant.sections {
  let f = renderers.at(s, default: none)
  if f != none { f() }
}
