#import "@preview/rustycure:0.2.0": qr-code

#let in-outline = state("in-outline", false)
#let flex-caption(short, long) = {
  context if in-outline.get() {
    short
  } else {
    long
  }
}

#let to-string(it) = {
  if type(it) == str {
    it
  } else if type(it) != content {
    str(it)
  } else if it.has("text") {
    it.text
  } else if it.has("children") {
    it.children.map(to-string).join()
  } else if it.has("body") {
    to-string(it.body)
  } else if it == [ ] {
    " "
  }
}

#let code(lang: "sh", text) = {
  block(
    fill: luma(240),
    inset: 6pt,
    radius: 4pt,
    raw(to-string(text), lang: lang, block: true),
  )
}

#let qr-code-link(href, size: 7em, stroke: 1pt + black, ..body) = {
  table(
    columns: 2,
    align: horizon,
    stroke: stroke,
    [
      #if body != none {
        link(href, ..body)
      } else {
        link(href)
      }
    ],
    [
      #qr-code(href, width: size, height: size)
    ],
  )
}
