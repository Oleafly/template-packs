#import "@preview/pointless-size:0.1.2": zh

// ctyp配置：字体/编号
#let ctyp_settings(ctyp, enum-label, item-label) = {
  return (
    ctyp(
      fontset-cjk: "windows", // 使用Windows的字体家族
      font-cjk-map: (
          text: (cjk: "song", latin: "serif"), // 正文
          strong: (cjk: "song", latin: "sans"), // 加粗
          emph: (cjk: "kai", latin: "serif"), // 斜体
          raw: (cjk: "fang", latin: "mono"), // 代码块
          heading: (cjk: "hei", latin: "sans"), // 标题
      ),
      font-latin: (
          serif: "Times New Roman",
          sans: "Arial",
          mono: "JetBrains Mono"
      ),
      heading-numbering: (
          (
              format: "第1章",
              sep: 1em,
              align: center
          ),
          "1.1",
          "1.1.1"
      ),
      fix-enum-args: (
        indent: 2em,
        numberer: (
            enum-label(
              "(1)",
              width: 1em,
              alignment: left,
            ),
            "a.",
            enum-label("i)", width: 1em, alignment: right),
          )
        ),
      fix-list-args: (
        marker: (
          item-label(sym.suit, width: 1em),
          sym.dash
        )
      )
    )
  )
}

// 标题格式配置
#let get_heading_config(fonts) = {
  return (
    "1": (
      size: zh("四号"), 
      font-cjk: fonts.hei,
      font-latin: "sans",
      weight: "bold",
      align: center, 
      above: 1.5em, 
      below: 3.5em,
      pagebreak: true
    ),
    "2": (
      size: zh("四号"), 
      font-cjk: fonts.song,
      font-latin: "sans",
      weight: "regular", 
      align: left, 
      above: 1.8em, 
      below: 1.9em,
      pagebreak: false
    ),
    "3": (
      size: zh("小四"), 
      font-cjk: fonts.hei,
      font-latin: "sans",
      weight: "regular", 
      align: left, 
      above: 2em, 
      below: 1.8em,
      pagebreak: false
    ),
  )
}


// 正文配置
#let get_body_config() = (
  size: zh("小四"),
  weight: "regular",
  leading: 1.25em,
  justify: true,
)
