#import "theme.typ": *
#import "data.typ": personal, summary, projects, experience, education, certifications, publications, skills
#import "components/header.typ": cv-header
#import "components/section.typ": cv-section
#import "components/entry.typ": cv-entry
#import "components/skill-group.typ": cv-skill-group
#import "components/footer.typ": cv-footer
#import "components/publication.typ": cv-publication

// ── Page ─────────────────────────────────────────────────────────────────────
#set document(title: "CV — " + personal.name)
#set page(
  paper: "a4",
  margin: (x: 2.2cm, top: 2.2cm, bottom: 3cm),
  footer: cv-footer(name: personal.name),
)
#set text(font: font, size: size-body, lang: "en", fill: color-body)
#set par(leading: 0.6em, spacing: 0em)

// ── Layout ───────────────────────────────────────────────────────────────────

#cv-header(..personal)

#{
  set par(leading: 0.4em)
  text(size: size-summary)[#summary]
}
#v(gap-after-summary)

#if projects.len() > 0 [
  #cv-section(title: "Projects")[
    #for p in projects { cv-entry(..p) }
  ]
]

#if experience.len() > 0 [
  #cv-section(title: "Experience")[
    #for e in experience { cv-entry(..e) }
  ]
]

#if education.len() > 0 [
  #cv-section(title: "Education")[
    #for e in education { cv-entry(..e) }
  ]
]

#if publications.len() > 0 [
  #cv-section(title: "Publications")[
    #for p in publications { cv-publication(..p) }
  ]
]

#if certifications.len() > 0 [
  #cv-section(title: "Courses, Training, and Certifications")[
    #for c in certifications { cv-entry(..c) }
  ]
]

#if skills.len() > 0 [
  #cv-section(title: "Skills")[
    #for s in skills { cv-skill-group(..s) }
  ]
]
