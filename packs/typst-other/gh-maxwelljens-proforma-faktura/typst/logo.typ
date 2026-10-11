// Logo helper — call in the invoice body.
// Pass a pre-loaded image (not a path) so paths resolve from the
// calling file, not from this module.
#let logo-it(
  img: none,
  corner: top + right,
  offset: (x: -2cm, y: 1.5cm),
) = context {
  if img != none {
    place(corner, dx: offset.x, dy: offset.y, img)
  }
}
