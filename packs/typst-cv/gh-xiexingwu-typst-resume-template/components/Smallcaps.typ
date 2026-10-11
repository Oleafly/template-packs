/// Simulate smallcaps for any string
///
/// - body (content):
/// - ratio (float): Proportion of uppercase chars to disply lowercase chars
/// - tracking (length): Simulated tracking (spacing between chars)
/// -> content
#let Smallcaps(
  body,
  ratio: 0.8,
  tracking: 0.1em,
) = {
  // Recursively handle body of content blocks
  if type(body) == content {
    let Smallcaps = Smallcaps.with(ratio: ratio, tracking: tracking)
    // Sequence of content blocks
    if body.has("children") {
      return body.children.map(c => Smallcaps(c)).sum()
    } else if body.has("text") {
      return Smallcaps(body.text)
    } else if body == [ ] {
      return [ ]
    } else {
      panic("Unprocessed content block:" + repr(body))
    }
  }

  body
    .clusters()
    .map(c => {
      if c.match(regex("[A-Z]")) != none {
        c
      } else if c.match(regex("[a-z]")) != none {
        set text(size: 1em * ratio)
        upper(c)
      } else {
        set text(size: 1em * ratio)
        c
      }
    })
    .join(h(tracking))
}
