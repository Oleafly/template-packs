// lib/utils.typ - 纯工具函数
// 中文数字转换、编号格式化、文本处理等

#import "config.typ": appendixcounter, 字号

// 阿拉伯数字转中文数字
// 改为使用 Typst 原生 numbering 函数实现
#let chinesenumber(num) = numbering("一", num)

// 中文章节编号格式化
#let chinesenumbering(..nums, location: none, brackets: false) = context {
  let actual_loc = if location == none { here() } else { location }
  if appendixcounter.at(actual_loc).first() < 10 {
    if nums.pos().len() == 1 {
      chinesenumber(nums.pos().first()) + "、"
    } else if nums.pos().len() == 2 {
      "（" + chinesenumber(nums.pos().at(1)) + "）"
    } else {
      numbering("1.1. ", ..nums.pos().slice(2))
    }
  } else {
    if nums.pos().len() == 1 {
      "附录 " + numbering("A.1", ..nums)
    } else {
      numbering(if brackets { "(A.1)" } else { "A.1" }, ..nums)
    }
  }
}
