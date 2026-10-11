/*
 * Package Entrypoint
 * Contains resume template and imports all components
 *
 * Compile with local fonts:
 *   typst compile --font-path fonts resume/CV_zh.typ output.pdf
 */

#import "@preview/scienceicons:0.1.0": orcid-icon

// Layout utilities
#import "layout/generic.typ": generic-two-by-two, generic-one-by-two
#import "layout/helpers.typ": dates-helper

// Experience components
#import "experience/edu.typ": edu
#import "experience/work.typ": work
#import "experience/project.typ": project
#import "experience/research-project.typ": research-project

// Achievement components
#import "achievements/article.typ": article, reset-article-counter
#import "achievements/book.typ": book, reset-book-counter
#import "achievements/software.typ": software
#import "achievements/patent.typ": patent
#import "achievements/certificates.typ": certificates
#import "achievements/extracurriculars.typ": extracurriculars
#import "achievements/award.typ": award

// Weight name to numeric value mapping
// Supported weights: 300(light), 400(regular), 500(medium), 600(semibold), 700(bold), 900(heavy)
#let _weight-map = (
  "light": 300,
  "regular": 400,
  "medium": 500,
  "semibold": 600,
  "bold": 700,
  "heavy": 900,
)

// Resolve a weight value from string name (e.g. "semibold") or numeric value (e.g. 600)
#let resolve-weight(w) = {
  if type(w) == str {
    _weight-map.at(lower(w), default: 400)
  } else if type(w) == int {
    w
  } else {
    400
  }
}

#let resume(
  author: "",
  author-position: left,
  personal-info-position: left,
  pronouns: "",
  location: "",
  email: "",
  github: "",
  linkedin: "",
  phone: "",
  personal-site: "",
  orcid: "",
  accent-color: "#000000",
  cjk-font: "Source Han Serif SC",
  en-font: "New Computer Modern",
  paper: "us-letter",
  author-font-size: 20pt,
  font-size: 10pt,
  en-font-weight: "regular",
  cjk-font-weight: "regular",
  name-weight: "bold",
  lang: "en",
  body,
) = {
  let resolved-en-weight = resolve-weight(en-font-weight)
  let resolved-cjk-weight = resolve-weight(cjk-font-weight)
  let resolved-name-weight = resolve-weight(name-weight)

  // Font fallback list: English font first, CJK font as fallback.
  // The `covers` hint tells Typst the English font handles Latin chars in CJK contexts,
  // preventing unnecessary fallback to the CJK font for Latin characters.
  let font = ((name: en-font, covers: "latin-in-cjk"), cjk-font)

  // Sets document metadata
  set document(author: author, title: author)

  // Document-wide formatting, including font and margins
  set text(
    font: font,
    size: font-size,
    weight: resolved-en-weight,
    lang: lang,
    // Disable ligatures so ATS systems do not get confused when parsing fonts.
    ligatures: false,
  )

  // Reccomended to have 0.5in margin on all sides
  set page(
    margin: 0.5in,
    paper: paper,
  )

  // Link styles
  show link: underline


  // Small caps for section titles
  show heading.where(level: 2): it => [
    #pad(top: 0pt, bottom: -10pt, [#smallcaps(it.body)])
    #line(length: 100%, stroke: 1pt)
  ]

  // Accent Color Styling
  show heading: set text(
    fill: rgb(accent-color),
  )

  show link: set text(
    fill: rgb(accent-color),
  )

  // Name keeps its own style (size/weight/font), regardless of CJK body rules.
  show heading.where(level: 1): it => [
    #set align(author-position)
    #set text(
      size: author-font-size,
      weight: resolved-name-weight,
      font: cjk-font,
    )
    #it.body
  ]

  // Level 1 Heading - apply name-weight directly
  [= #text(weight: resolved-name-weight)[#author]]

  // Override weight for CJK content after rendering the name heading,
  // so `name-weight` remains effective for CJK names.
  show regex("[\p{Han}\p{Hiragana}\p{Katakana}\p{Hangul}]"): set text(weight: resolved-cjk-weight)

  // Personal Info Helper
  let contact-item(value, prefix: "", link-type: "") = {
    if value != "" {
      if link-type != "" {
        link(link-type + value)[#(prefix + value)]
      } else {
        value
      }
    }
  }

  // Personal Info
  pad(
    top: 0.25em,
    align(personal-info-position)[
      #{
        let items = (
          contact-item(pronouns),
          contact-item(location),
          contact-item(phone, link-type: "tel:"),
          contact-item(email, link-type: "mailto:"),
          contact-item(github, link-type: "https://"),
          contact-item(linkedin, link-type: "https://"),
          contact-item(personal-site, link-type: "https://"),
          contact-item(orcid, prefix: [#orcid-icon(color: rgb("#AECD54"))orcid.org/], link-type: "https://orcid.org/"),
        )
        items.filter(x => x != none).join("  |  ")
      }
    ],
  )

  // Main body.
  set par(justify: true)

  body
}
