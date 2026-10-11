#import "../libs/template.typ": *


////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 図

#let img1 = {
  img(
    image(ipath("typst.svg"), width: auto),
    caption: [Typst @madje2022programmable],
  )
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 表

#let tbl1 = {
  tbl(
    caption: [表の例],
    ztable(
      columns: 3,
      align: center,
      format: (auto, auto, auto),
      [#text("項目", font: font_type.ja_text)],
      $alpha$,
      $beta$,
      table.hline(),
      [1],
      [2.3],
      [10000],
      [2],
      [2.33],
      [1.0],
      [3],
      [12.3],
      [1993],
      [4],
      [.001],
      [1.2],
      [10],
      [17],
      [0],
    ),
  )
}
