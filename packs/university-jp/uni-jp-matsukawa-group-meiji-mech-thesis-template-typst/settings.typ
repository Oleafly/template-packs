//////////////////////////////////////////////////////////////////
////
////                Meiji-mech_thesis_template_Typst
////                         settings.typ
////
//////////////////////////////////////////////////////////////////

// =================================================================
// フォントの設定
// =================================================================
// OS によらず同じ見た目になるよう，リポジトリの fonts/ に同梱したフォントを使う（README 参照）．
// New Computer Modern は Typst に内蔵されている．
// 本文（欧文：New Computer Modern，和文：BIZ UD明朝）
#let serif-font = ("New Computer Modern", "BIZ UDMincho")
// 見出し等（欧文・和文とも BIZ UDPゴシック）
#let sans-font = ("BIZ UDPGothic",)
// コード（欧文：DejaVu Sans Mono，和文：BIZ UDゴシック）
#let mono-font = ("DejaVu Sans Mono", "BIZ UDGothic")
// =================================================================

// 日本語のダミーテキスト
#import "@preview/roremu:0.1.0": roremu
// 数式を簡単に書くための設定
#import "@preview/physica:0.9.5": *
#let vr(v) = math.bold(math.upright(v)) // ベクトルを直立ボールドで表すコマンドを追加で作成
// 定理環境の設定
#import "@preview/theorion:0.6.0": *
// （好みに応じて変更可）
// #import cosmos.simple: *
// #import cosmos.fancy: *
#import cosmos.rainbow: *
// #import cosmos.clouds: *

// 単位に関する設定
#import "@preview/fancy-units:0.1.1": *

// 複数の図を並べるための設定
#import "@preview/hallon:0.1.3" as hallon: subfigure
// 図のキャプションの設定
#let my-figure-caption(it) = context {
  let gutter = 1em

  let label = [
    #it.supplement
    #h(0.1em)
    #it.counter.display(it.numbering)
  ]

  layout(size => {
    let label-w = measure(label).width
    let body-w = measure(it.body).width
    let gutter-w = measure(h(gutter)).width
    let total-w = label-w + gutter-w + body-w

    if total-w <= size.width {
      // 1 行に収まる場合：キャプション全体を中央寄せ
      align(center)[
        #grid(
          columns: (auto, auto),
          column-gutter: gutter,
          align: (left, top),
          label,
          align(left)[#it.body],
        )
      ]
    } else {
      // 折り返す場合：本文冒頭で揃える
      grid(
        columns: (auto, 1fr),
        column-gutter: gutter,
        align: (left, top),
        label,
        align(left)[#it.body],
      )
    }
  })
}
// サブ図のキャプションの設定
#let my-subfigure-caption(it, parent: none) = context {
  align(center)[
    #counter(figure.where(kind: "subfigure")).display(it.numbering)
    #h(0.5em)
    #it.body
  ]
}

#let appendix-mode = state("appendix-mode", false)

#let appendix = {
  counter(heading).update(0)
  counter(figure.where(kind: image)).update(0)
  counter(figure.where(kind: table)).update(0)
  counter(figure.where(kind: raw)).update(0)
  counter(math.equation).update(0)
  appendix-mode.update(true)
  set-theorion-numbering("A.1") // 定理環境の番号も付録用に
}

// 章番号付きの番号（本文：1.1，付録：A.1）を作る．
// 章番号と付録かどうかは loc の位置で判定する（省略時は現在の位置）．
// 参照時は参照先の位置を loc に渡すことで，どこから参照しても正しい番号になる．
#let chapter-number(n, loc: none, paren: false) = {
  let loc = if loc == none { here() } else { loc }
  let chap-no = counter(heading).at(loc).at(0, default: 0)
  let pattern = if appendix-mode.at(loc) { "A.1" } else { "1.1" }
  let num = numbering(pattern, chap-no, n)
  if paren { [(#num)] } else { [#num] }
}

// =================================================================
// 文書全体の設定
// =================================================================
#let setup(doc) = {
  // CJK 文字を組むときのスペース
  import "@preview/cjk-spacer:0.2.1": cjk-spacer
  show: cjk-spacer

  // 本文のフォント
  set text(lang: "en", font: serif-font)

  set par(
    justify: true, // 両端揃え
    leading: 0.65em, // 行送り
    spacing: 0.65em, // 段落間の間隔
    first-line-indent: (amount: 1em, all: false),
  )

  // 見出しのスタイル
  set heading(
    numbering: (..nums) => {
      let ns = nums.pos()
      if ns.len() == 1 {
        [第 #ns.first() 章#h(0.5em)]
      } else {
        numbering("1.1", ..ns)
      }
    },
  )
  show heading: it => {
    let is-appendix = appendix-mode.get()
    if it.level == 1 {
      pagebreak()
      v(1.8em)
      let has-number = it.numbering != none
      let ns = counter(heading).at(it.location())
      block(width: 100%, above: 2em, below: 2em)[
        #if has-number {
          text(size: 24pt, font: sans-font)[
            #if is-appendix {
              [付録 #numbering("A", ns.first())]
            } else {
              [第 #ns.first() 章]
            }
          ]
          v(1.0em)+h(-1em)
        }
        #text(size: 24pt, font: sans-font)[
          #it.body
        ]
      ]
    } else if it.numbering != none {
      let ns = counter(heading).at(it.location())
      text(font: sans-font)[
        #v(0.2em)
        #linebreak()
        #if is-appendix {
          numbering("A.1", ..ns)
        } else {
          numbering("1.1", ..ns)
        }
        #h(1em)
        #it.body
      ]
    } else {
      text(font: sans-font)[#it.body]
    }
    par(text(size: 0pt, "")) // 見出しの後に字下げするために空の段落を設定
  }
  // ページ番号
  // 本文上の見た目と PDF 内部のページラベルを揃えるため
  // set page(numbering: "--- 1 ---")
  // のようには設定しない．
  set page(numbering: "1")
  set page(
    footer: context align(center)[
      --- #counter(page).display() ---
    ],
  )

  // ページのヘッダーの設定
  import "@preview/hydra:0.6.2": hydra
  set page(
    header: context {
      let is-chapter-start = query(heading.where(level: 1)).any(it => it.location().page() == here().page())
      if not is-chapter-start {
        text(font: sans-font, weight: "bold")[#hydra(1)]
        line(length: 100%, stroke: 0.5pt)
      }
    },
  )

  // 番号なしの箇条書きの設定
  set list(
    indent: 1em,
  )
  show list: set block(
    spacing: 1em,
  )
  // 番号付きの箇条書きの設定
  set enum(
    indent: 1em,
  )
  show enum: set block(
    spacing: 1em,
  )

  // 複数行に亘る数式に関する設定
  import "@preview/equate:0.3.3": equate
  show: equate.with(breakable: true, sub-numbering: false)

  // 数式に関する設定
  set math.equation(
    numbering: (..nums) => chapter-number(nums.pos().first(), paren: true),
    number-align: bottom,
    supplement: none,
  )
  show math.equation: set block(
    spacing: 1em,
  )
  set math.cases(gap: 1em)

  // 図表・数式の番号付けを章ごとにリセットするための設定
  show heading.where(level: 1): it => {
    counter(math.equation).update(0)
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)
    counter(figure.where(kind: raw)).update(0)
    it
  }

  // リンク
  show link: set text(fill: blue)
  show ref: set text(fill: blue)
  show footnote: set text(fill: blue)

  // コードブロック（DejaVu Sans Mono には和文がないので和文フォントを補う）
  import "@preview/codly:1.3.0": *
  show raw: set text(font: mono-font)
  show: codly-init.with()

  // 単位に関する設定
  fancy-units-configure(
    per-mode: "slash",
    unit-separator: sym.dot,
  )
  // 単位のマクロを追加
  add-macros(
    u: sym.mu,
    celsius: [$degree:C$],
    fahrenheit: [$degree:F$],
  )

  // 複数の図を並べるための設定
  show: hallon.style-figures.with(
    heading-levels: 1,
    figure-caption: my-figure-caption,
    subfigure-caption: my-subfigure-caption,
  )
  show figure.where(kind: image): set figure(supplement: "Figure")
  show figure.where(kind: image): set figure.caption(separator: h(1em))
  show figure.where(kind: "subfigure"): set figure(supplement: none, numbering: " (a)")
  show figure.where(kind: table): set figure.caption(position: top)
  show figure.where(kind: table): set figure.caption(separator: h(1em))

  // 図とキャプションの間のスペースを設定
  set figure(gap: 1em)
  // 図・表・コードの番号（hallon の番号付けを上書きするため hallon の設定より後に置く）
  set figure(numbering: (..nums) => chapter-number(nums.pos().first()))

  // 参照の表示
  // 図・表・コード・定理などは「Figure」等をつけずに番号だけを表示する．
  // （Typst 標準の参照は参照先の位置で番号を計算するので，別の章から参照しても正しい番号になる）
  set ref(supplement: none)
  // 章・節と複数行の数式の行ラベルは標準の参照では正しく表示できないので個別に設定する．
  // パッケージ（equate）の参照の設定より優先させるため，文書全体の設定の最後に置く．
  // 番号は参照先の位置で計算する（参照した位置の章番号を使わないように）．
  show ref: it => {
    let el = it.element
    if el == none { return it }
    let loc = el.location()

    if el.func() == heading {
      let nums = counter(heading).at(loc)
      let is-appendix = appendix-mode.at(loc)
      link(loc)[#if nums.len() == 1 {
          if is-appendix { numbering("A", nums.first()) } else { nums.first() }
        } else {
          numbering(if is-appendix { "A.1" } else { "1.1" }, ..nums)
        }]
    } else if (
      el.func() == figure and el.kind == math.equation
        and el.body != none and el.body.func() == metadata
    ) {
      // 複数行の数式で行ごとにつけたラベル（equate，sub-numbering: false の場合）
      let nums = el.body.value
      let n = nums.first() + nums.slice(1).sum(default: 1) - 1
      link(loc, chapter-number(n, loc: loc, paren: true))
    } else {
      it
    }
  }

  doc
}
// =================================================================

// 次元表記用のマクロ
#let dimension(body) = {
  unit(
    per-mode: "power",
    unit-separator: h(0.2em),
  )[#body]
}

// =================================================================
// 表紙に関する設定
// =================================================================

// 卒業論文の表紙
#let bachelor-cover(
  title: [],
  subtitle: none,
  author: [],
  supervisor: [],
  department: [],
  FY: [],
  ID: [],
  class: [],
) = [
  #align(center)[
    #v(25mm)

    #text(22pt)[#title]

    // 副題（指定した場合のみ表示）
    #if subtitle != none {
      text(16pt)[#subtitle]
    }

    #v(25mm)

    #text(18pt)[指導教員]

    #text(18pt)[#supervisor]

    #v(18mm)

    #text(18pt)[明治大学理工学部]

    #text(18pt)[#department]

    #v(18mm)

    #text(18pt)[#FY 年度]

    #v(18mm)

    #text(18pt)[学籍番号 #h(1em) #ID]

    #text(18pt)[#class]

    #text(18pt)[#author]
  ]
]

// 修士論文の表紙
#let master-cover(
  title: [],
  subtitle: none,
  author: [],
  supervisor: [],
  department: [],
  FY: [],
) = [
  #align(center)[
    #v(15mm)

    #text(18pt)[明治大学大学院　理工学研究科]

    #text(18pt)[#FY 年度]

    #text(18pt)[修士学位請求論文]

    #v(18mm)

    #box(width: 80%, stroke: 1pt, inset: 12pt)[#text(18pt)[#align(left)[論文題目：]#title#if subtitle != none [ \ #text(14pt)[#subtitle]]]]

    #v(18mm)

    #box(width: 80%, stroke: 1pt, inset: 12pt)[#text(18pt)[#align(left)[指導教員名：#supervisor]]]

    #v(18mm)

    #box(width: 80%, stroke: 1pt, inset: 12pt)[#text(18pt)[#department#v(18pt)#align(left)[請求者氏名：#author]]]

  ]
]

// 表紙の設定
#let thesis-cover(
  kind: "bachelor", // bachelor, master
  title: [],
  subtitle: none,
  author: [],
  supervisor: [],
  department: [],
  FY: [],
  ID: [],
  class: [],
) = {
  assert(
    kind in ("bachelor", "master"),
    message: "thesis-cover の kind には \"bachelor\"（卒業論文）か \"master\"（修士論文）を指定してください．",
  )

  set page(
    margin: (top: 25mm, bottom: 25mm, x: 25mm),
    numbering: "i",
    footer: none,
  )
  // 表紙のフォント
  set text(lang: "en", font: serif-font)

  if kind == "bachelor" {
    bachelor-cover(
      title: title,
      subtitle: subtitle,
      author: author,
      supervisor: supervisor,
      department: department,
      FY: FY,
      ID: ID,
      class: class,
    )
  } else if kind == "master" {
    master-cover(
      title: title,
      subtitle: subtitle,
      author: author,
      supervisor: supervisor,
      department: department,
      FY: FY,
    )
  }
}
// =================================================================

// =================================================================
// 自作の表環境
// =================================================================
#let mytable(body) = {
  set table(
    stroke: (x, y) => (
      if y == 0 {
        (top: black)
        (bottom: black)
      }
        + if x == 0 {
          (right: black)
        }
    ),
    align: (x, y) => center,
    fill: (x, y) => {
      if y == 0 {
        none
      } else if calc.odd(y) {
        rgb("F7FBFD")
      } else {
        rgb("E6F2F7")
      }
    },
  )

  body
}

#let mytable2(body) = {
  set table(
    stroke: (x, y) => (
      if y == 0 {
        (top: black)
      }
        + if x == 0 {
          (right: black)
        }
    ),
    align: (x, y) => center,
    fill: (x, y) => {
      if calc.odd(y) {
        rgb("F7FBFD")
      } else {
        rgb("E6F2F7")
      }
    },
  )

  body
}
// =================================================================

// =================================================================
// 参考文献の設定
// =================================================================
#import "@preview/enja-bib:0.1.0": *
#import bib-setting-plain: *

#let doi-link(biblist, name) = {
  let doi = biblist.at(name).sum()
  link("https://doi.org/" + doi)[#raw(doi)]
}

#let url-link-if-no-doi(biblist, name) = {
  if biblist.at("doi", default: ()).len() == 0 {
    let url = biblist.at(name).sum()
    [URL: <#link(url)[#raw(url)]>]
  } else {
    []
  }
}

#let arxiv-link(biblist, name) = {
  let eprint = biblist.at(name).sum()
  [arXiv:#h(0.3em)#link("https://arxiv.org/abs/" + eprint)[#raw(eprint)]]
}

#let bibtex-article-en = (
  ("author", (none, "", author-set, "", ", ", (), ".")),
  ("title", (none, "\"", title-en, ",\"", " ", (), ".")),
  ("journal", (none, "", all-emph, "", ", ", (), ".")),
  ("year", (" ","(",all-return, "%year-doubling)", ", ", ("author","title","journal", "volume", "number"), "%year-doubling).")),
  ("volume", (none, "", all-bold, "", "", (), ".")),
  ("number", (none, "(", all-return, ")", "", (), ").")),
  ("pages", (none, ", ", page-set-without-p, ", ", "", (), ".")),
  ("note", (none, " (", all-return, "), ", "", (), ").")),
  ("doi", (none, "DOI: ", doi-link, "", "", (), ".")),
  ("url", (none, "", url-link-if-no-doi, "", ", ", (), ".")),
)

#let bibtex-article-ja = (
  ("author", (none, "", author-set, "", ", ", (), ".")),
  ("title", (none, "「", all-return, "」, ", " ", (), ".")),
  ("journal", (none, "", all-return, "", ", ", (), ".")),
  ("year", (" ","(",all-return, "%year-doubling)", ", ", ("author","title","journal", "volume", "number"), "%year-doubling).")),
  ("volume", (none, "", all-bold, "", "", (), ".")),
  ("number", (none, "(", all-return, ")", "", (), ").")),
  ("pages", (none, ", ", page-set-without-p, ", ", "", (), ".")),
  ("note", (none, " (", all-return, "), ", "", (), ").")),
  ("doi", (none, "DOI: ", doi-link, "", "", (), ".")),
  ("url", (none, "", url-link-if-no-doi, "", ", ", (), ".")),
)

#let bibtex-book-en = (
  ("author", (none, "", author-set, "", ", ", (), ".")),
  ("editor", (none, "", author-set, " ed.", ", ", (), ".")),
  ("title", (none, "\"", title-en, ",\"", " ", (), ".")),
  ("publisher", (none, "", all-emph, "", ", ", (), ".")),
  ("year", (" ","(",all-return, "%year-doubling)", ", ", ("author","title","publisher"), "%year-doubling).")),
  ("volume", (none, "", all-bold, "", "", (), ".")),
  ("number", (none, "(", all-return, ")", "", (), ").")),
  ("note", (none, " (", all-return, "), ", "", (), ").")),
  ("doi", (none, "DOI: ", doi-link, "", "", (), ".")),
  ("url", (none, "", url-link-if-no-doi, "", ", ", (), ".")),
)

#let bibtex-book-ja = (
  ("author", (none, "", author-set, "", ", ", (), ".")),
  ("editor", (none, "", author-set, "編", ", ", (), ".")),
  ("title", (none, "「", all-return, "」, ", " ", (), ".")),
  ("publisher", (none, "", all-return, "", ", ", (), ".")),
  ("year", (" ","(",all-return, "%year-doubling)", ", ", ("author","title","publisher"), "%year-doubling).")),
  ("volume", (none, "", all-bold, "", "", (), ".")),
  ("number", (none, "(", all-return, ")", "", (), ").")),
  ("note", (none, " (", all-return, "), ", "", (), ").")),
  ("doi", (none, "DOI: ", doi-link, "", "", (), ".")),
  ("url", (none, "", url-link-if-no-doi, "", ", ", (), ".")),
)

#let bibtex-booklet-en = (
  ("author", (none, "", author-set, "", ", ", (), ".")),
  ("title", (none, "\"", title-en, ",\"", " ", (), ".")),
  ("howpublished", (none, "", all-emph, "", ", ", (), ".")),
  ("year", (" ","(",all-return, "%year-doubling)", ", ", ("author","title","howpublished"), "%year-doubling).")),
  ("note", (none, " (", all-return, "), ", "", (), ").")),
  ("doi", (none, "DOI: ", doi-link, "", "", (), ".")),
  ("url", (none, "", url-link-if-no-doi, "", ", ", (), ".")),
)

#let bibtex-booklet-ja = (
  ("author", (none, "", author-set, "", ", ", (), ".")),
  ("title", (none, "「", all-return, "」, ", " ", (), ".")),
  ("howpublished", (none, "", all-return, "", ", ", (), ".")),
  ("year", (" ","(",all-return, "%year-doubling)", ", ", ("author","title","howpublished"), "%year-doubling).")),
  ("note", (none, " (", all-return, "), ", "", (), ").")),
  ("doi", (none, "DOI: ", doi-link, "", "", (), ".")),
  ("url", (none, "", url-link-if-no-doi, "", ", ", (), ".")),
)

#let bibtex-conference-en = (
  ("author", (none, "", author-set, "", ", ", (), ".")),
  ("title", (none, "\"", title-en, ",\"", " ", (), ".")),
  ("booktitle", (none, "", all-emph, "", ", ", (), ".")),
  ("year", (" ","(",all-return, "%year-doubling)", ", ", ("author","title","booktitle"), "%year-doubling).")),
  ("pages", (none, "", page-set-without-p, "", ", ", (), ".")),
  ("note", (none, " (", all-return, "), ", "", (), ").")),
  ("doi", (none, "DOI: ", doi-link, "", "", (), ".")),
  ("url", (none, "", url-link-if-no-doi, "", ", ", (), ".")),
)

#let bibtex-conference-ja = (
  ("author", (none, "", author-set, "", ", ", (), ".")),
  ("title", (none, "「", all-return, "」, ", " ", (), ".")),
  ("booktitle", (none, "", all-return, "", ", ", (), ".")),
  ("year", (" ","(",all-return, "%year-doubling)", ", ", ("author","title","booktitle"), "%year-doubling).")),
  ("pages", (none, "", page-set-without-p, "", ", ", (), ".")),
  ("note", (none, " (", all-return, "), ", "", (), ").")),
  ("doi", (none, "DOI: ", doi-link, "", "", (), ".")),
  ("url", (none, "", url-link-if-no-doi, "", ", ", (), ".")),
)

#let bibtex-inbook-en = (
  ("author", (none, "", author-set, "", ", ", (), ".")),
  ("editor", (none, "", author-set, " ed.", ", ", (), ".")),
  ("title", (none, "\"", title-en, ",\"", " ", (), ".")),
  ("publisher", (none, "", all-emph, "", ", ", (), ".")),
  ("year", (" ","(",all-return, "%year-doubling)", ", ", ("author","title","publisher"), "%year-doubling).")),
  ("volume", (none, "", all-bold, "", "", (), ".")),
  ("pages", (none, "", page-set-without-p, "", ", ", (), ".")),
  ("note", (none, " (", all-return, "), ", "", (), ").")),
  ("doi", (none, "DOI: ", doi-link, "", "", (), ".")),
  ("url", (none, "", url-link-if-no-doi, "", ", ", (), ".")),
)

#let bibtex-inbook-ja = (
  ("author", (none, "", author-set, "", ", ", (), ".")),
  ("editor", (none, "", author-set, "編", ", ", (), ".")),
  ("title", (none, "「", all-return, "」, ", " ", (), ".")),
  ("publisher", (none, "", all-return, "", ", ", (), ".")),
  ("year", (" ","(",all-return, "%year-doubling)", ", ", ("author","title","publisher"), "%year-doubling).")),
  ("volume", (none, "", all-bold, "", "", (), ".")),
  ("pages", (none, "", page-set-without-p, "", ", ", (), ".")),
  ("note", (none, " (", all-return, "), ", "", (), ").")),
  ("doi", (none, "DOI: ", doi-link, "", "", (), ".")),
  ("url", (none, "", url-link-if-no-doi, "", ", ", (), ".")),
)

#let bibtex-incollection-en = (
  ("author", (none, "", author-set, "", ", ", (), ".")),
  ("title", (none, "\"", title-en, ",\"", " ", (), ".")),
  ("booktitle", (none, "", all-emph, "", ", ", (), ".")),
  ("year", (" ","(",all-return, "%year-doubling)", ", ", ("author","title","booktitle"), "%year-doubling).")),
  ("pages", (none, "", page-set-without-p, "", ", ", (), ".")),
  ("note", (none, " (", all-return, "), ", "", (), ").")),
  ("doi", (none, "DOI: ", doi-link, "", "", (), ".")),
  ("url", (none, "", url-link-if-no-doi, "", ", ", (), ".")),
)

#let bibtex-incollection-ja = (
  ("author", (none, "", author-set, "", ", ", (), ".")),
  ("title", (none, "「", all-return, "」, ", " ", (), ".")),
  ("booktitle", (none, "", all-return, "", ", ", (), ".")),
  ("year", (" ","(",all-return, "%year-doubling)", ", ", ("author","title","booktitle"), "%year-doubling).")),
  ("pages", (none, "", page-set-without-p, "", ", ", (), ".")),
  ("note", (none, " (", all-return, "), ", "", (), ").")),
  ("doi", (none, "DOI: ", doi-link, "", "", (), ".")),
  ("url", (none, "", url-link-if-no-doi, "", ", ", (), ".")),
)

#let bibtex-inproceedings-en = (
  ("author", (none, "", author-set, "", ", ", (), ".")),
  ("title", (none, "\"", title-en, ",\"", " ", (), ".")),
  ("booktitle", (none, "", all-emph, "", ", ", (), ".")),
  ("year", (" ","(",all-return, "%year-doubling)", ", ", ("author","title","booktitle"), "%year-doubling).")),
  ("pages", (none, "", page-set-without-p, "", ", ", (), ".")),
  ("note", (none, " (", all-return, "), ", "", (), ").")),
  ("doi", (none, "DOI: ", doi-link, "", "", (), ".")),
  ("url", (none, "", url-link-if-no-doi, "", ", ", (), ".")),
)

#let bibtex-inproceedings-ja = (
  ("author", (none, "", author-set, "", ", ", (), ".")),
  ("title", (none, "「", all-return, "」, ", " ", (), ".")),
  ("booktitle", (none, "", all-return, "", ", ", (), ".")),
  ("year", (" ","(",all-return, "%year-doubling)", ", ", ("author","title","booktitle"), "%year-doubling).")),
  ("pages", (none, "", page-set-without-p, "", ", ", (), ".")),
  ("note", (none, " (", all-return, "), ", "", (), ").")),
  ("doi", (none, "DOI: ", doi-link, "", "", (), ".")),
  ("url", (none, "", url-link-if-no-doi, "", ", ", (), ".")),
)

#let bibtex-manual-en = (
  ("author", (none, "", author-set, "", ", ", (), ".")),
  ("title", (none, "\"", title-en, "\"", " ", (), ".")),
  ("year", (" ","(",all-return, "%year-doubling)", ", ", ("author","title"), "%year-doubling).")),
  ("note", (none, " (", all-return, "), ", "", (), ").")),
  ("doi", (none, "DOI: ", doi-link, "", "", (), ".")),
  ("url", (none, "", url-link-if-no-doi, "", ", ", (), ".")),
)

#let bibtex-manual-ja = (
  ("author", (none, "", author-set, "", ", ", (), ".")),
  ("title", (none, "「", all-return, "」", " ", (), ".")),
  ("year", (" ","(",all-return, "%year-doubling)", ", ", ("author","title"), "%year-doubling).")),
  ("note", (none, " (", all-return, "), ", "", (), ").")),  
  ("doi", (none, "DOI: ", doi-link, "", "", (), ".")),
  ("url", (none, "", url-link-if-no-doi, "", ", ", (), ".")),
)

#let bibtex-mastersthesis-en = (
  ("author", (none, "", author-set, "", ", ", (), ".")),
  ("title", (none, "\"", title-en, ",\"", " ", (), ".")),
  ("school", (none, "_Master's Thesis_, ", all-emph, "", ", ", (), ".")),
  ("year", (" ","(",all-return, "%year-doubling)", ", ", ("author","title","school"), "%year-doubling).")),
  ("note", (none, " (", all-return, "), ", "", (), ").")),
  ("doi", (none, "DOI: ", doi-link, "", "", (), ".")),
  ("url", (none, "", url-link-if-no-doi, "", ", ", (), ".")),
)

#let bibtex-mastersthesis-ja = (
  ("author", (none, "", author-set, "", ", ", (), ".")),
  ("title", (none, "「", all-return, "」, ", " ", (), ".")),
  ("school", (none, "", all-return, "修士論文", ", ", (), ".")),
  ("year", (" ","(",all-return, "%year-doubling)", ", ", ("author","title","school"), "%year-doubling).")),
  ("note", (none, " (", all-return, "), ", "", (), ").")),
  ("doi", (none, "DOI: ", doi-link, "", "", (), ".")),
  ("url", (none, "", url-link-if-no-doi, "", ", ", (), ".")),
)

#let bibtex-misc-en = (
  ("author", (none, "", author-set, "", ", ", (), ".")),
  ("title", (none, "\"", title-en, ",\"", " ", (), ".")),
  ("howpublished", (none, "", all-emph, "", ", ", (), ".")),
  ("year", (" ","(",all-return, "%year-doubling)", ", ", ("author","title","howpublished"), "%year-doubling).")),
  ("note", (none, " (", all-return, "), ", "", (), ").")),
  ("eprint", (none, "", arxiv-link, "", ", ", (), ".")),
  ("doi", (none, "DOI: ", doi-link, "", "", (), ".")),
  ("url", (none, "", url-link-if-no-doi, "", ", ", (), ".")),
)

#let bibtex-misc-ja = (
  ("author", (none, "", author-set, "", ", ", (), ".")),
  ("title", (none, "「", all-return, "」, ", " ", (), ".")),
  ("howpublished", (none, "", all-return, "", ", ", (), ".")),
  ("year", (" ","(",all-return, "%year-doubling)", ", ", ("author","title","howpublished"), "%year-doubling).")),
  ("note", (none, " (", all-return, "), ", "", (), ").")),
  ("eprint", (none, "", arxiv-link, "", ", ", (), ".")),
  ("doi", (none, "DOI: ", doi-link, "", "", (), ".")),
  ("url", (none, "", url-link-if-no-doi, "", ", ", (), ".")),
)

#let bibtex-online-en = (
  ("author", (none, "", author-set, "", ", ", (), ".")),
  ("title", (none, "\"", title-en, ",\"", " ", (), ".")),
  ("howpublished", (none, "", all-emph, "", ", ", (), ".")),
  ("year", (" ","(",all-return, "%year-doubling)", ", ", ("author","title","howpublished"), "%year-doubling).")),
  ("note", (none, " (", all-return, "), ", "", (), ").")),
  ("doi", (none, "DOI: ", doi-link, "", "", (), ".")),
  ("url", (none, "", url-link-if-no-doi, "", ", ", (), ".")),
  ("access", (none, "(accessed on: ", all-return, ")", ", ", (), ").")),
)

#let bibtex-online-ja = (
  ("author", (none, "", author-set, "", ", ", (), ".")),
  ("title", (none, "「", all-return, "」, ", " ", (), ".")),
  ("howpublished", (none, "", all-return, "", ", ", (), ".")),
  ("year", (" ","(",all-return, "%year-doubling)", ", ", ("author","title","howpublished"), "%year-doubling).")),
  ("note", (none, " (", all-return, "), ", "", (), ").")),
  ("doi", (none, "DOI: ", doi-link, "", "", (), ".")),
  ("url", (none, "", url-link-if-no-doi, "", ", ", (), ".")),
  ("access", (none, "(accessed on: ", all-return, ")", ", ", (), ").")),
)


#let bibtex-phdthesis-en = (
  ("author", (none, "", author-set, "", ", ", (), ".")),
  ("title", (none, "\"", title-en, ",\"", " ", (), ".")),
  ("school", (none, "_Ph.D. Dissertation_, ", all-emph, "", ", ", (), ".")),
  ("year", (" ","(",all-return, "%year-doubling)", ", ", ("author","title","school"), "%year-doubling).")),
  ("note", (none, " (", all-return, "), ", "", (), ").")),
  ("doi", (none, "DOI: ", doi-link, "", "", (), ".")),
  ("url", (none, "", url-link-if-no-doi, "", ", ", (), ".")),
)

#let bibtex-phdthesis-ja = (
  ("author", (none, "", author-set, "", ", ", (), ".")),
  ("title", (none, "「", all-return, "」, ", " ", (), ".")),
  ("school", (none, "", all-return, "博士論文", ", ", (), ".")),
  ("year", (" ","(",all-return, "%year-doubling)", ", ", ("author","title","school"), "%year-doubling).")),
  ("note", (none, " (", all-return, "), ", "", (), ").")),
  ("doi", (none, "DOI: ", doi-link, "", "", (), ".")),
  ("url", (none, "", url-link-if-no-doi, "", ", ", (), ".")),
)

#let bibtex-proceedings-en = (
  ("editor", (none, "", author-set, " ed.", ", ", (), ".")),
  ("title", (none, "\"", title-en, ",\"", " ", (), ".")),
  ("publisher", (none, "", all-emph, "", ", ", (), ".")),
  ("year", (" ","(",all-return, "%year-doubling)", ", ", ("editor","title","publisher"), "%year-doubling).")),
  ("note", (none, " (", all-return, "), ", "", (), ").")),
  ("doi", (none, "DOI: ", doi-link, "", "", (), ".")),
  ("url", (none, "", url-link-if-no-doi, "", ", ", (), ".")),
)

#let bibtex-proceedings-ja = (
  ("editor", (none, "", author-set, "編", ", ", (), ".")),
  ("title", (none, "「", all-return, "」, ", " ", (), ".")),
  ("publisher", (none, "", all-return, "", ", ", (), ".")),
  ("year", (" ","(",all-return, "%year-doubling)", ", ", ("editor","title","publisher"), "%year-doubling).")),
  ("note", (none, " (", all-return, "), ", "", (), ").")),
  ("doi", (none, "DOI: ", doi-link, "", "", (), ".")),
  ("url", (none, "", url-link-if-no-doi, "", ", ", (), ".")),
)

#let bibtex-techreport-en = (
  ("author", (none, "", author-set, "", ", ", (), ".")),
  ("title", (none, "\"", title-en, ",\"", " ", (), ".")),
  ("institution", (none, "", all-emph, "", ", ", (), ".")),
  ("year", (" ","(",all-return, "%year-doubling)", ", ", ("author","title","institution"), "%year-doubling).")),
  ("number", (none, "(", all-return, "), ", "", (), ").")),
  ("note", (none, " (", all-return, "), ", "", (), ").")),
  ("doi", (none, "DOI: ", doi-link, "", "", (), ".")),
  ("url", (none, "", url-link-if-no-doi, "", ", ", (), ".")),
)

#let bibtex-techreport-ja = (
  ("author", (none, "", author-set, "", ", ", (), ".")),
  ("title", (none, "「", all-return, "」, ", " ", (), ".")),
  ("institution", (none, "", all-return, "", ", ", (), ".")),
  ("year", (" ","(",all-return, "%year-doubling)", ", ", ("author","title","institution"), "%year-doubling).")),
  ("number", (none, "(", all-return, "), ", "", (), ").")),
  ("note", (none, " (", all-return, "), ", "", (), ").")),
  ("doi", (none, "DOI: ", doi-link, "", "", (), ".")),
  ("url", (none, "", url-link-if-no-doi, "", ", ", (), ".")),
)

#let bibtex-unpublished-en = (
  ("author", (none, "", author-set, "", ", ", (), ".")),
  ("title", (none, "\"", title-en, "\"", " ", (), ".")),
  ("year", (" ","(",all-return, "%year-doubling)", ", ", ("author","title"), "%year-doubling).")),
  ("note", (none, " (", all-return, "), ", "", (), ").")),
  ("doi", (none, "DOI: ", doi-link, "", "", (), ".")),
  ("url", (none, "", url-link-if-no-doi, "", ", ", (), ".")),
)

#let bibtex-unpublished-ja = (
  ("author", (none, "", author-set, "", ", ", (), ".")),
  ("title", (none, "「", all-return, "」", " ", (), ".")),
  ("year", (" ","(",all-return, "%year-doubling)", ", ", ("author","title"), "%year-doubling).")),
  ("note", (none, " (", all-return, "), ", "", (), ").")),
  ("doi", (none, "DOI: ", doi-link, "", "", (), ".")),
  ("url", (none, "", url-link-if-no-doi, "", ", ", (), ".")),
)

#let my-bib-style = (
  bibtex-article-en: bibtex-article-en,
  bibtex-article-ja: bibtex-article-ja,
  bibtex-book-en: bibtex-book-en,
  bibtex-book-ja: bibtex-book-ja,
  bibtex-booklet-en: bibtex-booklet-en,
  bibtex-booklet-ja: bibtex-booklet-ja,
  bibtex-conference-en: bibtex-conference-en,
  bibtex-conference-ja: bibtex-conference-ja,
  bibtex-inbook-en: bibtex-inbook-en,
  bibtex-inbook-ja: bibtex-inbook-ja,
  bibtex-incollection-en: bibtex-incollection-en,
  bibtex-incollection-ja: bibtex-incollection-ja,
  bibtex-inproceedings-en: bibtex-inproceedings-en,
  bibtex-inproceedings-ja: bibtex-inproceedings-ja,
  bibtex-manual-en: bibtex-manual-en,
  bibtex-manual-ja: bibtex-manual-ja,
  bibtex-mastersthesis-en: bibtex-mastersthesis-en,
  bibtex-mastersthesis-ja: bibtex-mastersthesis-ja,
  bibtex-misc-en: bibtex-misc-en,
  bibtex-misc-ja: bibtex-misc-ja,
  bibtex-online-en: bibtex-online-en,
  bibtex-online-ja: bibtex-online-ja,
  bibtex-phdthesis-en: bibtex-phdthesis-en,
  bibtex-phdthesis-ja: bibtex-phdthesis-ja,
  bibtex-proceedings-en: bibtex-proceedings-en,
  bibtex-proceedings-ja: bibtex-proceedings-ja,
  bibtex-techreport-en: bibtex-techreport-en,
  bibtex-techreport-ja: bibtex-techreport-ja,
  bibtex-unpublished-en: bibtex-unpublished-en,
  bibtex-unpublished-ja: bibtex-unpublished-ja,
)
// =================================================================


// =================================================================
// showybox の設定
// =================================================================
#import "@preview/showybox:2.0.4": showybox as original-showybox
#let showybox(
  title: none,
  // breakable: true,
  ..args,
  body,
) = {
  let title-arg = if title == none {
    (:)
  } else {
    (title: text(font: sans-font)[#title])
  }

  original-showybox(
  // breakable: true,
    ..args,
    ..title-arg,
  )[
    #body
  ]
}

#let bluebox = (
  title-color: rgb("#007bff"),
  border-color: rgb("#007bff"),
  body-color: rgb("#f0f8ff"),
  footer-color: rgb("#f0f8ff"),
)

#let redbox = (
  title-color: rgb("#fc3e3e"),
  border-color: rgb("#fc3e3e"),
  body-color: rgb("#fff0f0"),
  footer-color: rgb("#fff0f0"),
)

#let greenbox = (
  title-color: rgb("#00cc4b"),
  border-color: rgb("#00cc4b"),
  body-color: rgb("#f0fff0"),
  footer-color: rgb("#f0fff0"),
)

#let graybox = (
  title-color: rgb("#666666"),
  border-color: rgb("#666666"),
  body-color: rgb("#F5F5F5"),
  footer-color: rgb("#F5F5F5"),
)
// =================================================================


// =================================================================
// 自分用の変数定義
// =================================================================
// 各種無次元数
#let Gr = $"Gr"$
#let Ma = $"Ma"$
#let Nu = $"Nu"$
#let Pe = $"Pe"$
#let Ra = $"Ra"$
#let Ret = $"Re"_tau$
#let Sc = $"Sc"$
#let St = $"St"$
#let Ta = $"Ta"$
#let Wi = $"Wi"$

// 略語
#let avg = $"avg"$
#let rms = $"rms"$
// =================================================================


