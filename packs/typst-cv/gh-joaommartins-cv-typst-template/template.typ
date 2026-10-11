// Minimalistic CV Template in Typst
// Author: João Martins
// Optimised for the Australian job market
//
// This file contains all the styling and layout functions
// Import this in your CV content file

// Monochromatic color palette - sleek and minimal
#let primary-color = rgb("#000000")      // Black
#let secondary-color = rgb("#1a1a1a")    // Near black
#let accent-color = rgb("#333333")       // Dark gray
#let text-color = rgb("#000000")         // Black
#let light-gray = rgb("#f8f8f8")         // Almost white
#let medium-gray = rgb("#666666")        // Medium gray
#let divider-gray = rgb("#e0e0e0")       // Light divider

// Main CV wrapper function
#let cv(
  name: "",
  title: "",
  contacts: (),
  location: "",
  body
) = {
  // Document setup
  set document(title: name + " - CV", author: name)
  set page(
    paper: "a4",
    margin: (x: 1.5cm, y: 1.5cm),
    footer: [
      #set text(size: 7.5pt, fill: medium-gray)
      #line(length: 100%, stroke: 0.3pt + divider-gray)
      #v(0.25em)
      #grid(
        columns: (1fr, auto),
        align: (left, right),
        [Referees available upon request],
        context [Page #counter(page).display()]
      )
    ]
  )
  set text(
    font: "Liberation Sans",
    size: 9.5pt,
    lang: "en",
    fill: text-color,
  )
  set par(justify: true, leading: 0.5em)

  // Header with name and title - minimalistic and sleek
  block(
    width: 100%,
    inset: (bottom: 0.1em),
  )[
    #text(size: 24pt, weight: 300, fill: primary-color, tracking: -0.5pt)[#name]
    #v(0.1em)
    #text(size: 10pt, weight: 400, fill: medium-gray, tracking: 1pt)[#upper(title)]
    #if location != "" [
      #v(0.05em)
      #text(size: 8.5pt, weight: 400, fill: medium-gray)[#location]
    ]
  ]

  // Contact information - minimal and clean
  if contacts.len() > 0 {
    v(0.2em)
    line(length: 100%, stroke: 0.3pt + divider-gray)
    v(0.3em)
    set text(size: 8.5pt, fill: medium-gray)
    contacts.join("   ·   ")
    v(0.3em)
    line(length: 100%, stroke: 0.3pt + divider-gray)
  }

  // Main content
  body
}

// Section heading style - minimal and sleek
#let section(title) = {
  v(0.6em)
  text(
    size: 10pt,
    weight: 400,
    fill: primary-color,
    tracking: 2pt
  )[#upper(title)]
  v(0.1em)
  line(length: 100%, stroke: 0.5pt + primary-color)
  v(0.2em)
}

// Entry with date - minimal and clean
// Unified function: always uses positions array structure
// Use for: Experience, Education, Projects
//
// Parameters:
//   organization: Company/University name
//   location: City, State
//   positions: Array of position dictionaries with title, date, description
//
// Single position example:
//   positions: ((title: "Job", date: "2023", description: [...]))
//
// Multiple positions example:
//   positions: (
//     (title: "Senior Job", date: "2024", description: [...]),
//     (title: "Job", date: "2023", description: [...])
//   )
#let entry(
  organization: "",
  location: "",
  positions: ()
) = {
  // Compact layout: single position with no title — merge date into org header
  let single-no-title = positions.len() == 1 and positions.at(0).title == ""

  if single-no-title {
    let position = positions.at(0)
    grid(
      columns: (1fr, auto),
      align: (left, right),
      column-gutter: 0.5em,
      [
        #text(size: 10pt, weight: 600, fill: primary-color)[#organization]
        #if location != "" [
          #h(0.5em)
          #text(size: 8.5pt, fill: medium-gray, style: "italic")[#location]
        ]
      ],
      [
        #text(size: 8.5pt, fill: medium-gray)[#position.date]
      ]
    )

    if "description" in position and position.description != none {
      v(0.15em)
      set text(size: 9pt, fill: text-color)
      set list(marker: [–], indent: 0em, body-indent: 0.5em, spacing: 0.4em)
      position.description
      v(0.2em)
    } else {
      v(0.15em)
    }
  } else {
    // Standard layout: org header + individual position rows
    grid(
      columns: (1fr, auto),
      align: (left, right),
      column-gutter: 0.5em,
      [
        #text(size: 10pt, weight: 600, fill: primary-color)[#organization]
        #if location != "" [
          #h(0.5em)
          #text(size: 8.5pt, fill: medium-gray, style: "italic")[#location]
        ]
      ],
      []
    )

    v(0.2em)

    // Individual positions within the organization
    for position in positions {
      grid(
        columns: (1fr, auto),
        align: (left, right),
        column-gutter: 1em,
        [
          #text(size: 9.5pt, weight: 400, fill: primary-color, style: "italic")[#position.title]
        ],
        [
          #text(size: 8.5pt, fill: medium-gray)[#position.date]
        ]
      )

      if "description" in position and position.description != none {
        v(0.15em)
        set text(size: 9pt, fill: text-color)
        set list(marker: [–], indent: 0em, body-indent: 0.5em, spacing: 0.4em)
        position.description
        v(0.2em)
      } else {
        v(0.15em)
      }
    }
  }

  v(0.3em)
}

// Skill item - minimal style
#let skill-item(skill) = {
  text(size: 8.5pt, fill: text-color)[#skill]
}

// Skill category - minimal and clean
// Use for grouping related skills
#let skill-category(title, skills) = {
  [
    #text(size: 9pt, weight: 600, fill: primary-color)[#title]
    #v(0.2em)
    #text(size: 8.5pt)[#skills.join("  ·  ")]
  ]
}

// ============================================================================
// DATA VALIDATION FUNCTIONS
// ============================================================================

// Validate that a dictionary has exactly the required keys
#let validate-keys(dict, required-keys, ctx: "") = {
  let dict-keys = dict.keys()
  let missing = required-keys.filter(k => k not in dict-keys)
  let extra = dict-keys.filter(k => k not in required-keys)

  if missing.len() > 0 {
    panic("Missing required fields in " + ctx + ": " + missing.join(", "))
  }

  if extra.len() > 0 {
    panic("Unexpected fields in " + ctx + ": " + extra.join(", "))
  }
}

// Validate contact object
#let validate-contact(contact, index) = {
  let required = ("value",)
  let optional = ("url",)
  let all-keys = required + optional

  for key in required {
    if key not in contact {
      panic("Missing required field '" + key + "' in contact[" + str(index) + "]")
    }
  }

  for key in contact.keys() {
    if key not in all-keys {
      panic("Unexpected field '" + key + "' in contact[" + str(index) + "]")
    }
  }
}

// Validate position object
#let validate-position(position, ctx, index) = {
  let required = ("title", "date")
  let optional = ("description",)
  let all-keys = required + optional

  for key in required {
    if key not in position {
      panic("Missing required field '" + key + "' in " + ctx + ".positions[" + str(index) + "]")
    }
  }

  for key in position.keys() {
    if key not in all-keys {
      panic("Unexpected field '" + key + "' in " + ctx + ".positions[" + str(index) + "]")
    }
  }
}

// Validate experience/education/project entry
#let validate-entry(entry, ctx, index) = {
  let required = ("organization", "location", "positions")
  let optional = ("organization_url",)
  let all-keys = required + optional

  for key in required {
    if key not in entry {
      panic("Missing required field '" + key + "' in " + ctx + "[" + str(index) + "]")
    }
  }

  for key in entry.keys() {
    if key not in all-keys {
      panic("Unexpected field '" + key + "' in " + ctx + "[" + str(index) + "]")
    }
  }

  // Validate positions array
  for (pos-idx, position) in entry.positions.enumerate() {
    validate-position(position, ctx + "[" + str(index) + "]", pos-idx)
  }
}

// Validate skill category
#let validate-skill(skill, index) = {
  validate-keys(skill, ("category", "items"), ctx: "skills[" + str(index) + "]")
}

// Validate certification
#let validate-certification(cert, index) = {
  validate-keys(cert, ("name", "issuer", "year"), ctx: "certifications[" + str(index) + "]")
}

// Validate entire CV data structure
#let validate-cv-data(data) = {
  // Validate top-level keys
  validate-keys(data, ("personal", "summary", "experience", "education", "skills", "projects", "certifications"), ctx: "root")

  // Validate personal section
  validate-keys(data.personal, ("name", "title", "location", "contacts"), ctx: "personal")

  // Validate contacts
  for (idx, contact) in data.personal.contacts.enumerate() {
    validate-contact(contact, idx)
  }

  // Validate experience entries
  for (idx, exp) in data.experience.enumerate() {
    validate-entry(exp, "experience", idx)
  }

  // Validate education entries
  for (idx, edu) in data.education.enumerate() {
    validate-entry(edu, "education", idx)
  }

  // Validate skills
  for (idx, skill) in data.skills.enumerate() {
    validate-skill(skill, idx)
  }

  // Validate projects
  for (idx, project) in data.projects.enumerate() {
    validate-entry(project, "projects", idx)
  }

  // Validate certifications
  for (idx, cert) in data.certifications.enumerate() {
    validate-certification(cert, idx)
  }
}

// ============================================================================
// DATA EXTRACTION FUNCTIONS
// ============================================================================

// Extract personal information and setup CV
#let cv-from-data(data, body) = {
  validate-cv-data(data)
  cv(
    name: data.personal.name,
    title: data.personal.title,
    location: data.personal.location,
    contacts: data.personal.contacts.map(contact => {
      if "url" in contact {
        link(contact.url)[#contact.value]
      } else {
        contact.value
      }
    }),
    body
  )
}

// Unified section renderer from data
// Accepts section type enum and renders the appropriate section
// section-type: "summary" | "experience" | "education" | "skills" | "projects" | "certifications"
#let section-from-data(
  section-type: "summary",
  data
) = {
  // Validate section type
  let valid-types = ("summary", "experience", "education", "skills", "projects", "certifications")
  assert(section-type in valid-types,
    message: "section-type must be one of: " + valid-types.join(", "))

  // Check if data is empty and skip if so
  let is-empty = (
    (section-type == "summary" and (data == none or data == "")) or
    (section-type != "summary" and data.len() == 0)
  )

  if not is-empty {
    // Render based on section type
    if section-type == "summary" {
      section("Professional Summary")
      data
    } else if section-type == "experience" {
      section("Experience")
      for exp in data {
        entry(
          organization: exp.organization,
          location: exp.location,
          positions: exp.positions.map(pos => (
            title: pos.title,
            date: pos.date,
            description: pos.description.map(item => [- #item]).join([])
          ))
        )
      }
    } else if section-type == "education" {
      section("Education")
      for edu in data {
        entry(
          organization: edu.organization,
          location: edu.location,
          positions: edu.positions.map(pos => (
            title: pos.title,
            date: pos.date,
            description: if "description" in pos {
              pos.description.map(item => [- #item]).join([])
            } else {
              none
            }
          ))
        )
      }
    } else if section-type == "skills" {
      section("Skills")
      grid(
        columns: (1fr, 1fr),
        column-gutter: 1.5em,
        row-gutter: 0.8em,
        ..data.map(skill => {
          skill-category(skill.category, skill.items)
        })
      )
    } else if section-type == "projects" {
      section("Projects")
      for project in data {
        entry(
          organization: if "organization_url" in project {
            link(project.organization_url)[#project.organization]
          } else {
            project.organization
          },
          location: project.location,
          positions: project.positions.map(pos => (
            title: pos.title,
            date: pos.date,
            description: if "description" in pos {
              pos.description.map(item => [#item]).join([])
            } else {
              none
            }
          ))
        )
      }
    } else if section-type == "certifications" {
      section("Certifications & Awards")
      for cert in data {
        [- *#cert.name* — #cert.issuer, #cert.year]
      }
    }
  }
}

// Legacy functions for backward compatibility - now just call section-from-data
#let summary-from-data(summary) = {
  section-from-data(section-type: "summary", summary)
}

#let experience-from-data(experiences) = {
  section-from-data(section-type: "experience", experiences)
}

#let education-from-data(education) = {
  section-from-data(section-type: "education", education)
}

#let skills-from-data(skills) = {
  section-from-data(section-type: "skills", skills)
}

#let projects-from-data(projects) = {
  section-from-data(section-type: "projects", projects)
}

#let certifications-from-data(certifications) = {
  section-from-data(section-type: "certifications", certifications)
}

