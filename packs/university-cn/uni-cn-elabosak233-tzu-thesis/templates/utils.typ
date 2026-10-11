#import "fonts.typ": fonts, sizes

#let three-line-table(
  columns: 3,
  header: (),
  ..body,
) = {
  set text(
    top-edge: 0.9em,
    bottom-edge: 0em,
  )
  table(
    columns: (1fr,) * columns, // 自动占满 100% 宽度并平分列
    stroke: none,
    inset: (x: 8pt, y: 10pt),

    align: (col, row) => {
      if row == 0 {
        center + horizon
      } else {
        left + horizon
      }
    },

    table.hline(y: 0, stroke: 1.5pt),
    ..header.map(it => [ #it ]),
    table.hline(y: 1, stroke: 0.5pt),
    ..body,
    table.hline(stroke: 1.5pt),
  )
}

#let parencite-csl = bytes(
  ```xml
  <?xml version="1.0" encoding="utf-8"?>
  <style xmlns="http://purl.org/net/xbiblio/csl" version="1.0" class="in-text" default-locale="zh-CN">
    <info>
      <title>China National Standard GB/T 7714-2015 (numeric, 中文, 只支持引用, 引用不上标)</title>
      <id>https://github.com/citation-style-language/styles/blob/a05bb4d/china-national-standard-gb-t-7714-2015-numeric.csl#L423-L430</id>
    </info>
    <citation collapse="citation-number" after-collapse-delimiter=",">
      <sort>
        <key variable="citation-number"/>
      </sort>
      <!-- 此处删除了 vertical-align="sup" -->
      <layout delimiter="," prefix="[" suffix="]">
        <text variable="citation-number"/>
      </layout>
    </citation>
  </style>
  ```.text,
)

#let parencite(..args) = {
  let keys = args.pos()
  let cite-args = args.named()
  show super: it => text(font: fonts.宋体, size: sizes.五号, baseline: 0em)[#it.body]
  [文献#keys.map(k => cite(k, style: parencite-csl, ..cite-args)).join()]
}
