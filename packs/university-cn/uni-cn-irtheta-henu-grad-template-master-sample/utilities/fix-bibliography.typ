// 专用于修复 CSL 中文文献输出 et al. 的后处理工具
#let fix_bibliography(body) = {
  let to-string(content) = {
    if content.has("text") {
      content.text
    } else if content.has("children") {
      content.children.map(to-string).join("")
    } else if content.has("child") {
      to-string(content.child)
    } else if content.has("body") {
      to-string(content.body)
    } else {
      ""
    }
  }

  // 拦截并修改参考文献行的内容
  show grid.cell.where(x: 1): it => {
    let ittext = to-string(it)
    // 1. 判断是否为中文文献：剔除无意义的字符，找找看有没有连续中文
    let pureittext = ittext.replace(regex("[^\\p{sc=Hani}]+"), "")
    if pureittext.find(regex("\p{sc=Hani}{2,}")) != none {
      // ★ 2. 如果是中文文献，将 et al. 强行替换为 等
      ittext = ittext.replace("et al.", "等.")
      ittext
    } else {
      // 如果不是中文文献，原样输出（保留 et al. 或其他格式）
      ittext
    }
  }
  body
}