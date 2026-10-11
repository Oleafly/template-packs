// 这里使用的是南京大学typst模板中的字体设置
// 见 https://github.com/nju-lug/modern-nju-thesis/blob/main/utils/style.typ

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
  中四: 13pt,
  小四: 12pt,
  五号: 10.5pt,
  小五: 9pt,
  六号: 7.5pt,
  小六: 6.5pt,
  七号: 5.5pt,
  小七: 5pt,
)


#let font = (
  Times: ("Times New Roman", ),
  // 宋体，属于「有衬线字体」，一般可以等同于英文中的 Serif Font
  // 这一行分别是「新罗马体（有衬线英文字体）」「宋体（Windows）」、「宋体（MacOS）」
  宋体: ("SimSun", ),
  // 黑体，属于「无衬线字体」，一般可以等同于英文中的 Sans Serif Font
  // 这一行分别是「Arial（无衬线英文字体）」、「黑体（Windows）」、「黑体（MacOS）」
  黑体: ("Arial", "SimHei", "Heiti SC", ),
  // 楷体
  楷体: ("KaiTi", ),
  // 仿宋
  仿宋: ("FangSong", "FangSong SC", "STFangSong", "FZFangSong-Z02S", "Noto Serif CJK SC"),
  // 等宽字体，用于代码块环境，一般可以等同于英文中的 Monospaced Font
  // 这一行分别是「Courier New（Windows 等宽英文字体）」、「思源等宽黑体（简体）」、「思源等宽黑体」、「黑体（Windows）」、「黑体（MacOS）」
  新魏: ("STXINWEI"),
  等宽: ("Courier New", "Menlo", "IBM Plex Mono", "Source Han Sans HW SC", "Source Han Sans HW", "Noto Sans Mono CJK SC", "SimHei", "Heiti SC", "STHeiti"),
)

#let global-font = font.Times + font.宋体
