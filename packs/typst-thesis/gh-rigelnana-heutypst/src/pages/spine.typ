#import "../utils.typ": font-size, font-family, show-cn-fakebold

// 书脊页
// 由上至下逐字竖排：论文题目、作者姓名、哈尔滨工程大学
// 小4号宋体加粗，数字字母Times New Roman加粗
// 上下有封口线（横线）
#let spine-page(
  title: "",
  author: "",
) = {
  // 将文本逐字竖排（每字一行）
  let vertical-text(body) = {
    let s = if type(body) == str { body } else if type(body) == content and body.has("text") { body.text } else { "" }
    let chars = s.clusters()
    for (i, c) in chars.enumerate() {
      [#c]
      if i < chars.len() - 1 { linebreak() }
    }
  }

  // 根据标题长度计算字号（标题+作者+学校 总字数）
  let title-str = if type(title) == str { title } else if type(title) == content and title.has("text") { title.text } else { "" }
  let total-chars = title-str.clusters().len() + author.clusters().len() + 7  // 7="哈尔滨工程大学"
  // 180mm高度，每字占 字号+leading，如果总高度超出则缩小
  // 默认小4号=12pt，每字约占14pt（含leading），180mm=510pt
  // 可用高度约510pt - 间距约60pt = 450pt
  let available = 450
  let char-height = 14  // pt per char at xiaosi
  let needed = total-chars * char-height
  let spine-size = if needed > available {
    // 按比例缩小，最小到小5号(9pt)
    let ratio = available / needed
    let new-size = 12 * ratio
    if new-size < 9 { 9pt } else { new-size * 1pt }
  } else {
    font-size.xiaosihao
  }

  page(
    width: 210mm,   // A4竖向
    height: 297mm,
    margin: (x: 20mm, y: 20mm),
    header: none,
    footer: none,
  )[
    #show: show-cn-fakebold
    #set text(font: ("Times New Roman",) + font-family.songti, size: spine-size, weight: "bold", lang: "zh")
    #set par(leading: 0.3em, justify: false)
    // 书脊居中显示，长方形框
    #align(center + horizon,
      box(width: 20mm, height: 180mm, stroke: 0.5pt, inset: (x: 4pt, y: 6pt), {
        set align(center)
        v(1fr)
        // 论文题目
        vertical-text(title)
        v(1fr)
        // 作者姓名
        vertical-text(author)
        v(1fr)
        // 学校名称
        vertical-text("哈尔滨工程大学")
        v(1fr)
      })
    )
  ]
}
