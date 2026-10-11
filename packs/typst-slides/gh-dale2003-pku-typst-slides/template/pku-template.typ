#let pku-red = rgb(160, 0, 0)
#let pku-blue = rgb(0, 64, 152)
#let pku-light-gray = rgb(245, 245, 245)

// 定义北大演示文稿主题
#let pku-theme(
  title: none,
  subtitle: none,
  author: none,
  institute: none,
  date: none,
  body,
) = {
  // 全局样式设置 - 增大整体字号
  set text(size: 18pt)
  
  // 设置中文字体，使用macOS系统上最常见的中文字体
  set text(font: ("Songti SC"))

  // 修改为4:3比例的幻灯片
  set page(
    paper: "presentation-4-3",
    margin: (x: 1.5cm, y: 1.5cm), // 进一步增加页边距，确保页眉页脚有足够空间
    header: box(
      width: 100%,
      height: 1.2cm, // 增加页眉高度
      fill: pku-light-gray,
      stroke: (bottom: 2pt + pku-blue),
      inset: (x: 20pt, y: 15pt), // 增加内边距
      grid(
        columns: (1fr, auto),
        align(left + horizon, text(fill: pku-blue, size: 12pt)[#context {
          let headings = query(heading.where(level: 1))
          if headings.len() > 0 {
            let current-page = counter(page).at(here()).first()
            let current-heading = headings.at(0).body
            
            for hdg in headings {
              if hdg.location().page() <= current-page {
                current-heading = hdg.body
              } else {
                break
              }
            }
            
            current-heading
          }
        }]),
        align(right + horizon, image("../assets/images/pku-logo.png", height: 0.6cm)),
      )
    ),
    footer: box(
      width: 100%,
      height: 1.2cm, // 增加页脚高度
      fill: pku-light-gray,
      stroke: (top: 2pt + pku-red),
      inset: (x: 20pt, y: 15pt), // 增加内边距
      context align(center + horizon, text(fill: pku-blue, size: 12pt)[第 #counter(page).display() 页]),
    ),
  )

  // 标题页 - 修复分页和页眉页脚问题
  page(
    margin: (top: 3cm, bottom: 2cm, x: 1.5cm),
    header: box(
      width: 100%,
      height: 1.2cm, 
      fill: pku-light-gray,
      stroke: (bottom: 2pt + pku-blue),
      inset: (x: 20pt, y: 15pt), 
      align(right + horizon, image("../assets/images/pku-logo.png", height: 0.6cm)),
    ),
    footer: box(
      width: 100%,
      height: 1.2cm, 
      fill: pku-light-gray,
      stroke: (top: 2pt + pku-red),
      inset: (x: 20pt, y: 15pt), 
      align(center + horizon, text(fill: pku-blue, size: 12pt)[#date]),
    ),
  )[
    #align(center)[
      #v(0.5cm)
      #image("../assets/images/pku-logo.png", height: 4cm)
      #v(0.8cm)
      #text(size: 35pt, weight: "bold", fill: pku-red)[#title]

      #if subtitle != none {
        v(0.4cm)
        text(size: 26pt, weight: "regular", fill: pku-blue)[#subtitle]
      }

      #v(0.8cm)
      #text(size: 22pt)[#author]

      #if institute != none {
        v(0.3cm)
        text(size: 20pt)[#institute]
      }
    ]
  ]

  // 目录页 - 修复序号问题
  page(
    margin: (top: 1.5cm, bottom: 1.5cm, x: 1.5cm),
    header: box(
      width: 100%,
      height: 1.2cm,
      fill: pku-light-gray,
      stroke: (bottom: 2pt + pku-blue),
      inset: (x: 20pt, y: 15pt),
      grid(
        columns: (1fr, auto),
        align(left + horizon, text(fill: pku-blue, size: 12pt)[目录]),
        align(right + horizon, image("../assets/images/pku-logo.png", height: 0.6cm)),
      )
    ),
    footer: box(
      width: 100%,
      height: 1.2cm,
      fill: pku-light-gray,
      stroke: (top: 2pt + pku-red),
      inset: (x: 20pt, y: 15pt),
      align(center + horizon, text(fill: pku-blue, size: 12pt)[目录]),
    ),
  )[
    #v(0.5cm)
    #text(size: 24pt, weight: "bold", fill: pku-red)[目录]
    #v(0.8cm)

    // 修复目录序号显示 - 增大字号
    #show outline.entry.where(level: 1): it => {
      v(0.4em)
      grid(
        columns: (1fr, auto),
        text(size: 18pt, weight: "bold", fill: pku-blue)[
          #link(it.element.location())[
            #if (
              it.element.numbering != none
            ) [#numbering(it.element.numbering, ..counter(heading).at(it.element.location()))]
            #it.element.body
          ]
        ],
        text(fill: pku-red, size: 16pt)[
          #counter(page).at(it.element.location()).first()
        ],
      )
      v(0.2em)
    }

    #show outline.entry.where(level: 2): it => {
      v(0.2em)
      grid(
        columns: (1fr, auto),
        text(size: 16pt, fill: black)[
          #h(1em)
          #link(it.element.location())[
            #if (
              it.element.numbering != none
            ) [#numbering(it.element.numbering, ..counter(heading).at(it.element.location()))]
            #it.element.body
          ]
        ],
        text(fill: pku-blue, size: 14pt)[
          #counter(page).at(it.element.location()).first()
        ],
      )
    }

    #outline(indent: auto, depth: 2)
  ]

  // 正文内容设置
  set heading(numbering: "1.") // 保留标题的内部计数器，但不在显示时使用

  // 自定义分页状态，用于控制分页行为
  let pku-pagebreak-state = state("pagebreak-enabled", true)

  // 修改一级标题：居中显示且不带序号
  show heading.where(level: 1): it => {
    // 根据状态决定是否分页
    if pku-pagebreak-state.get() {
      pagebreak(weak: false)
    }
    v(0.1cm)
    align(center, text(fill: pku-red, size: 26pt, weight: "bold")[#it.body])
  }

  // 修改二级标题：居中显示且不带序号
  show heading.where(level: 2): it => {
    // 根据状态决定是否分页
    if pku-pagebreak-state.get() {
      pagebreak(weak: false)
    }
    align(center, text(fill: pku-blue, size: 24pt, weight: "bold")[#it.body])
  }

  // 设置列表样式 - 增大字号
  set list(marker: text(fill: pku-red)[•])
  set enum(numbering: n => text(fill: pku-blue)[#n.])

  // 正文内容
  body
}

// 定义幻灯片
#let slide(title: none, body) = {
  page(
    header: box(
      width: 100%,
      height: 1.2cm,
      fill: pku-light-gray,
      stroke: (bottom: 2pt + pku-blue),
      inset: (x: 20pt, y: 15pt),
      grid(
        columns: (1fr, auto),
        align(left + horizon, text(fill: pku-blue, size: 12pt)[#context {
          let headings = query(heading.where(level: 1))
          if headings.len() > 0 {
            let current-page = counter(page).at(here()).first()
            let current-heading = headings.at(0).body
            
            for hdg in headings {
              if hdg.location().page() <= current-page {
                current-heading = hdg.body
              } else {
                break
              }
            }
            
            current-heading
          }
        }]),
        align(right + horizon, image("../assets/images/pku-logo.png", height: 0.6cm)),
      )
    ),
    footer: box(
      width: 100%,
      height: 1.2cm,
      fill: pku-light-gray,
      stroke: (top: 2pt + pku-red),
      inset: (x: 20pt, y: 15pt),
      context align(center + horizon, text(fill: pku-blue, size: 12pt)[第 #counter(page).display() 页]),
    ),
    margin: (top: 1.5cm, bottom: 1.5cm, x: 1.5cm), // 增加页边距，与全局设置保持一致
  )[
    #if title != none {
      text(size: 22pt, weight: "bold", fill: pku-red)[#title]
      v(0.5cm)
    }
    #body
  ]
}

// 定义文本块
#let pku-block(title: none, color: pku-blue, radius: 4pt, body) = {
  block(
    fill: rgb(245, 245, 245),
    stroke: (top: 3pt + color),
    radius: radius,
    width: 100%,
    inset: 10pt,
    [
      #if title != none {
        block(
          fill: color,
          width: 100%,
          inset: (x: 8pt, y: 5pt),
          radius: (top-left: radius, top-right: radius),
          text(fill: white, weight: "bold")[#title],
        )
        v(5pt)
      }
      #body
    ],
  )
}

// 定义警告块
#let pku-alert-block(title: none, body) = {
  pku-block(title: title, color: pku-red, body)
}

// 定义两栏布局
#let pku-columns(left-width, left, right) = {
  grid(
    columns: (left-width, 100% - left-width),
    column-gutter: 0.5cm,
    left, right,
  )
}

// 定义代码块样式
#let pku-code(code, lang: "python") = {
  block(
    fill: rgb(245, 245, 245),
    stroke: (left: 3pt + pku-blue),
    radius: 4pt,
    width: 100%,
    inset: 10pt,
    raw(lang: lang, code),
  )
}

// 启用或禁用分页功能
#let pku-enable-pagebreak(enabled) = {
  state("pagebreak-enabled").update(enabled)
}

// 新增：手动强制分页函数
#let pku-pagebreak() = {
  pagebreak(weak: false)
}
