// MARK: Call Out Boxes

// Generic Callout Function
#let callout(body, title: "Note", color: blue, icon: "i") = {
  block(
    fill: color.lighten(90%),
    stroke: (left: 4pt + color),
    radius: 4pt,
    inset: 1em,
    width: 100%,
    below: 1em,
  )[
    #stack(
      dir: ltr,
      spacing: 0.5em,
      // text(weight: "bold", fill: color)[#icon],
      text(weight: "semibold", fill: color)[#title],
    )
    // #v(0.1em)
    #body
  ]
}

// Note/Information
#let co-note(body, title: "Note") = callout(body, title: title, color: blue, icon: "n")
#let co-info(body, title: "Info") = callout(body, title: title, color: teal, icon: "i")

// Alert/Warning
#let co-warn(body, title: "Warning") = callout(body, title: title, color: orange, icon: "w")

// Error/Critical
#let co-erro(body, title: "Error") = callout(body, title: title, color: red, icon: "e")

// Success/Important
#let co-succ(body, title: "Success") = callout(body, title: title, color: green, icon: "s")
