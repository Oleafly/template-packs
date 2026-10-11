// 字体与字号配置模块

#import "utils.typ": merge-dict

// ============================================================
// 字体配置
// ============================================================

/// 默认字体配置（跨平台回退）
#let fonts = (
  serif: ("Times New Roman", "SimSun"),
  sans: ("Arial", "Microsoft YaHei"),
  mono: ("Courier New"),
  code: ("Courier New"),
  cjk: ("SimSun", "Microsoft YaHei"),
)

/// macOS 字体配置
#let fonts-macos = (
  serif: ("Times New Roman", "Songti SC", "STSong", "SimSun"),
  sans: ("Helvetica Neue", "PingFang SC", "Microsoft YaHei"),
  mono: ("SF Mono", "Menlo", "Monaco", "Courier New"),
  code: ("SF Mono", "Menlo", "Monaco"),
  cjk: ("PingFang SC", "Songti SC", "STSong", "SimSun"),
)

/// Windows 字体配置
#let fonts-windows = (
  serif: ("Times New Roman", "SimSun", "宋体"),
  sans: ("Microsoft YaHei", "微软雅黑", "Arial"),
  mono: ("Consolas", "Courier New"),
  code: ("Consolas", "Courier New"),
  cjk: ("Microsoft YaHei", "SimSun", "宋体"),
)

/// Linux 字体配置
#let fonts-linux = (
  serif: ("Noto Serif CJK SC", "Source Han Serif SC", "SimSun"),
  sans: ("Noto Sans CJK SC", "Source Han Sans SC", "WenQuanYi Micro Hei"),
  mono: ("JetBrains Mono", "Fira Code", "Noto Sans Mono CJK SC"),
  code: ("JetBrains Mono", "Fira Code", "DejaVu Sans Mono"),
  cjk: ("Noto Sans CJK SC", "Source Han Sans SC", "WenQuanYi Micro Hei"),
)

/// 默认字体配置别名
#let fonts-default = fonts

/// 获取字体列表
#let get-fonts(category) = {
  fonts.at(category, default: fonts.default)
}

/// 代码字体
#let code-font = fonts.code

/// 正文字体
#let body-font = fonts.serif

/// CJK 字体
#let cjk-font = fonts.cjk

// ============================================================
// 字号配置
// ============================================================

/// 中文字号对照表
#let font-size = (
  四号: 14pt,
  小四: 12pt,
  五号: 10.5pt,
)

/// 默认字号配置
///
/// 基于 base-size 自动计算各元素字号
#let default-size-config(base-size: 13pt) = {
  (
    text: base-size,
    math: (
      text: base-size - 0.5pt,  // 行内公式
      block: base-size - 0.5pt, // 独立公式
    ),
    figure: base-size - 1pt,  // 图件标题
    table: base-size - 1pt,   // 表格标题
    raw: base-size - 2pt,     // 代码块
    heading: (
      default: base-size,
      H1: base-size + 1.5pt,
      H2: base-size + 1.0pt,
      H3: base-size + 0.5pt,
      H4: base-size + 0.5pt,
      H5: base-size + 0.5pt,
      H6: base-size + 0.5pt,
    ),
  )
}

/// 定义字号配置
#let define-size(base-size, user-config: (:)) = {
  let default = default-size-config(base-size: base-size)
  merge-dict(default, user-config)
}

/// 应用字号配置的 show 规则
#let apply-size-config(config) = {
  set text(size: config.text)

  show math.equation: set text(size: config.math.text)
  show math.equation.where(block: true): set text(size: config.math.block)

  show figure.caption: set text(size: config.figure)
  show figure.caption.where(kind: table): set text(size: config.table)

  show raw: set text(size: config.raw)

  show heading.where(level: 1): set text(size: config.heading.H1)
  show heading.where(level: 2): set text(size: config.heading.H2)
  show heading.where(level: 3): set text(size: config.heading.H3)
  show heading.where(level: 4): set text(size: config.heading.H4)
  show heading.where(level: 5): set text(size: config.heading.H5)
  show heading.where(level: 6): set text(size: config.heading.H6)
}

/// 为表格应用自定义字号样式
#let table-styled(tbl, config: (text: 11pt, math: 10pt)) = {
  show table.cell: it => {
    set text(size: config.text)
    show math.equation: set text(size: config.math)
    it
  }
  tbl
}

// ============================================================
// 字体设置函数
// ============================================================

/// 设置正文字体
#let set-body-font() = {
  set text(font: body-font)
}

/// 设置代码字体
#let set-code-font() = {
  set text(font: code-font)
}

/// 设置 CJK 字体
#let set-cjk-font() = {
  set text(font: cjk-font)
}
