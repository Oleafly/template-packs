#import "../dev/lib.typ": *

#show: template.with(
  footer-left: [Typst Report Lib],
  footer-right: [Basic Example],
)

#title-page(
  [Typst Report Lib],
  [Nyayuta],
  [2026-06-12],
  abstract: [レポート本文、目次、付録を含む基本例です。],
  keywords: [Typst, report, template],
)

#pagebreak()
#report-toc(title: "目次")

#pagebreak()
= はじめに

本文のサンプルです。

== 小見出し

- 箇条書き
- 追加項目

#appendix[
= 補足資料

付録のサンプルです。
]
