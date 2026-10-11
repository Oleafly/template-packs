// 字体
#let font = (
  main: "IBM Plex Serif",
  mono: "IBM Plex Mono",
  cjk: "Microsoft YaHei",
)

// 图标
#let icon(path) = box(
  baseline: 0.125em,
  height: 1.0em,
  width: 1.25em,
  image("./icons/" + path)
)

#let faAngleRight = icon("fa-angle-right.svg")



// 主体
#let resume(
  size: 10pt,
  themeColor: rgb(38, 38, 125),
  info:none,
  photo_path:none,
  body
) = {
  // 页边距设定
  set page(margin: 20pt, background: place(top + right, image("简历背景（无个人信息）.jpg")))
  
  // 基础字体设定
  set text(font: (font.main, font.cjk), size: size, lang: "zh")

  // 标题及小标题样式
  show heading: set text(themeColor, 1.1em)

  // 二级标题下加一条横线
  show heading.where(level: 2): it => stack(
    v(0.3em),
    it,
    v(0.6em),
    line(length: 100%, stroke: 0.05em + themeColor),
    v(0.1em),
  )
  
  // 更改 bullet list 的图标
  // set list(indent: 1em, body-indent: 0.8em, marker: faAngleRight)
  // 上面的语句无法精确控制图标位置, 因此改用了下列方法重写 list
  show list: it => stack(spacing: 0.4em, ..it.children.map(item => {
    grid(
      columns: (2em, 1fr),
      gutter: (0em),
      box({
        h(0.75em)
        faAngleRight
      }),
      pad(top: 0.15em, item.body)
    )
  }))
  
  // 链接颜色
  show link: set text(fill: themeColor)
  
  // 主体设定
  set par(justify: true)
  show par: set block(spacing: 0.65em)

  // 空出个人信息的位置
  box(height: 150pt)
  //个人信息
  place(top+right, 
        dx: 12pt, 
        dy: 81pt,
        box(
          width: 440pt,height: 60pt,
        )[
        #set text(fill: white, font: font.cjk, size: size+1pt, weight: 550)
        #set par(leading:13pt)
        #set align(left)
        #grid(columns: 2, column-gutter: 25pt, row-gutter: 5pt)[
          姓名：#info.name\
          院校：#info.school\
          专业：#info.major
        ][
          电话：#info.phone\
          邮箱：#info.email\
          微信：#info.wechat
        ]
        ]//box
        )
  //照片
  place(top+left, 
        dx: 0pt, 
        dy: 0pt,
        box(
          height: 40mm,
        )[
          #if photo_path != none [
            #image(photo_path)
          ]else[
            #box(fill: white,width: 30mm,height: 40mm)
            // #rect[111]
          ]
        ]//box
        )
  body
}


// 带竖线的侧边栏
#let sidebar(side, content, withLine: true, sideWidth: 12%) = style(styles => {
  let sideSize = measure(side, styles)
  let contentSize = measure(content, styles)
  let height = calc.max(sideSize.height, contentSize.height) + 0.5em
  grid(
    columns: (auto, 0%, 1fr),
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
})




// 日期： 颜色变灰
#let date(body) = text(
  fill: rgb(128, 128, 128),
  size: 0.9em,
  body
)



// 项目
#let item(
  title,
  desc,
  endnote,
  color: rgb(23, 95, 139),
) = {
  set text(fill: color)
  v(0.25em)
  grid(
    columns: (30%, 1fr, auto),
    gutter: (0em),
    title, desc, endnote
  )
}
