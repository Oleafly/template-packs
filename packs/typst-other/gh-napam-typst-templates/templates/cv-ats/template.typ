// =============================================================================
// ATS-friendly CV layout — single-column, no images, no icons, no decorative
// elements, plain text flow.  Optimized for machine parsing.
//
// Font: PT Sans (bundled in ./fonts via TYPST_FONT_PATHS)
// =============================================================================

// ---- Constants ----

#let body-size = 10pt
#let label-size = 11pt
#let name-size = 18pt
#let meta-color = luma(100)

// ---- Skills ----

// Bold label on its own line, followed by a plain comma-separated skill list.
#let skill-category(
  name: "",
  skills: (),
) = {
  block(below: 1.5em, {
    text(size: label-size, weight: "bold", name)
    linebreak()
    text(size: body-size, skills.join(", "))
  })
}

// ---- Entries (work experience / education) ----

// Shared base for education and work experience entries.
// Single-column stacked layout — critical for ATS parsing.
// Title and subtitle (company/institution) on the same line, separated by a
// comma — the most universally recognized pattern for ATS parsers.  Avoids
// em-dashes/en-dashes which some older systems mis-parse.
#let _entry(
  title: "",
  subtitle: "",
  dates: "",
  location: "",
  description: [],
) = {
  block(below: 2em, breakable: true, {
    // Title line (e.g. "Fullstack Developer & Technical Lead, IslandGarden")
    {
      set par(justify: false)
      text(size: label-size, weight: "bold", title)
      if subtitle != "" {
        text(size: label-size, ", ")
        text(size: label-size, emph(subtitle))
      }
    }
    v(-0.5em)
    // Metadata line: "August 2023 - May 2026 | Bergen"
    // Uses ASCII hyphen-minus and single-space pipes for maximum ATS compat.
    {
      set par(justify: false)
      text(size: body-size, fill: meta-color, {
        dates
        if location != "" {
          " | "
          location
        }
      })
    }
    parbreak()
    text(size: body-size, description)
  })
}

#let education-entry(
  degree: "",
  institution: "",
  dates: "",
  location: "",
  description: [],
) = _entry(
  title: degree,
  subtitle: institution,
  dates: dates,
  location: location,
  description: description,
)

#let work-experience-entry(
  title: "",
  company: "",
  dates: "",
  location: "",
  description: [],
) = _entry(
  title: title,
  subtitle: company,
  dates: dates,
  location: location,
  description: description,
)

#let selected-project-entry(
  name: "",
  place: "",
  dates: "",
  description: [],
  skills: (),
  skills-label: "Technologies",
) = {
  _entry(
    title: name,
    subtitle: place,
    dates: dates,
    description: {
      description
      if skills.len() > 0 {
        set text(fill: meta-color)
        parbreak()
        text(size: label-size, weight: "bold", skills-label + ": ")
        text(size: body-size, skills.join(", "))
      }
    },
  )
}

#let reference-entry(
  name: "",
  phone: "",
  email: "",
  description: [],
  phone-label: "Phone",
  email-label: "Email",
) = {
  block(below: 1.75em, breakable: false, {
    text(size: label-size, weight: "bold", name)
    v(-0.25em)
    text(size: body-size, fill: meta-color, {
      if phone != "" {
        text(weight: "bold", phone-label + ": ")
        phone
      }
      if email != "" {
        if phone != "" { " | " }
        text(weight: "bold", email-label + ": ")
        email
      }
    })
    v(-0.25em)
    text(size: body-size, description)
  })
}

// ---- Header ----

// Full-width single-column header.  No profile image, no icons.
// Contacts are pipe-separated on one line — most ATS parsers handle this well,
// and it saves vertical space.  Each contact type (email, phone, location, URL)
// is a plain text field or clickable link.
#let header(
  name: "",
  subtitle: [],
  contacts: (),
) = {
  block(below: 8pt, {
    set par(justify: false)
    text(size: name-size, weight: "bold", name)
  })

  block(below: 8pt, {
    set par(justify: false)
    text(size: label-size, subtitle)
  })

  block(below: 16pt, {
    set par(justify: false)
    text(
      size: body-size,
      fill: meta-color,
      contacts
        .map(c => {
          if "url" in c {
            link(c.url, c.display)
          } else {
            c.display
          }
        })
        .join(" | "),
    )
  })
}

// ---- Show-rule wrapper ----

// Document metadata, page settings, font, heading styles.
#let cv(
  name: "",
  lang: "en",
  keywords: (),
) = body => {
  set document(
    title: "CV - " + name,
    author: name,
    keywords: keywords,
  )
  set page(
    margin: 2.75cm,
    footer: context {
      let current = counter(page).get().first()
      let total = counter(page).final().first()
      set text(size: body-size, fill: meta-color)
      align(center, [#current / #total])
    },
  )
  // Bundled font: PT Sans (via TYPST_FONT_PATHS)
  set text(size: label-size, font: "PT Sans", lang: lang, hyphenate: false)
  set par(justify: true)

  // Normalize en-dashes and em-dashes to ASCII hyphen-minus.  ATS regex
  // patterns for date ranges (e.g. "2023 - 2026") reliably match hyphens but
  // sometimes miss Unicode dashes.
  show sym.dash.en: "-"
  show sym.dash.em: "-"

  // Section headings: generous space above for clear section breaks.
  // We style via `set` rules and wrap `it` rather than replacing it with raw
  // `text()`, so that the heading element itself is emitted to the PDF.  Typst
  // maps heading elements to /H1 structure tags — these help ATS parsers
  // segment the CV into sections.
  show heading.where(level: 1): set text(size: 13pt, weight: "bold", tracking: 0.5pt)
  show heading.where(level: 1): it => {
    v(1.0em)
    upper(it)
    v(0.75em)
  }

  body
}
