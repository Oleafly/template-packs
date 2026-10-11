// ============================================================================
// 第57期 日本航空宇宙学会 年会講演会 原稿テンプレート (Typst版)
// ============================================================================

// ---------------------------------------------------------------------------
// ユーザ設定（ここを編集してください）
// ---------------------------------------------------------------------------

#let paper-id     = "1A01"
#let title-ja     = "日本航空宇宙学会講演集原稿書式見本"
#let title-en     = "How to Prepare the Paper for the 57th Annual Meeting of JSASS"

#let authors-ja = (
  (name: "航空一郎", presenter: true),
  (name: "宇宙花子", presenter: false),
)
#let affiliation-ja = "日本航空宇宙学会"

#let authors-en = "Ichiro Koku and Hanako Uchu"
#let affiliation-en = "JSASS"

#let keywords = "Society Activities, …"

#let abstract-text = [
  This is the manual for how to prepare your manuscript for the 57th Annual Meeting of Japan Society for Aeronautical and Space Sciences (JSASS). All the final drafts should be written by word processors and the paper in a PDF form must arrive at the Society Head-quarter by 27 February, 2026. Any questions regarding this manual should be addressed to the head-quarter.
]

// ---------------------------------------------------------------------------
// フォント設定
// ---------------------------------------------------------------------------

#let serif-en = ("TeX Gyre Termes", "Times New Roman")
#let mincho = ("Noto Serif CJK JP", "MS Mincho")
#let body-fonts = serif-en + mincho

// ---------------------------------------------------------------------------
// ページ設定
// ---------------------------------------------------------------------------

#set page(
  paper: "a4",
  margin: (left: 23mm, right: 23mm, top: 20mm, bottom: 20mm),
  numbering: none,
)

// ---------------------------------------------------------------------------
// 本文デフォルト
// ---------------------------------------------------------------------------

#set text(
  font: body-fonts,
  size: 9.5pt,
  lang: "ja",
)

#set par(
  justify: true,
  first-line-indent: 1em,
  leading: 0.7em,
  spacing: 0.7em,
)

// ---------------------------------------------------------------------------
// 見出し自動番号
//   =   → １．はじめに
//   ==  → ２－１注意点
//   === → ２－１－１詳細
// ---------------------------------------------------------------------------

// 全角数字変換ヘルパー
#let to-fullwidth(n) = {
  let fw = ("０","１","２","３","４","５","６","７","８","９")
  let s = str(n)
  for c in s { fw.at(int(c)) }
}

// 番号フォーマット関数
#let jsass-numbering(..nums) = {
  let ns = nums.pos()
  if ns.len() == 1 {
    // = → 「１．」
    to-fullwidth(ns.at(0))
    "．"
  } else {
    // == → 「２－１」, === → 「２－１－１」
    ns.map(n => to-fullwidth(n)).join("－")
    h(0.5em)
  }
}

#set heading(numbering: jsass-numbering)

// Level 1: 太字
#show heading.where(level: 1): set text(weight: "bold", size: 9.5pt)
#show heading.where(level: 1): set par(first-line-indent: 0pt)
#show heading.where(level: 1): set block(above: 1.2em, below: 0.5em)

// Level 2: 通常ウェイト
#show heading.where(level: 2): set text(weight: "regular", size: 9.5pt)
#show heading.where(level: 2): set par(first-line-indent: 0pt)
#show heading.where(level: 2): set block(above: 0.8em, below: 0.4em)

// Level 3: 通常ウェイト
#show heading.where(level: 3): set text(weight: "regular", size: 9.5pt)
#show heading.where(level: 3): set par(first-line-indent: 0pt)
#show heading.where(level: 3): set block(above: 0.6em, below: 0.3em)

#show heading: it => {
  it
  par(text(size: 0pt, ""))
}

// ---------------------------------------------------------------------------
// 図表スタイル
// ---------------------------------------------------------------------------

#show figure.where(kind: table): set figure.caption(position: top)

#let fullwidth-num(..nums) = {
  let fw = ("０","１","２","３","４","５","６","７","８","９")
  let n = str(nums.pos().first())
  for c in n { fw.at(int(c)) }
}

#set figure(numbering: fullwidth-num)
#set figure.caption(separator: none)

#show figure.caption: it => {
  set text(size: 9.5pt)
  set par(first-line-indent: 0pt)
  it.supplement
  it.counter.display(it.numbering)
  h(0.5em)
  it.body
}

#show figure.where(kind: image): set figure(supplement: "図")
#show figure.where(kind: table): set figure(supplement: "表")

// ---------------------------------------------------------------------------
// 参考文献スタイル
// ---------------------------------------------------------------------------

#show bibliography: set text(size: 9.5pt, lang: "en")
#show bibliography: set par(first-line-indent: 0pt)

// ---------------------------------------------------------------------------
// ヘッダ部（1段組）
// ---------------------------------------------------------------------------

#align(center)[
  #text(size: 16pt, weight: "bold")[
    #paper-id
    #h(1em)
    #title-ja
  ]
]

#v(2em)

#align(center)[#{
  for (i, author) in authors-ja.enumerate() {
    if i > 0 [，]
    if author.presenter { [〇] }
    text(weight: "bold")[#author.name]
  }
  [（#affiliation-ja）]
}]

#v(2em)

#align(center)[#title-en]
#align(center)[#authors-en (#affiliation-en)]

#v(2em)

#align(center)[Key Words : #keywords]

// ---------------------------------------------------------------------------
// Abstract（1段組）
// ---------------------------------------------------------------------------

#v(0.8em)

#align(center)[#text(weight: "bold")[Abstract]]

#par(first-line-indent: 0pt)[#abstract-text]

#v(0.5em)

// ---------------------------------------------------------------------------
// 本文（2段組）
// ---------------------------------------------------------------------------

#show: rest => columns(2, gutter: 7mm, rest)

// ---------------------------------------------------------------------------
// ↓↓↓ ここから本文を記述してください ↓↓↓
//
//  =   大見出し  → 「１．はじめに」（自動番号）
//  ==  小見出し  → 「２－１注意点」（自動番号）
//  === 小小見出し → 「２－１－１詳細」（自動番号）
//
//  表: #figure(table(...), caption: [...]) <tbl:label>
//  図: #figure(image("fig.png"), caption: [...]) <fig:label>
//  引用: @key → [1]
// ---------------------------------------------------------------------------

= はじめに

これは航空宇宙学会主催の講演会講演集原稿の詳細および見本です. 参考文献はこのように引用できます @sample2024 @example2023 . 

= 原稿の詳細

== 原稿作成上の注意点

提出された原稿はそのまま写真製本用原稿として使用します. 

講演番号は, 2月中旬にお知らせいたします. 

=== フォーマットについて

表１の原稿フォーマットにしたがって作成してください. 図は印刷時に見えにくくならないよう, 線は太目に作成してください. 

=== 図表について

図表のタイトル記入場所は, 図の場合は下端, 表の場合は上端です. 図・表には必ず番号とタイトルをつけてください. また, 図の各軸には必ず変数名を記入してください. 

原稿にカラーの図を使用しても前刷集の印刷は白黒になります. 

= 原稿送付

本会より, メール「講演会原稿アップロード依頼」でご案内いたしますアドレスへ, PDF原稿を電子投稿してください. 

原稿はＡ４判6ページ以内, PDF形式に変換, 5MB以内. 

※ *PDF形式に変換した場合, フォント, 画像の鮮明さ等, 十分確認をしてから投稿してください. 事務局では, 文字化け等の責任は負いかねます. *

= 原稿締切り

*2026年2月27日（金）. * ただし, 早期登録（2月27日）完了者に限り原稿締切を3月31日（火）まで延長. 

若手優秀講演賞・学生優秀講演賞にエントリーされている方は, 上記締切（早期登録者に限り3月31日）に間に合わない場合は賞の対象外となります. 

#figure(
  table(
    columns: (auto, 1fr),
    align: (left, left),
    stroke: 0.5pt,
    inset: 5pt,
    [原稿サイズ],          [Ａ4],
    [原稿ページ数],        [2〜6ページ],
    [原稿(PDF)サイズ],     [5MB以下],
    [原稿余白],            [左右各約23mm，2段組中央約7mm, 上下各約25mm],
    [日本語字体],          [明朝体],
    [文字サイズ],          [約9.5ポイント（9〜10ポイント）],
    [行間],               [文字高の約50%],
    [段組],               [本文は2段組, タイトル・abstract部は段組なし],
    [題目],               [16ポイント明朝体, 中央揃え],
    [著者名],             [題名から2行送りで記入, 中央揃え, 登壇者氏名の左に〇印を付記],
    [所属],               [氏名の後に括弧付きで記載],
    [各段落の字下],        [１字下げ],
    [数字],               [英数字で半角],
    [英語字体],            [Times New Roman],
    [英文題目],            [日本語著者から2行送りで記載],
    [英文著者名],          [英文題目に続いて記入する. 中央揃え],
    [英語キーワード],      [英文著者名から2行送り, Key Words : に続いて3〜5語を記入. 中央揃え],
    [英文概要],            [英文キーワードに続いて記載],
  ),
  caption: [原稿のフォーマット],
) <tbl:format>

#v(0.5em)

（この原稿は, 9.5ポイントの明朝体で作成）

#v(0.5em)

\*ご提出いただいた講演集掲載論文の著作権は, （一社）日本航空宇宙学会に帰属するものとします. ご了承ください. 

// ---------------------------------------------------------------------------
// 参考文献
// ---------------------------------------------------------------------------

#bibliography(
  "refs.bib",
  title: "参考文献",
  style: "ieee",
)
