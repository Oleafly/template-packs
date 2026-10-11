#import "./styles/settings.typ": document-settings
#import "./styles/title.typ": title

// 発行年を固定する場合は document-settings.with(copyright-year: 2026) とします．
#show: document-settings

#title(
  title: [和文題目],
  // subtitle: [和文副題],
  en-title: [English Title],
  // en-subtitle: [English Subtitle],
  authors: (
    (
      name: "著者 太郎",
      en-name: "Taro CHOSHA",
      email: "taro@example.ac.jp",
      affiliations: ("University",),
    ),
    (
      name: "著者 花子",
      en-name: "Hanako CHOSHA",
      email: "hanako@example.ac.jp",
      affiliations: ("University",),
    ),
  ),
  affiliations: (
    (
      label: "University",
      name: [所属機関名],
      address: [〒000--0000 東京都○○区○○1--2--3],
      en-name: [Faculty of Engineering, Example University],
      en-address: [1--2--3 Example, Tokyo, 000--0000 Japan],
    ),
  ),
  abstract: [
    ここに和文あらましを記述します．研究の背景，目的，提案手法，評価方法，および得られた結果を簡潔にまとめます．技術研究報告では，本文を読まなくても研究の概要を把握できるように記述します．
  ],
  keywords: [キーワード1，キーワード2，キーワード3],
  // eabstract: [Write the English abstract here.],
  ekeywords: [keyword one, keyword two, keyword three],
)

= まえがき

研究の背景，課題，目的，および本稿の構成を記述します．

= 関連研究

研究分野の位置付けと既存手法との差異を記述します @sample-reference．

== 関連手法

提案手法の理解に必要な既存技術を記述します．

= 提案手法

提案するモデル，アルゴリズム，またはシステムを記述します．

= 実験

評価方法と実験条件を記述します．

== 実験設定

データセット，評価指標，パラメータ，および比較手法を記述します．

= 結果と考察

実験結果を示し，結果から得られる知見と制約を考察します．

= おわりに

本稿の結論と今後の課題を記述します．

#bibliography("./bib.bib", style: "ieee", full: true)
