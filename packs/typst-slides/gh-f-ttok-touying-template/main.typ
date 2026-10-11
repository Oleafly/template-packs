#import "lib/color-tab10.typ": colorconfig
#import "lib/theme.typ": *
#import "lib/utils.typ": *
#show: apply-palette.with(colorconfig)

#show: mytheme.with(
  text-font: ("Twitter Color Emoji", "Helvetica Neue", "Noto Sans JP"),
  text-size: 19.5pt,
  math-font: "New Computer Modern Sans Math",
  math-size: 1.05em,
  config-info(
    title: [タイトル],
    author: [著者],
    date: [発表場所（日時）],
  ),
  config-page(paper: "presentation-16-9"),
  config-colors(..colorconfig),
)

#import "lib/bindings.typ": *

#title-slide()


= はじめに
#new-section-slide()


#slide(title: [Beamerのblock/colorbox環境のようなもの])[
  #grid(
    columns: (1fr, 1fr), gutter: 1em
  )[
    #structure-block[`#structure-block`][
      簡潔な定義
    ]

    #alert-block[`#alert-block`][
      驚愕の定理
    ]

    #example-block[`#example-block`][
      明瞭な具体例
    ]
  ][
    #structure-colorbox[
      `#structure-colorbox`
    ]
    #alert-colorbox[
      `#alert-colorbox`
    ]
    #example-colorbox[
      `#example-colorbox`
    ]
  ]
]


#slide(title: [文字サイズについて])[
  #figure(
    table(
      columns: 3,
      [],[16:9],[4:3],
      [PowerPoint [inch]], [13.33×7.5], [10×7.5],
      [PowerPoint [mm]], [338.67×190.5], [254×190.5],
      [Typst [mm]], [297×167.0625], [280×210]
    )
  )

  #figure(
    table(
      columns: 3,
      [],[16:9],[4:3],
      [PowerPoint], [22pt], [22pt],
      [Typst], [19.29pt], [24.25pt]
    )
  )
]

#show: appendix
#slide(title: [参考文献])[
  #text(size: 16pt, lang: "en")[
    #bibliography("reference.bib", title: none, style: "lib/apa-custom.csl")
  ]
]