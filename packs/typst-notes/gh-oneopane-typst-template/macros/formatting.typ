// Formatting helpers and callouts.

#let callout(title, body, fill) = block(fill: fill, inset: 10pt, radius: 5pt, width: 100%)[
  *#title*

  #body
]
#let note(body) = callout("Note.", body, rgb("#eef6ff"))
#let warning(body) = callout("Warning.", body, rgb("#fff3cd"))
#let todo(body) = callout("TODO.", body, rgb("#fdeaea"))

#let term(x) = emph(x)
#let key(x) = strong(x)
#let hr() = line(length: 100%)
#let space(amount: 1em) = v(amount)
