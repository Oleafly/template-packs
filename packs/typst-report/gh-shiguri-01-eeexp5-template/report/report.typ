#import "preamble.typ": bu, doc, format-table, keepp, num, subpar, zi
#show: doc

= 目的

= 原理

= 実験方法

= 使用機器

本実験で使用した機器を@tab:使用機器\に示す．

#figure(
  caption: [使用機器],
  table(
    align: (x, y) => if y == 0 { center } else { left },
    columns: (auto, auto, auto, auto),
    table.hline(),
    table.header([機器名], [メーカー名], [型番], [機器番号]),
    table.hline(),
    [], [], [], [],
    table.hline(),
  ),
)<tab:使用機器>

= 結果および考察

= 報告事項

#bibliography("refs.yml")
