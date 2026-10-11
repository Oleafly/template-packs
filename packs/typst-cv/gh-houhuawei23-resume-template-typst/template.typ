
// 字体
#let mono = "IBM Plex Mono"
#let tnr = "Times New Roman"
#let ibm_plex_serif = "IBM Plex Serif"

#let fsong = "FangSong"
#let song = "SimSun"
#let hei = "SimHei"
#let noto = "Noto Serif CJK SC"

#let font = (
  main: tnr,
  mono: mono,
  cjk: noto
)

// 图标
#let icon(path) = box(
  baseline: 0.125em,
  height: 1.0em,
  width: 1.25em,
  image(path)
)

#let faAngleRight = icon("icons/fa-angle-right.svg")

// 主体
#let resume(
  size: 10pt, // 字体基准大小
  themeColor: rgb(38, 38, 125), // 标题颜色
  // 控制纸张的边距
  top: 1.5cm, bottom: 2cm, left: 2cm, right: 2cm,
  photograph: "", photographWidth: 0em, gutterWidth: 0em,
  need_photograph: true,
  header,
  body
) = {
  if not need_photograph {
    photographWidth = 0em
    gutterWidth = 0em
  }

  // 页边距设定
  set page(paper: "a4", numbering: "1", margin: (
    top: top,
    bottom: bottom,
    left: left,
    right: right,
  ))
  
  // 基础字体设定
  set text(font: (font.main, font.cjk), size: size, lang: "zh")

  // 标题及小标题样式
  show heading: set text(themeColor, 1.0em)

  // 二级标题下加一条横线
  show heading.where(level: 2): it => stack(
    // v(0.1em),
    it,
    v(0.1em),
    line(length: 100%, stroke: 0.03em + themeColor),
    // v(0.1em),
  )
  
  // 更改 bullet list 的图标
  // set list(indent: 1em, body-indent: 0.8em, marker: faAngleRight)
  // 上面的语句无法精确控制图标位置, 因此改用了下列方法重写 list
  show list: it => stack(spacing: 0.4em, ..it.children.map(item => {
    grid(
      columns: (1.8em, 1fr),
      gutter: (0em),
      box({
        h(0.5em)
        faAngleRight
      }),
      pad(top: 0.15em, item.body)
    )
  }))
  
  // 链接颜色
  show link: set text(fill: themeColor)
  
  // 主体设定
  set par(justify: true, spacing: 0.5em)
  
  // 首部与照片
  grid(
    columns: (auto, 1fr, photographWidth),
    gutter: (gutterWidth, 0em),
    header,
    if (photograph != "" and need_photograph) {
      image(photograph, width: photographWidth)
    }
  )
  
  body
}


// 带竖线的侧边栏
#let sidebar(
  side, 
  content, 
  withLine: true, 
  sideWidth: 12%) = context {
  let sideSize = measure(side)
  let contentSize = measure(content)
  let height = calc.max(sideSize.height, contentSize.height) + 0.4em
  grid(
    // size, line, content
    columns: (sideWidth, 0%, 1fr),
    gutter: (0.75em),
    {
      set align(right)
      v(0.25em)
      side
      v(0.25em)
    },
    if (withLine) {line(end: (0em, height), stroke: 0.05em)},
    {
      v(0.25em)
      content
      v(0.25em)
    },
  )
}


// 个人信息
#let info(
  color: black,
  ..infos
) = {
  set text(font: (font.mono, font.cjk), fill: color)
  infos.pos().map(dir => {
    box({
      if "icon" in dir {
        if (type(dir.icon) == "string") {
          icon(dir.icon)
        } else {
          dir.icon
        }
      }
      h(0.15em) // Inserts horizontal spacing into a paragraph.
      if "link" in dir {
        link(dir.link, dir.content)
      } else {
        dir.content
      }
    })
  }).join(" ")
  v(0.4em)
}

// 日期： 颜色变灰
#let date(body) = text(
  fill: rgb(128, 128, 128),
  size: 0.9em,
  body
)

// 技术: 字体斜体变细
#let tech(body) = block({
  set text(weight: "extralight", style: "italic", size: 0.9em)
  body
})

// 项目
#let item(
  columns: (60%, 1fr, auto),
  title,
  desc,
  endnote
) = {
  v(0.1em)
  grid(
    columns: columns,
    gutter: (1em),
    title, desc, endnote
  )
}

// Date

#let DateStyle = "[year]-[month]"

#let display_duration(d1: datetime, d2: datetime, style: DateStyle, date_format: true) = {
  if date_format {
    return date(d1.display(style) + "~" + d2.display(style))
  } else {
    return d1.display(style) + "~" + d2.display(style)
  }
}

#let display_date(d: datetime, style: DateStyle, date_format: true) = {
  if date_format {
    return date(d.display(style))
  } else {
    return d.display(style)
  }
}