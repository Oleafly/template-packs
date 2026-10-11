// ============================================================
// 复旦大学学位论文 Typst 模板 - 全局配置
// 规范依据：《复旦大学博士、硕士学位论文规范（2026 年 6 月修订版）》
// ============================================================

// 字号定义（中文字号 → pt 映射）
#let font-size = (
  初号: 42pt,
  小初: 36pt,
  一号: 26pt,
  小一: 24pt,
  二号: 22pt,
  小二: 18pt,
  三号: 16pt,
  小三: 15pt,
  四号: 14pt,
  小四: 12pt,
  五号: 10.5pt,
  小五: 9pt,
  六号: 7.5pt,
  小六: 6.5pt,
  七号: 5.5pt,
)

// 字体族定义。前两项是仓库 CI/Linux 上的可复现组合：
// Tinos 与 Times New Roman 字宽兼容，Noto CJK 用作宋/黑体的开源替代。
// 如学院要求指定字库，可将 SimSun/SimHei 或 Times New Roman 放到专用
// 字体目录，并使用 `typst compile --font-path <dir> main.typ`。
#let font-family = (
  宋体: ("Tinos", "Noto Serif CJK SC"),
  黑体: ("Tinos", "Noto Sans CJK SC"),
  楷体: ("Tinos", "AR PL KaitiM GB", "Noto Serif CJK SC"),
  仿宋: ("Tinos", "Noto Serif CJK SC"),
  行楷: ("AR PL KaitiM GB", "Noto Serif CJK SC"),
  等宽: ("Liberation Mono", "Noto Sans Mono CJK SC"),
)

// Word 中文环境默认 A4 页边距：上/下 2.54 cm，左/右 3.17 cm。
#let page-margin = (top: 2.54cm, bottom: 2.54cm, left: 3.17cm, right: 3.17cm)

// 规范要求正文固定行距 20 pt。Typst 的 par.leading 是字形行框之间的
// 附加距离，不能按“12 pt 字号 + leading”直接相加。对模板使用的
// Noto Serif CJK SC 12 pt 正文，11.25 pt leading 对应约 20 pt 基线距。
#let body-leading = 11.25pt

// 规范版本，用于 PDF 元数据和教程。
#let specification-version = "2026 年 6 月修订版"

// 供章节、图表公式编号和前置清单共享的附录状态。
#let appendix-mode = state("fudan-thesis-appendix-mode", false)

// 学校信息
#let school-code = "10246"
#let school-name = "复旦大学"

// 引用记号
#let ref-markers = (
  图: "图",
  表: "表",
  公式: "式",
  节: "节",
  代码: "代码",
)
