#let get-theme(theme: "blue-pink") = {
  let themes = (
    // 蓝粉主题（清新柔和）
    "blue-pink": (
      // 主要色
      primary: rgb(164, 197, 218), // 温柔湖水蓝
      secondary: rgb(224, 187, 198), // 淡雅玫瑰粉
      accent: rgb(183, 206, 206), // 薄荷绿调和色
      // 功能色（带次要变体）
      background: (
        base: rgb(246, 240, 237), // 温暖米白
        secondary: rgb(238, 232, 229), // 深米白
      ),
      text: (
        base: rgb(71, 84, 103), // 深邃靛青
        secondary: rgb(92, 104, 121), // 浅靛青
      ),
      border: (
        base: rgb(201, 215, 223), // 柔和边框蓝
        secondary: rgb(181, 198, 208), // 深边框蓝
      ),
    ),
    // 纯白主题（简约优雅）
    "white": (
      // 主要色
      primary: rgb(157, 178, 191), // 清澈天空蓝
      secondary: rgb(215, 196, 187), // 温润赭石色
      accent: rgb(190, 198, 196), // 清爽薄荷灰
      // 功能色（带次要变体）
      background: (
        base: rgb(255, 255, 255), // 纯净白
        secondary: rgb(245, 245, 245), // 浅灰白
      ),
      text: (
        base: rgb(82, 92, 101), // 典雅墨灰
        secondary: rgb(102, 111, 119), // 浅墨灰
      ),
      border: (
        base: rgb(225, 229, 232), // 珍珠灰边框
        secondary: rgb(206, 211, 215), // 深珍珠灰
      ),
    ),
    // 暗黑主题（深邃高级）
    "dark": (
      // 主要色
      primary: rgb(87, 121, 145), // 深海蓝
      secondary: rgb(147, 112, 123), // 暗玫瑰
      accent: rgb(108, 128, 128), // 深青灰
      // 功能色（带次要变体）
      background: (
        base: rgb(28, 32, 37), // 午夜黑
        secondary: rgb(36, 40, 45), // 深午夜黑
      ),
      text: (
        base: rgb(201, 206, 212), // 暗月光白
        secondary: rgb(168, 175, 183), // 更暗月光白
      ),
      border: (
        base: rgb(64, 73, 82), // 石墨灰
        secondary: rgb(51, 58, 65), // 深石墨灰
      ),
    ),
  )

  // 返回指定主题的颜色方案，如果主题不存在则返回默认主题（蓝粉）
  return themes.at(theme, default: themes.at("blue-pink"))
}

#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 8pt,
  rect(radius: 4pt, fill: get-theme(theme: "dark").primary, width: 100%, height: 64pt),
  rect(radius: 4pt, fill: get-theme(theme: "dark").accent, width: 100%, height: 64pt),
  rect(radius: 4pt, fill: get-theme(theme: "dark").secondary, width: 100%, height: 64pt),

  rect(radius: 4pt, fill: get-theme(theme: "dark").background.base, width: 100%, height: 64pt),
  rect(radius: 4pt, fill: get-theme(theme: "dark").background.secondary, width: 100%, height: 64pt),
  rect(radius: 4pt, fill: get-theme(theme: "dark").text.base, width: 100%, height: 64pt),

  rect(radius: 4pt, fill: get-theme(theme: "dark").text.secondary, width: 100%, height: 64pt),
  rect(radius: 4pt, fill: get-theme(theme: "dark").border.base, width: 100%, height: 64pt),
  rect(radius: 4pt, fill: get-theme(theme: "dark").border.secondary, width: 100%, height: 64pt),
)

#h(32pt)

#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 8pt,
  rect(radius: 4pt, fill: get-theme(theme: "white").primary, width: 100%, height: 64pt),
  rect(radius: 4pt, fill: get-theme(theme: "white").accent, width: 100%, height: 64pt),
  rect(radius: 4pt, fill: get-theme(theme: "white").secondary, width: 100%, height: 64pt),

  rect(radius: 4pt, fill: get-theme(theme: "white").background.base, width: 100%, height: 64pt),
  rect(radius: 4pt, fill: get-theme(theme: "white").background.secondary, width: 100%, height: 64pt),
  rect(radius: 4pt, fill: get-theme(theme: "white").text.base, width: 100%, height: 64pt),

  rect(radius: 4pt, fill: get-theme(theme: "white").text.secondary, width: 100%, height: 64pt),
  rect(radius: 4pt, fill: get-theme(theme: "white").border.base, width: 100%, height: 64pt),
  rect(radius: 4pt, fill: get-theme(theme: "white").border.secondary, width: 100%, height: 64pt),
)

#h(32pt)

#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 8pt,
  rect(radius: 4pt, fill: get-theme(theme: "blue-pink").primary, width: 100%, height: 64pt),
  rect(radius: 4pt, fill: get-theme(theme: "blue-pink").accent, width: 100%, height: 64pt),
  rect(radius: 4pt, fill: get-theme(theme: "blue-pink").secondary, width: 100%, height: 64pt),

  rect(radius: 4pt, fill: get-theme(theme: "blue-pink").background.base, width: 100%, height: 64pt),
  rect(radius: 4pt, fill: get-theme(theme: "blue-pink").background.secondary, width: 100%, height: 64pt),
  rect(radius: 4pt, fill: get-theme(theme: "blue-pink").text.base, width: 100%, height: 64pt),

  rect(radius: 4pt, fill: get-theme(theme: "blue-pink").text.secondary, width: 100%, height: 64pt),
  rect(radius: 4pt, fill: get-theme(theme: "blue-pink").border.base, width: 100%, height: 64pt),
  rect(radius: 4pt, fill: get-theme(theme: "blue-pink").border.secondary, width: 100%, height: 64pt),
)
// 使用示例：
// let colors = get-theme(theme: "dark")
// 使用主色
// let primary-color = colors.primary
// 使用背景色
// let bg-color = colors.background.base
// 使用背景色的次要变体
// let bg-secondary-color = colors.background.secondary
