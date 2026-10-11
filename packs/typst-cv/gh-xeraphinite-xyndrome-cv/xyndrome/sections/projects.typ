#import "../components/ui.typ": content-with-icon
#import "experience.typ": format-date-range, format-place, render-stack

#let project-entry(
  title: "",
  stack: none,
  role: "",
  org: "",
  start: "",
  end: "",
  location: "",
  summary: none,
  details: [],
  url: "",
  icon: none,
  icon-height: 0.95em,
  icon-baseline: 15%,
) = {
  let project-title = if url != "" { link(url)[#title] } else { title }
  let title-content = content-with-icon(
    strong[#project-title],
    icon: icon,
    height: icon-height,
    baseline: icon-baseline,
    gap: 0.15em,
  )

  let stack-text = render-stack(stack)
  let date-range = format-date-range(start, end)
  let has-stack = stack-text != none
  let has-date = date-range != none
  let place = format-place(org, location)
  let has-role = role != none and role != ""
  let has-place = place != none

  grid(
    columns: (1fr, auto),
    align(left)[
      #title-content
    ],
    align(right)[
      #if has-stack and has-date [
        #stack-text#h(0.6em)#text(size: 0.88em)[#date-range]
      ] else if has-stack [
        #stack-text
      ] else if has-date [
        #text(size: 0.88em)[#date-range]
      ]
    ],
  )

  if has-role or has-place [
    #v(-0.5em)
    #grid(
      columns: (1fr, auto),
      align(left)[
        #if has-role [
          #text(size: 0.9em, [#role])
        ]
      ],
      align(right)[
        #if has-place [
          #text(size: 0.9em, [#place])
        ]
      ],
    )
    #v(-0.2em)
  ]

  if summary != none [
    #strong(text(size: 0.85em, [#summary]))
    #v(0.1em)
  ]
  details
}

#let project = project-entry
