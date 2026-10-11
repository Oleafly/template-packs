#import "./template.typ":*
#import "@preview/roremu:0.1.0": roremu
#import "@preview/physica:0.9.4":*

#show:template.with(
  header: [Typst2段組みテンプレート],
)

#title[Typst 2段組みテンプレート]
#entitle[English Title]
#author[国際信州学院大学 理学部 フランス生物学科　佐藤 洋(Hiroshi Sato)]

= はじめに

日本語向けTypst2段組みのテンプレートです。\
数式は"@eq1" のように引用されます。

$ F = m dv(x,t,2) $<eq1>

画像は"@im1" のように引用されます。

#figure(
  caption: [サンプル画像],
  image(
    "sample.png",
    width: 70%
  )
)<im1>

表は"@tab1" のように引用されます。

#figure(
  caption: [サンプル表],
  table(
    columns: 2,
    align: horizon+center,
    inset: 10pt,
    [*時間*], [*あいさつ*],
    [朝], [おはよう],
    [昼], [こんにちは],
    [夜], [こんばんは],
  )
)<tab1>

= 詳細

#roremu(150)

== 詳細1

#roremu(500)

== 詳細2

#roremu(500)

= おわりに

#roremu(150)
