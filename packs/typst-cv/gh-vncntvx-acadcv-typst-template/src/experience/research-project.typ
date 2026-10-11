/*
 * Research project component for academic CV
 */

#import "../layout/generic.typ": generic-two-by-two

#let research-project(
  name: "",           // 项目名称
  funding: "",        // 项目来源/资助方
  role: "",           // 角色
  dates: "",          // 时间段（可选）
  spacing: -0.2em,    // 条目间距
) = {
  generic-two-by-two(
    top-left: strong(name),
    top-right: role,
    bottom-left: emph(funding),
    bottom-right: emph(dates),
  )
  v(spacing)
}
