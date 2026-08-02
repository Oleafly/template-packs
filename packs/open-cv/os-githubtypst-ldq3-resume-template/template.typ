#let font = (
  main: "IBM Plex Serif",
  mono: "IBM Plex Mono",
  cjk: "Noto Serif CJK SC",
)

#let theme-color = rgb("#26267d")

#let icon_path = "../icons/"
/// 图标来源: https://fontawesome.com/icons/
///
/// 本地资源位于 icon_path 目录下
/// 
/// - name (str): 图标名称
/// -> box
#let icon(name) = box(
  height: 0.7em,
  width: 1.25em,
  align(
    center + horizon,
    image(bytes(read(icon_path + "fa-" + name + ".svg").replace("path d", "path fill=\"" + theme-color.to-hex() + "\" d")), height: 1em),
  ),
)

/// Three-column item
///
/// - c1 (content): 第一列内容
/// - c2 (content): 第二列内容
/// - c3 (content): 第三列内容
/// -> content
#let item_3c(c1, c2, c3) = {
  v(0.25em)
  grid(
    columns: (30%, 1fr, auto),
    gutter: 0em,
    c1, c2, c3,
  )
}

/// 用于设置页面的主要参数
///
/// - theme-color (color): 
/// - body (content): 
/// -> content
#let config(
  theme-color: rgb("#26267d"), 
  body,
) = {
  let size = 10pt // 字体和基准大小
  let margin = ( // 纸张的边距
    top: 1.5cm,
    bottom: 2cm,
    left: 2cm,
    right: 2cm,
  )
  let photograph-width = 10em
  let gutter-width = 2em

  set page(paper: "a4", numbering: "1", margin: margin)

  set text(font: (font.main, font.cjk), size: size, lang: "zh")

  show heading: set text(theme-color, 1.1em)

  show heading.where(level: 2): it => stack(
    v(0.3em),
    it,
    v(0.6em),
    line(length: 100%, stroke: 0.05em + theme-color),
    v(0.1em),
  )

  // set list(indent: 1em, body-indent: 0.8em, marker: faAngleRight)
  // 以上语句无法精确控制图标位置
  show list: it => stack(
    spacing: 0.4em,
    ..it.children.map(item => {
      grid(
        columns: (2em, 1fr),
        gutter: 0em,
        box({
          h(0.75em)
          icon("angle-right")
        }),
        pad(top: 0.15em, item.body),
      )
    }),
  )

  show link: set text(fill: theme-color)

  set par(justify: true, spacing: 1em)

  body
}

#let photograph = "../res/profile.jpg"
#let photograph-width = 10em
#let gutter-width = 2em
/// 简历头部
///
/// - center (bool): 是否居中，如设置为 `false`，则需保证变量 `photograph` 所指向的文件为头像
/// - header (dictionary): 包含：
///   - name (str): 姓名
///   - info (array): 个人基本信息，元素的数据类型为 `array`，包含：
///     0. (图标, 电话号码)
///     1. (图标, 大学)
///     2. (图标, 邮件名, 邮件地址)
///     3. (图标, github 用户名, github 主页地址)
///   - self_intro (str): 个人简介
/// -> content
#let header(
  center: false,
  header,
) = {
  let info = {
    [ = #header.name ]

    set text(font: (font.mono, font.cjk), fill: theme-color)
    set par(justify: false)
    header.info.map(dir => {
        box({
          dir.at(0)

          h(0.15em)

          if dir.len() == 2 {
            dir.at(1)
          } else {
            link(dir.at(2), dir.at(1))
          }
        })
      })
      .join(h(0.5em) + "·" + h(0.5em))
    v(0.5em)
  }

  if center {
    align(alignment.center, info)
    header.self_intro
  } else {
    grid(
      columns: (auto, 1fr, photograph-width),
      gutter: (gutter-width, 0em),
      [#info #header.self_intro],
      image(photograph, width: photograph-width)
    )
  }
}

#let side-width = 12%
/// 教育经历
/// 
/// - edu (dictionary): 包含: 
///   - time (array): 元素的数据类型为 datetime() 函数，包含入学和毕业时间
///   - college (str): 大学名称
///   - major (str): 专业
///   - gpa (str): 例如 5/5
///   - rank (str): 例如 5%
/// -> content
#let edu(edu) = layout(size => {
  let time = [
    #edu.time.at(1).display()

    #edu.time.at(0).display()
  ]
  let content = [
    *#edu.college* · #edu.major

    GPA: #edu.gpa · Rank: #edu.rank
  ]

  let side-size = measure(width: size.width, height: size.height, time)
  let content-size = measure(width: size.width * (100% - side-width), height: size.height, content)
  let height = calc.max(side-size.height, content-size.height) + 0.5em 
 
  grid(
    columns: (side-width, 0%, 1fr),
    gutter: 0.75em,
    {
      set align(right)
      v(0.25em)
      time
      v(0.25em)
    },
    { line(end: (0em, height), stroke: 0.05em) },
    {
      v(0.25em)
      content
      v(0.25em)
    },
  )
})

/// 技能
///
/// - skill (array): 包含：
///   - 0(str) name
///   - 1(percent) proficiency
/// -> block
#let skill(skill) = {
  [
    - 编程语言：#skill.lang.join(", ")
    - 命令行：#skill.shell.join(", ")
    - 文档工具：#skill.doc.join(", ")
  ]
}

/// 工作经历
/// 
/// = experience (dictionary): 包含：
///   - position (str): 职位
///   - firm (str): 公司名称
///   - time (array): 元素类型为 datetime 函数，(开始时间， 结束时间)
///   - des (array): 元素类型为 str，细节描述
#let experience(experience) = {
  item_3c(
    strong(experience.position),
    experience.firm,
    [ #experience.date.at(0).display() - #experience.date.at(1).display() ],
  )

  list(..experience.des)
}

/// 项目
///
/// - project (dictionary): 包含：
///   - name (str): 项目名称 
///   - type (str): 可选 “个人项目” 或 “团队项目”
///   - time (array): 项目起始时间和最后更新时间
///   - tech (array): 元素的数据类型给为 str
///   - intro (str): 项目简介
///   - feat (array): 元素的数据类型为 str，项目特点
/// -> content
#let project(project) = {
  item_3c(
    link(
      project.link,
      strong(project.name),
    ),
    strong(project.type),
    project.time.display()
  )

  {
    set text(weight: "extralight")

    project.tech.join(",  ")
  }

  [ \ #project.intro ]

  list(..project.feat)
}