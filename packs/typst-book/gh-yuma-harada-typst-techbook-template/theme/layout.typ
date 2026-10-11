#let resolve-layout(config, profile) = {
  assert(
    profile in ("preview", "print"),
    message: "profile must be 'preview' or 'print'",
  )

  let layout = config.layout
  let print-config = config.print

  assert(
    layout.binding in ("left", "right"),
    message: "layout.binding must be 'left' or 'right'",
  )

  let binding = if layout.binding == "left" { left } else { right }
  let bleed = if profile == "print" {
    print-config.bleed_mm * 1mm
  } else {
    0mm
  }

  (
    width: layout.trim_width_mm * 1mm,
    height: layout.trim_height_mm * 1mm,
    bleed: bleed,
    binding: binding,
    margin: (
      inside: layout.margin_inside_mm * 1mm,
      outside: layout.margin_outside_mm * 1mm,
      top: layout.margin_top_mm * 1mm,
      bottom: layout.margin_bottom_mm * 1mm,
    ),
    chapter-starts-on-odd-page: layout.chapter_starts_on_odd_page,
  )
}
