#import "@preview/fontawesome:0.5.0": *

#let LinkEmpty(
  icon: "link",
  body,
) = {
  let BODY = {
    if icon != "" and icon != none {fa-icon(icon)}
    h(1em / 4)
    body
  }

  // Content
  box(text(BODY))
}

/// Presents a link with clickable icon
/// Example usage:
///   `Link("https://url.com")[]` <- Icon only
///   `Link("https://url.com")[Thesis]` <- Icon with label
///   `Link(icon: none, "https://url.com")[Thesis]` <- No Icon
#let Link(
  icon: "link",
  dest,
  body,
) = {
  show: underline
  link(
    dest,
    LinkEmpty(icon: icon, body),
  )
}

