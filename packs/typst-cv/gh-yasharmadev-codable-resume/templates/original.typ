// =============================================================================
// Original (Teal Classic) — the initial design, kept as a selectable variant.
// Compile: typst compile --root . templates/original.typ resume-original.pdf
// Content is shared from content/data.typ; only layout/styling lives here.
// =============================================================================

#import "/content/data.typ": *

// --- Design system (colors, spacing) ---
#let accent = rgb("#0d9488")
#let heading-fill = rgb("#0f172a")
#let body-fill = rgb("#334155")
#let muted-fill = rgb("#64748b")
#let rule-stroke = rgb("#e2e8f0")
#let section-header-bg = rgb("#f1f5f9")
#let section-gap = 0.95em         // space above each section heading
#let section-content-top = 0.68em // space between the separator line and content
#let job-gap = 1.15em             // space between roles
#let bullet-gap = 0.62em          // space between bullets (must exceed line leading)
#let title-bullets-gap = 0.68em   // space between a role's title and its bullets
#let edu-gap = 0.72em             // space between education entries

// --- Page & base typography ---
#set page(
  paper: "us-letter",
  margin: (top: 0.55in, bottom: 0.55in, left: 0.6in, right: 0.6in),
  fill: white,
)
#set text(size: 10.5pt, fill: body-fill)
#set par(justify: false, leading: 0.58em)

// Section headings: light bar + bold title; thin rule under header; clear separation from content
#show heading.where(level: 1): it => {
  v(section-gap, weak: true)
  block(
    fill: section-header-bg,
    inset: (left: 0.6em, right: 0.6em, top: 0.3em, bottom: 0.3em),
    radius: 3pt,
    stroke: (left: 3pt + accent),
    below: 0.14em,
  )[
    #set text(size: 11pt, weight: "bold", fill: heading-fill)
    #it.body
  ]
  line(length: 100%, stroke: 0.5pt + rule-stroke)
  v(section-content-top, weak: true)
}

// Skills block (built from the shared category arrays in content/data.typ)
#let skills-content = [
  #text(weight: "bold", fill: heading-fill)[Languages] #text(fill: body-fill)[#skills-languages.join(" · ")]
  #v(0.25em)
  #text(weight: "bold", fill: heading-fill)[Databases] #text(fill: body-fill)[#skills-databases.join(" · ")]
  #v(0.25em)
  #text(weight: "bold", fill: heading-fill)[Frameworks & Libraries] #text(fill: body-fill)[#skills-frameworks.join(" · ")]
  #v(0.25em)
  #text(weight: "bold", fill: heading-fill)[Cloud & DevOps] #text(fill: body-fill)[#skills-cloud.join(" · ")]
  #v(0.25em)
  #text(weight: "bold", fill: heading-fill)[Methodologies & Tools] #text(fill: body-fill)[#skills-methods.join(" · ")]
  #v(0.25em)
  #text(weight: "bold", fill: heading-fill)[Testing & CI/CD] #text(fill: body-fill)[#skills-testing.join(" · ")]
]

// =============================================================================
// Resume body
// =============================================================================

// Circular profile photo (clipped to a circle).
#let photo-path = "/" + photo-file
#let photo-content = box(
  width: 100%, height: 100%,
  radius: 50%, clip: true,
)[
  #image(photo-path, width: 100%, height: 100%, fit: "cover")
]

#let contact-line = text(size: 9.5pt, fill: body-fill)[
  #email #h(0.8em) #text(fill: rule-stroke)[|] #h(0.8em) #phone #h(0.6em) / #h(0.6em) #phone-alt #h(0.8em) #text(fill: rule-stroke)[|] #h(0.8em) #website #h(0.8em) #text(fill: rule-stroke)[|] #h(0.8em) #location
]

#let header-text-block(align-side) = {
  set align(align-side)
  text(size: 26pt, weight: "bold", fill: heading-fill)[#name]
  v(0.2em)
  text(size: 11pt, fill: accent)[#tagline]
  v(0.15em)
  text(size: 9.5pt, fill: muted-fill)[#years-note]
  v(0.45em)
  contact-line
}

#block(width: 100%)[
  #if show-photo [
    #grid(
      columns: (1.05in, 1fr),
      column-gutter: 1em,
      align: (left + horizon, left + horizon),
      box(width: 1.05in, height: 1.05in)[#photo-content],
      header-text-block(left),
    )
  ] else [
    #align(center)[#header-text-block(center)]
  ]
  #v(0.3em)
  #line(length: 100%, stroke: 0.75pt + rule-stroke)
]

= Professional Summary

#block[#text(fill: body-fill)[#summary]]

= Experience

#for (i, job) in experience.enumerate() [
  #block(above: if i == 0 { 0em } else { job-gap }, breakable: false)[
    #grid(
      columns: (1fr, auto),
      gutter: 1em,
      align: (left + horizon, right + horizon),
      [#text(weight: "bold", fill: heading-fill)[#job.title] #h(0.4em) #text(fill: muted-fill)[#job.company]],
      [#text(size: 9.5pt, fill: muted-fill)[#job.dates]],
    )
    #for (j, bullet) in job.bullets.enumerate() [
      #block(above: if j == 0 { title-bullets-gap } else { bullet-gap }, inset: (left: 1em))[
        #grid(
          columns: (auto, 1fr),
          gutter: 0.45em,
          align: (left + top, left + top),
          text(fill: accent)[#sym.triangle.filled.small.r],
          bullet,
        )
      ]
    ]
  ]
]

= Education

#for (k, edu) in education.enumerate() [
  #block(above: if k == 0 { 0em } else { edu-gap })[
    #grid(
      columns: (1fr, auto),
      gutter: 1em,
      align: (left + horizon, right + horizon),
      [#text(weight: "bold", fill: heading-fill)[#edu.degree], #h(0.2em) #text(fill: body-fill)[#edu.institution]],
      [#text(size: 9.5pt, fill: muted-fill)[#edu.dates#if edu.note != none [ #h(0.35em) #text(fill: rule-stroke)[|] #h(0.35em) #edu.note]]],
    )
  ]
]

= #skills-heading

#block(inset: (left: 0.5em), fill: rgb("#f8fafc"), radius: 4pt)[
  #pad(left: 0.6em, right: 0.6em, top: 0.45em, bottom: 0.45em)[
    #skills-content
  ]
]

#if projects.len() > 0 [
  = Selected Talks & Projects

  #for proj in projects [
    #block(above: 0.3em)[
      #link(proj.link)[#text(weight: "bold", fill: accent)[#proj.name]] — #text(fill: body-fill)[#proj.description]
    ]
  ]
]
