// import
#import "./styles/settings.typ": *
#import "./styles/title.typ": *
#import "./styles/utils.typ": *

// 全体設定の反映
#show: setting

// タイトル
#title(
  title: "情報処理学会の全て",
  en-title: "All of IPSJ",
  authors: (
    (
      name: "はだしのゲンちゃん" + $omega$,
      en-name: "Genchan Omega",
      organization: "東京農工大学",
      en-organization: "Tokyo University of Agriculture and Technology",
    ),
    (
      name: "農工 太郎",
      en-name: "Taro Noko",
      organization: "東京農工大学",
      en-organization: "Tokyo University of Agriculture and Technology",
    ),
    (
      name: "農工 花子",
      en-name: "Hanako Noko",
      organization: "東京農工大学",
      en-organization: "Tokyo University of Agriculture and Technology",
    ),
  ),
)

= はじめに
#lorem(150)

= モデル
#lorem(75)

#figure(
  kind: image,
  image("images/ipsj.png", width: 100%),
  caption: "情報処理学会",
) <ipsj_1>

#lorem(75)

= 計算機実験
#lorem(75)

#figure(
  grid(
    columns: 2,
    gutter: 2mm,
    image("images/no_1.png", width: 100%),
    image("images/no_2.png", width: 100%),
  ),
  caption: "並列した図",
) <ipsj_2>

#lorem(75)

= おわりに
#lorem(150)

#text(lang: "en", font: ("Times New Roman", "YuMincho"))[
  #bibliography(title: "参考文献", "bib.bib", style: "ieee", full: true)
]
