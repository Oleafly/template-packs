// Hand-drawn vector icons (no emoji fonts needed).
#import "theme.typ": palette

#let _dot(x, y, r, fill) = place(top + left, dx: x - r, dy: y - r, circle(radius: r, fill: fill))

/// Cat face.
#let cat(size: 1.4em, fill: palette.sun.darken(10%), ink: palette.ink) = box(width: size, height: size, {
  let s = size
  // ears
  place(top + left, polygon(fill: fill, (0.06 * s, 0.45 * s), (0.14 * s, 0.02 * s), (0.44 * s, 0.24 * s)))
  place(top + left, polygon(fill: fill, (0.94 * s, 0.45 * s), (0.86 * s, 0.02 * s), (0.56 * s, 0.24 * s)))
  // head
  place(top + left, dx: 0.06 * s, dy: 0.16 * s, ellipse(width: 0.88 * s, height: 0.78 * s, fill: fill))
  // eyes
  _dot(0.34 * s, 0.5 * s, 0.065 * s, ink)
  _dot(0.66 * s, 0.5 * s, 0.065 * s, ink)
  // nose
  place(top + left, polygon(fill: palette.coral, (0.44 * s, 0.62 * s), (0.56 * s, 0.62 * s), (0.5 * s, 0.69 * s)))
  // whiskers
  let w = 0.6pt + ink
  place(top + left, line(start: (0.3 * s, 0.68 * s), end: (0.0 * s, 0.63 * s), stroke: w))
  place(top + left, line(start: (0.3 * s, 0.72 * s), end: (0.0 * s, 0.76 * s), stroke: w))
  place(top + left, line(start: (0.7 * s, 0.68 * s), end: (1.0 * s, 0.63 * s), stroke: w))
  place(top + left, line(start: (0.7 * s, 0.72 * s), end: (1.0 * s, 0.76 * s), stroke: w))
})

/// Dog face with floppy ears.
#let dog(size: 1.4em, fill: rgb("#C98B5A"), ink: palette.ink) = box(width: size, height: size, {
  let s = size
  let ear = fill.darken(30%)
  // head
  place(top + left, dx: 0.14 * s, dy: 0.1 * s, ellipse(width: 0.72 * s, height: 0.82 * s, fill: fill))
  // ears
  place(top + left, dx: 0.0 * s, dy: 0.12 * s, rotate(18deg, ellipse(width: 0.26 * s, height: 0.56 * s, fill: ear)))
  place(top + left, dx: 0.74 * s, dy: 0.12 * s, rotate(-18deg, ellipse(width: 0.26 * s, height: 0.56 * s, fill: ear)))
  // muzzle
  place(top + left, dx: 0.3 * s, dy: 0.55 * s, ellipse(width: 0.4 * s, height: 0.3 * s, fill: fill.lighten(45%)))
  // eyes
  _dot(0.38 * s, 0.43 * s, 0.06 * s, ink)
  _dot(0.62 * s, 0.43 * s, 0.06 * s, ink)
  // nose
  place(top + left, dx: 0.41 * s, dy: 0.57 * s, ellipse(width: 0.18 * s, height: 0.11 * s, fill: ink))
})

/// Little robot. `angle` tilts it (e.g. 70deg = falling over).
#let robot(size: 1.6em, fill: palette.blue, angle: 0deg) = box(width: size, height: size, {
  let s = size
  let body = {
    let b = box(width: s, height: s, {
      // antenna
      place(top + left, line(start: (0.5 * s, 0.04 * s), end: (0.5 * s, 0.14 * s), stroke: 1.2pt + palette.ink))
      _dot(0.5 * s, 0.05 * s, 0.045 * s, palette.coral)
      // head
      place(top + left, dx: 0.28 * s, dy: 0.14 * s, rect(width: 0.44 * s, height: 0.26 * s, radius: 0.06 * s, fill: fill))
      _dot(0.41 * s, 0.27 * s, 0.045 * s, white)
      _dot(0.59 * s, 0.27 * s, 0.045 * s, white)
      // torso
      place(top + left, dx: 0.24 * s, dy: 0.43 * s, rect(width: 0.52 * s, height: 0.3 * s, radius: 0.06 * s, fill: fill.darken(15%)))
      // arms
      place(top + left, line(start: (0.24 * s, 0.48 * s), end: (0.1 * s, 0.64 * s), stroke: (paint: palette.ink, thickness: 2pt, cap: "round")))
      place(top + left, line(start: (0.76 * s, 0.48 * s), end: (0.9 * s, 0.64 * s), stroke: (paint: palette.ink, thickness: 2pt, cap: "round")))
      // legs
      place(top + left, line(start: (0.38 * s, 0.73 * s), end: (0.36 * s, 0.94 * s), stroke: (paint: palette.ink, thickness: 2.4pt, cap: "round")))
      place(top + left, line(start: (0.62 * s, 0.73 * s), end: (0.64 * s, 0.94 * s), stroke: (paint: palette.ink, thickness: 2.4pt, cap: "round")))
    })
    if angle == 0deg { b } else { rotate(angle, origin: bottom + center, b) }
  }
  body
})

/// Robot that has just fallen: tilted robot, motion marks and a ground line.
#let robot-fallen(size: 1.6em, fill: palette.blue) = box(width: size * 1.6, height: size, {
  let s = size
  place(top + left, dx: 0.62 * s, robot(size: s, fill: fill, angle: -62deg))
  // motion marks (it was walking to the right, then tipped over to the left)
  for (i, y) in (0.2, 0.32, 0.44).enumerate() {
    place(top + left, line(start: (1.3 * s - i * 0.04 * s, y * s), end: (1.55 * s - i * 0.04 * s, (y - 0.06) * s), stroke: 1pt + palette.muted))
  }
  place(top + left, line(start: (0pt, 0.97 * s), end: (1.6 * s, 0.97 * s), stroke: 1.2pt + palette.muted))
})

/// Standing robot on the ground.
#let robot-standing(size: 1.6em, fill: palette.blue) = box(width: size, height: size, {
  place(top + left, robot(size: size, fill: fill))
  place(top + left, line(start: (0pt, 0.97 * size), end: (size, 0.97 * size), stroke: 1.2pt + palette.muted))
})

/// Person (head + shoulders).
#let person(size: 2em, fill: palette.ink) = box(width: size, height: size, {
  let s = size
  place(top + left, dx: 0.32 * s, dy: 0.08 * s, circle(radius: 0.18 * s, fill: fill))
  place(top + left, dx: 0.12 * s, dy: 0.5 * s, box(width: 0.76 * s, height: 0.45 * s, clip: true,
    ellipse(width: 0.76 * s, height: 0.9 * s, fill: fill)))
})

/// Magnifying glass.
#let magnifier(size: 2em, fill: palette.ink) = box(width: size, height: size, {
  let s = size
  place(top + left, dx: 0.1 * s, dy: 0.1 * s, circle(radius: 0.28 * s, stroke: (0.09 * s) + fill))
  place(top + left, line(start: (0.62 * s, 0.62 * s), end: (0.9 * s, 0.9 * s), stroke: (paint: fill, thickness: 0.12 * s, cap: "round")))
})

/// Train seen from the front.
#let train(size: 2em, fill: palette.ink) = box(width: size, height: size, {
  let s = size
  place(top + left, dx: 0.18 * s, dy: 0.08 * s, rect(width: 0.64 * s, height: 0.68 * s, fill: fill))
  place(top + left, dx: 0.26 * s, dy: 0.16 * s, rect(width: 0.48 * s, height: 0.24 * s, fill: white))
  place(top + left, dx: 0.27 * s, dy: 0.52 * s, circle(radius: 0.06 * s, fill: palette.sun))
  place(top + left, dx: 0.61 * s, dy: 0.52 * s, circle(radius: 0.06 * s, fill: palette.sun))
  place(top + left, line(start: (0.28 * s, 0.76 * s), end: (0.14 * s, 0.94 * s), stroke: (0.06 * s) + fill))
  place(top + left, line(start: (0.72 * s, 0.76 * s), end: (0.86 * s, 0.94 * s), stroke: (0.06 * s) + fill))
})

/// Calendar page.
#let calendar(size: 2em, fill: palette.ink) = box(width: size, height: size, {
  let s = size
  place(top + left, dx: 0.1 * s, dy: 0.14 * s, rect(width: 0.8 * s, height: 0.76 * s, stroke: (0.06 * s) + fill))
  place(top + left, dx: 0.1 * s, dy: 0.14 * s, rect(width: 0.8 * s, height: 0.2 * s, fill: fill))
  for r in range(2) {
    for c in range(3) {
      let on = r == 1 and c == 1
      place(top + left, dx: (0.2 + c * 0.22) * s, dy: (0.44 + r * 0.22) * s,
        rect(width: 0.14 * s, height: 0.14 * s, fill: if on { palette.coral } else { fill.transparentize(70%) }))
    }
  }
  place(top + left, line(start: (0.3 * s, 0.06 * s), end: (0.3 * s, 0.2 * s), stroke: (0.06 * s) + fill))
  place(top + left, line(start: (0.7 * s, 0.06 * s), end: (0.7 * s, 0.2 * s), stroke: (0.06 * s) + fill))
})
