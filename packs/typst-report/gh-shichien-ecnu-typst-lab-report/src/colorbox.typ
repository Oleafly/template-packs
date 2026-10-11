#import "@preview/showybox:2.0.4": showybox
#import "@preview/colorful-boxes:1.2.0": colorbox, outlinebox, slantedColorbox, stickybox
#import "@preview/fontawesome:0.6.0": *

// Colors from the official palette of the University of Strasbourg
// https://langagevisuel.unistra.fr/index.php?id=396

// 参考 Colorbox 项目如下：
// https://github.com/wardenxyz/xyznote

#let i_white = rgb("#ffffff")
#let i_black = rgb("#000000")

#let i_link-color = rgb(118, 50, 55)

#let i_grey = (
  "A": rgb("#333332"),
  "B": rgb("#929292"),
  "C": rgb("#CACACA"),
  "D": rgb("#F6F6F6"),
  "E": rgb("#696260"),
)

#let i_maroon = (
  "A": rgb("#522122"),
  "B": rgb("#96716A"),
  "C": rgb("#CDB6B3"),
  "D": rgb("#F3F0EF"),
  "E": rgb("#B0685F"),
)

#let i_brown = (
  "A": rgb("#512414"),
  "B": rgb("#AF745B"),
  "C": rgb("#D6BAAB"),
  "D": rgb("#F4EAE7"),
  "E": rgb("#BD6244"),
)

#let i_orange = (
  "A": rgb("#7D340D"),
  "B": rgb("#E94E1B"),
  "C": rgb("#FAC294"),
  "D": rgb("#FEF0E7"),
  "E": rgb("#FF4600"),
)

#let i_red = (
  "A": rgb("#8A200D"),
  "B": rgb("#E42313"),
  "C": rgb("#F6AF8F"),
  "D": rgb("#FDEDE8"),
  "E": rgb("#FF2015"),
)

#let i_pink = (
  "A": rgb("#921428"),
  "B": rgb("#E40136"),
  "C": rgb("#F4A5AA"),
  "D": rgb("#FDEDED"),
  "E": rgb("#FF1D44"),
)

#let i_purple = (
  "A": rgb("#7E0F44"),
  "B": rgb("#BF1C66"),
  "C": rgb("#F3A3C1"),
  "D": rgb("#FCEAF4"),
  "E": rgb("#FA186E"),
)

#let i_violet = (
  "A": rgb("#3B2983"),
  "B": rgb("#584495"),
  "C": rgb("#AAA5D2"),
  "D": rgb("#EDE7F4"),
  "E": rgb("#4C2ED6"),
)

#let i_nblue = (
  "A": rgb("#22398E"),
  "B": rgb("#4458A3"),
  "C": rgb("#95B5E0"),
  "D": rgb("#E7EDF9"),
  "E": rgb("#315CDD"),
)

#let i_blue = (
  "A": rgb("#003F75"),
  "B": rgb("#0070B9"),
  "C": rgb("#8CD3F6"),
  "D": rgb("#E2F3FC"),
  "E": rgb("#0095FF"),
)

#let i_cyan = (
  "A": rgb("#004C4C"),
  "B": rgb("#009194"),
  "C": rgb("#85CCD3"),
  "D": rgb("#DCEFF4"),
  "E": rgb("#00C1C1"),
)

#let i_ngreen = (
  "A": rgb("#00462E"),
  "B": rgb("#008A57"),
  "C": rgb("#73C09B"),
  "D": rgb("#E7F3EC"),
  "E": rgb("#29D49D"),
)

#let i_green = (
  "A": rgb("#004818"),
  "B": rgb("#009A3A"),
  "C": rgb("#A6D2A7"),
  "D": rgb("#EBF4E9"),
  "E": rgb("#61F275"),
)

#let i_camo = (
  "A": rgb("#3B471A"),
  "B": rgb("#89A12A"),
  "C": rgb("#D8E08E"),
  "D": rgb("#F0F5E2"),
  "E": rgb("#96D400"),
)

#let i_yellow = (
  "A": rgb("#E28E00"),
  "B": rgb("#FFCD00"),
  "C": rgb("#FFF594"),
  "D": rgb("#FFFDE8"),
  "E": rgb("#FFF028"),
)

// ----

#let colorthemes = (
  lblue: (i_blue.E, i_cyan.E),
  blue: (i_nblue.E, i_cyan.E),
  dblue: (i_nblue.E, i_blue.E),
  yellow: (i_yellow.B, i_yellow.C, i_black),
  pink: (i_pink.E, i_pink.B),
  neon: (i_violet.E, i_pink.E),
  mandarine: (i_orange.E, i_brown.E),
  hazy: (i_maroon.E, i_grey.E),
  smoke: (i_grey.E, i_black),
  forest: (i_green.A, i_camo.E),
  berry: (i_pink.A, i_purple.A),
  ocean: (i_cyan.A, i_blue.B, i_blue.D),
  lavender: (i_purple.C, i_violet.C, i_black),
  moss: (i_ngreen.C, i_grey.B, i_black),
  clay: (i_brown.B, i_maroon.C),
  mint: (i_ngreen.E, i_cyan.C, i_black),
  lemon: (i_yellow.A, i_camo.E, i_black),
  wine: (i_maroon.A, i_brown.A, i_maroon.D),
)

#let bluebox(title: "", footer: "", body) = {
  if footer != none {
    showybox(
      title: title,
      frame: (
        border-color: blue,
        title-color: blue.lighten(30%),
        body-color: blue.lighten(95%),
        footer-color: blue.lighten(80%),
      ),
      footer: footer,
    )[
      #body
    ]
  } else {
    showybox(
      title: title,
      frame: (
        border-color: blue,
        title-color: blue.lighten(30%),
        body-color: blue.lighten(95%),
        footer-color: blue.lighten(80%),
      ),
    )[
      #body
    ]
  }
}

#let greenbox(title: "", footer: "", body) = {
  if footer != none {
    showybox(
      title: title,
      frame: (
        title-color: green.darken(40%),
        body-color: green.lighten(80%),
        footer-color: green.lighten(60%),
        border-color: green.darken(60%),
        radius: (top-left: 10pt, bottom-right: 10pt, rest: 0pt),
      ),
      title-style: (
        boxed-style: (
          anchor: (
            x: center,
            y: horizon,
          ),
          radius: (top-left: 10pt, bottom-right: 10pt, rest: 0pt),
        ),
      ),
      footer: footer,
    )[
      #body
    ]
  } else {
    showybox(
      title: title,
      frame: (
        title-color: green.darken(40%),
        body-color: green.lighten(80%),
        footer-color: green.lighten(60%),
        border-color: green.darken(60%),
        radius: (top-left: 10pt, bottom-right: 10pt, rest: 0pt),
      ),
      title-style: (
        boxed-style: (
          anchor: (
            x: center,
            y: horizon,
          ),
          radius: (top-left: 10pt, bottom-right: 10pt, rest: 0pt),
        ),
      ),
    )[
      #body
    ]
  }
}

#let blackbox(title: "", footer: "", body) = {
  showybox(
    title: title,
    footer: footer,
    footer-style: (
      sep-thickness: 0pt,
      align: right,
      color: black,
    ),
  )[
    #body
  ]
}

#let dotblackbox(title: "", footer: "", body) = {
  showybox(
    frame: (
      dash: "dashed",
      border-color: red.darken(40%),
    ),
    body-style: (
      align: center,
    ),
    sep: (
      dash: "dashed",
    ),
    shadow: (
      offset: (x: 2pt, y: 3pt),
      color: yellow.lighten(70%),
    ),
    title: title,
    footer: footer,
  )[
    #body
  ]
}

#let redbox(title: "", footer: "", body) = {
  if footer != none {
    showybox(
      title: title,
      shadow: (
        color: yellow.lighten(55%),
        offset: 3pt,
      ),
      frame: (
        title-color: red.darken(30%),
        border-color: red.darken(30%),
        body-color: red.lighten(80%),
      ),
      footer: footer,
    )[
      #body
    ]
  } else {
    showybox(
      title: title,
      shadow: (
        color: yellow.lighten(55%),
        offset: 3pt,
      ),
      frame: (
        title-color: red.darken(30%),
        border-color: red.darken(30%),
        body-color: red.lighten(80%),
      ),
    )[
      #body
    ]
  }
}

#let redwhitebox(title: "", footer: "", body) = {
  showybox(
    title: title,
    footer: footer,
    frame: (
      border-color: red.darken(30%),
      title-color: red.darken(30%),
      radius: 0pt,
      thickness: 2pt,
      body-inset: 2em,
      dash: "densely-dash-dotted",
    ),
  )[
    #body
  ]
}

#let lightredbox(title: "", footer: "", body) = {
  showybox(
    title: title,
    footer: footer,
    frame: (
      border-color: red.darken(50%),
      title-color: red.lighten(60%),
      body-color: red.lighten(80%),
    ),
    title-style: (
      color: black,
      weight: "regular",
      align: center,
    ),
    shadow: (
      offset: 3pt,
    ),
  )[
    #body
  ]
}

#let h_redbox(title: "", body) = {
  showybox(
    title: title,
    frame: (
      title-color: red.lighten(80%),
      border-color: red.darken(40%),
      thickness: (left: 1pt),
      radius: 0pt,
    ),
    title-style: (
      weight: 900,
      color: red.darken(40%),
      sep-thickness: 0pt,
      align: center,
    ),
  )[
    #body
  ]
}

// 为引用设置颜色
#show ref: set text(red)

#let ADMONITION-TRANSLATIONS = (
  "task": ("en": "Task", "zh": "任务"),
  "answer": ("en": "Answer", "zh": "答案"),
  "brainstorming": ("en": "Brainstorming", "zh": "头脑风暴"),
  "question": ("en": "Question", "zh": "问题"),
  "tips": ("en": "Tips", "zh": "提示"),
  "warning": ("en": "Warning", "zh": "注意"),
  "error": ("en": "Error", "zh": "错误"),
  "solution": ("en": "Solution", "zh": "解"),
)

#let admonition(
  body,
  title: none,
  // time: none,
  primary-color: i_pink.E,
  secondary-color: i_pink.E.lighten(90%),
  tertiary-color: i_pink.E,
  dotted: false,
  figure-kind: none,
  text-color: black,
  emoji: none,
  ..args,
) = {
  let lang = args.named().at("lang", default: "en")
  set text(font: ("libertinus serif", "KaiTi")) // color-box 字体
  
  // 获取标题文本
  let title = if title == none {
    (ADMONITION-TRANSLATIONS).at(figure-kind).at(lang)
  } else {
    h(-2em)
    title
  }
  
  block(
    width: 100%,
    height: auto,
    inset: 0.2em,
    outset: 0.2em,
    fill: secondary-color,
    stroke: (
      left: (
        thickness: 5pt,
        paint: primary-color,
        dash: if dotted { "dotted" } else { "solid" },
      ),
    ),
    pad(
      left: 0.3em,
      right: 0.3em,
      text(
        size: 1.1em,
        strong(
          text(
            fill: tertiary-color,
            h(-2em) + emoji + " " + smallcaps(title),
          ),
        ),
      )
        + block(
          above: 0.8em,
          text(size: 1em, fill: text-color, body),
        ),
    ),
  )
}

#let task(body, ..args) = admonition(
  body,
  primary-color: i_nblue.E,
  secondary-color: i_nblue.E.lighten(90%),
  tertiary-color: i_nblue.E,
  figure-kind: "task",
  emoji: fa-rocket(),
  ..args,
)

#let tips(body, ..args) = admonition(
  body,
  primary-color: i_blue.E,
  secondary-color: i_blue.E.lighten(90%),
  tertiary-color: i_blue.E,
  figure-kind: "tips",
  emoji: fa-list(),
  ..args,
)

#let answer(body, ..args) = admonition(
  body,
  primary-color: i_ngreen.C,
  secondary-color: i_ngreen.C.lighten(90%),
  tertiary-color: i_ngreen.B,
  figure-kind: "answer",
  emoji: fa-key(),
  ..args,
)

#let brainstorming(body, ..args) = admonition(
  body,
  primary-color: i_pink.E.lighten(60%),
  secondary-color: i_pink.E.lighten(90%),
  tertiary-color: i_pink.E,
  figure-kind: "brainstorming",
  emoji: fa-brain(),
  ..args,
)

#let warning(body, ..args) = admonition(
  body,
  primary-color: i_yellow.B,
  secondary-color: i_yellow.B.lighten(90%),
  tertiary-color: i_yellow.A.lighten(10%),
  figure-kind: "warning",
  emoji: fa-triangle-exclamation(),
  ..args,
)

#let question(body, ..args) = admonition(
  body,
  primary-color: i_violet.E,
  secondary-color: i_violet.E.lighten(90%),
  tertiary-color: i_violet.E,
  figure-kind: "question",
  emoji: fa-q(),
  ..args,
)

#let error(body, ..args) = admonition(
  body,
  primary-color: i_orange.E,
  secondary-color: i_orange.E.lighten(90%),
  tertiary-color: i_orange.E,
  figure-kind: "error",
  emoji: fa-bomb(),
  ..args,
)

#let solution(body, ..args) = admonition(
  body,
  primary-color: i_grey.E,
  secondary-color: i_grey.E.lighten(90%),
  tertiary-color: i_grey.E,
  figure-kind: "solution",
  emoji: fa-check-double(),
  ..args,
)

#let CrossLine = block(above: 2em, below: 2em, width: 100%)[
  #set align(center)
  #set math.equation(numbering: none)
  $
    #line(start: (0em, -.15em), end: (12em, -.15em), stroke: (
      cap: "round",
      paint: gradient.linear(white, black, white),
    ))
    #move(dx: .5em, dy: 0em, "🙠")
    #text(15pt)[🙣]
    #h(0.4em)
    #move(dy: -0.25em, text(12pt)[✢])
    #h(0.4em)
    #text(15pt)[🙡]
    #move(dx: -.5em, dy: 0em, "🙢")
    #line(start: (0em, -.15em), end: (12em, -.15em), stroke: (
      cap: "round",
      paint: gradient.linear(white, black, white),
    ))
  $
]

// 书法字体设计，仅能传入一个字母
// https://sitandr.github.io/typst-examples-book/book/snippets/math/calligraphic.html
#let scr(it) = math.class(
  "normal",
  box({
    show math.equation: set text(stylistic-set: 1)
    str(it).clusters().map(x => $cal(#x)$).join()
  }),
)

// 闪烁星星包裹体
#let amazed(term, color: blue) = {
  text(color, box[✨#term✨])
}
