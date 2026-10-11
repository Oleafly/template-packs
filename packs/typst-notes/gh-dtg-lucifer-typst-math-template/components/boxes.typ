// components/boxes.typ
// Foundational box primitives modeled exactly after Charlie's LaTeX template (cmt.sty)

#import "theme.typ": resolve-palette

/// Tab-badge box (Charlie's Definition box: \cmtdefinitionthm)
/// Attached dark red header tab seamlessly resting on the top border.
#let badge-box(
  title: none,
  tag: none,
  body,
  tab-fill: auto,
  tab-fg: auto,
  stroke: auto,
  fill: auto,
  text-color: auto,
  radius: 2.5pt,
  x-offset: 24pt,
  breakable: true,
  theme: none,
) = {
  context {
    let p = resolve-palette(theme-override: theme)
    let c-stroke = if stroke == auto { p.definition.border } else { stroke }
    let c-fill = if fill == auto { p.definition.bg } else { fill }
    let c-tab-fill = if tab-fill == auto { p.definition.header-bg } else { tab-fill }
    let c-tab-fg = if tab-fg == auto { p.definition.header-fg } else { tab-fg }
    let c-text = if text-color == auto { p.definition.text } else { text-color }

    v(13pt)
    block(
      width: 100%,
      stroke: c-stroke + 1.1pt,
      fill: c-fill,
      radius: radius,
      inset: (top: 14pt, bottom: 11pt, x: 12pt),
      breakable: breakable,
      {
        if title != none {
          place(
            top + left,
            dx: x-offset,
            dy: -23pt,
            box(
              fill: c-tab-fill,
              radius: (top: 3pt, bottom: 0pt),
              inset: (x: 10pt, y: 4.5pt),
              baseline: 0%,
              outset: 0pt,
              text(
                fill: c-tab-fg,
                weight: "bold",
                size: 9.5pt,
                {
                  title
                  if tag != none and tag != "" [
                    #h(3pt)#text(weight: "regular", "(" + tag + ")")
                  ]
                }
              )
            )
          )
        }
        text(fill: c-text, body)
      }
    )
  }
}

/// Rivet box (Charlie's signature screws/rivets card for Note:-)
/// Features a floating badge on the top border with two circular rivet/screw dots.
#let rivet-box(
  title: "Note:-",
  body,
  fill: auto,
  stroke: auto,
  badge-fill: auto,
  badge-stroke: auto,
  badge-fg: auto,
  dot-color: auto,
  text-color: auto,
  radius: 2.5pt,
  x-offset: 24pt,
  breakable: true,
  theme: none,
) = {
  context {
    let p = resolve-palette(theme-override: theme)
    let c-fill = if fill == auto { p.note.bg } else { fill }
    let c-stroke = if stroke == auto { p.note.border } else { stroke }
    let c-b-fill = if badge-fill == auto { p.note.badge-bg } else { badge-fill }
    let c-b-stroke = if badge-stroke == auto { p.note.badge-border } else { badge-stroke }
    let c-b-fg = if badge-fg == auto { p.note.badge-fg } else { badge-fg }
    let c-dot = if dot-color == auto { p.note.dot } else { dot-color }
    let c-text = if text-color == auto { p.note.text } else { text-color }

    v(13pt)
    block(
      width: 100%,
      stroke: c-stroke + 0.95pt,
      fill: c-fill,
      radius: radius,
      inset: (top: 14pt, bottom: 10pt, x: 12pt),
      breakable: breakable,
      {
        if title != none {
          place(
            top + left,
            dx: x-offset,
            dy: -22.5pt,
            {
              // Left rivet screw on border line
              place(top + left, dx: -8.5pt, dy: 6pt, circle(radius: 2pt, fill: c-dot))
              // Center badge
              box(
                fill: c-b-fill,
                stroke: c-b-stroke + 0.95pt,
                radius: 2.5pt,
                inset: (x: 8.5pt, y: 3.5pt),
                text(weight: "bold", size: 8.5pt, fill: c-b-fg, title)
              )
              // Right rivet screw on border line
              place(top + right, dx: 8.5pt, dy: 6pt, circle(radius: 2pt, fill: c-dot))
            }
          )
        }
        text(fill: c-text, body)
      }
    )
  }
}

/// Left-bar box (Charlie's theorem/proposition style: \cmtleftthm)
/// Sharp corners, thick vertical left accent rule, soft background tint.
#let left-bar-box(
  title: none,
  tag: none,
  body,
  bar-color: auto,
  bar-width: 2.2pt,
  bg-color: auto,
  title-color: auto,
  text-color: auto,
  radius: 0pt, // Sharp corners as in Charlie's LaTeX template
  inset: (left: 12pt, right: 12pt, top: 9pt, bottom: 9pt),
  breakable: true,
  theme: none,
) = {
  context {
    let p = resolve-palette(theme-override: theme)
    let c-bar = if bar-color == auto { p.theorem.bar } else { bar-color }
    let c-bg = if bg-color == auto { p.theorem.bg } else { bg-color }
    let c-title = if title-color == auto { c-bar } else { title-color }
    let c-text = if text-color == auto { p.text } else { text-color }

    v(8pt)
    block(
      width: 100%,
      stroke: (left: bar-width + c-bar),
      fill: c-bg,
      inset: inset,
      radius: radius,
      breakable: breakable,
      {
        if title != none {
          text(
            weight: "bold",
            fill: c-title,
            size: 10pt,
            {
              title
              if tag != none and tag != "" [
                #h(3pt)#text(weight: "regular", fill: c-title, "(" + tag + ")")
              ]
            }
          )
          v(4pt)
        }
        text(fill: c-text, body)
      }
    )
  }
}

/// Continuation box (Charlie's \Theoremcon: continuation card without header)
#let continuation-box(
  body,
  bar-color: auto,
  bar-width: 2.2pt,
  bg-color: auto,
  text-color: auto,
  radius: 0pt,
  inset: (left: 12pt, right: 12pt, top: 9pt, bottom: 9pt),
  breakable: true,
  theme: none,
) = {
  left-bar-box(
    title: none,
    tag: none,
    body,
    bar-color: bar-color,
    bar-width: bar-width,
    bg-color: bg-color,
    text-color: text-color,
    radius: radius,
    inset: inset,
    breakable: breakable,
    theme: theme,
  )
}

/// Ribbon box (Charlie's Question and Solution style: \cmtribbonbox)
/// Features a top colored banner across the box.
#let ribbon-box(
  title: none,
  tag: none,
  body,
  ribbon-color: auto,
  ribbon-fg: rgb("#ffffff"),
  bg-color: auto,
  border-color: auto,
  text-color: auto,
  radius: 2.5pt,
  breakable: true,
  theme: none,
) = {
  context {
    let p = resolve-palette(theme-override: theme)
    let c-ribbon = if ribbon-color == auto { p.question.ribbon } else { ribbon-color }
    let c-border = if border-color == auto { c-ribbon } else { border-color }
    let c-bg = if bg-color == auto { p.question.bg } else { bg-color }
    let c-text = if text-color == auto { p.text } else { text-color }

    v(8pt)
    block(
      width: 100%,
      stroke: c-border + 0.95pt,
      fill: c-bg,
      radius: radius,
      clip: true,
      breakable: breakable,
      {
        if title != none {
          block(
            fill: c-ribbon,
            width: 100%,
            inset: (x: 12pt, y: 5.5pt),
            text(
              fill: ribbon-fg,
              weight: "bold",
              size: 9.5pt,
              {
                title
                if tag != none and tag != "" [
                  #h(4pt)#text(weight: "regular", "(" + tag + ")")
                ]
              }
            )
          )
        }
        block(
          inset: (x: 12pt, top: 8pt, bottom: 10pt),
          text(fill: c-text, body)
        )
      }
    )
  }
}

/// Frame box (Charlie's Example box style: \cmtexamplethm)
/// Sharp corners, 1pt teal border, soft background tint, colored bold title.
#let frame-box(
  title: none,
  tag: none,
  body,
  border-color: auto,
  bg-color: auto,
  title-color: auto,
  text-color: auto,
  radius: 0pt, // Sharp corners as in Charlie's LaTeX template
  inset: 12pt,
  breakable: true,
  theme: none,
) = {
  context {
    let p = resolve-palette(theme-override: theme)
    let c-border = if border-color == auto { p.example.border } else { border-color }
    let c-bg = if bg-color == auto { p.example.bg } else { bg-color }
    let c-title = if title-color == auto { p.example.title } else { title-color }
    let c-text = if text-color == auto { p.example.text } else { text-color }

    v(8pt)
    block(
      width: 100%,
      stroke: c-border + 1pt,
      fill: c-bg,
      radius: radius,
      inset: inset,
      breakable: breakable,
      {
        if title != none {
          text(
            weight: "bold",
            fill: c-title,
            size: 10pt,
            {
              title
              if tag != none and tag != "" [
                #h(3pt)#text(weight: "regular", fill: c-title, "(" + tag + ")")
              ]
            }
          )
          v(4pt)
        }
        text(fill: c-text, body)
      }
    )
  }
}
