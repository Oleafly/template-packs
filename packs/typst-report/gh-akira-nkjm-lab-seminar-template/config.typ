// ========================================
// 輪講資料 設定ファイル
// ========================================

// ========================================
// ページ設定
// ========================================
#let page-config = (
  // 用紙サイズ
  paper: "a4",

  // マージン設定
  margin: (
    top: 3cm,
    bottom: 2.5cm,
    left: 3cm,
    right: 3cm,
  ),
)

// ========================================
// フォント設定
// ========================================
#let font-config = (
  // 本文フォント
  main-font: "Noto Serif CJK JP",
  
  // "Times New Roman", // Windows
  // "Nimbus Roman", // Ubuntu
  // "Hiragino Mincho ProN", // Mac
  // "Yu Mincho", // Windows
  // "Noto Serif CJK JP", // Ubuntu

  // 本文サイズ
  main-size: 11pt,

  // 見出しサイズ
  heading-sizes: (
    level1: 18pt,  // 大見出し
    level2: 14pt,  // 中見出し
    level3: 12pt,  // 小見出し
  ),
)

// ========================================
// 段落設定
// ========================================
#let paragraph-config = (
  // 行間
  leading: 0.65em,

  // 段落間隔
  spacing: 0.65em,

  // 字下げ
  first-line-indent: 1em,

  // 両端揃え
  justify: true,
)

// ========================================
// 見出し設定
// ========================================
#let heading-config = (
  // 見出しの番号付け形式
  numbering: "1.1",

  // レベル1見出しの前後余白
  level1-spacing-above: 1.5em,
  level1-spacing-below: 1em,

  // レベル2見出しの前後余白
  level2-spacing-above: 1.2em,
  level2-spacing-below: 0.8em,

  // レベル3見出しの前後余白
  level3-spacing-above: 1em,
  level3-spacing-below: 0.6em,
)

// ========================================
// 資料情報
// ========================================
#let document-info = (
  // タイトル
  title: "輪講資料タイトル",

  // 著者
  author: "発表者名",

  // 所属
  affiliation: "中須賀船瀬五十里研究室",

  // 日付（空の場合は今日の日付を自動挿入）
  date: none,
)

// ========================================
// ヘッダー・フッター設定
// ========================================
#let header-footer-config = (
  // ヘッダーを表示するか
  show-header: true,

  // ヘッダーのフォントサイズ
  header-size: 10pt,

  // ヘッダー左側のテキスト（noneの場合はaffilitionを使用）
  header-left: none,

  // ヘッダー右側に日付を表示するか
  show-date-in-header: true,

  // フッターにページ番号を表示するか
  show-page-number: true,

  // 罫線の太さ
  line-stroke: 0.5pt,
)

// ========================================
// コードブロック設定
// ========================================
#let code-config = (
  // 背景色
  background: rgb("#f5f5f5"),

  // 枠線
  stroke: 0.5pt + rgb("#cccccc"),

  // 内側の余白
  inset: 8pt,

  // 角の丸み
  radius: 3pt,

  // フォントサイズ
  font-size: 9pt,
)

// ========================================
// 図表設定
// ========================================
#let figure-config = (
  // 図のキャプションサイズ
  image-caption-size: 10pt,

  // 表のキャプションサイズ
  table-caption-size: 10pt,

  // 表の本体フォントサイズ
  table-body-size: 10pt,

  // 図表番号の形式
  numbering: "1",
)

// ========================================
// 参考文献設定
// ========================================
#let bibliography-config = (
  // 参考文献ファイル
  file: "references.bib",

  // スタイル
  style: "ieee",

  // タイトル
  title: "参考文献",

  // フォントサイズ
  font-size: 10pt,
)

// ========================================
// カラー設定
// ========================================
#let color-config = (
  // 見出しの色
  heading-color: black,

  // リンクの色
  link-color: blue,

  // 強調ボックスの背景色
  emphasis-background: rgb("#e8f4f8"),

  // 警告ボックスの背景色
  warning-background: rgb("#fff3cd"),

  // 警告ボックスの枠線色
  warning-stroke: rgb("#856404"),
)

// ========================================
// エクスポート用のまとめ
// ========================================
#let rinko-config = (
  page: page-config,
  font: font-config,
  paragraph: paragraph-config,
  heading: heading-config,
  document: document-info,
  header-footer: header-footer-config,
  code: code-config,
  figure: figure-config,
  bibliography: bibliography-config,
  color: color-config,
)
