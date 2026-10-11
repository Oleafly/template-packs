/*
 * Patent component for academic CV
 * Supports invention patents, utility models, and designs
 */

#import "../layout/generic.typ": generic-two-by-two

// Main patent function
#let patent(
  authors: (),              // 发明人列表（数组）
  highlight-authors: (),    // 需要加粗的发明人索引（数组，从0开始）
  title: "",                // 专利名称
  patent-number: "",        // 专利号（如 CN116XXXXXXXA）
  publication-date: "",     // 公开/公告日期
  patent-type: "发明专利",   // 专利类型：发明专利、实用新型、外观设计
  country: "",              // 国家/地区
  status: "",               // 状态：已授权、实质审查、公开
  note: "",                 // 备注
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

  // Build bottom-right: country, patent number, type, status
  let meta-parts = ()
  if country != "" {
    meta-parts.push(country)
  }
  if patent-number != "" {
    meta-parts.push(patent-number)
  }
  if patent-type != "" {
    meta-parts.push(patent-type)
  }
  if status != "" {
    meta-parts.push(status)
  }
  if note != "" {
    meta-parts.push(note)
  }
  let meta-str = meta-parts.join(", ")

  generic-two-by-two(
    top-left: title,
    top-right: publication-date,
    bottom-left: author-str,
    bottom-right: meta-str,
  )
  v(spacing)
}
