// Markdown inline bold parser (Softer medium weight instead of heavy bold)
#let render-markdown(text-str, primary-color) = {
  if type(text-str) != str { return text-str }
  let parts = text-str.split("**")

  for (i, part) in parts.enumerate() {
    if calc.odd(i) {
      text(weight: "medium", fill: primary-color, part)
    } else {
      part
    }
  }
}

// Safely get position label with fallback
#let get-position(item) = {
  item.at("position", default: item.at("positon", default: ""))
}

// Helper to render labeled key-value item (e.g., "frontend: Next.js, React")
#let render-labeled-item(label, content, primary-color) = {
  if label != "" [
    #text(weight: "regular", fill: primary-color)[#label]: #text(weight: "regular")[#content]
  ] else [
    #text(weight: "regular")[#content]
  ]
}

// Profile Section Layout
#let profile-layout(title, description, settings) = {
  let primary-color = settings.at("color-primary", default: rgb("#111827"))
  block(width: 100%)[
    == #title

    #pad(x: 0.5em)[
      #render-markdown(description, primary-color)
    ]
  ]
}

// Timeline Component
#let render-timeline(timeline, secondary-color) = {
  let period = if timeline.end == none [
    #timeline.start - Present
  ] else [
    #timeline.start - #timeline.end
  ]

  let launch = timeline.at("launch", default: none)
  let launch-text = if launch != none [\ (#launch 론칭)] else []

  text(fill: secondary-color, size: 0.9em)[#period#launch-text]
}

// Title & Link Component
#let render-title(entry, primary-color) = {
  let name = entry.at("institution", default: entry.at("name", default: ""))
  let title-element = text(weight: "medium", fill: primary-color)[#name]

  if "url" in entry and entry.url != none {
    link(entry.url)[#title-element]
  } else {
    title-element
  }
}

// Subtitle / Program / Summary Component
#let render-subtitle(entry, secondary-color) = {
  if "summary" in entry {
    [\ #text(weight: "regular", fill: secondary-color)[#entry.summary]]
  } else if "program" in entry {
    [\ #text(weight: "regular", fill: secondary-color)[#entry.program]]
  }
}

// Responsibilities Component
#let render-responsibilities(
  responsibilities,
  spacing-item,
  spacing-list,
  primary-color,
  show-heading: false,
) = {
  if responsibilities == none { return }

  [
    #if show-heading [
      === 주요업무
    ]

    #list(
      spacing: spacing-item,
      ..responsibilities.map(item => [
        #text(weight: "regular", fill: primary-color)[#item.category]

        #v(-0.3em)

        #list(
          spacing: spacing-list,
          ..item
            .at("achievements", default: ())
            .map(achievement => [
              #text(weight: "light")[#render-markdown(achievement, primary-color)]
            ]),
        )
      ]),
    )
  ]
}

// Description List Component
#let render-description(description, spacing) = {
  if description == none { return }

  v(-0.3em)

  list(
    spacing: spacing + 2pt,
    ..description.map(item => [
      #text(weight: "regular")[#item]
    ]),
  )
}

// Main Entry Layout Coordinator
#let entry-layout(
  entry,
  settings,
  is-last,
) = {
  let year-column-width = 7em
  let spacing-entry = settings.at("spacing-entry", default: 0.5em)
  let spacing-entry-item = settings.at("spacing-entry-item", default: 0.5em)
  let spacing-entry-item-list = settings.at("spacing-entry-item-list", default: 0.5em)
  let primary-color = settings.at("color-primary", default: rgb("#111827"))
  let secondary-color = settings.at("color-secondary", default: rgb("#6B7280"))
  let divider-color = settings.at("color-divider", default: rgb("#E5E7EB"))

  set list(
    marker: ([•], [–]),
    indent: 0.3em,
    body-indent: 0.3em,
  )

  show heading.where(level: 3): it => [
    #v(0.35em)
    #text(fill: primary-color)[#it.body]
    #v(-0.2em)
  ]

  let has-prior-sections = ("tech-stack" in entry) or ("architecture" in entry)

  block(breakable: false, [
    #grid(
      columns: (year-column-width, 1fr),
      gutter: 1em,

      align(right)[#render-timeline(entry.timeline, secondary-color)],
      grid.vline(stroke: 0.5pt + divider-color),

      pad(left: 0.8em)[
        #render-title(entry, primary-color)
        #render-subtitle(entry, secondary-color)

        #render-responsibilities(
          entry.at("responsibilities", default: none),
          spacing-entry-item,
          spacing-entry-item-list,
          primary-color,
          show-heading: has-prior-sections,
        )

        #render-description(entry.at("description", default: none), spacing-entry-item-list)
      ],
    )

    #if not is-last {
      v(spacing-entry)
    }
  ])
}

