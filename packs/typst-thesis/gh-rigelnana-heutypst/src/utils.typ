// 中文字号定义（单位：pt，1bp ≈ 1pt in Typst）
// 按照国标字号对应磅值
#import "@preview/cuti:0.4.0": show-cn-fakebold
#let font-size = (
  chuhao: 42pt,      // 初号
  xiaochuhao: 36pt,  // 小初
  yihao: 26pt,       // 一号
  xiaoyihao: 24pt,   // 小一
  erhao: 22pt,       // 二号
  xiaoerhao: 18pt,   // 小二号
  sanhao: 16pt,      // 三号
  xiaosanhao: 15pt,  // 小三号
  sihao: 14pt,       // 四号
  xiaosihao: 12pt,   // 小四号
  wuhao: 10.5pt,     // 五号
  xiaowuhao: 9pt,    // 小五号
  liuhao: 7.5pt,     // 六号
  xiaoliuhao: 6.5pt, // 小六号
)

// 字体族定义
#let font-family = (
  songti: ("Times New Roman", "SimSun", "Songti SC", "STSong"),
  heiti: ("Times New Roman", "SimHei", "Heiti SC", "STHeiti"),
  kaiti: ("Times New Roman", "KaiTi", "Kaiti SC", "STKaiti"),
  fangsong: ("Times New Roman", "FangSong", "STFangsong"),
)

// CJK两端对齐填充函数
// 将文字在固定宽度内两端对齐（首字左对齐，末字右对齐，中间均分）
#let cjk-fill(width, body) = {
  // 从 content 中提取纯文本
  let extract-text(c) = {
    if type(c) == str { return c }
    if type(c) == content {
      if c.has("text") { return c.text }
      if c.has("children") {
        return c.children.map(extract-text).join()
      }
    }
    return ""
  }
  let s = extract-text(body)
  box(width: width, {
    let chars = s.clusters()
    if chars.len() <= 1 {
      [#s]
    } else {
      [#chars.first()]
      for c in chars.slice(1, -1) {
        h(1fr)
        [#c]
      }
      h(1fr)
      [#chars.last()]
    }
  })
}

// 固定行距段落设置
#let fixed-leading(size) = size - 1em
