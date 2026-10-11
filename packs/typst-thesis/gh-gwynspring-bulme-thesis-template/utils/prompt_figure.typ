#import "../globals.typ": lightblue, lighterblue, mainblue

#let prompt-figure(title: "", tool: "", model: "", body) = {
  figure(
    caption: title,
    kind: "prompt",
    supplement: [Prompt],
    block(
      width: 100%,
      stroke: none,
      inset: 0pt,
      table(
        columns: 1fr,
        stroke: none,
        inset: 6pt,
        table.cell(fill: mainblue, align: left)[
          *#title*
          #h(1fr)
          #text(size: 8pt)[#tool #if model != "" [ | #model]]
        ],
        table.cell(fill: lighterblue, align: left)[
          #block(width: 100%, raw(body))
        ],
      ),
    ),
  )
}
