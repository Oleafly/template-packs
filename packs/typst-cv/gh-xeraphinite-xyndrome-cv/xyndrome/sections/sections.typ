/// Section heading helper that preserves the existing typography style.
/// Usage: `#sec-heading(icon: education-icon, title: "Education")`
#import "../components/ui.typ": content-with-icon

#let sec-heading(
  title: "",
  icon: none,
  level: 1,
  icon-height: 1em,
  icon-baseline: 13.5%,
  gap: 0.35em,
  subtitle: none,
  subtitle-gap: 0.5em,
) = {
  let heading-body = content-with-icon(
    title,
    icon: icon,
    height: icon-height,
    baseline: icon-baseline,
    gap: gap,
  )

  let heading-block = if subtitle == none {
    heading-body
  } else {
    [#heading-body #h(subtitle-gap) #text(size: 10.5pt, weight: "medium")[#subtitle]]
  }

  heading(level: level)[#heading-block]
}
