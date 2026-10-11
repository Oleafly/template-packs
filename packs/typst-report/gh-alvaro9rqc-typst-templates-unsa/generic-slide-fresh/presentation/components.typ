// --- REUSABLE PRESENTATION COMPONENTS ---
#import "style.typ" as style
#import "icons.typ" as icons

// --- GEOMETRIC AND DECORATIVE COMPONENTS ---

/// Renders a generic circular ring decoration.
///
/// - x (length): Absolute X coordinate of the ring's center.
/// - y (length): Absolute Y coordinate of the ring's center.
/// - radius (length): The radius of the ring.
/// - stroke-width (length): The width of the ring outline. Default is `30.96pt`.
/// - color (color): The color of the ring. Default is `style.theme.decor`.
/// -> content
#let ring-decoration(
  x,
  y,
  radius,
  stroke-width: 30.96pt,
  color: style.theme.decor
) = {
  place(
    top + left,
    dx: x - radius,
    dy: y - radius,
    circle(
      radius: radius,
      stroke: stroke-width + color,
      fill: none,
    )
  )
}

/// Renders the default bottom-left corner ring decoration.
/// -> content
#let bottom-left-decoration() = {
  ring-decoration(362.29pt, 940.57pt, 272.52pt, stroke-width: 30.96pt, color: style.theme.decor)
}

/// Renders a solid filled decorative circle.
///
/// - x (length): Absolute X coordinate of the circle's center.
/// - y (length): Absolute Y coordinate of the circle's center.
/// - radius (length): The radius of the circle.
/// - fill-color (color): The fill color of the circle. Default is `style.theme.secondary`.
/// -> content
#let decorative-circle(
  x,
  y,
  radius,
  fill-color: style.theme.secondary
) = {
  place(
    top + left,
    dx: x - radius,
    dy: y - radius,
    circle(
      radius: radius,
      fill: fill-color,
      stroke: none,
    )
  )
}

/// Renders a clean visual placeholder for slides when an image is not provided.
///
/// - label (string): The label or description text to display.
/// -> content
#let image-placeholder(label) = rect(
  width: 100%,
  height: 100%,
  fill: rgb("#e2e8f0"),
  stroke: none,
)[
  #align(center + horizon)[
    #stack(
      spacing: 12pt,
      text(size: 32pt, fill: rgb("#94a3b8"))[🖼️],
      text(size: 14pt, fill: rgb("#64748b"), weight: "medium")[#label]
    )
  ]
]

/// Renders a round-bottom arch container for images (typically used on cover slides).
///
/// - x (length): Absolute X coordinate.
/// - y (length): Absolute Y coordinate.
/// - width (length): Width of the container.
/// - height (length): Height of the container.
/// - stroke-color (color): Accent stroke border color. Default is `style.theme.primary`.
/// - image (content): Optional actual image element.
/// - label (string): Description label for the placeholder.
/// -> content
#let arch-image-container(
  x,
  y,
  width,
  height,
  stroke-color: style.theme.primary,
  image: none,
  label: ""
) = {
  let radius-bottom = width / 2
  place(
    top + left,
    dx: x,
    dy: y,
    block(
      width: width,
      height: height,
      radius: (bottom: radius-bottom),
      clip: true,
      stroke: 6pt + stroke-color,
    )[
      #if image != none {
        image
      } else {
        image-placeholder(label)
      }
    ]
  )
}

/// Renders an adaptable pattern of grid dots that supports overflow without warnings.
///
/// - x (length): Absolute X coordinate.
/// - y (length): Absolute Y coordinate.
/// - width (length): Width of the grid block.
/// - height (length): Height of the grid block.
/// - cols (integer): Number of dot columns. Default is `10`.
/// - rows (integer): Number of dot rows. Default is `10`.
/// - dot-radius (length): Radius of each dot. Default is `2pt`.
/// - dot-color (color): Color of each dot. Default is `style.theme.text-dark`.
/// - shape (string, function): The dot shape: `"circle"`, `"square"`, or a custom function `(radius, color) => ...`.
/// -> content
#let dot-grid(
  x,
  y,
  width,
  height,
  cols: 10,
  rows: 10,
  dot-radius: 2pt,
  dot-color: style.theme.text-dark,
  shape: "circle"
) = {
  let col-step = if cols > 1 { width / (cols - 1) } else { width }
  let row-step = if rows > 1 { height / (rows - 1) } else { height }
  
  place(
    top + left,
    dx: x,
    dy: y,
    block(
      width: width,
      height: height,
      clip: false, // Ensures overflow does not crash or throw warnings
      [
        #for r in range(rows) {
          for c in range(cols) {
            let shape-element = if shape == "square" {
              rect(width: dot-radius * 2, height: dot-radius * 2, fill: dot-color)
            } else if type(shape) == function {
              shape(dot-radius, dot-color)
            } else {
              circle(radius: dot-radius, fill: dot-color)
            }
            place(
              top + left,
              dx: c * col-step - dot-radius,
              dy: r * row-step - dot-radius,
              shape-element
            )
          }
        }
      ]
    )
  )
}

// --- CONTAINER AND CARD COMPONENTS ---

/// Renders a flowable layout card.
///
/// - width (length): Card width. Default is `100%`.
/// - height (length): Card height. Default is `auto`.
/// - radius (length): Corner radius. Default is `24pt`.
/// - fill (color): Card background color. Default is `style.theme.secondary`.
/// - text-color (color): Card text color. Default is `white`.
/// - inset (length, dictionary): Padding inside the card. Default is `20pt`.
/// - body (content): The body content of the card.
/// -> content
#let black-card(
  width: 100%,
  height: auto,
  radius: 24pt,
  fill: style.theme.secondary,
  text-color: white,
  inset: 20pt,
  body
) = {
  block(
    width: width,
    height: height,
    fill: fill,
    radius: radius,
    inset: inset,
    align(center + horizon)[
      #set text(fill: text-color)
      #body
    ]
  )
}

/// Renders an absolutely positioned card.
///
/// - x (length): Absolute X coordinate.
/// - y (length): Absolute Y coordinate.
/// - width (length): Card width.
/// - height (length): Card height.
/// - radius (length): Corner radius. Default is `24pt`.
/// - fill (color): Card background color. Default is `style.theme.secondary`.
/// - text-color (color): Card text color. Default is `white`.
/// - inset (length, dictionary): Padding inside the card. Default is `20pt`.
/// - body (content): The body content of the card.
/// -> content
#let placed-black-card(
  x,
  y,
  width,
  height,
  radius: 24pt,
  fill: style.theme.secondary,
  text-color: white,
  inset: 20pt,
  body
) = {
  place(
    top + left,
    dx: x,
    dy: y,
    black-card(
      width: width,
      height: height,
      radius: radius,
      fill: fill,
      text-color: text-color,
      inset: inset,
      body
    )
  )
}

/// Renders a sticky note / highlight block.
///
/// - width (length): Container width. Default is `100%`.
/// - height (length): Container height. Default is `auto`.
/// - fill (color): Background color. Default is `style.theme.primary`.
/// - text-color (color): Text color. Default is `style.theme.text-dark`.
/// - inset (length, dictionary): Inner padding. Default is `32pt`.
/// - radius (length): Corner radius. Default is `0pt`.
/// - body (content): Note content.
/// -> content
#let sticky-note(
  width: 100%,
  height: auto,
  fill: style.theme.primary,
  text-color: style.theme.text-dark,
  inset: 32pt,
  radius: 0pt,
  body
) = {
  block(
    width: width,
    height: height,
    fill: fill,
    radius: radius,
    inset: inset,
    align(center + horizon)[
      #set text(fill: text-color)
      #body
    ]
  )
}

// --- LIST AND GRID STRUCTURED COMPONENTS ---

/// Renders a grid-based sequence of numbered circles with headings and bodies.
///
/// - items (array): List of items. Each item is an array `(num, title, body)` or a dictionary with matching keys.
/// - columns (int, array): Number of columns or absolute column widths. Default is `2`.
/// - column-gutter (length): Gap between columns. Default is `48pt`.
/// - row-gutter (length): Gap between rows. Default is `50pt`.
/// - circle-radius (length): Radius of the numbering circle. Default is `52.68pt`.
/// - circle-fill (color): Fill color of the circle. Default is `style.theme.primary`.
/// - circle-text-color (color): Text color of the circle numbers. Default is `white`.
/// - title-size (length): Font size of column titles. Default is `26pt`.
/// - body-size (length): Font size of column descriptions. Default is `16.5pt`.
/// - title-color (color): Color of column titles. Default is `style.theme.text-dark`.
/// - body-color (color): Color of column descriptions. Default is `style.theme.text-muted`.
/// - spacing (length): Vertical space between circle and texts. Default is `16pt`.
/// -> content
#let circle-grid-list(
  items,
  columns: 2,
  column-gutter: 48pt,
  row-gutter: 50pt,
  circle-radius: 52.68pt,
  circle-fill: style.theme.primary,
  circle-text-color: white,
  title-size: 26pt,
  body-size: 16.5pt,
  title-color: style.theme.text-dark,
  body-color: style.theme.text-muted,
  spacing: 16pt,
) = {
  grid(
    columns: if type(columns) == int { range(columns).map(_ => 1fr) } else { columns },
    column-gutter: column-gutter,
    row-gutter: row-gutter,
    ..items.map(item => {
      let (num, title, body) = if type(item) == array {
        if item.len() == 3 {
          item
        } else if item.len() == 2 {
          (item.at(0), item.at(1), "")
        } else {
          ("", item.at(0), "")
        }
      } else if type(item) == dictionary {
        (
          item.at("num", default: ""),
          item.at("title", default: ""),
          item.at("body", default: "")
        )
      } else {
        ("", "", item)
      }
      
      stack(
        spacing: spacing,
        if num != "" {
          circle(
            radius: circle-radius,
            fill: circle-fill,
            stroke: none,
            align(center + horizon)[
              #text(size: circle-radius * 0.8, weight: "bold", fill: circle-text-color)[#num]
            ]
          )
        },
        stack(
          spacing: 10pt,
          if title != "" {
            text(size: title-size, weight: "bold", fill: title-color)[
              #set par(leading: 0.35em)
              #title
            ]
          },
          if body != "" {
            text(size: body-size, weight: "regular", fill: body-color)[
              #set par(leading: 0.5em)
              #body
            ]
          }
        )
      )
    })
  )
}

/// Renders a horizontal label pill with a checkmark indicator.
///
/// - width (length): Pill width. Default is `100%`.
/// - height (length): Pill height. Default is `44.54pt`.
/// - radius (length): Pill corner rounding. Default is `8pt`.
/// - fill (color): Pill background color. Default is `style.theme.secondary`.
/// - text-color (color): Pill text color. Default is `white`.
/// - icon (string, content): Icon content or `"✓"`. Default is `"✓"`.
/// - icon-fill (color): Icon circle background color. Default is `white`.
/// - icon-text-color (color): Icon color. Default is `style.theme.secondary`.
/// - inset (length, dictionary): Padding inside the pill. Default is `(x: 18pt)`.
/// - body (content): Pill text content.
/// -> content
#let black-pill(
  width: 100%,
  height: 44.54pt,
  radius: 8pt,
  fill: style.theme.secondary,
  text-color: white,
  icon: "✓",
  icon-fill: white,
  icon-text-color: style.theme.secondary,
  inset: (x: 18pt),
  body
) = {
  block(
    width: width,
    height: height,
    fill: fill,
    radius: radius,
    inset: inset,
    align(left + horizon)[
      #grid(
        columns: (auto, 1fr),
        column-gutter: 14pt,
        align: horizon,
        if icon != none {
          circle(
            radius: height * 0.27,
            fill: icon-fill,
            stroke: none,
            align(center + horizon)[
              #if icon == "✓" {
                icons.icon-check(icon-text-color, size: height * 0.3)
              } else {
                text(size: height * 0.3, weight: "bold", fill: icon-text-color)[#icon]
              }
            ]
          )
        },
        text(fill: text-color)[#body]
      )
    ]
  )
}

/// Renders a vertical list of custom pills.
///
/// - items (array): List of text items.
/// - width (length): Pill width. Default is `100%`.
/// - height (length): Pill height. Default is `44.54pt`.
/// - radius (length): Pill corner rounding. Default is `8pt`.
/// - fill (color): Pill background color. Default is `style.theme.secondary`.
/// - text-color (color): Pill text color. Default is `white`.
/// - icon (string, content): Icon content or `"✓"`. Default is `"✓"`.
/// - icon-fill (color): Icon circle background color. Default is `white`.
/// - icon-text-color (color): Icon color. Default is `style.theme.secondary`.
/// - spacing (length): Spacing between pills in the list. Default is `12pt`.
/// -> content
#let pill-list(
  items,
  width: 100%,
  height: 44.54pt,
  radius: 8pt,
  fill: style.theme.secondary,
  text-color: white,
  icon: "✓",
  icon-fill: white,
  icon-text-color: style.theme.secondary,
  spacing: 12pt,
) = {
  stack(
    spacing: spacing,
    ..items.map(item => {
      black-pill(
        width: width,
        height: height,
        radius: radius,
        fill: fill,
        text-color: text-color,
        icon: icon,
        icon-fill: icon-fill,
        icon-text-color: icon-text-color,
        item
      )
    })
  )
}

/// Renders N vertical columns consisting of a numbered circle, title, description, and rounded image.
///
/// - items (array): List of items. Each item is an array `(num, title, body, img)` or dictionary.
/// - columns (int, array): Column counts or widths. Default is `3`.
/// - column-gutter (length): Gap between columns. Default is `47pt`.
/// - circle-radius (length): Radius of the top numbered circle. Default is `46.34pt`.
/// - circle-fill (color): Fill color of the circle. Default is `style.theme.primary`.
/// - circle-text-color (color): Text color of the circle numbers. Default is `white`.
/// - title-size (length): Heading text size. Default is `26pt`.
/// - body-size (length): Description italic text size. Default is `15pt`.
/// - title-color (color): Heading text color. Default is `style.theme.text-dark`.
/// - body-color (color): Description text color. Default is `style.theme.text-muted`.
/// - img-width (length): Width of the column images. Default is `100%`.
/// - img-height (length): Height of the column images. Default is `326.25pt`.
/// - img-radius (length): Rounded corner radius of column images. Default is `16pt`.
/// -> content
#let image-column-list(
  items,
  columns: 3,
  column-gutter: 47pt,
  circle-radius: 46.34pt,
  circle-fill: style.theme.primary,
  circle-text-color: white,
  title-size: 26pt,
  body-size: 15pt,
  title-color: style.theme.text-dark,
  body-color: style.theme.text-muted,
  img-width: 100%,
  img-height: 326.25pt,
  img-radius: 16pt,
) = {
  grid(
    columns: if type(columns) == int { range(columns).map(_ => 1fr) } else { columns },
    column-gutter: column-gutter,
    ..items.map(item => {
      let (num, title, body, img) = if type(item) == array {
        (item.at(0), item.at(1), item.at(2), item.at(3))
      } else {
        (
          item.at("num", default: ""),
          item.at("title", default: ""),
          item.at("body", default: ""),
          item.at("image", default: none)
        )
      }
      
      align(center)[
        #stack(
          spacing: 16pt,
          if num != "" {
            circle(
              radius: circle-radius,
              fill: circle-fill,
              stroke: none,
              align(center + horizon)[
                #text(size: circle-radius * 0.73, weight: "bold", fill: circle-text-color)[#num]
              ]
            )
          },
          v(8pt),
          if title != "" {
            text(size: title-size, weight: "bold", fill: title-color)[#title]
          },
          if body != "" {
            box(width: 100%, height: 95pt)[
              #set par(leading: 0.5em)
              #text(size: body-size, style: "italic", fill: body-color)[#body]
            ]
          },
          if img != none {
            block(
              width: img-width,
              height: img-height,
              radius: img-radius,
              clip: true,
              if type(img) == str {
                image-placeholder(img)
              } else {
                img
              }
            )
          }
        )
      ]
    })
  )
}

/// Renders a horizontal timeline featuring N steps connected by a dynamic background line.
///
/// - items (array): Timeline steps `(num, title, body)`.
/// - line-color (color): Stroke color of the connector line. Default is `style.theme.secondary`.
/// - line-stroke (length): Stroke thickness of the line. Default is `4.5pt`.
/// - circle-radius (length): Radius of the step circles. Default is `42.79pt`.
/// - circle-fill (color): Circle fill color. Default is `style.theme.primary`.
/// - circle-text-color (color): Circle number text color. Default is `white`.
/// - title-size (length): Step title font size. Default is `20pt`.
/// - body-size (length): Step body font size. Default is `14pt`.
/// - title-color (color): Step title text color. Default is `style.theme.text-dark`.
/// - body-color (color): Step description text color. Default is `style.theme.text-muted`.
/// - column-gutter (length): Distance between columns. Default is `20pt`.
/// - dot-radius (length): Radius of optional indicator dots placed on the line. Default is `none`.
/// - dot-fill (color): Fill color of the indicator dots. Default is `style.theme.secondary`.
/// - align-text (alignment): Text alignment for step descriptions. Default is `left`.
/// -> content
#let horizontal-timeline(
  items,
  line-color: style.theme.secondary,
  line-stroke: 4.5pt,
  circle-radius: 42.79pt,
  circle-fill: style.theme.primary,
  circle-text-color: white,
  title-size: 20pt,
  body-size: 14pt,
  title-color: style.theme.text-dark,
  body-color: style.theme.text-muted,
  column-gutter: 20pt,
  dot-radius: none,
  dot-fill: style.theme.secondary,
  align-text: left,
) = {
  let n = items.len()
  
  // Computes the Y coordinate center for the connector line
  let line-y = if dot-radius == none {
    circle-radius
  } else {
    circle-radius * 2 + 24pt
  }
  
  block(width: 100%, [
    // Background connector line centered between column centers
    #place(
      top + left,
      dy: line-y,
      dx: 100% / n / 2,
      line(
        length: 100% * (1 - 1 / n),
        stroke: line-stroke + line-color
      )
    )
    
    // Column grid containing timeline items
    #grid(
      columns: range(n).map(_ => 1fr),
      column-gutter: column-gutter,
      ..items.map(item => {
        let (num, title, body) = if type(item) == array {
          (item.at(0), item.at(1), item.at(2))
        } else {
          (
            item.at("num", default: ""),
            item.at("title", default: ""),
            item.at("body", default: "")
          )
        }
        
        stack(
          spacing: 24pt,
          align(center)[
            #circle(
              radius: circle-radius,
              fill: circle-fill,
              stroke: none,
              align(center + horizon)[
                #text(size: circle-radius * 0.8, weight: "bold", fill: circle-text-color)[#num]
              ]
            )
          ],
          
          if dot-radius != none {
            align(center)[
              #circle(radius: dot-radius, fill: dot-fill)
            ]
          } else {
            none
          },
          
          block(
            width: 100%,
            inset: (x: 10pt),
            [
              #set align(align-text)
              #stack(
                spacing: 12pt,
                if title != "" {
                  text(size: title-size, weight: "bold", fill: title-color)[
                    #set par(leading: 0.35em)
                    #title
                  ]
                },
                if body != "" {
                  text(size: body-size, weight: "regular", fill: body-color)[
                    #set par(leading: 0.5em)
                    #body
                  ]
                }
              )
            ]
          )
        )
      })
    )
  ])
}

// --- PAGE DECORATION & INFO COMPONENTS ---

/// Renders a contact information row featuring a square icon card and details text.
///
/// - icon (content): The icon to place inside the square highlight card.
/// - text-content (string): Details text (e.g. email, phone number).
/// -> content
#let contact-row(icon, text-content) = {
  grid(
    columns: (56.5pt, 1fr),
    column-gutter: 22.8pt,
    align: (center + horizon, left + horizon),
    rect(
      width: 56.5pt,
      height: 56.5pt,
      fill: style.theme.primary,
      radius: 8pt,
      stroke: none,
      align(center + horizon)[#icon]
    ),
    text(size: 21.5pt, weight: "regular", fill: style.theme.text-dark)[#text-content]
  )
}
