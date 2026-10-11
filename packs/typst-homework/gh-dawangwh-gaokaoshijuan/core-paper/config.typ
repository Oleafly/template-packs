// =============================================================================
// 全局配置字典 (Exam Config)
// 所有页面和排版参数集中管理。
// =============================================================================
#let config-default = (
  // 1. 页面几何与布局 (Page geometry)
  page: (
    paper: "a3",
    flipped: false,
    margin: (top: 2.45cm, bottom: 1.8cm, left: 4cm, right: 4cm),
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

  // 3. 选择题专用配置 (Options)
  options: (
    row-gap: 1.2em,
    column-gap: 1.5em,
  ),

  // 4. 试卷头部 (Header)
  header: (
    title-above-gap: 1.5em,
    title-size: 13pt,
    subject-size: 21pt,
    exam-title: [2026 年普通高等学校招生全国统一考试],
    secret-label: [绝密★启用前],
    subject-title: [数　学]
  ),

  // 5. 注意事项 (Notes)
  notice: (
    size: 11pt,
    weight: "bold",  // 注意事项标题字重（notice-title）
  ),

  // 5.1 卷首区 (Cover meta)：本试卷共… / 使用范围… 等自由文本块
  // 参考注意事项排版：字号取 notice.size，字重取本项
  cover: (
    weight: "bold",
    leading: auto,   // 可选：覆盖 cover-meta 行距；auto = typography.leading
    spacing: auto,   // 可选：覆盖 cover-meta 段间距；auto = leading
  ),

  // 5.2 附图 (Figures)：多图网格的间距（#figure-grid 宏读取）
  figure: (
    above: 0.6em,
    column-gutter: 1em,
    row-gap: 0.6em,
  ),

  // 6. 页脚与杂项 (Footer & misc)
  footer: (
    subject: [数学],
    total-pages: 4,
    size: 9pt,          // 自动页脚字号（apply-paper-config 使用；A3 对开手工 paper-footer 不用）
    bottom-gap: 0.4cm,  // Typst footer-descent（页脚相对正文位置）；页脚到底边的距离 = margin.bottom - 该值 - 页脚高
    autofooter: true,   // 自动页脚（A4 流式）：apply-paper-config 里统一设置，页码自动；A3 对开设 false
  ),
  
  // 填空题专用
  blank-width: 3cm,
)
