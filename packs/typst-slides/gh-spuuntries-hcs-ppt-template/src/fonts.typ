/// Font configuration for HCS Presentation Template
///
/// Provides coordinated typography presets across 4 roles:
/// - `heading`: Titles, slide headers, section titles
/// - `body`: Slide content, bullet points, descriptions
/// - `code`: Monospace syntax highlighting, inline backticks
/// - `accent`: HUD badges, pill counters, breadcrumbs, stat values

#let default-font-presets = (
  modern: (
    heading: ("Bahnschrift", "Segoe UI", "Arial"),
    body: ("Segoe UI", "Arial", "Helvetica"),
    code: ("Cascadia Code", "Cascadia Mono", "Consolas", "Courier New"),
    accent: ("Bahnschrift", "Segoe UI", "Arial"),
  ),
  cute: (
    heading: ("Century Gothic", "Segoe UI", "Arial"),
    body: ("Corbel", "Segoe UI", "Arial"),
    code: ("Cascadia Code", "Consolas"),
    accent: ("Century Gothic", "Segoe UI", "Arial"),
  ),
  tech: (
    heading: ("Bahnschrift", "Segoe UI", "Arial"),
    body: ("Segoe UI", "Helvetica", "Arial"),
    code: ("Cascadia Code", "Consolas"),
    accent: ("Bahnschrift", "Segoe UI"),
  ),
)

/// Configure presentation fonts with presets or custom families
#let config-fonts(
  style: "cute",
  body: auto,
  heading: auto,
  code: auto,
  accent: auto,
) = {
  let base = default-font-presets.at(style, default: default-font-presets.cute)
  (
    fonts: (
      heading: if heading != auto { heading } else { base.heading },
      body: if body != auto { body } else { base.body },
      code: if code != auto { code } else { base.code },
      accent: if accent != auto { accent } else { base.accent },
    )
  )
}

/// Global state storing the active typography configuration
#let hcs-fonts-state = state("hcs-fonts", default-font-presets.cute)

