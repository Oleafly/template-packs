#import "@preview/cetz:0.4.2" as cetz
#import "@preview/codly-languages:0.1.8": *
#import "@preview/codly:1.3.0": *
#import "@preview/lilaq:0.5.0" as lq
#import "@preview/mannot:0.3.0": *
#import "@preview/physica:0.9.6": *
#import "@preview/showybox:2.0.4" as showybox

#let common-style(body) = {
  show raw: set text(
    font: "Monaspace Neon",
    ligatures: true,
    size: 1em,
    spacing: 100%,
  )

  set math.equation(numbering: "(1)")
  show math.equation: set block(spacing: 0.65em)
  set math.mat(delim: "[")

  set enum(indent: 10pt, body-indent: 9pt)
  set list(indent: 10pt, body-indent: 9pt)

  show link: it => {
    set text(fill: blue.darken(30%), style: "italic")
    it
  }

  show std.bibliography: set text(8pt)
  show std.bibliography: set block(spacing: 0.5em)
  set std.bibliography(title: text(10pt)[References], style: "ieee")

  show: codly-init.with()
  codly(languages: codly-languages)

  body
}

#let eq_no_num(body) = {
  math.equation(block: true, numbering: none, body)
}

#let no_indent(body) = context {
  let prev_indent = par.first-line-indent
  set par(first-line-indent: 0em)
  body
  set par(first-line-indent: prev_indent)
}

#let colored_titlebox(title: [Definition], footer: "", color: color, body) = {
  h(5mm)

  if title == none {
    showybox.showybox(
      frame: (
        body-color: color.lighten(90%),
        footer-color: color.lighten(75%),
        border-color: color.darken(50%),
        radius: (rest: 1mm),
      ),
      footer: if footer == "" { "" } else { text(emph(footer)) },
      body,
    )
  } else {
    showybox.showybox(
      title-style: (
        boxed-style: (
          anchor: (x: left, y: horizon),
          radius: (rest: 1mm),
        ),
      ),
      frame: (
        title-color: color.darken(50%),
        body-color: color.lighten(90%),
        footer-color: color.lighten(75%),
        border-color: color.darken(50%),
        radius: (rest: 1mm),
      ),
      title: title,
      footer: if footer == "" { "" } else { text(emph(footer)) },
      body,
    )
  }
}

#let definition(title: [Definition], footer: "", body) = {
  colored_titlebox(title: title, footer: footer, color: color.green, body)
}

#let theorem(title: [Theorem], footer: "", body) = {
  colored_titlebox(title: title, footer: footer, color: color.purple, body)
}

#let proof(title: [Proof], footer: "", body) = {
  colored_titlebox(title: title, footer: footer, color: color.blue, body)
}

#let note(title: [Note], footer: "", body) = {
  colored_titlebox(title: title, footer: footer, color: color.eastern, body)
}
