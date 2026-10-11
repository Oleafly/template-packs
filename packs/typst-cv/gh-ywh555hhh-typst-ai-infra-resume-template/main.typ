// Main entry for the fully controlled resume project.
// Build with: typst compile main.typ output/resume.pdf

#import "theme.typ": *
#import "data.typ": *
#import "components.typ": *
#import "content/ai-infra.typ": resume_content

#set page(
  paper: "a4",
  margin: page_margin,
)

#set text(
  size: base_size,
  fill: text_color,
  lang: "zh",
  region: "cn",
)

// Optional local font override:
// Typst Web and local Typst often expose different font families. Leaving
// `font` unset avoids noisy "unknown font family" warnings in Typst Web.
// If you want a specific local font, uncomment the line below and edit
// `body_fonts` in theme.typ.
// #set text(font: body_fonts)

#set par(
  leading: line_leading,
  justify: false,
)

#set list(
  marker: [•],
  indent: 0.75em,
  body-indent: 0.35em,
  spacing: list_item_spacing,
)

#show link: it => text(fill: accent, underline(it.body))

#show: resume_page.with(
  basic: basic_info,
)

#resume_content
