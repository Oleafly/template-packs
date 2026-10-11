// 字体定义 — 浙江大学本科毕业论文格式
#let fonts = (
  // 英文字体
  main: ("Times New Roman", "Arial", "Calibri"),
  // 英文字体 (Cambria — 用于英文题目)
  cambria: ("Cambria", "Times New Roman"),

  // 中文字体
  cjk: (
    "FangSong",         // 仿宋 — 正文主字体
    "SimSun",           // 宋体 — 参考文献
    "SimHei",           // 黑体
    "KaiTi",            // 楷体
    "Microsoft YaHei",
  ),

  // 仿宋系列 — 正文/标题主字体
  fang: (
    "FangSong",         // 仿宋 (GB2312)
    "STFangsong",       // 华文仿宋
    "Microsoft YaHei",
  ),

  // 宋体系列 — 参考文献/图表标题
  song: (
    "SimSun",           // 宋体
    "NSimSun",          // 新宋体
    "STSong",           // 华文宋体
    "Microsoft YaHei",
  ),

  // 黑体系列
  hei: (
    "SimHei",           // 黑体
    "STXihei",          // 华文细黑
    "Microsoft YaHei",
  ),

  // 楷体系列
  kai: (
    "KaiTi",            // 楷体
    "STKaiti",          // 华文楷体
    "Microsoft YaHei",
  ),
)

// 全局字体设置
#let font-setup() = {
  set text(
    font: fonts.main + fonts.cjk,
    size: 12pt,
    lang: "zh",
    region: "cn"
  )

  // 1.5倍行距（浙大规范）
  set par(
    leading: 1.5em,
    justify: true,
    first-line-indent: 2em
  )
}

// 字体快捷函数
#let fangsong(content) = text(font: fonts.fang, content)
#let songti(content) = text(font: fonts.song, content)
#let heiti(content) = text(font: fonts.hei, content)
#let kaiti(content) = text(font: fonts.kai, content)
