#let Skill(
  body,
  underline: underline,
) = {
  let style = if type(underline) == function {
    x => underline(x)
  } else { x => x }

  show: style
  set text(hyphenate: false)
  box(body)
}

/// List of skills with an optional header
/// Example usage:
///   `Skills(header: [Data & Analytics], [Skill 1], [Skill 2])`
///   `Skills(delimeter: h(1em), [Skill 1], [Skill 2])`
///   `Skills(aligned: left, [Skill 1], [Skill 2])`
///   `Skills(underline: none, [Skill 1], [Skill 2])`
#let Skills(
  header: none,
  delimeter: h(1em),
  aligned: center,
  underline: underline,
  ..skills,
) = {
  let mapped = skills
    .pos()
    .map(s => {
      Skill(s, underline: underline)
    })
  if header != none [
    === #header
  ]
  show: align.with(aligned)
  mapped.join(delimeter)
}
