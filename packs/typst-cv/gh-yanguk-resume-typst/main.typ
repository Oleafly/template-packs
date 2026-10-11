#import "./layout.typ": entry-layout, profile-layout

#let data = yaml("resume-data.yml")

#let settings = (
  font: "Pretendard",
  fontsize: 10.5pt,

  // Gentle Soft Slate Color Palette (No heavy dark black)
  color-primary: oklch(36%, 0, 0deg), // Soft Slate Charcoal for Headings & Titles (36% Lightness)
  color-body: oklch(42%, 0, 0deg), // Gentle Reading Gray for Body (42% Lightness)
  color-secondary: oklch(58%, 0, 0deg), // Soft Light Gray for Metadata & Timelines (58% Lightness)
  color-hyperlink: oklch(42%, 0, 0deg), // Soft Dark Link Color
  color-divider: oklch(90%, 0, 0deg), // Subtle Soft Divider Line (90% Lightness)

  spacing-section: 14pt,
  spacing-entry: 1.2em,
  spacing-entry-item: 1.4em,
  spacing-entry-item-list: 0.65em,
  spacing-line: 0.65em,

  page: (
    paper: "a4",
  ),
)

// Helper to strip protocol for clean link display
#let clean-url-text(url) = {
  url.replace(regex("^https?://"), "")
}

// Page setup
#set page(
  paper: settings.page.paper,
)

#show link: it => {
  text(fill: settings.color-hyperlink)[#underline(it)]
}

// Global text configuration: Soft dark gray body text
#set text(
  font: settings.font,
  size: settings.fontsize,
  weight: "regular",
  fill: settings.color-body,
  hyphenate: false,
)

// Header layout
#show title: set text(size: 17pt, weight: "medium", fill: settings.color-primary)
#show title: set align(center)
#title(data.personal.name)

#align(center)[
  #text(weight: "regular", fill: settings.color-secondary)[#data.personal.titles.join("  /  ")]
]

// Contact Info
#align(center)[
  #text(size: 0.95em, fill: settings.color-secondary)[
    #(
      link("mailto:" + data.personal.contact.email)[#data.personal.contact.email],
      link("tel:" + data.personal.contact.phone)[#data.personal.contact.phone],
      link(data.personal.contact.website)[#clean-url-text(data.personal.contact.website)],
      link(data.personal.contact.github)[#clean-url-text(data.personal.contact.github)],
    ).join([#sym.space.en | #sym.space.en])
  ]
]

// Section headings Setup
#show heading.where(level: 2): it => block(width: 100%)[
  #v(settings.spacing-section)
  #set align(left)
  #set text(font: settings.font, size: 1.1em, weight: "medium", fill: settings.color-primary)

  #it.body

  #v(-0.35em)
  #line(length: 100%, stroke: 0.6pt + settings.color-divider)
]

#set par(
  leading: settings.spacing-line,
  justify: true,
)

#for section in data.sections {
  if section.title == "Profile" {
    profile-layout(section.title, section.description, settings)
  } else {
    block(
      width: 100%,
      breakable: true,
      inset: 0pt,
      outset: 0pt,
    )[
      == #section.title

      #for (i, entry) in section.entries.enumerate() {
        let is-last = (i == section.entries.len() - 1)
        entry-layout(entry, settings, is-last)
      }
    ]
  }
}

