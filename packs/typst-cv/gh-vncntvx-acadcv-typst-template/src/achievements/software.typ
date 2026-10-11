/*
 * Software copyright component for academic CV
 */

#import "../layout/generic.typ": generic-two-by-two

// Main software function
#let software(
  authors: (),              // 作者列表（数组）
  highlight-authors: (),    // 需要加粗的作者索引（数组，从0开始）
  title: "",                // 软件名称
  version: "",              // 版本号
  date: "",                 // 登记日期
  country: "",              // 国家/地区
  number: "",               // 登记号
  note: "",                 // 备注（如排名）
  spacing: -0.2em,          // 条目间距
) = {
  // Format authors with highlight
  let formatted-authors = authors.enumerate().map(((i, author)) => {
    if i in highlight-authors {
      strong(author)
    } else {
      author
    }
  })
  let author-str = formatted-authors.join(", ")

  // Build title with version
  let title-display = if version != "" {
    [#title V#version]
  } else {
    title
  }

  // Build bottom-right: country, number, note
  let meta-parts = ()
  if country != "" {
    meta-parts.push(country)
  }
  if number != "" {
    meta-parts.push(number)
    meta-parts.push("软件著作权")
  }
  if note != "" {
    meta-parts.push(note)
  }
  let meta-str = meta-parts.join(", ")

  generic-two-by-two(
    top-left: title-display,
    top-right: date,
    bottom-left: author-str,
    bottom-right: meta-str,
  )
  v(spacing)
}
