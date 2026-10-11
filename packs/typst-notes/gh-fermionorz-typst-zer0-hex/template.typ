// 默认变量
#let Title = "笔记模板"
#let Author = "Zer0-hex"
#let Date = datetime.today().display()
#let Paper = "a4"
#let CoverBackGround = "./background.png"
#let Logo = "./logo.png"
// 字体设置
#let HeadFont = "Open Sans"
#let TextFont = "Source Han Serif SC"
#let CodeFont = "FiraCode Nerd Font Mono"
#let HSize = (20pt, 18pt, 16pt, 14pt, 12pt)
#let TextSize = 12pt

// 封面
#let paper_cover(title:none, author:none, date:none, background: none, logo: none) = {
  // 设置页面
  let fg = none
  let bg = none
  if background != none {
    bg = image(
      CoverBackGround,
      width: 100%,
      height: 100%,
    )
  }
  if logo != none {
    fg = move(
      dx: -30%,
      dy: 0%,
      image(
        logo, 
        height: 15%, 
        width: 15%
      )
    )
  }
  set page(
    margin: (top: 10%),
    background: bg,
    foreground: fg,
  )
  // 标题
  if title != none {
    align(
      horizon + center, 
      text(
        size: 32pt, 
        weight: "regular",
        title,
      ),
    )
  }
  // 作者
  if author != none {
    align(
      center + horizon, 
      text(
        size: 16pt, 
        weight: "regular",
        author
      ),
    )
  }
  // 时间
  if date != none {
    align(
      top + right, 
      text(
        size: 12pt, 
        weight: "regular",
        // fill:rgb("#ABCDEF"),
        date
      ),
    )
  }
}

// 目录
#let paper_outline() = {
  set page(paper: Paper)
  outline(
        title: text(size: HSize.at(1), "目录"),
        depth: 4,
    )
}

// 正文
#let paper_content(body) = {
  // 标题设置
  set heading(numbering: "1.1")
  show heading.where(level: 1): set text(HSize.at(0))
  show heading.where(level: 2): set text(HSize.at(1))
  show heading.where(level: 3): set text(HSize.at(2))
  show heading.where(level: 4): set text(HSize.at(3))
  show heading.where(level: 5): set text(HSize.at(4))

  // 内容设置
  set text(font: TextFont, size: TextSize, weight: "regular")
  body
}

// Main
#let paper(title: Title, author: Author, date: Date, background: CoverBackGround, logo: none, body) = {
  // 配置全局页面
  set page(paper: Paper)
  // 全局字体设置
  
  // Show 封面
  paper_cover(title:title, author:author, date: date, background:background, logo: logo)
  // 目录
  paper_outline()
  // Show 正文
  paper_content(body)

  
}

#show: paper.with(
  title: Title, 
  author: Author, 
  date: Date, 
  logo: Logo, 
)

= 标题1
== 标题2
== A.B
=== A.A.A
==== A.A.A.A
===== A.A.A.A.A
====== A.A.A.A.A.A
= B
====== A.A.A.A.A.A
====== A.A.A.A.A.A

#for i in (1, 2, 3, 4, 5) [
  #i
]


