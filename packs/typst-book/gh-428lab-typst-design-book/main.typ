#import "template.typ": techbook, article, chapter-title-page, chapter-number-counter
#import "emo.typ": setup-emo
#show: setup-emo
#let ebook = sys.inputs.at("EBOOK", default: none) == "true"

// 奥付用の関数
#let date = datetime(year: 2024, month: 11, day: 3)

#show: techbook.with(
  ebook: ebook,
  title: [Typstで作る技術書デザインブック],
  author: "四谷ラボ",
  date: date
)

= はじめに
#article(include("00-01-at-first/at-first.typ")) // == はじめに

#pagebreak()
= Typstの基本
#article(include("01-01-typst-basics/typst-basics.typ")) // == Typstの基本

#pagebreak()
= 図表と画像の活用
#article(include("02-01-figures-and-images/figures-and-images.typ")) // == 図表と画像の活用

#pagebreak()
= 索引と参考文献
#article(include("03-01-references-and-index/references-and-index.typ")) // == 索引と参考文献

#pagebreak()
= レイアウトとテンプレート
#article(include("04-01-layout-template/layout-template.typ")) // == レイアウトとテンプレート

#pagebreak()
= 出版準備とワークフロー
#article(include("05-01-publishing/publishing.typ")) // == 出版準備とワークフロー

#pagebreak()
= 制作事例と実践テクニック
#article(include("06-01-case-studies/case-studies.typ")) // == 制作事例と実践テクニック

#pagebreak()
= あとがき
#article(include("other/article2.typ")) // あとがき


#pagebreak()
#article(include("other/article3.typ")) // 過去作紹介
#article(include("other/article1.typ")) // 四谷ラボについて

#include("contributors.typ")

// 奥付作成用の処理
#import "/colophon.typ": create_colophon
#create_colophon(ebook)
