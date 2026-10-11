/* modifid from https://github.com/memset0/ZJU-Project-Report-Template/blob/master/template.typ
by https://github.com/darstib */

#import "@preview/tablex:0.0.9": tablex, colspanx, rowspanx, hlinex, vlinex, cellx
#import "@preview/showybox:2.0.1": showybox
#import "font.typ": font_serif, font_sans_serif, font_mono

#let state-course = state("course", none)
#let state-author = state("author", none)
#let state-school-id = state("school_id", none)
#let state-date = state("date", none)
#let state-theme = state("theme", none)
#let state-block-theme = state("block_theme", none)

#let _underlined_cell(content, color: black) = {
  tablex(
    align: center + horizon,
    stroke: 0pt,
    inset: 0.75em,
    map-hlines: h => {
      if (h.y > 0) {
        (..h, stroke: 0.5pt + color)
      } else {
        h
      }
    },
    columns: 1fr,
    content,
  )
}

#let fakebold(content) = {
  set text(stroke: 0.02857em) // https://gist.github.com/csimide/09b3f41e838d5c9fc688cc28d613229f
  content
}

#let table3(
  // 三线表
  ..args,
  inset: 0.5em,
  stroke: 0.5pt,
  align: center + horizon,
  columns: 1fr,
) = {
  tablex(
    columns: 1fr,
    inset: 0pt,
    stroke: 0pt,
    map-hlines: h => {
      if (h.y > 0) {
        (..h, stroke: (stroke * 2) + black)
      } else {
        h
      }
    },
    tablex(
      ..args,
      inset: inset,
      stroke: stroke,
      align: align,
      columns: columns,
      map-hlines: h => {
        if (h.y == 0) {
          (..h, stroke: (stroke * 2) + black)
        } else if (h.y == 1) {
          (..h, stroke: stroke + black)
        } else {
          (..h, stroke: 0pt)
        }
      },
      auto-vlines: false,
    ),
  )
}

#let figurex(img, caption) = {
  show figure.caption: it => {
    set text(size: 0.9em, fill: luma(100), weight: 700)
    it
    v(0.1em)
  }
  set figure.caption(separator: ":")
  figure(
    img,
    caption: [
      #set text(weight: 400)
      #caption
    ],
  )
}

// 多图块
#let figures(columns: 2, images: (), texts: (), caption: none) = {
  figure(
    grid(
      columns: columns,
      gutter: 10pt,
      ..images
        .enumerate()
        .map(((i, img)) => [
          #stack(
            spacing: 5pt,
            align(center + horizon, img),
            align(center, text(size: 0.9em, texts.at(i))),
          )
        ]),
    ),
    caption: caption,
  )
}

#let blockx(it, name: "", color: red, theme: "default") = {
  context {
    let _theme = theme
    if (_theme == none) {
      _theme = state-block-theme.get()
    }
    if (_theme == "default") {
      let _inset = 1em
      let _color = color.darken(5%)
      v(0.2em)
      block(below: 1em, stroke: 0.5pt + _color, radius: 3pt, width: 100%, inset: _inset)[
        #place(
          top + left,
          dy: -6pt - _inset, // Account for inset of block
          dx: 8pt - _inset,
          block(fill: white, inset: 1pt)[
            #set text(font: font_mono, fill: _color)
            #text(size: 0.8em)[#name]
          ],
        )
        #set text(fill: _color)
        #set par(first-line-indent: 0em)
        #it
      ]
    } else if (_theme == "boxed") {
      showybox(
        title: name,
        frame: (
          border-color: color,
          title-color: color.lighten(20%),
          body-color: color.lighten(95%),
          footer-color: color.lighten(80%),
        ),
        it,
      )
    } else if (_theme == "float") {
      showybox(
        title-style: (
          boxed-style: (anchor: (x: center, y: horizon), radius: (top-left: 10pt, bottom-right: 10pt, rest: 0pt)),
        ),
        frame: (
          title-color: color.darken(5%),
          body-color: color.lighten(95%),
          footer-color: color.lighten(60%),
          border-color: color.darken(20%),
          radius: (top-left: 10pt, bottom-right: 10pt, rest: 0pt),
        ),
        title: name,
        [
          #it
          #v(0.25em)
        ],
      )
    } else if (_theme == "thickness") {
      showybox(
        title-style: (color: color.darken(20%), sep-thickness: 0pt, align: center),
        frame: (title-color: color.lighten(85%), border-color: color.darken(20%), thickness: (left: 1pt), radius: 0pt),
        title: name,
        it,
      )
    } else if (_theme == "dashed") {
      showybox(
        title: name,
        frame: (
          border-color: color,
          title-color: color,
          radius: 0pt,
          thickness: 1pt,
          body-inset: 1em,
          dash: "densely-dash-dotted",
        ),
        it,
      )
    } else {
      block(
        width: 100%,
        stroke: 0.5pt + red,
        inset: 1em,
        radius: 0.25em,
        align(center, text(fill: red, size: 1.2em, weight: "bold", [Unknown block theme!])),
      )
    }
  }
}

#let example(it, name: none) = blockx(
  it,
  name: if (name != none) {
    name
  } else {
    strong("Example")
  },
  color: rgb("#9479e6"),
)
#let proof(it, name: none) = blockx(
  it,
  name: if (name != none) {
    name
  } else {
    strong("Proof")
  },
  color: rgb(120, 120, 120),
)
#let abstract(it, name: none) = blockx(
  it,
  name: if (name != none) {
    name
  } else {
    strong("Abstract")
  },
  color: rgb(0, 133, 143),
)
#let summary(it, name: none) = blockx(
  it,
  name: if (name != none) {
    name
  } else {
    strong("Summary")
  },
  color: rgb(0, 133, 143),
)
#let info(it, name: none) = blockx(
  it,
  name: if (name != none) {
    name
  } else {
    strong("Info")
  },
  color: rgb(68, 115, 218),
)
#let note(it, name: none) = blockx(
  it,
  name: if (name != none) {
    name
  } else {
    strong("Note")
  },
  color: rgb(68, 115, 218),
)
#let tip(it, name: none) = blockx(
  it,
  name: if (name != none) {
    name
  } else {
    strong("Tip")
  },
  color: rgb(0, 133, 91),
)
#let hint(it, name: none) = blockx(
  it,
  name: if (name != none) {
    name
  } else {
    strong("Hint")
  },
  color: rgb(0, 133, 91),
)
#let success(it, name: none) = blockx(
  it,
  name: if (name != none) {
    name
  } else {
    strong("Success")
  },
  color: rgb(62, 138, 0),
)
#let important(it, name: none) = blockx(
  it,
  name: if (name != none) {
    name
  } else {
    strong("Important")
  },
  color: rgb(62, 138, 0),
)
#let help(it, name: none) = blockx(
  it,
  name: if (name != none) {
    name
  } else {
    strong("Help")
  },
  color: rgb(153, 110, 36),
)
#let warning(it, name: none) = blockx(
  it,
  name: if (name != none) {
    name
  } else {
    strong("Warning")
  },
  color: rgb(184, 95, 0),
)
#let attention(it, name: none) = blockx(
  it,
  name: if (name != none) {
    name
  } else {
    strong("Attention")
  },
  color: rgb(216, 58, 49),
)
#let caution(it, name: none) = blockx(
  it,
  name: if (name != none) {
    name
  } else {
    strong("Caution")
  },
  color: rgb(216, 58, 49),
)
#let failure(it, name: none) = blockx(
  it,
  name: if (name != none) {
    name
  } else {
    strong("Failure")
  },
  color: rgb(216, 58, 49),
)
#let danger(it, name: none) = blockx(
  it,
  name: if (name != none) {
    name
  } else {
    strong("Danger")
  },
  color: rgb(216, 58, 49),
)
#let error(it, name: none) = blockx(
  it,
  name: if (name != none) {
    name
  } else {
    strong("Error")
  },
  color: rgb(216, 58, 49),
)
#let bug(it, name: none) = blockx(
  it,
  name: if (name != none) {
    name
  } else {
    strong("Bug")
  },
  color: rgb(204, 51, 153),
)
#let quote(it, name: none) = blockx(
  it,
  name: if (name != none) {
    name
  } else {
    strong("Quote")
  },
  color: rgb("#302727"),
)
#let cite(it, name: none) = blockx(
  it,
  name: if (name != none) {
    name
  } else {
    strong("Cite")
  },
  color: rgb("#21201e"),
)
#let experiment(it, name: none) = blockx(
  it,
  name: if (name != none) {
    name
  } else {
    strong("Experiment")
  },
  color: rgb(132, 90, 231),
)
#let question(it, name: none) = blockx(
  it,
  name: if (name != none) {
    name
  } else {
    strong("Question")
  },
  color: rgb(132, 90, 231),
)
#let analysis(it, name: none) = blockx(
  it,
  name: if (name != none) {
    name
  } else {
    strong("Analysis")
  },
  color: rgb(0, 133, 91),
)

/* Add by @darstib */

#let option(it, name: none) = blockx(
  it,
  name: if (name != none) { name } else { strong("Option") },
  color: rgb(100, 100, 100),
)
#let comment(it, name: none) = blockx(
  it,
  name: if (name != none) { name } else { strong("Comment") },
  color: rgb(122, 115, 116),
)
#let flag(it, name: none) = blockx(
  it,
  name: if (name != none) { name } else { strong("Flag") },
  color: rgb(0, 127, 110),
)

#let prerequisite(it, name: none) = blockx(
  it,
  name: if (name != none) { name } else { strong("Prerequisite") },
  color: rgb(34, 44, 63),
)

#let superbold(content) = {
  set text(stroke: 0.06em, fill: black)
  content
}

// 使用blockx改造codex块
// #let codex(code, lang: none, size: 0.9em, border: true, name: none) = {
//   if code.len() > 0 {
//     if code.ends-with("\n") {
//       code = code.slice(0, code.len() - 1)
//     }
//   } else {
//     code = "/* no code */"
//   }
//   set text(size: size)
//   blockx(
//     align(left)[
//       #if border == true {
//         block(width: 100%, stroke: 0.2pt + luma(150), radius: 2pt, inset: 2pt, outset: 4pt)[
//           #raw(lang: lang, block: true, code)
//         ]
//       } else {
//         raw(lang: lang, block: true, code)
//       }
//     ],
//     name: if (name != none) { name } else { strong("Code") },
//     color: rgb(100, 100, 100),
//   )
// }
//

/* credit to https://github.com/platformer/typst-algorithms/blob/main/algo.typ - code */
#let codex(
  code,
  lang: none,
  size: 0.9em,
  border: true,
  name: none,
  line-numbers: true,
  line-number-styles: (:),
  column-gutter: 1em,
  row-gutter: 4pt,
  body: none,
) = {
  // 处理 Markdown 风格的代码块
  code = if body != none {
    body
  } else {
    code
  }
  let (processed-code, detected-lang) = if type(code) == str {
    // 检测是否为 Markdown 风格的代码块
    let markdown-regex = regex("^```([a-zA-Z0-9_+-]*)\n([\s\S]*?)\n```$")
    let match = code.match(markdown-regex)

    if match != none {
      // 是 Markdown 风格的代码块
      let captures = match.captures
      let block-lang = if captures.at(0) != "" { captures.at(0) } else { none }
      let block-code = captures.at(1)

      // 使用检测到的语言，如果 lang 参数没有指定的话
      let final-lang = if lang != none { lang } else { block-lang }

      (block-code, final-lang)
    } else {
      // 不是 Markdown 风格，保持原样
      (code, lang)
    }
  } else {
    // 如果 code 不是字符串（可能是 raw 类型等），保持原样
    (code, lang)
  }

  // 处理空代码的情况
  let final-code = if type(processed-code) == str {
    if processed-code.len() > 0 {
      if processed-code.ends-with("\n") {
        processed-code.slice(0, processed-code.len() - 1)
      } else {
        processed-code
      }
    } else {
      "/* no code */"
    }
  } else {
    processed-code
  }

  set text(size: size)

  let code-content = if line-numbers {
    context {
      // 分割代码为行
      let lines = if type(final-code) == str {
        final-code.split("\n")
      } else {
        // 如果是其他类型（如 raw），尝试获取文本内容
        if final-code.has("text") {
          final-code.text.split("\n")
        } else {
          str(final-code).split("\n")
        }
      }

      let num-lines = lines.len()

      // 计算行号列宽度
      let line-number-col-width = (
        measure({
          set text(..line-number-styles)
          str(num-lines)
        }).width
          + 5pt
      )

      // 构建表格数据
      let table-data = ()
      for (i, line) in lines.enumerate() {
        let line-number = i + 1

        // 添加行号
        table-data.push({
          set text(..line-number-styles)
          set text(fill: gray, size: 0.75em)
          str(line-number)
        })

        // 添加代码行
        table-data.push(raw(lang: detected-lang, line, block: true))
      }

      // 创建表格，添加分隔线
      table(
        columns: 2,
        column-gutter: column-gutter,
        row-gutter: row-gutter,
        align: (right + horizon, left + top),
        stroke: (x, y) => {
          // 在所有行的第一列右侧添加连续的虚线分隔线
          if x == 0 {
            (right: (paint: luma(180), thickness: 0.8pt, dash: "loosely-dotted"))
          } else {
            none
          }
        },
        inset: (x, y) => {
          // 调整单元格内边距，让分隔线与内容保持合适距离
          if x == 0 {
            // 行号列：右侧留更多空间
            (left: -7.5pt, right: 5pt, top: 2pt, bottom: 2pt)
          } else {
            // 代码列：左侧留更多空间
            (left: -5pt, right: 0pt, top: 2pt, bottom: 2pt)
          }
        },
        ..table-data
      )
    }
  } else {
    // 不显示行号的情况
    if type(final-code) == str {
      raw(lang: detected-lang, block: true, final-code)
    } else {
      final-code
    }
  }
  blockx(
    align(left)[
      #if border == true {
        block(width: 100%, stroke: 0.2pt + luma(150), radius: 2pt, inset: 8pt, outset: 4pt)[
          #v(-0.75em)
          #code-content
          #v(-0.25em)
        ]
      } else {
        v(gap)
        code-content
        v(gap)
      }
    ],
    name: if (name != none) { name } else {
      /* empty */
    },
    color: rgb(100, 100, 100),
  )
}
