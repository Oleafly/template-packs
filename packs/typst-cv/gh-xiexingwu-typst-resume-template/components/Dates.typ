#import "@preview/fontawesome:0.5.0": *

/// Render a calendar icon with a date range (or date if only 1 content block given)
/// Example usage:
///   `Dates[Jan25][Present]`
///   `Dates[Jan25]`
///   `Dates(icon:none)[Jan25]`
#let Dates(
  icon: "calendar-minus",
  ..dates,
) = {
  let argc = dates.pos().len()
  assert(argc >= 1 and argc <= 2)
  set text(fill: gray)
  // set text(..style)

  // Content
  if icon != "" and icon != none { fa-icon(icon) }
  h(1em / 4)
  if argc == 2 {
    dates.pos().join([---])
  } else if argc == 1 {
    dates.pos().at(0)
  }
}
