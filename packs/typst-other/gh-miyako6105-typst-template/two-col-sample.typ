#import "two-col.typ": two_col

#show: two_col.with(
  title: "Typstによる予稿テンプレート（2段組）",
  authors: (
    (name: "ほげ山 太郎", affiliation: 1),
    (name: "ふが田 花子", affiliation: 2),
  ),
  // 著者所属
  affiliations: (
    "○○大学",
    "△△研究所",
  ),
  // 参考文献（ある場合）
  bibliography-file: "ref.bib",
)

= はじめに
このテンプレートは、Typst による2段組の学会予稿用テンプレートです．「なんとなくこんな構成だったら大丈夫だろうなぁ」というノリで作りました．至らないところが多々あると思います（特に参考文献）．また，特定の学会のテンプレートに従っているわけではないことに注意してください．
= 参考文献の引用
bibファイルによる参考文献の引用は，bibファイルがあれば、"\@参照名 "で引用可能です．例えば、以下ののようになります．

Mask R-CNN @heMaskRCNN2017a は \~．

= 画像の挿入
本文中で参照したいときは、"\#figure" でラベルをつけておくと、参考文献と同様に "\@参照名" で参照できます．
#figure(
  image("figs/sample-owl.jpg"),
  caption: "フクロウの画像（サンプル）",
)<fig:sample-owl>

= おわりに