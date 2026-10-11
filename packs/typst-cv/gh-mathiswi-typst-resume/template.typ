#import "@preview/fontawesome:0.5.0": *

#let defaultTheme = (
  // Colors
  colors: (
    primary: black,
    text: black,
    accent: rgb("#1772e9")  // Slightly lighter gray for better contrast
  ),
  
  // Typography
  fonts: (
    primary: "IBM Plex Sans",
    size: (
      base: 9.5pt,      // Slightly increased base size
      heading: 11pt,
      title: 26pt,      // Increased from 24pt
      subtitle: 15pt    // Increased from 14pt
    )
  ),
  
  // Spacing
  spacing: (
    grid: (
      label: 8em,
      content: 13em,
      gutter: 0.5em
    ),
    vertical: (
      section: 1.5em,   // Reduced from 2em
      item: 0.6em,      // Reduced from 0.8em
      tight: 0.2em,     // Reduced from 0.3em
      list: 0.3em       // Reduced from 0.4em
    )
  )
)

// Helper function for consistent grid layouts
#let contentGrid(leftWidth, rightContent, leftContent: none) = {
  grid(
    columns: (leftWidth, 1fr),
    gutter: defaultTheme.spacing.grid.gutter,
    if leftContent != none [#leftContent] else [],
    rightContent
  )
}

// Hardcoded section numbers instead of counter
#let sectionNumbers = ("01", "02", "03", "04", "05")
#let sectionIndex = counter("section-index")
#{ sectionIndex.update(0) }

#let cv(doc, theme: defaultTheme) = {
  // Document setup
  set document(author: "Mathis Witte", title: "CV")
  set page(
    margin: (left: 20mm, right: 20mm, top: 20mm, bottom: 20mm),
    numbering: none
  )
  set text(
    font: theme.fonts.primary,
    lang: "de",
    size: theme.fonts.size.base
  )
  
  // Link styling
  show link: it => {
    text(fill: theme.colors.primary, weight: "medium", underline(offset: 2pt, it))
  }
  
  // Heading styles
  set heading(numbering: none)
  show heading: it => {
    set text(weight: "bold", size: theme.fonts.size.heading)
    let index = sectionIndex.get().at(0)
    let number = sectionNumbers.at(index)
    let heading_text = [#number #upper(it.body)]
    context {
      let size = measure(heading_text)
      block[
        #text(weight: "bold")[#heading_text]
        #v(-2pt)
        #line(length: size.width, stroke: 1.8pt + theme.colors.primary)
      ]
    }
    v(theme.spacing.vertical.section)
    sectionIndex.step()
  }
  
  doc
}

#let cvHeader(name: "", title: "", contact: ()) = {
  // Name and title
  align(left)[
    #text(weight: "bold", size: defaultTheme.fonts.size.title)[#name]
    #v(-16pt)
    #text(weight: "medium", size: defaultTheme.fonts.size.subtitle)[#title]
  ]

  // Contact info helper with just icons
  let makeContactRow(content, icon) = {
    grid(
      columns: (auto, 1fr),
      gutter: 0.7em,
      [#text(fill: defaultTheme.colors.accent, size: 0.8em)[#icon]],
      [#text(size: 0.8em)[#content]]
    )
  }

  // Build contact items dynamically based on which fields are provided
  let contactItems = ()
  if "location" in contact { contactItems.push(makeContactRow(contact.location, fa-location-dot())) }
  if "email" in contact { contactItems.push(makeContactRow(contact.email, fa-envelope())) }
  if "phone" in contact { contactItems.push(makeContactRow(contact.phone, fa-phone())) }
  if "links" in contact { contactItems.push(makeContactRow(contact.links, fa-link())) }

  // Always use 4-column grid, fill empty columns with empty content
  while contactItems.len() < 4 {
    contactItems.push([])
  }

  // Contact info layout in fixed 4-column grid
  grid(
    columns: (1fr, 1fr, 1fr, 1fr),
    gutter: 1em,
    ..contactItems
  )
  v(defaultTheme.spacing.vertical.section)
}

#let cvEntry(
  date: "",
  location: "",
  organization: "",
  title: "",
  description: []
) = {
  grid(
    columns: (defaultTheme.spacing.grid.content, 1fr),
    gutter: defaultTheme.spacing.grid.gutter,
    {
      if date != "" [#text(weight: "bold", size: 0.8em)[#fa-calendar(size: 0.9em) #h(0.3em) #date]]
      if location != "" [
        #v(-2pt)
        #text(style: "italic", size: 0.8em)[#fa-location-dot(size: 0.9em) #h(0.3em) #location]
      ]
    },
    {
      if title != "" [
        #text(weight: "bold")[#title]
        #v(-2pt)
      ]
      if organization != "" [
        #text(size: 0.9em, fill: defaultTheme.colors.accent, weight: "bold")[#organization]
      ]
      if description != [] [
        #v(defaultTheme.spacing.vertical.tight)
        #block[
          #set text(size: 0.85em)
          #set par(leading: 1.4em)
          #description
        ]
      ]
    }
  )
  v(defaultTheme.spacing.vertical.item)
}

// Helper for list-based sections (Technologies, Languages)
#let cvList(items: (), leftWidth: defaultTheme.spacing.grid.content) = {
  contentGrid(
    leftWidth,
    [
      #for item in items {
        text(item)
        linebreak()
      }
    ]
  )
  v(defaultTheme.spacing.vertical.list)
}

#let cvTechnologies(technologies: ()) = {
  cvList(items: technologies)
}

#let cvSkillFullWidth(name: "", skills: "") = {
  block[
    #text(weight: "bold", size: defaultTheme.fonts.size.base)[#name]
    #v(-2pt)
    #text(size: 0.85em)[#skills]
    #v(0.8em)
  ]
}

#let cvSkillCategories(categories: ()) = {
  // Create a grid layout with 2 columns
  let grid_items = ()

  // Build array of content items
  for (i, category) in categories.enumerate() {
    let (name, skills) = category

    grid_items.push([
      // Category name in bold
      #text(weight: "bold", size: defaultTheme.fonts.size.base)[#name]
      #v(-2pt)           // Reduced from 2pt

      // Skills for this category
      #text(size: 0.85em)[#skills]

      // Add vertical space after each category
      #v(0.4em)         // Reduced from defaultTheme.spacing.vertical.item
    ])
  }

  // Create grid with the items
  grid(
    columns: (1fr, 1fr),
    gutter: 1.2em,      // Increased from 0.8em
    ..grid_items
  )
} 