#import "../components/ui.typ": content-with-icon

#let text-size-override = state("text-size-override", none)

#let artifact-entry(
  name: "",
  tech: (),
  description: "",
  url: "",
  icon: none,
  icon-height: 0.9em,
  icon-baseline: 15%,
  year: "",
) = {
  let tech-list = if tech == none {
    ()
  } else if type(tech) == array {
    tech
  } else if type(tech) == str {
    tech.split(",").map(item => item.trim()).filter(item => item != "")
  } else {
    (str(tech),)
  }
  let artifact_name = content-with-icon(
    strong[#name],
    icon: icon,
    height: icon-height,
    baseline: icon-baseline,
    gap: 0.15em,
  )

  context {
    let active-size = text-size-override.get()
    let content = grid(
      columns: (1fr, 2fr, 1.5fr, auto),
      column-gutter: 1.25em,
      align(left)[#text(style: "italic", font: "Maple Mono")[#artifact_name]],
      align(left)[#text(style: "italic")[#description]],
      align(left)[#{ if tech-list.len() > 0 [ #tech-list.join(",  ") ] }],
      align(right)[#{ if year != "" [#year] }],
    )

    if active-size == none {
      content
    } else {
      text(size: active-size)[#content]
    }
  }
}

#let artifact = artifact-entry
