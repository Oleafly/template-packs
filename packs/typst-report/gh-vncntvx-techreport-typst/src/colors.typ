// 莫配色

// 核心色彩
#let morandi-blue = rgb("#6B8EB5")
#let morandi-green = rgb("#7BA68D")
#let morandi-coral = rgb("#D49A8C")
#let morandi-purple = rgb("#9B8AB4")
#let morandi-yellow = rgb("#D9C77A")
#let morandi-teal = rgb("#6BA3A8")
#let morandi-orange = rgb("#C4977A")

// 语义色彩
// 
/// 主色 - 标题、链接
#let primary = morandi-blue

/// 次要色 - 副标题、次要元素
#let secondary = rgb("#7A7A7A")

/// 强调色 - 重点内容
#let accent = morandi-coral

/// 成功色 - 正向提示
#let success = morandi-green

/// 警告色 - 注意事项
#let warning = morandi-orange

/// 信息色 - 代码、引用
#let info = morandi-teal

// ============================================================
// 背景色
// ============================================================

/// 浅灰背景 - 带微暖色调
#let bg-light = rgb("#FAF9F7")

/// 卡片背景 - 纯净白
#let bg-card = rgb("#FFFFFF")

/// 代码背景 - 微暖灰
#let bg-code = rgb("#F7F6F3")

/// 盒子背景色（各主题色的浅色版本）
#let bg-blue = rgb("#EEF3F8")
#let bg-green = rgb("#EDF3EF")
#let bg-coral = rgb("#F8F0EE")
#let bg-purple = rgb("#F3F0F7")
#let bg-teal = rgb("#EEF4F5")
#let bg-yellow = rgb("#FAF8EC")
#let bg-orange = rgb("#F7F2EE")

// 文本色
// 
/// 正文色 - 深灰，易于阅读
#let text-primary = rgb("#2D2D2D")

/// 次要文本 - 中灰
#let text-secondary = rgb("#5A5A5A")

/// 浅色文本 - 浅灰
#let text-muted = rgb("#8A8A8A")

// 边框色
// 
/// 默认边框
#let border = rgb("#D8D8D8")

/// 浅边框
#let border-light = rgb("#E8E8E8")

// 配色组
// 
#let theme = (
  blue: (color: morandi-blue, bg: bg-blue),
  green: (color: morandi-green, bg: bg-green),
  coral: (color: morandi-coral, bg: bg-coral),
  purple: (color: morandi-purple, bg: bg-purple),
  teal: (color: morandi-teal, bg: bg-teal),
  yellow: (color: morandi-yellow, bg: bg-yellow),
  orange: (color: morandi-orange, bg: bg-orange),
)

/// 获取主题色
#let get-color(name) = {
  theme.at(name, default: (color: morandi-blue, bg: bg-blue)).color
}

/// 获取主题背景色
#let get-bg(name) = {
  theme.at(name, default: (color: morandi-blue, bg: bg-blue)).bg
}
