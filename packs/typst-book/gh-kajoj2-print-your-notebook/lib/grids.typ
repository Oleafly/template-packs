// Grids that fill the page area: dots, lines, squares, blank.
// A grid is centred in the available area so that leftover space
// is split evenly on both sides.

#import "config.typ": cfg

#let _fit(size, spacing) = {
  let n = calc.floor(size / spacing + 1e-6)
  (n: n, offset: (size - n * spacing) / 2)
}

#let dots(width, height, spacing: cfg.grid.spacing, diameter: cfg.grid.dot-diameter, color: cfg.grid.color) = {
  let fx = _fit(width, spacing)
  let fy = _fit(height, spacing)
  let r = diameter / 2
  let dot = circle(radius: r, fill: color, stroke: none)
  box(width: width, height: height, {
    for i in range(fx.n + 1) {
      for j in range(fy.n + 1) {
        place(dx: fx.offset + i * spacing - r, dy: fy.offset + j * spacing - r, dot)
      }
    }
  })
}

#let _hlines(fx, fy, width, spacing, stroke) = {
  for j in range(fy.n + 1) {
    let y = fy.offset + j * spacing
    place(line(start: (fx.offset, y), end: (width - fx.offset, y), stroke: stroke))
  }
}

#let lines(width, height, spacing: cfg.grid.spacing, color: cfg.grid.color, thickness: cfg.grid.line-width) = {
  let fy = _fit(height, spacing)
  box(width: width, height: height, _hlines((offset: 0pt), fy, width, spacing, thickness + color))
}

#let squares(width, height, spacing: cfg.grid.spacing, color: cfg.grid.color, thickness: cfg.grid.line-width) = {
  let fx = _fit(width, spacing)
  let fy = _fit(height, spacing)
  let stroke = thickness + color
  box(width: width, height: height, {
    _hlines(fx, fy, width, spacing, stroke)
    for i in range(fx.n + 1) {
      let x = fx.offset + i * spacing
      place(line(start: (x, fy.offset), end: (x, height - fy.offset), stroke: stroke))
    }
  })
}

#let blank(width, height) = box(width: width, height: height)

// Dots on a triangular grid (for isometric drawings): every other row
// shifted by half the spacing, rows every spacing·√3/2.
#let isometric(width, height, spacing: cfg.grid.spacing, diameter: cfg.grid.dot-diameter, color: cfg.grid.color) = {
  let row = spacing * calc.sqrt(3) / 2
  let fx = _fit(width - spacing / 2, spacing)
  let fy = _fit(height, row)
  let r = diameter / 2
  let dot = circle(radius: r, fill: color, stroke: none)
  box(width: width, height: height, {
    for j in range(fy.n + 1) {
      let shift = if calc.odd(j) { spacing / 2 } else { 0pt }
      for i in range(fx.n + 1) {
        place(dx: fx.offset + shift + i * spacing - r, dy: fy.offset + j * row - r, dot)
      }
    }
  })
}

// A "flat-top" hexagon honeycomb (horizontal side on top). spacing = side length.
#let hex(width, height, spacing: cfg.grid.spacing, color: cfg.grid.color, thickness: cfg.grid.line-width) = {
  let s = spacing
  let h = s * calc.sqrt(3)
  let col = 1.5 * s
  // as many whole columns and rows as fit (with every other column shifted)
  let nx = calc.max(1, calc.floor((width - 0.5 * s) / col + 1e-6))
  let ny = calc.max(1, calc.floor((height - h / 2) / h + 1e-6))
  let ox = (width - (nx * col + 0.5 * s)) / 2
  let oy = (height - (ny * h + h / 2)) / 2
  let cell = polygon(
    stroke: thickness + color,
    (0.5 * s, 0pt), (1.5 * s, 0pt), (2 * s, h / 2), (1.5 * s, h), (0.5 * s, h), (0pt, h / 2),
  )
  box(width: width, height: height, {
    for i in range(nx) {
      let dy = if calc.odd(i) { h / 2 } else { 0pt }
      for j in range(ny) {
        place(dx: ox + i * col, dy: oy + dy + j * h, cell)
      }
    }
  })
}

// Music staff: groups of 5 lines every spacing·0.4, 2·spacing between groups.
#let staff(width, height, spacing: cfg.grid.spacing, color: cfg.grid.color, thickness: cfg.grid.line-width) = {
  let gap = spacing * 0.4
  let staff-h = 4 * gap
  let pitch = staff-h + 2 * spacing
  let n = calc.max(1, calc.floor((height - staff-h) / pitch + 1e-6) + 1)
  let oy = (height - ((n - 1) * pitch + staff-h)) / 2
  let stroke = thickness + color
  box(width: width, height: height, {
    for k in range(n) {
      for l in range(5) {
        let y = oy + k * pitch + l * gap
        place(line(start: (0pt, y), end: (width, y), stroke: stroke))
      }
    }
  })
}

// Graph paper: spacing = major square, divided into 5 minor ones;
// every other major line is bolder still (at 5 mm: 1 / 5 / 10 mm).
#let graph(width, height, spacing: cfg.grid.spacing, color: cfg.grid.color, accent: cfg.grid.accent, thickness: cfg.grid.line-width) = {
  let minor = spacing / 5
  let fx = _fit(width, spacing)
  let fy = _fit(height, spacing)
  let nx = fx.n * 5
  let ny = fy.n * 5
  let x1 = width - fx.offset
  let y1 = height - fy.offset
  let weight(i) = if calc.rem(i, 10) == 0 { 2.2 } else if calc.rem(i, 5) == 0 { 1.5 } else { 0.6 }
  // minor lines in the pattern colour, major ones (every 5 minor) in the accent; minor first
  // so the major ones end up on top
  let s(i) = thickness * weight(i) + if calc.rem(i, 5) == 0 { accent } else { color }
  box(width: width, height: height, {
    for major in (false, true) {
      for j in range(ny + 1) {
        if (calc.rem(j, 5) == 0) != major { continue }
        let y = fy.offset + j * minor
        place(line(start: (fx.offset, y), end: (x1, y), stroke: s(j)))
      }
      for i in range(nx + 1) {
        if (calc.rem(i, 5) == 0) != major { continue }
        let x = fx.offset + i * minor
        place(line(start: (x, fy.offset), end: (x, y1), stroke: s(i)))
      }
    }
  })
}

// Lines with a vertical margin line on the left (4 spacings from the edge).
#let margin-lines(width, height, spacing: cfg.grid.spacing, color: cfg.grid.color, accent: cfg.grid.accent, thickness: cfg.grid.line-width) = {
  let x = calc.min(4 * spacing, width / 4)
  box(width: width, height: height, {
    place(lines(width, height, spacing: spacing, color: color, thickness: thickness))
    place(dx: x, line(start: (0pt, 0pt), end: (0pt, height), stroke: thickness * 1.6 + accent))
  })
}

// Calligraphy ruling: spacing = x-height; above and below it, ascender and descender
// zones of the same height (dashed lines), spacing between rows.
// Thinner slant guides at 55° every 2·spacing.
#let calligraphy(width, height, spacing: cfg.grid.spacing, color: cfg.grid.color, accent: cfg.grid.accent, thickness: cfg.grid.line-width, slant: 55deg) = {
  let x = spacing
  let row = 3 * x
  let pitch = row + x
  let n = calc.max(1, calc.floor((height + x) / pitch + 1e-6))
  let oy = (height - (n * pitch - x)) / 2
  let solid = thickness + color
  let dashed = (thickness: thickness, paint: color, dash: (0.8mm, 0.8mm))
  let thin = (thickness: thickness * 0.5, paint: color)
  // horizontal run of a slant line across the row height
  let run = row / calc.tan(slant)
  let step = 2 * x
  box(width: width, height: height, clip: true, {
    for k in range(n) {
      let top = oy + k * pitch
      let hl(y, s) = place(line(start: (0pt, y), end: (width, y), stroke: s))
      hl(top, dashed)
      hl(top + x, solid)
      // baseline in the accent colour
      hl(top + 2 * x, thickness * 1.3 + accent)
      hl(top + row, dashed)
      for i in range(calc.ceil((width + run) / step) + 1) {
        let x0 = i * step
        place(line(start: (x0, top + row), end: (x0 + run, top), stroke: thin))
      }
    }
  })
}

// Seyès (French) ruling: spacing = distance between bold lines, 3 thin ones
// in between, vertical lines every spacing and a margin on the left.
#let seyes(width, height, spacing: cfg.grid.spacing, color: cfg.grid.color, accent: cfg.grid.accent, thickness: cfg.grid.line-width) = {
  let fine = spacing / 4
  let fy = _fit(height, spacing)
  let margin = calc.min(3 * spacing, width / 4)
  let fx = _fit(width - margin, spacing)
  box(width: width, height: height, {
    for j in range(fy.n * 4 + 1) {
      let y = fy.offset + j * fine
      let s = if calc.rem(j, 4) == 0 { thickness * 1.5 } else { thickness * 0.5 }
      place(line(start: (0pt, y), end: (width, y), stroke: s + color))
    }
    for i in range(fx.n + 1) {
      let x = margin + fx.offset + i * spacing
      place(line(start: (x, fy.offset), end: (x, height - fy.offset), stroke: thickness * 0.5 + color))
    }
    place(dx: margin, line(start: (0pt, 0pt), end: (0pt, height), stroke: thickness * 1.8 + accent))
  })
}

// Guitar tablature: groups of 6 lines every spacing·0.5, 2·spacing between groups.
#let tab(width, height, spacing: cfg.grid.spacing, color: cfg.grid.color, thickness: cfg.grid.line-width) = {
  let gap = spacing * 0.5
  let tab-h = 5 * gap
  let pitch = tab-h + 2 * spacing
  let n = calc.max(1, calc.floor((height - tab-h) / pitch + 1e-6) + 1)
  let oy = (height - ((n - 1) * pitch + tab-h)) / 2
  let stroke = thickness + color
  box(width: width, height: height, {
    for k in range(n) {
      let y0 = oy + k * pitch
      for l in range(6) {
        place(line(start: (0pt, y0 + l * gap), end: (width, y0 + l * gap), stroke: stroke))
      }
      // vertical bars at the start and end of the system
      for x in (0pt, width) {
        place(line(start: (x, y0), end: (x, y0 + tab-h), stroke: thickness * 1.5 + color))
      }
    }
  })
}

// Storyboard: 16:9 frames, each with 2 lines below for a description (spacing apart).
// Two columns of frames on a wide page.
#let storyboard(width, height, spacing: cfg.grid.spacing, color: cfg.grid.color, accent: cfg.grid.accent, thickness: cfg.grid.line-width) = {
  let cols = if width > 120mm { 2 } else { 1 }
  let gutter = 3mm
  let w = (width - (cols - 1) * gutter) / cols
  let frame-h = w * 9 / 16
  let cell-h = frame-h + 2 * spacing + gutter
  let n = calc.max(1, calc.floor((height + gutter) / cell-h + 1e-6))
  let oy = (height - (n * cell-h - gutter)) / 2
  let stroke = thickness + color
  box(width: width, height: height, {
    for j in range(n) {
      for i in range(cols) {
        let x = i * (w + gutter)
        let y = oy + j * cell-h
        place(dx: x, dy: y, rect(width: w, height: frame-h, stroke: thickness * 2 + accent))
        for l in (1, 2) {
          let ly = y + frame-h + l * spacing
          place(line(start: (x, ly), end: (x + w, ly), stroke: stroke))
        }
      }
    }
  })
}

// Half and half: dots at the top, lines at the bottom.
#let split(width, height, spacing: cfg.grid.spacing, diameter: cfg.grid.dot-diameter, color: cfg.grid.color, thickness: cfg.grid.line-width) = {
  let top = calc.floor(height / 2 / spacing) * spacing
  box(width: width, height: height, {
    place(dots(width, top - spacing / 2, spacing: spacing, diameter: diameter, color: color))
    place(dy: top, lines(width, height - top, spacing: spacing, color: color, thickness: thickness))
  })
}

#let kinds = (
  dots: dots,
  lines: lines,
  squares: squares,
  blank: blank,
  isometric: isometric,
  hex: hex,
  staff: staff,
  graph: graph,
  margin-lines: margin-lines,
  calligraphy: calligraphy,
  seyes: seyes,
  tab: tab,
  storyboard: storyboard,
  split: split,
)

// Fills all available space with the chosen grid.
// inset: distance of the outermost dots/lines from the edge of the area.
#let fill-grid(kind: auto, inset: 0pt) = {
  let k = if kind == auto { cfg.grid.type } else { kind }
  assert(k in kinds, message: "Unknown grid type: " + k)
  layout(size => pad(inset, (kinds.at(k))(size.width - 2 * inset, size.height - 2 * inset)))
}
