#import "@preview/touying:0.7.4": *
#import "@preview/showybox:2.0.4": *
// #import "@preview/codelst:2.0.2": sourcecode
#import "@preview/zebraw:0.6.3": *

// Emphasized box (for equations)
#let _emphbox(self: none, body) = {
  set align(center)
  box(
    stroke: 1pt + self.colors.box.lighten(20%),
    radius: 5pt,
    inset: 0.5em,
    fill: self.colors.box.lighten(80%),
  )[#body]
}
#let emphbox(body) = touying-fn-wrapper(_emphbox.with(body))
//----

#let _subtitle(self: none, body) = {
  if self.store.navigation == "topbar" {
    set text(size: 1.2em, fill: self.colors.primary, weight: "bold")
    place(top + left, pad(left: -0.8em, top: -0.25em, body))
    v(1em)
  }
}
#let subtitle(body) = touying-fn-wrapper(_subtitle.with(body))

//---- Utilities for boxes ----
#let box-title(a, b) = {
  grid(columns: 2, column-gutter: 0.5em, align: (horizon),
    a,
    b
  )
}

#let colorize(svg, color) = {
  let blk = black.to-hex();
  if svg.contains(blk) {
    svg.replace(blk, color.to-hex())
  } else {
    svg.replace("<svg ", "<svg fill=\""+color.to-hex()+"\" ")
  }
}

#let color-svg(
  path,
  color,
  ..args,
) = {
  let data = colorize(read(path), color)
  return image(bytes(data), ..args)
}
//----

//---- Utility boxes ----
// Information box
#let _info(self: none, body) = {
  set text(size: 0.8em)

  showybox(
    title: box-title(color-svg("resources/assets/icons/info.svg", self.colors.info, width: 1em), [*Note*]),
    title-style: (
      color: self.colors.info,
      sep-thickness: 0pt,
    ),
    frame: (
      title-color: self.colors.info.lighten(80%),
      border-color: self.colors.info,
      body-color: none,
      thickness: (left: 3pt),
      radius: (top-left: 0pt, bottom-right: 1em, top-right: 1em),
    )
  )[#body]
}
#let info(body) = touying-fn-wrapper(_info.with(body))

// Tip box
#let _tip(self: none, body) = {
  set text(size: 0.8em)

  showybox(
    title: box-title(color-svg("resources/assets/icons/light-bulb.svg", self.colors.tip, width: 1em), [*Tip*]),
    title-style: (
      color: self.colors.tip,
      sep-thickness: 0pt,
    ),
    frame: (
      title-color: self.colors.tip.lighten(80%),
      border-color: self.colors.tip,
      body-color: none,
      thickness: (left: 3pt),
      radius: (top-left: 0pt, bottom-right: 1em, top-right: 1em),
    )
  )[#body]
}
#let tip(body) = touying-fn-wrapper(_tip.with(body))

// Important box
#let _important(self: none, body) = {
  set text(size: 0.8em)
  showybox(
    title: box-title(color-svg("resources/assets/icons/report.svg", self.colors.important, width: 1em), [*Important*]),
    title-style: (
      color: self.colors.important,
      sep-thickness: 0pt,
    ),
    frame: (
      title-color: self.colors.important.lighten(80%),
      border-color: self.colors.important,
      body-color: none,
      thickness: (left: 3pt),
      radius: (top-left: 0pt, bottom-right: 1em, top-right: 1em),
    )
  )[#body]
}
#let important(body) = touying-fn-wrapper(_important.with(body))

// Question box
#let _question(self: none, body) = {
  set text(size: 0.8em)
  showybox(
    title: box-title(color-svg("resources/assets/icons/question.svg", self.colors.question, width: 1em), [*Question*]),
    title-style: (
      color: self.colors.question,
      sep-thickness: 0pt,
    ),
    frame: (
      title-color: self.colors.question.lighten(80%),
      border-color: self.colors.question,
      body-color: none,
      thickness: (left: 3pt),
      radius: (top-left: 0pt, bottom-right: 1em, top-right: 1em),
    )
  )[#body]
}
#let question(body) = touying-fn-wrapper(_question.with(body))

// Code box
// #let _code(self: none, lang: none, body) = sourcecode(
//     frame: showybox.with(
//       title: [*Code* #h(1fr) #strong(lang)],
//       frame: (
//         title-color: self.colors.primary,
//         border-color: self.colors.primary,
//         body-color: none,
//         thickness: (left: 3pt),
//         radius: (top-left: 0pt, top-right: 1em),
//       )
//     ),
//     body
// )
#let _code(self: none, lang: none, body) = showybox(
    title: [#h(00.5em)*Code* #h(1fr) #strong(lang)],
    frame: (
      title-color: self.colors.primary,
      border-color: self.colors.primary,
      body-color: none,
      thickness: (left: 3pt),
      radius: (top-left: 0pt, top-right: 1em),
      body-inset: (top: 0em, bottom: 0em, left: 0.1em)
    )
  )[#zebraw(lang:false, indentation: 2)[#body]]
)
#let code(lang: none, body) = touying-fn-wrapper(_code.with(lang: lang, body))

// Custom box
#let _custom-box(self: none, type, title, color, size: 0.8em, body) = {
  set text(size: size)

  let type-box = if type.contains("info") {
    "resources/assets/icons/info.svg"
  } else if type.contains("tip") {
    "resources/assets/icons/light-bulb.svg"
  } else if type.contains("important") {
    "resources/assets/icons/report.svg"
  } else if type.contains("question") {
    "resources/assets/icons/question.svg"
  } else {
    "resources/assets/icons/info.svg"
  }

  showybox(
    title: box-title(color-svg(type-box, color, width: 1em), [*#title*]),
    title-style: (
      color: color,
      sep-thickness: 0pt,
    ),
    frame: (
      title-color: color.lighten(80%),
      border-color: color,
      body-color: none,
      thickness: (left: 3pt),
      radius: (top-left: 0pt, bottom-right: 1em, top-right: 1em),
    )
  )[#body]
}
#let custom-box(type, title, color, body) = touying-fn-wrapper(_custom-box.with(type, title, color, body))

// Centered box
#let _cbox(self: none, title, color, body) = {
  showybox(
  title: [*#title*],
  title-style: (
    boxed-style: (
      anchor: (x: center, y: horizon)
    )
  ),
  frame: (
    title-color: color,
    border-color: color,
    body-color: color.lighten(80%),
    thickness: 2pt
  ),
  align: center
)[
  #body
  #v(0.5em)
]
}
#let cbox(title, color, body) = touying-fn-wrapper(_cbox.with(title, color, body))

// Link box
#let _link-box(self: none, location, name) = {
  block(fill: self.colors.primary, radius: 1em, inset: 0.5em)[
    #set text(size: 0.8em, weight: "bold")
    #show link: set text(fill: white)
    #link(location, name)
  ]
}
#let link-box(location, name) = touying-fn-wrapper(_link-box.with(location, name))