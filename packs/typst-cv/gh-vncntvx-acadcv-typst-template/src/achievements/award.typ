/*
 * Award/Honor component for academic CV
 */

// Main award function
#let award(
  title: none,            // 奖项/荣誉名称
  issuer: none,           // 颁发机构/会议
  date: none,             // 时间
  note: none,             // 备注
  spacing: -0.2em,        // 条目间距
) = {
  if note != none {
    [
      #strong(title) #h(1fr) #date \
      #emph(issuer) \
      #note
    ]
  } else {
    [
      #strong(title) #h(1fr) #date \
      #emph(issuer)
    ]
  }
  v(spacing)
}
