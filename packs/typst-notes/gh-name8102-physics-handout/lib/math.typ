#import "state.typ": theme-state

// 中文数学角标统一使用正文宋体回退，并略微收紧和缩小，避免与数学斜体字形脱节。
#let zh-sub(body, compact: false) = context {
  let theme = theme-state.get()
  let size = if compact { 0.86em } else { 0.92em }
  [
    #h(if compact { -0.09em } else { -0.08em })
    #text(
      font: theme.fonts.math-cjk,
      size: size,
      weight: 400,
      lang: "zh",
    )[#body]
  ]
}
