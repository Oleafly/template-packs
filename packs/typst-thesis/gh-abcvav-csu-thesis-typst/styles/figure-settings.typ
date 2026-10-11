#import "font-settings.typ": *

#let figure-setting(it) = {
  set figure.caption(separator: [#"  "])
  par()[#text(size: 0em)[#h(0.0em)]]
  if it.kind == table {
    set table(inset: 0.7em)
    set figure.caption(position: top)
    it
  } else {
    it
  }
  par()[#text(size: 0em)[#h(0.0em)]]
}

#let caption-setting(it) = {
  set text(font: font.Times + font.楷体, size: font-size.五号)
  it
}