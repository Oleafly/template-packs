// 自动生成的内容文件列表
// 请勿手动编辑此文件，运行 python scripts/scan-content.py 重新生成

// 章节文件列表 (按序号排序)
#let chapter-files = (
  "01-introduction.md",
  "02-literature-review.md",
  "03-methodology.md",
  "04-results.md",
  "05-discussion.md",
  "06-conclusion.md",
)

// 其他内容文件
#let other-content-files = (
)

// 获取章节文件数量
#let chapter-count = chapter-files.len()

// 检查文件是否存在的辅助函数
#let file-exists(filename) = {
  // 在Typst中，我们假设文件存在
  // 实际使用时可以通过try-catch来检查
  true
}
