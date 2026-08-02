#let two-col(
  left,
  right,
  gutter: 2em,
  left-width: 50%,
  right-width: 50%,
) = {
  grid(
    columns: (left-width, right-width),
    column-gutter: gutter,
    left, right,
  )
}

#let key-points(
  ..points,
  accent-color: rgb("#37a0cb"),
) = {
  list(
    ..points
      .pos()
      .map(point => {
        [#text(accent-color)[●] #point]
      }),
  )
}

#let stat-box(
  number,
  label,
  bg-color: rgb("#f5f5f5"),
  text-color: rgb("#002546"),
) = {
  set text(fill: text-color)
  block(
    fill: bg-color,
    width: 100%,
    inset: 1.2em,
    radius: 0.4em,
    {
      align(center, {
        text(size: 2.5em, weight: "bold", number)
        v(-0.5em)
        text(size: 0.9em, weight: "light", label)
      })
    },
  )
}

#let image-with-caption(
  image-path,
  caption: none,
  width: 100%,
  height: auto,
) = {
  stack(
    spacing: 0.5em,
    image(image-path, width: width, height: height),
    if caption != none {
      text(size: 0.8em, style: "italic", fill: rgb("#666666"), caption)
    },
  )
}

#let timeline-item(
  number,
  title,
  description,
  color: rgb("#37a0cb"),
) = {
  grid(
    columns: (auto, 1fr),
    column-gutter: 1em,
    align: (center + top, top),
    {
      set text(fill: color, weight: "bold", size: 1em)
      circle(
        radius: 0.4em,
        fill: color,
        stroke: none,
        align(center + horizon, text(fill: white, size: 0.7em, weight: "bold", [#number])),
      )
    },
    {
      text(weight: "bold", size: 1.1em, title)
      v(-0.3em)
      text(size: 0.95em, fill: rgb("#333333"), description)
    },
  )
}

#let comparison-table(
  headers: (),
  rows: (),
  header-color: rgb("#002546"),
  header-text: rgb("#ffffff"),
  stripe-color: rgb("#f5f5f5"),
) = {
  table(
    columns: headers.len(),
    fill: (columns, rows) => {
      if rows == 0 { header-color } else if calc.odd(rows) { stripe-color } else { white }
    },
    stroke: 0.5pt + rgb("#cccccc"),
    table.header(
      ..headers.map(h => {
        text(weight: "bold", fill: header-text, size: 1em, h)
      }),
    ),
    ..rows.flatten()
  )
}

#let highlight(
  body,
  accent-color: rgb("#37a0cb"),
  bg-color: rgb("#f5f5f5"),
) = {
  block(
    fill: bg-color,
    stroke: (left: 4pt + accent-color),
    inset: (x: 1em, y: 0.8em),
    radius: 0.3em,
    body,
  )
}

#let badge(
  number,
  size: 1.5em,
  fill-color: rgb("#37a0cb"),
  text-color: white,
) = {
  set text(fill: text-color, weight: "bold", size: size)
  circle(
    radius: size / 2,
    fill: fill-color,
    stroke: none,
    align(center + horizon, number),
  )
}

#let arrow-step(
  from,
  to,
  label: none,
) = {
  stack(
    dir: ltr,
    spacing: 0.5em,
    align(center + horizon, from),
    {
      text(size: 0.8em, if label != none { label } else { "→" })
    },
    align(center + horizon, to),
  )
}


#let callout(
  body,
  title: none,
  color: rgb("#37a0cb"),
) = {
  block(
    fill: color.lighten(90%),
    stroke: 1pt + color,
    inset: 1em,
    radius: 0.5em,
    {
      if title != none {
        text(weight: "bold", fill: color, size: 1em, title)
        v(-0.3em)
        line(length: 100%, stroke: 0.5pt + color.lighten(30%))
        v(0.5em)
      }
      text(fill: color, body)
    },
  )
}


#let success(body) = {
  block(
    fill: rgb("#8bad3f").lighten(85%),
    stroke: 1pt + rgb("#8bad3f"),
    inset: 1em,
    radius: 0.4em,
    {
      set text(fill: rgb("#2d4a1a"))
      body
    },
  )
}


#let warning(body) = {
  block(
    fill: rgb("#e67e22").lighten(85%),
    stroke: 1pt + rgb("#e67e22"),
    inset: 1em,
    radius: 0.4em,
    {
      set text(fill: rgb("#533700"))
      body
    },
  )
}


#let error(body) = {
  block(
    fill: rgb("#d73f58").lighten(85%),
    stroke: 1pt + rgb("#d73f58"),
    inset: 1em,
    radius: 0.4em,
    {
      set text(fill: rgb("#4a1620"))
      body
    },
  )
}


#let info(body) = {
  block(
    fill: rgb("#37a0cb").lighten(85%),
    stroke: 1pt + rgb("#37a0cb"),
    inset: 1em,
    radius: 0.4em,
    {
      set text(fill: rgb("#1a4a6a"))
      body
    },
  )
}
