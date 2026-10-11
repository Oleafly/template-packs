

#import "../../core-paper/lib.typ": *
#let paper-config = (
  // 1. 页面几何与布局 (Page geometry)
  page: (
    paper: "a3",
    flipped: true,
    margin: (top: 2.45cm, bottom: 1.75cm, left: 4cm, right: 4cm),
    spread-gutter: 3cm,
    spread-line-stroke: 1pt,
  ),
  // 2. 全局排版与字体 (Global typography)
  typography: (
    fonts: ("Songti SC", "STSong"),
    size: 13pt,
    first-line-indent: 2em,
    par-above: 2em,
    item-above: 1.2em,
    label-width: 2em,
    leading: 1.2em,
  ),

  // 3. 试卷头部 (Header)
  header: (
    title-above-gap: 1.5em,
    title-size: 13pt,
    subject-size: 21pt,
    exam-title: [2026 年普通高等学校招生全国统一考试],
    secret-label: [绝密★启用前],
    subject-title: [数 学],
  ),

  // 4. 注意事项 (Notes)
  notice: (
    size: 11pt,
  ),

  // 5. 选择题专用配置 (Options)
  options: (
    row-gap: 1.2em,
    column-gap: 1.5em,
  ),

  // 填空题专用
  blank-width: 3cm,
  
  // 6. 页脚与杂项 (Footer & misc)
  footer: (
    subject: [数学],
    total-pages: 4,
    bottom-gap: 1cm,   // 页脚文字距页面底边的距离
    autofooter: false,       // A3 对开用半页页码，关闭自动页脚
  ),

)
