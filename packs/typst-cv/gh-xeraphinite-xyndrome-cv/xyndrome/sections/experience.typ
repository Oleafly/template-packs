#let format-date(value) = {
  if value == none or value == "" {
    none
  } else if type(value) == datetime {
    value.display("[month repr:long] [year]")
  } else {
    value
  }
}

#let format-date-range(start, end) = {
  let start-text = format-date(start)
  let end-text = format-date(end)

  if start-text == none and end-text == none {
    none
  } else if end-text == none {
    start-text
  } else if start-text == none {
    end-text
  } else {
    [#start-text \- #end-text]
  }
}

#let format-place(org, location) = {
  let has-org = org != none and org != ""
  let has-location = location != none and location != ""

  if has-org and has-location {
    [#org \@ #location]
  } else if has-org {
    org
  } else if has-location {
    location
  } else {
    none
  }
}

#let normalize-stack-item(item) = {
  if item == none {
    ""
  } else if type(item) == str {
    item.trim()
  } else {
    str(item).trim()
  }
}

#let stack-items(stack) = {
  if stack == none or stack == "" {
    ()
  } else if type(stack) == array {
    stack.map(item => normalize-stack-item(item)).filter(item => item != "")
  } else if type(stack) == str {
    stack.split(",").map(item => normalize-stack-item(item)).filter(item => item != "")
  } else {
    let item = normalize-stack-item(stack)
    if item == "" { () } else { (item,) }
  }
}

#let render-stack(stack, size: 0.8em) = {
  let items = stack-items(stack)
  if items.len() == 0 {
    none
  } else {
    let rendered = items.map(item => text(size: size, fill: gray, font: "Inconsolata", weight: "bold")[#item])
    rendered.join(text(fill: gray)[, ])
  }
}

#let experience-entry(
  project: "",
  stack: none,
  role: "",
  org: "",
  start: "",
  end: "",
  location: "",
  summary: none,
  details: [],
) = {
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
      #strong[#project]
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
  ] else [
    #v(-0.3em)
  ]

  if summary != none [
    #strong(text(size: 0.85em, [#summary]))
    #v(0.1em)
  ]
  details
}

#let exp = experience-entry

#let service-entry(
  role: "",
  org: "",
  start: "",
  end: "",
  summary: none,
) = {
  grid(
    columns: (auto, 1fr),
    align(left)[
      #org, #strong[#role]
      #{
        if summary != none [
          \ #summary
        ]
      }
    ],
    align(right)[
      #text[
        #{
          if type(start) == datetime {
            start.display("[month repr:long] [year]")
          } else { start }
        } #{
          if end != "" [
            #{
              if type(end) == datetime {
                end.display("- [month repr:long] [year]")
              } else [\- #end]
            }
          ]
        }]
    ],
  )
}

#let ser = service-entry
