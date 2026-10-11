// 符号说明页
// 需要在 main.typ 的 #show: main-text.with 代码块中设置
// show-notation-page: true
// 才能显示符号说明页的内容

#import "../styles/font-settings.typ": font, font-size, global-font

#let heiti(body) = [#text(font: font.黑体, body)]

#align(center)[#table(
  columns: (1fr, 1fr, 1fr),
  [#heiti[符号]], [#heiti[意义]], [#heiti[单位（量纲）]],
  [$a$ （示例）], [加速度（示例）], [$m \/ s^2$ 示例],
  [符号], [意义], [量纲],
  [符号], [意义], [量纲],
  [符号], [意义], [量纲],
  [符号], [意义], [量纲],
  [符号], [意义], [量纲],
  [符号], [意义], [量纲],
  [符号], [意义], [量纲],
)]
