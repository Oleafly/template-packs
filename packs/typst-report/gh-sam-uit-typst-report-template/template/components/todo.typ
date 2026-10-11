// MARK: Upgraded TODO function (Registers as a 'todo' kind figure)
#let todo(body) = {
  figure(
    kind: "todo",
    supplement: "TODO",
    caption: body, // The text acts as the caption for the Outline
    outlined: true,
    // The visual box (Red Box)
    block(
      fill: red.lighten(95%),
      stroke: 1pt + red.lighten(80%),
      inset: 1em,
      radius: 4pt,
      width: 100%,
      align(left)[
        #text(weight: "bold", fill: red.lighten(20%))[TODO:]
        #body
      ],
    ),
  )
}
