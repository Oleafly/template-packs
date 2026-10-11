// lib.typ - Mauve Mist Theme (Scope Fix Edition)

// ==========================================
// 1. 配色与参数
// ==========================================
#let c-bg-base   = rgb("#fdfaff")
#let c-mauve     = rgb("#cfa0c7") 
#let c-text      = rgb("#5a4a58") 
#let c-dark-purp = rgb("#2e2a36") 
#let c-glass-fill = white.transparentize(30%)

#let sidebar-width = 7cm // 侧边栏宽度
#let standard-margin = 2cm // 全宽模式下的标准边距

// ==========================================
// 2. 核心组件
// ==========================================

// Mac 代码块
#let mac-code-block(it) = {
  let mac-red    = rgb("#ff5f56")
  let mac-yellow = rgb("#ffbd2e")
  let mac-green  = rgb("#27c93f")
  block(
    width: 100%,
    fill: c-mauve.transparentize(70%),
    radius: 8pt,
    inset: 12pt,
    stroke: 1pt + c-mauve.transparentize(70%),
    {
      grid(columns: (1fr, auto), align: horizon,
        stack(dir: ltr, spacing: 6pt, circle(radius: 4pt, fill: mac-red), circle(radius: 4pt, fill: mac-yellow), circle(radius: 4pt, fill: mac-green)),
        if it.has("lang") { text(fill: white.transparentize(60%), size: 8pt, weight: "bold", font: "Fira Code", it.lang) }
      )
      v(8pt)
      set text(fill: rgb("#7a1070"), font: ("Maple Mono NF","JetBrains Mono", "Fira Code"), size: 10pt)
      set par(leading: 0.8em)
      it
    }
  )
}

// 悬浮胶囊 Callout
#let capsule-callout(title: "Note", icon: "🎈", body) = {
  v(1.5em) 
  block(
    width: 100%, breakable: false, radius: 12pt, 
    fill: white.transparentize(50%), stroke: 1.5pt + c-mauve,
    inset: (top: 1.5em, x: 1.2em, bottom: 1.2em),
    {
      place(top + left, dx: -0.5em, dy: -2.2em, box(
        fill: c-mauve, radius: 100pt, inset: (x: 1em, y: 0.4em),
        stroke: 2pt + c-bg-base,
        text(fill: white, weight: "bold", size: 10pt)[#icon #title]
      ))
      body
    }
  )
  v(0.5em)
}

// 玻璃侧边栏渲染器
#let sidebar-renderer(title, author, content) = {
  block(
    width: 100%, height: 100%,
    fill: c-glass-fill,
    stroke: (right: 1.5pt + white),
    inset: (x: 1.5em, y: 3em),
    align(center)[
      #box(radius: 50%, width: 80pt, height: 80pt, fill: c-mauve, stroke: 3pt+white, inset: 0pt)[
        #align(center+horizon, text(fill:white, size: 40pt)[🔥])
      ]
      #v(1em)
      #text(weight: "bold", size: 1.5em, title)
      #v(0.5em)
      #text(size: 0.9em, fill: c-text.lighten(30%), author)
      #v(1em)
      #line(length: 100%, stroke: 1pt + white)
      #v(1em)
      #align(left, content)
    ]
  )
}

// ==========================================
// 3. 布局逻辑 (Project)
// ==========================================

// [修复点] 这里定义为一个接受 body 的函数，用于 show 规则
#let switch-to-full-width(body) = {
  pagebreak()
  // 在这里重新设置页边距，这会影响随后传入的 body
  set page(margin: (left: standard-margin)) 
  body
}

#let project(
  title: "Untitled",
  author: "Anonymous",
  sidebar-content: [], 
  body
) = {
  let bg-layer = {
    place(top + left, rect(width: 100%, height: 100%, fill: c-bg-base))
    place(top + right, dx: 10%, dy: -10%, circle(radius: 15cm, fill: c-mauve.transparentize(85%)))
    place(bottom + left, dx: -5%, dy: 5%, circle(radius: 12cm, fill: rgb("#b39ddb").transparentize(90%)))
  }

  set page(
    paper: "a4",
    // 首页默认：左边距 = 侧边栏宽度 + 间隙
    margin: (left: sidebar-width + 1cm, right: 1.5cm, top: 2cm, bottom: 2cm),
    numbering: "1 / 1",
    background: context {
      bg-layer
      // 仅第1页显示侧边栏
      if counter(page).get().first() == 1 {
        place(left + top, block(
          width: sidebar-width, 
          height: 100%, 
          sidebar-renderer(title, author, sidebar-content)
        ))
      }
    }
  )

  set text(font: ("Times New Roman","simhei","Nunito", "Microsoft YaHei"), fill: c-text, size: 11pt, lang: "zh")
  
  show raw.where(block: true): mac-code-block
  show heading.where(level: 1): it => { v(0.5em); text(fill: c-mauve.darken(10%), size: 1.8em, weight: "black", it.body); v(0.5em) }
  show heading.where(level: 2): it => { v(1em); grid(columns: (4pt, 1fr), gutter: 8pt, block(fill: c-mauve, height: 1.2em, radius: 2pt), text(fill: c-text, weight: "bold", size: 1.2em, it.body)); v(0.5em) }

  body
}