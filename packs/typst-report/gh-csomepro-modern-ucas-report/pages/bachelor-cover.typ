#import "../utils/datetime-display.typ": datetime-display
#import "../utils/style.typ": 字号, 字体

// 本科生封面
#let bachelor-cover(
  // documentclass 传入的参数
  anonymous: false,
  twoside: false,
  fonts: (:),
  info: (:),
  // 其他参数
  stoke-width: 0.5pt,
  min-title-lines: 2,
  info-inset: (x: 0pt, bottom: 1pt),
  info-key-width: 72pt,
  info-key-font: "楷体",
  info-value-font: "楷体",
  column-gutter: -3pt,
  row-gutter: 11.5pt,
  anonymous-info-keys: ("grade", "student-id", "author", "supervisor", "supervisor-ii"),
  bold-info-keys: ("title",),
  bold-level: "bold",
  datetime-display: datetime-display,
) = {
  // 1.  默认参数
  fonts = 字体 + fonts
  info = (
    title: ("XXX课程论文", "副标题副标题"),
    grade: "20XX",
    student-id: "1234567890",
    author: "张三",
    department: "某学院",
    major: "某专业",
    supervisor: ("李四", "教授"),
    submit-date: datetime.today(),
  ) + info

  // 2.  对参数进行处理
  // 2.1 如果是字符串，则使用换行符将标题分隔为列表
  if type(info.title) == str {
    info.title = info.title.split("\n")
  }
  // 2.2 根据 min-title-lines 填充标题
  info.title = info.title + range(min-title-lines - info.title.len()).map((it) => "　")
  // 2.3 处理提交日期
  if type(info.submit-date) == datetime {
    info.submit-date = datetime-display(info.submit-date)
  }

  // 3.  内置辅助函数
  let info-key(body) = {
    rect(
      width: 100%,
      inset: info-inset,
      stroke: none,
      text(
        font: fonts.at(info-key-font, default: "楷体"),
        size: 字号.三号,
        body
      ),
    )
  }

  let info-value(key, body) = {
    set align(center)
    rect(
      width: 100%,
      inset: info-inset,
      stroke: (bottom: stoke-width + black),
      text(
        font: fonts.at(info-value-font, default: "宋体"),
        size: 字号.三号,
        weight: if key in bold-info-keys { bold-level } else { "regular" },
        bottom-edge: "descender",
        body,
      ),
    )
  }

  let info-long-value(key, body) = {
    grid.cell(colspan: 3,
      info-value(
        key,
        if anonymous and (key in anonymous-info-keys) {
          "██████████"
        } else {
          body
        }
      )
    )
  }

  let info-short-value(key, body) = {
    info-value(
      key,
      if anonymous and (key in anonymous-info-keys) {
        "█████"
      } else {
        body
      }
    )
  }
  

  // 4.  正式渲染
  
  pagebreak(weak: true, to: if twoside { "odd" })

  // 居中对齐
  set align(center)

  // 匿名化处理去掉封面标识
  if anonymous {
    v(52pt)
  } else {
    // 封面图标
    v(6pt)
    // image("../assets/vi/nju-emblem.svg", width: 2.38cm)
    v(22pt)
    // 调整一下左边的间距
    pad(image("../assets/vi/ucas_logo.svg", width: 15.5cm), left: 0.4cm)
    v(40pt)
  }

  // 将中文之间的空格间隙从 0.25 em 调整到 0.5 em
  text(size: 字号.一号, font: fonts.宋体, spacing: 200%, weight: "bold", info.title.at(0))
  v(10pt)
  text(size: 字号.二号, font: fonts.宋体, spacing: 200%, weight: "bold", info.title.at(1))
  
  if anonymous {
    v(155pt)
  } else {
    v(160pt)
  }

  block(width: 318pt, grid(
    columns: (info-key-width, 1fr, info-key-width, 1fr),
    column-gutter: column-gutter,
    row-gutter: row-gutter,

    info-key("学生姓名"),
    info-long-value("author", info.author),
    info-key("学　　号"),
    info-long-value("student-id", info.student-id),
    info-key("院　　所"),
    info-long-value("institute", info.institute),

    ) + align(center,
      text(
          font: fonts.at(info-value-font, default: "宋体"),
          size: 字号.三号,
          weight: "regular" ,
          bottom-edge: "descender",
          info.submit-date,
        )
    )
  )
}