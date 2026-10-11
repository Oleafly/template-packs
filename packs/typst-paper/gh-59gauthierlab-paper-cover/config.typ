// ================================
// 共通設定
// ================================

// 日付
#let date = datetime.today()

// 所属
#let affiliation = [
  有明工業高等専門学校 創造工学科\
  情報システムコース\
  Gauthier Lovic 研究室
]

// フォント
#let font = ("New Computer Modern", "Noto Serif CJK JP")

// ================================
// 各論文の設定
// ================================

#let config = (
  // 内田・浦崎
  uchida_urasaki: (
    title: [
      異常値を含むデータに対する\
      文脈情報統合の有効性に関する研究\
      #text(size: 18pt)[\~ 株価予測を題材とした検証 \~]
    ],
    author: "内田　陽太・浦崎　華瑠",
    affiliation: affiliation,
    date: date,
    font: font,
    title-spine: "異常値を含むデータに対する文脈情報統合の有効性に関する研究\n　　~株価予測を題材とした検証~",
  ),
  // 片野
  katano: (
    title: [
      系列モデルを用いた\
      大規模ファイル断片の種別識別
    ],
    author: "片野　凱介",
    affiliation: affiliation,
    date: date,
    font: font,
    title-spine: "系列モデルを用いた大規模ファイル断片の種別識別",
  ),
  // 齋藤
  saito: (
    title: [
      実録音音源の原音再現を目的とした\
      ニューラルネットワーク型音響フィルタの研究
    ],
    author: "齋藤　健吾",
    affiliation: affiliation,
    date: date,
    font: font,
    title-spine: "実録音音源の原音再現を目的とした\nニューラルネットワーク型音響フィルタの研究",
  ),
  // 米村
  yonemura: (
    title: [
      Grad-CAM に基づく視線一貫性指標の定義と\
      深層学習モデルへの適用
    ],
    author: "米村　慶太",
    affiliation: affiliation,
    date: date,
    font: font,
    title-spine: "Grad-CAMに基づく視線一貫性指標の定義と深層学習モデルへの適用",
  ),
  // ジオ
  muhoro: (
    title: [
      #text(18pt)[Deep Learning for Automated Nutrition Estimation: \
        From Food101 Classification Failures to Nutrition5K Regression Success]
    ],
    author: "Njogu　George　Muhoro",
    affiliation: affiliation,
    date: date,
    font: font,
    title-spine: "Deep Learning for Automated Nutrition Estimation:\n From Food101 Classification Failures to Nutrition5K Regression Success",
  ),
)
