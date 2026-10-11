#import "heading_utils.typ": get_chapter_number

/// Create a chapter ribbon (requires context)
#let draw_chapter_ribbon(
  color: black,
  top_offset: 28mm,
) = {
  if state("enable_chapter_ribbon").get() == true {
    let chapter_number = get_chapter_number()
    if chapter_number == 0 {
      return
    }

    if calc.odd(here().page()) {
      let b = box(
        width: 4em, height: 2em, inset: 0.5em, fill: color, radius: (left: 0.5em),
        align(left, text([#h(1mm) #chapter_number], fill: white, size: 1.5em, weight: "bold"))
      )

      place(top + right, dy: top_offset, b)
    } else {
      let b = box(
        width: 4em, height: 2em, inset: 0.5em, fill: color, radius: (right: 0.5em),
        align(right, text([#chapter_number #h(1mm)], fill: white, size: 1.5em, weight: "bold"))
      )

      place(top + left, dy: top_offset, b)
    }
  }
}


/// Create cutting marks on the corners of the page (requires context)
#let draw_cutting_marks(
  size: 2.5mm,
  offset: 3mm,
) = {
  if calc.odd(here().page()) {
    // Top right corner
    place(top + right, dy: offset, line(length: size))
    place(top + right, dx: -offset, line(length: size, angle: 90deg))
    // bottom right corner
    place(bottom + right, dy: -offset, line(length: size))
    place(bottom + right, dx: -offset, line(length: size, angle: 90deg))
  } else {
    // Top left corner
    place(top + left, dy: offset, line(length: size))
    place(top + left, dx: offset, line(length: size, angle: 90deg))
    // bottom left corner
    place(bottom + left, dy: -offset, line(length: size))
    place(bottom + left, dx: offset, line(length: size, angle: 90deg))
  }
}