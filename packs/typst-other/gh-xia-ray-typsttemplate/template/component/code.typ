#import "@preview/zebraw:0.6.1": *

#let themed_code(theme, body) = {
  let code-rule = luma(75%) + 0.1em
  let code-inset = (
    top: 0.34em,
    right: 0.8em,
    bottom: 0.34em,
    left: 0.8em,
  )
  let code-numbering-font-args = (
    font: theme.type.code.font,
    size: theme.sizes.code,
    fill: black,
    weight: theme.type.code.weight,
    style: theme.type.code.style,
  )

  show raw.where(block: true): it => {
    set text(
      size: theme.sizes.code,
      font: theme.type.code.font,
      fill: black,
      weight: theme.type.code.weight,
      style: theme.type.code.style,
    )
    block(
      width: 100%,
      stroke: (top: code-rule, bottom: code-rule),
      zebraw(
        lang: false,
        inset: code-inset,
        numbering-separator: true,
        numbering-offset: -1,
        numbering-font-args: code-numbering-font-args,
        background-color: (white, white),
        highlight-color: white,
        radius: 0pt,
        it,
      ),
    )
  }
  body
}
