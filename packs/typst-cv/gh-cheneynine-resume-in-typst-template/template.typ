// 字体
#let font = (
  main: "PingFang SC", // 更改主要字体为苹方
  mono: "PingFang SC", // 更改等宽字体为苹方，若需要等宽效果，可能需要找到适合的等宽字体或保留原设置
  cjk: "PingFang SC", // 保持 CJK 字体设置为苹方，确保中文显示一致性
)

#let cell = box.with()
// 图标
#let icon(path) = box(
  baseline: 0.125em,
  height: 1.0em,
  width: 1.25em,
  align(center + horizon, image(path))
)

#let faAngleRight = icon("icons/fa-angle-right.svg")

// 主体
#let resume(
  size: 10pt,
  themeColor: rgb(38, 38, 125),
  top: 1.5cm,
  bottom: 2cm,
  left: 2cm,
  right: 2cm,
  photograph: "",
  photographWidth: 0em,
  gutterWidth: 0em,
  backgroundImage: "",
  header,
  body
) = {
  // 页边距设定
  set page(paper: "a4", numbering: none, margin: (
    top: top,
    bottom: bottom,
    left: left,
    right: right,
  ),
  background:image(backgroundImage)
  )
  
  // 基础字体设定
  set text(font: (font.main, font.cjk), size: size, lang: "zh")
  // 标题及小标题样式
  show heading: set text(themeColor, 1.1em)
  show heading: set block(spacing: 0.85em)

  // 二级标题下加一条横线
  show heading.where(level: 2): it => stack(
    v(0em), //段前
    it,
    v(0.25em), //线条前
    line(start:(0%,0%),end:(100%,0%),length: 50%, stroke: 0.06em + themeColor,),
    v(0em), //线条后
  )

  // 链接颜色
  show link: set text(fill: themeColor)
  
  // 主体设定
  set par(justify: true,leading:0.5em)
  show par: set block(spacing: 0em)
  
  // 首部与照片
  grid(
    columns: (auto, 1fr, photographWidth),
    gutter: (gutterWidth, 0em),
    header,
    if (photograph != "") {
      image(photograph, width: photographWidth)
    }
  )
  body
}


// 个人信息
#let info(
  color: black,
  ..infos
) = {
    set text(font: (font.mono, font.cjk), fill: color)
    set par(justify: true)
    infos.pos().map(dir => {
      box({
        if "icon" in dir {
          if (type(dir.icon) == "string") {
            icon(dir.icon)
          } else {
            dir.icon
          }
        }
        h(0.15em)
        if "link" in dir {
          underline(link(dir.link, dir.content))
        } else {
          dir.content
        }
      })
    }).join(h(0.5em) + " " + h(0.5em))
    
}


// 日期： 颜色变灰
#let date(body) = text(
  fill: rgb(128, 128, 128),
  size: 0.9em,
  body
)


// 技术: 字体变细
#let tech(body) = block({
  set text(weight: "extralight")
  body
})

// 项目
#let item(
  title,
  desc,
  endnote
) = {
  grid(
    columns: (41%, 2fr, auto),
    gutter: (0.5em),
    title, desc, endnote
  )
}
