#import "@preview/fontawesome:0.6.0": *

// Icon wrapper function
#let icon(name, size: 1em) = {
  let icon-map = (
    // Contact icons
    "envelope": fa-envelope,
    "phone": fa-phone,
    "location-dot": fa-location-dot,
    "globe": fa-globe,
    // Social media icons
    "github": fa-github,
    "linkedin": fa-linkedin,
    "twitter": fa-twitter,
    "instagram": fa-instagram,
    "facebook": fa-facebook,
    // Other common icons
    "calendar": fa-calendar,
    "briefcase": fa-briefcase,
    "graduation-cap": fa-graduation-cap,
    "certificate": fa-certificate,
    "award": fa-award,
    "star": fa-star,
    "check": fa-check,
    "arrow-right": fa-arrow-right,
    "link": fa-external-link,
  )

  if name in icon-map {
    text(size: size, icon-map.at(name)())
  } else {
    // Fallback to generic icon
    text(size: size, fa-circle())
  }
}

// Progress bar for skills
#let skill-bar(level: 5, max: 5, width: 100%, height: 4pt, color: rgb("#1e88e5")) = {
  box(
    width: width,
    height: height,
    stroke: 0.5pt + color,
    radius: height / 2,
    clip: true,
    {
      place(
        box(
          width: width * level / max,
          height: height,
          fill: color,
        ),
      )
    },
  )
}

// Rating display (stars or dots)
#let rating(level: 3, max: 5, style: "stars", filled-color: rgb("#1e88e5"), empty-color: rgb("#e0e0e0")) = {
  let filled-icon = if style == "stars" { fa-star } else { fa-circle }
  let empty-icon = if style == "stars" { fa-star } else { fa-circle }

  let items = ()
  for i in range(max) {
    if i < level {
      items.push(text(fill: filled-color, filled-icon()))
    } else {
      items.push(text(fill: empty-color, empty-icon()))
    }
  }

  items.join(h(0.1em))
}

// Tag/badge component
#let tag(content, color: rgb("#1e88e5"), text-color: white) = {
  box(
    fill: color,
    inset: (x: 0.5em, y: 0.2em),
    radius: 3pt,
    text(fill: text-color, size: 0.9em, weight: "medium", content),
  )
}

// Timeline component for experience/education
#let timeline-entry(
  date,
  title,
  subtitle: none,
  content: none,
  accent-color: rgb("#1e88e5"),
) = {
  grid(
    columns: (auto, 1fr),
    column-gutter: 1em,

    // Timeline marker
    {
      circle(radius: 4pt, fill: accent-color)
      v(-0.5em)
      line(
        start: (0pt, 0pt),
        end: (0pt, 100%),
        stroke: 1pt + accent-color.lighten(50%),
      )
    },

    // Content
    {
      text(weight: "bold", size: 0.9em, fill: gray.darken(20%), date)
      linebreak()
      text(weight: "bold", size: 1.1em, title)
      if subtitle != none {
        linebreak()
        text(style: "italic", fill: gray, subtitle)
      }
      if content != none {
        v(0.3em)
        content
      }
      v(1em)
    },
  )
}

// Section divider
#let section-divider(style: "line", color: rgb("#e0e0e0"), spacing: 1em) = {
  v(spacing)
  if style == "line" {
    line(length: 100%, stroke: 0.5pt + color)
  } else if style == "dots" {
    align(center)[
      #for i in range(3) {
        circle(radius: 2pt, fill: color)
        if i < 2 { h(0.5em) }
      }
    ]
  } else if style == "dash" {
    align(center)[
      #line(length: 3em, stroke: 1pt + color)
    ]
  }
  v(spacing)
}

// Language level indicator
#let language-level(level, style: "cefr") = {
  let cefr-levels = (
    "A1": "Anfänger",
    "A2": "Grundkenntnisse",
    "B1": "Mittelstufe",
    "B2": "Gute Kenntnisse",
    "C1": "Fortgeschritten",
    "C2": "Verhandlungssicher",
  )

  let numeric-levels = (
    "1": "Grundkenntnisse",
    "2": "Gut",
    "3": "Sehr gut",
    "4": "Fließend",
    "5": "Muttersprache",
  )

  if style == "cefr" and level in cefr-levels {
    level + " - " + cefr-levels.at(level)
  } else if style == "numeric" and level in numeric-levels {
    numeric-levels.at(level)
  } else {
    level
  }
}

// Format a list with custom bullets
#let custom-list(items, bullet: "•", spacing: 0.3em, indent: 1em) = {
  for item in items {
    h(indent)
    text(bullet)
    h(0.5em)
    item
    v(spacing)
  }
}

// Two-column list for skills or similar
#let two-column-list(items, gutter: 1em) = {
  let half = calc.ceil(items.len() / 2)
  grid(
    columns: 2,
    column-gutter: gutter,
    ..items
      .enumerate()
      .map(((i, item)) => {
        if i < half {
          [#item]
        } else {
          []
        }
      }),
    ..items
      .enumerate()
      .map(((i, item)) => {
        if i >= half {
          [#item]
        } else {
          []
        }
      })
  )
}

// Format phone number based on country
#let format-phone(number, country: "DE") = {
  // Remove all non-numeric characters
  let clean = number.replace(regex("[^0-9+]"), "")

  if country == "DE" {
    // German format: +49 123 456789
    if clean.starts-with("+49") {
      let parts = clean.slice(3).codepoints()
      let formatted = "+49 "
      for (i, digit) in parts.enumerate() {
        formatted += digit
        if i == 2 or i == 5 { formatted += " " }
      }
      formatted
    } else {
      number
    }
  } else {
    number
  }
}
