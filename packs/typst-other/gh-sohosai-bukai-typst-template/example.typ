#import "template.typ": bukai_setup, title_block, signature_line

#show: bukai_setup

#title_block("議題名")
#signature_line(affiliation: "開発部", name: "山田 太郎")
#signature_line(affiliation: "開発部", name: "山田 太郎2")

#set par(first-line-indent: 1em)

= 見出し1
ここに本文を記載します。会議の背景、目的、判断したい事項を簡潔に書いてください。

== 小見出し1
必要に応じて補足情報を記載します。段落は1字下げで始まり、行間は読みやすい幅に設定されています。

== 小見出し2
別の観点の説明です。本文はTypst標準記法でそのまま編集できます。

= 見出し2
- 箇条書きの項目1
- 箇条書きの項目2
- 箇条書きの項目3
