//////////////////////////////////////////////////////////////////
////
////                Meiji-mech_thesis_template_Typst
////                           main.typ
////
//////////////////////////////////////////////////////////////////

// === 設定ファイル ===
#import "settings.typ": *

// ========================
// ========= 表紙 =========
// ========================
#thesis-cover(
  // 卒業論文なら "bachelor" を，修士論文なら "master" を指定
  kind: "bachelor",
  // 学位論文題目を間違えずに入力
  title: [乱流遷移に関する研究],
  // 副題がある場合は以下のコメントアウトを外して入力
  // subtitle: [――副題――],
  // 指導教員の氏名
  // 役職名（教授・准教授・専任講師）を書く場合は間違えないように注意
  supervisor: [姓姓　名名　教授],
  // 学科名・専攻名を入力
  // 卒業論文：機械工学科
  // 修士論文：機械工学専攻
  department: [機械工学科],
  // 学位論文の提出「年度」
  FY: [2026],
  // 卒業論文の場合は学籍番号を入力
  // 修士論文の場合は不要なのでコメントアウト
  ID: [12345678],
  // 卒業論文の場合は著者の学年・組・番号を入力
  // 修士論文の場合は不要なのでコメントアウト
  class: [n年n組nn番],
  // 学位論文執筆者氏名
  author: [姓姓　名名],
)
// ========================

#show: setup            // 文書全体の設定
#show: show-theorion    // 定理環境
#show: bib-init         // 参考文献の設定

#set page(numbering: "i")
// === 目次 ===
// 目次が不要な場合は以下の行をコメントアウトしてください．
#outline(
  title: "目次",
  indent: auto,
)
#heading(numbering: none)[図目次]
#show outline.entry: set par(justify: true)
#outline(
  title: none,
  indent: auto,
  target: figure.where(kind: image)
)
#heading(numbering: none)[表目次]
#outline(
  title: none,
  indent: auto,
  target: figure.where(kind: table)
)

// === 記号表 ===
#include "chapter/symbol.typ"

#set page(numbering: "1")
#counter(page).update(1)
// 上のコマンドは消さないで．
// 本文はこれ以降に記載する．

// Typst ソースは一つの typ ファイルに書くのではなく，章ごとの typ ファイルに分割して書きましょう．
// 分割したファイルを読み込むときは #include を使います．

// === 序論 ===
#include "chapter/introduction.typ"

// === 計算手法・実験手法 ===
#include "chapter/method.typ"

// === 結果 ===
#include "chapter/result.typ"

// === 考察 ===
#include "chapter/discussion.typ"

// === 結論 ===
#include "chapter/conclusion.typ"

// === 謝辞 ===
#include "chapter/acknowledgement.typ"

// === 参考文献 ===
#bibliography-list(
  title: "参考文献",
  bib-full: false,
  bib-sort: true,
  bib-sort-ref: false,
  ..bib-file(read("mybib_en.bib"), ..my-bib-style),
  ..bib-file(read("mybib_ja.bib"), ..my-bib-style),
)

// === 付録 ===
#include "chapter/appendix.typ"

