// ─────────────────────────────────────────────
//  Adam's Personal Resume Template · Typst
//  Customizable component-based resume template
// ─────────────────────────────────────────────


// —— Import packages —————————————————————————
#import "@preview/fontawesome:0.6.0": *


// —— Document variables —————————————————————————
#let name = "Your Name"
#let job-titles = ("Title1", "Title 2", "Title 3")
#let phone = "(123) 456-789"
#let location = "Hometown"
#let website = "Website"
#let email = "Email"
#let linkedin = "LinkedIn"
#let github = "Github"

// Custom separator
#let separator = "·"

// Color palette
#let accent  = rgb("#2563eb")
#let body  = rgb("#1a1a1a")
#let muted   = rgb("#5D646F")

// Document spacing
#let line-spacing = 0.5em
#let paragraph-spacing = 1em           // Default is 1em
#set list(indent: 1em)            // Sets indent on bullets


// ── Document metadata ──────────────────────────
#set document(author: name, title: [#name's Resume])

// ── Page & font setup ──────────────────────────
#set page(
  paper: "us-letter",
  margin: (top: 0.5in, bottom: 0.5in, x: 0.5in),
)

// Font
#set text(font: "Spectral", size: 9.5pt, fill: body)

// Document spacing
#set par(leading: line-spacing, spacing: paragraph-spacing)

// ── Document styles ──────────────────────────
// #show link: it => text(it, fill: accent)


// ── Helper components ──────────────────────────
// Section heading with colored rule
#let section(title) = {
  v(0.25em)
  grid(
    columns: (auto, 1fr),
    column-gutter: 0.5em,
    align(horizon, text(weight: "bold", size: 12pt, fill: accent, smallcaps(title))),
    align(horizon, line(length: 100%, stroke: 0.75pt + accent)),
  )
  v(-0.25em)
}

// Contact links
#let contact-link(label, url, icon: none) = box()[#{
  if icon != none {
    fa-icon(icon, size: 0.8em); h(0.2em)
  }
  link(url, label)
}]

// Phone number formatting
#let phone-digits = phone.replace(regex("[^\d+]"), "")

// Project links
#let project-link(label, url, icon: none) = [
  #link(url)[
    #text(weight: "bold", label)
    #if icon != none {
      fa-icon(icon, size: 0.75em)
    }
  ]
]

// Icon links
#let icon-link(icon, url) = (
  link(url)[#fa-icon(icon, size: 0.75em)]
)

// Muted text component
#let muted-text(content) = (
  text(fill: muted, content)
)


// == DOCUMENT START =============================

// ── Header ─────────────────────────────────────
#align(center)[
  #block()[
    // #set par(leading: 0.5em)
    #context text(size: 20pt, weight: "bold", [#document.author.first()]) \
    #text(size: 10.5pt, fill: muted)[#job-titles.join([#h(0.25em) • #h(0.25em)])]
    #linebreak()
    #(
      contact-link(phone, "tel:"+phone-digits, icon: "phone"),
      contact-link(location, "https://maps.apple.com/?q="+location, icon: "location-dot"),
      contact-link(email, "mailto:" + email, icon: "envelope"),
      contact-link(website, "https://" + website, icon: "compass"),
      contact-link(linkedin, "https://linkedin.com/in/" + linkedin, icon: "linkedin"),
      contact-link(github, "https://github.com/" + github, icon: "github")
    ).join(h(0.5em)+separator+h(0.5em),)
  ]
]


// ── Summary ────────────────────────────────────
#section("Summary")
#lorem(30)


// ── Education ──────────────────────────────────
#section("Education")

*University* #separator _Degree_ #h(1fr) Date – Range
- #lorem(5)
*University 2* #separator _Degree_ #h(1fr) Date – Range
- #lorem(10)


// ── Projects ───────────────────────────────────
#section("Projects")

#project-link("Project", "https://github.com", icon: "link") | _Technologies_ #h(1fr) Date – Range
- #lorem(17)
- #lorem(17)

#link("https://github.com")[*Project 1*] | _Technologies_ #h(1fr) Date – Range
- #lorem(17)
- #lorem(17)
- #lorem(17)

#link("https://github.com")[*Project 1*] | _Technologies_ #h(1fr) Date – Range
- #lorem(17)
- #lorem(17)
- #lorem(17)

#link("https://github.com")[*Project 1*] | _Technologies_ #h(1fr) Date – Range
- #lorem(17)
- #lorem(17)
- #lorem(17)


// ── Experience ─────────────────────────────────
#section("Experience")

*Company* #h(1fr) Location \
_Job Title_ #h(1fr) Date – Range
- #lorem(17)
- #lorem(17)
#v(-0.5em)
_Job Title_ #h(1fr) Date – Range
- #lorem(17)
- #lorem(17)

*Job Title* @ _Company_ | Location #h(1fr) Date – Range \
#h(1em) _this is a summary statement_
- #lorem(17)
- #lorem(17)


// ── Skills ─────────────────────────────────────
#section("Skills")

#grid(
  columns: (auto, 1fr),
  column-gutter: 1em,
  row-gutter: 0.4em,
  [*Languages*], [#lorem(10)],
  [*Tools*], [#lorem(10)],
  [*Frameworks*], [#lorem(10)],
)


// ── Certifications & Awards ────────────────────
#section("Certifications & Awards")

#grid(
  columns: (auto, 1fr),
  column-gutter: 1em,
  row-gutter: 0.4em,
  [*Certifications*], [#lorem(10)],
  [*Awards*], [#lorem(10)],
)

