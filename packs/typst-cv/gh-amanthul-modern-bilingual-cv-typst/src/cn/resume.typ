#import "../common.typ": default-accent-color, make-icon, fa-angle-right, fa-angle-right-svg

// Chinese resume fonts
#let cn-font = (
  main: "IBM Plex Serif",
  mono: "IBM Plex Mono",
  cjk: "Noto Serif CJK SC",
)

// Main resume show rule
#let resume(
  size: 10pt,
  accent-color: default-accent-color,
  margin: (
    top: 1.5cm,
    bottom: 2cm,
    left: 2cm,
    right: 2cm,
  ),
  photograph: none,
  photograph-width: 0em,
  gutter-width: 0em,
  header-center: false,
  header,
  introduction,
  body,
) = {
  // Page setup
  set page(paper: "a4", numbering: "1", margin: margin)

  // Base font: serif for body, CJK fallback for Chinese
  set text(font: (cn-font.main, cn-font.cjk), size: size, lang: "zh")

  // Heading style
  show heading: set text(accent-color, 1.1em)

  // Horizontal rule under level-2 headings
  show heading.where(level: 2): it => stack(
    v(0.3em),
    it,
    v(0.6em),
    line(length: 100%, stroke: 0.05em + accent-color),
    v(0.1em),
  )

  // Custom list bullets using angle-right icon
  // Recreate with accent color if it differs from default
  let bullet = if accent-color == default-accent-color {
    fa-angle-right
  } else {
    make-icon(fa-angle-right-svg, fill: accent-color)
  }

  show list: it => stack(
    spacing: 0.4em,
    ..it.children.map(item => {
      grid(
        columns: (2em, 1fr),
        gutter: 0em,
        box({
          h(0.75em)
          bullet
        }),
        pad(top: 0.15em, item.body),
      )
    }),
  )

  // Link color matches accent
  show link: set text(fill: accent-color)

  // Paragraph settings
  set par(justify: true, spacing: 1em)

  // Header with optional photo
  if header-center {
    assert(photograph == none, message: "can not centerize the name with the photo")
    align(alignment.center, header)
    introduction
  } else {
    grid(
      columns: (auto, 1fr, photograph-width),
      gutter: (gutter-width, 0em),
      [#header #introduction],
      if photograph != none {
        photograph
      },
    )
  }

  body
}

// --- Content Functions ---

// Two-column sidebar with optional vertical divider line
#let sidebar(side, content, with-line: true, side-width: 12%) = layout(size => {
  let side-size = measure(width: size.width, height: size.height, side)
  let content-size = measure(
    width: size.width * (100% - side-width),
    height: size.height,
    content,
  )
  let height = calc.max(side-size.height, content-size.height) + 0.5em
  grid(
    columns: (side-width, 0%, 1fr),
    gutter: 0.75em,
    {
      set align(right)
      v(0.25em)
      side
      v(0.25em)
    },
    if with-line { line(end: (0em, height), stroke: 0.05em) },
    {
      v(0.25em)
      content
      v(0.25em)
    },
  )
})

// Contact information row with icons
#let info(
  color: black,
  ..infos,
) = {
  set text(font: (cn-font.mono, cn-font.cjk), fill: color)
  set par(justify: false)
  infos
    .pos()
    .map(dir => {
      box({
        if "icon" in dir {
          dir.icon
        }
        h(0.15em)
        if "link" in dir {
          link(dir.link, dir.content)
        } else {
          dir.content
        }
      })
    })
    .join(h(0.5em) + "·" + h(0.5em))
  v(0.5em)
}

// Date text (gray, smaller)
#let date(body) = text(
  fill: rgb(128, 128, 128),
  size: 0.9em,
  body,
)

// Technology tags (extra light weight)
#let tech(body) = block({
  set text(weight: "extralight")
  body
})

// Three-column entry grid (title | description | endnote)
#let item(
  title,
  desc,
  endnote,
) = {
  v(0.25em)
  grid(
    columns: (30%, 1fr, auto),
    gutter: 0em,
    title, desc, endnote,
  )
}
