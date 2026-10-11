
#let titled-box(contents, title: "title", text-size: 12pt,) = box(stroke: 2pt + gray, inset: 6pt, radius: 5pt, width: 100%,
  [
    #v(2pt)
    #text(size: text-size, [#place(top+left, [#v(-1.2em) #box(fill: white, inset: 1pt, title)])])
    #v(2pt)
    #contents
  ]
)

#let non-titled-box(contents, text-size: 12pt,) = box(stroke: 2pt + gray, inset: 6pt, radius: 5pt, width: 100%,
  [
    #contents
  ]
)

#let task-lines(count) = {
  let line = (mark: rotate(30deg, text(fill: gray, "󰋙")), line: [#line(start: (0em, 1em), length: 100%)])
  [
    #grid(columns: (1em, 1fr),
          ..for _ in range(1, count) {
            (line.mark, line.line, v(1em), "")
          },
          [#line.mark], [#line.line],
    )
    #v(1pt)
  ]
}

#let note-lines(lines) = block(
  [
    #set text(size: 10pt)
    #v(0.5em)
    #for _ in range(lines) {
      line(start: (0em, 1em), stroke: (paint: black, dash: "dotted"), length: 99%)
    }
    #v(1pt)
  ]
)

#let week-box() ={
  let mark = box(text(fill: gray, rotate(30deg, "󰋙")))
  titled-box(title: "Week",
    [
      #set align(right)
      #v(-2pt)
      #grid(columns: 2,
        [
          #set text(size: 24pt, fill: gray)
          #set align(center+horizon)
          
          #h(16pt)
        ],
        [
          #set text(size: 8pt)
          #set align(left)
          #mark mon #mark tue #mark wed\
          #mark thu #mark fri
        ],
      )
    ]
  )
}

#let tracker() ={
  titled-box(title: "Tracker",
  [
    #grid(columns: (1fr, 7fr, 1fr, 8fr), row-gutter: 4pt, column-gutter: 5em,
      "Exercise:",
      [
          #set align(right)
          #text(fill: gray, "     ")
          #place(dx: 4.8pt, dy: -6.6pt, text(size: 4pt, number-width: "tabular", kerning: false, spacing: 0pt, tracking: 13.4pt, "555555"))
      ],
      "Coffee:", align(right, [#text(fill: gray, "󰛊 󰛊 󰛊   󰲄 󰲄") #h(0.3em)]),
      [],
      [
        #set align(center)
        󰘈   #h(0.5em) 󱅝 #h(0.9em) 󰎏
      ],
      "Hydrate:", align(right, [#text(fill: gray, "󰸊 󰸊 󰸊 󰸊 󰸊 󰸊") #h(0.3em)]),
    )
    #v(2pt)
  ]
)
}
