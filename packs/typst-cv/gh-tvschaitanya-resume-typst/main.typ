#import "@preview/basic-resume:0.2.9": *
#import "contact.typ": *
#import "data.typ": *


// ── Section Order ─────────────────────────────────────────────────────────────
// Reorder, comment out, or remove lines to control what appears and where

#let section-order = (
  "summary",
  "skills",
  "experience",
  "projects",
  "education",
  "certifications",
)


// ── Helpers ───────────────────────────────────────────────────────────────────
// Converts "" or none to none so optional fields are cleanly omitted

#let maybe(s) = if s == none or s == "" { none } else { s }


// ── Page & Theme ──────────────────────────────────────────────────────────────

#show: resume.with(
  author:                name,
  location:              maybe(location),
  email:                 maybe(email),
  github:                maybe(github),
  linkedin:              maybe(linkedin),
  phone:                 maybe(phone),
  ..if maybe(personal-site) != none { (personal-site: personal-site) },
  accent-color:          "#000000",
  font:                  "Times New Roman",
  paper:                 "us-letter",
  author-position:       center,
  personal-info-position: center,
)


// ── Section Renderer ──────────────────────────────────────────────────────────
// Renders a single section by name; unknown names are silently ignored

#let render-section(s) = {
  if s == "summary" {
    if summary != "" [
      == Summary
      #summary
    ]

  } else if s == "skills" {
    if skills.len() > 0 [
      == Skills
      #for s in skills [
        - *#s.label*: #s.items
      ]
    ]

  } else if s == "experience" {
    if work-experience.len() > 0 [
      == Experience
      #for w in work-experience [
        #work(
          title:   w.title,
          company: maybe(w.company),
          location: maybe(w.location),
          dates:   dates-helper(start-date: w.start, end-date: w.end),
        )
        #for b in w.bullets [- #eval(b, mode: "markup")]
        #if w.bullets.len() == 0 [ #v(2pt) ]
      ]
    ]

} else if s == "projects" {
  if projects.len() > 0 [
    == Projects
    #for p in projects [
      #project(
        name: maybe(p.role),
        role: strong(p.name),
        ..if maybe(p.url) != none { (url: p.url) },
      )
      #for b in p.bullets [- #eval(b, mode: "markup")]
      #if p.bullets.len() == 0 [ #v(2pt) ]
    ]
  ]

  } else if s == "education" {
    if education.len() > 0 [
      == Education
      #for e in education [
        #edu(
          institution: e.institution,
          location:    maybe(e.location),
          dates:       dates-helper(start-date: e.start, end-date: e.end),
          degree: maybe(eval(e.degree, mode: "markup")),
        )
        #for b in e.bullets [- #eval(b, mode: "markup")]
        #if e.bullets.len() == 0 [ #v(2pt) ]
      ]
    ]

  } else if s == "certifications" {
    if certifications.len() > 0 [
      == Certifications
      #for c in certifications [
        - #c.name
      ]
    ]
  }
}


// ── Render ────────────────────────────────────────────────────────────────────

#for s in section-order {
  render-section(s)
}