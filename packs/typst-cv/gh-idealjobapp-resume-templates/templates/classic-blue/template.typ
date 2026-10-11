// Classic Blue: photo, contact and languages in a left column, the rest on
// the right. Ported from IdealJob's original default template.
#import "/lib/idealjob.typ": *

#let cv = load-cv()

#set page(paper: "a4", margin: (x: 10mm, y: 10mm))
#set text(font: "DejaVu Sans", size: 9.5pt, fill: rgb("#1f2937"))
#set par(leading: 0.62em, spacing: 0.72em)

#let blue = rgb("#2347ff")
#let muted = rgb("#6b7280")
#let rule = rgb("#e5e7eb")
#let body-grey = rgb("#4b5563")
#let heading-ink = rgb("#111827")

#let section-title(body) = {
  v(6pt)
  text(size: 10pt, weight: "bold", fill: blue, tracking: 0.7pt, upper(body))
  line(length: 100%, stroke: 0.7pt + blue)
  v(3pt)
}

#let pill(body) = box(
  inset: (x: 6pt, y: 3pt),
  radius: 8pt,
  fill: rgb("#eef2ff"),
  stroke: 0.4pt + rgb("#dbeafe"),
  text(size: 8.3pt, fill: blue, body),
)

#let dates-line(item) = {
  let dates = date-range(item)
  if dates != "" { linebreak(); text(size: 8pt, fill: muted, dates) }
}

#let achievement-list(position, size) = {
  let lines = achievements(position)
  if lines.len() > 0 {
    hl-block(position.at("highlights_highlight", default: false) == true,
      text(size: size, fill: body-grey, list(..lines)))
  }
}

// ── Left column ─────────────────────────────────────────────────────────

#let sidebar = block(width: 100%)[
  #align(center)[
    #photo(cv, stroke: 0.8pt + rule)
    #v(5pt)
    #text(size: 15pt, weight: "bold", fill: heading-ink, first-present(cv.name, "IdealJob"))
    #if cv.headline != "" [
      #v(2pt)
      #text(size: 9pt, fill: muted, hl(changed(cv, "headline"), cv.headline))
    ]
  ]

  #line(length: 100%, stroke: 0.6pt + rule)
  #v(5pt)
  #text(size: 10pt, weight: "bold", fill: blue)[CONTACT]
  #for c in contacts(cv) [
    #v(3pt)
    #grid(columns: (10pt, 1fr), gutter: 4pt, align: horizon,
      icon(c.kind), text(size: 8.5pt, fill: muted, c.value))
  ]

  #let langs = languages(cv)
  #if langs.len() > 0 [
    #v(10pt)
    #line(length: 100%, stroke: 0.6pt + rule)
    #v(6pt)
    #text(size: 10pt, weight: "bold", fill: blue)[LANGUAGES]
    #for l in langs [
      #v(4pt)
      #text(size: 8.8pt, weight: "semibold", clean(l.name))
      #if present(l.at("proficiency", default: none)) {
        text(size: 7.5pt, fill: muted, clean(l.proficiency))
      }
    ]
  ]
]

// ── Right column ────────────────────────────────────────────────────────

#let main = {
  if cv.summary != "" {
    section-title[Summary]
    text(size: 9.2pt, hl(changed(cv, "summary"), cv.summary))
  }

  let groups = experience-groups(cv)
  if groups.len() > 0 {
    section-title[Experience]
    for group in groups {
      block(breakable: false, below: 6pt)[
        #text(size: 9.8pt, weight: "bold", fill: heading-ink, group.organization)
        #v(3pt)
        #for position in group.positions [
          #grid(columns: (7pt, 1fr), gutter: 5pt,
            circle(radius: 2pt, fill: blue),
            [
              #text(size: 9pt, weight: "semibold", clean(position.position))
              #dates-line(position)
              #if present(position.at("description", default: none)) [
                \ #text(size: 8.5pt, fill: body-grey,
                  hl(position.at("highlight", default: false) == true, clean(position.description)))
              ]
              #achievement-list(position, 8.5pt)
            ],
          )
          #v(3pt)
        ]
      ]
    }
  }

  let eds = educations(cv)
  if eds.len() > 0 {
    section-title[Education]
    for e in eds {
      block(breakable: false)[
        #text(size: 9.8pt, weight: "bold", fill: heading-ink, clean(e.at("institution", default: none)))
        #if present(e.at("course", default: none)) [\ #text(size: 9pt, fill: blue, clean(e.course))]
        #dates-line(e)
        #let details = education-details(e)
        #if details != "" [\ #text(size: 8.3pt, fill: body-grey, details)]
      ]
    }
  }

  let projs = projects(cv)
  if projs.len() > 0 {
    section-title[Projects]
    for p in projs {
      block(breakable: false)[
        #text(size: 9.8pt, weight: "bold", fill: heading-ink, clean(p.name))
        #dates-line(p)
        #if present(p.at("description", default: none)) [\ #text(size: 8.8pt, clean(p.description))]
      ]
    }
  }

  let certs = certifications(cv)
  if certs.len() > 0 {
    section-title[Certifications]
    for c in certs [
      #text(size: 9pt, weight: "semibold", clean(c.name))
      #if present(c.at("issuer", default: none)) { text(size: 8.5pt, fill: muted, clean(c.issuer)) }
      #if present(c.at("date", default: none)) { text(size: 8pt, fill: muted, clean(c.date)) }
      #v(2pt)
    ]
  }

  let vols = volunteerings(cv)
  if vols.len() > 0 {
    section-title[Volunteering]
    for vol in vols [
      #text(size: 9pt, weight: "semibold", clean(vol.at("position", default: none)))
      #if present(vol.at("institution", default: none)) { text(size: 8.5pt, fill: muted, clean(vol.institution)) }
      #let dates = date-range(vol)
      #if dates != "" { text(size: 8pt, fill: muted, dates) }
      #v(3pt)
    ]
  }

  let sk = skills(cv)
  if sk.len() > 0 {
    section-title[Skills]
    hl-block(changed(cv, "skills"),
      grid(columns: 3, gutter: 5pt, row-gutter: 5pt, ..sk.map(s => pill(s))))
  }
}

#grid(columns: (31%, 1fr), gutter: 12pt, sidebar, main)
