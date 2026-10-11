#import "@preview/cuti:0.2.1": show-cn-fakebold
#import "../function/emph.typ": emph_builtin

#let themed_text(theme, body) = {
  show: show-cn-fakebold
  set text(
    size: theme.sizes.regular,
    font: theme.type.regular.font,
    weight: theme.type.regular.weight,
    style: theme.type.regular.style,
  )
  show link: underline
  show emph: it => emph_builtin(text(it))
  show strong: set text(weight: "bold", fill: maroon)
  set par(leading: theme.text.leading)
  body
}
