//////////////////////////////////////////////////////////////////
////
////                report_template_Typst
////                    settings.typ
////
//////////////////////////////////////////////////////////////////

// =================================================================
// フォントの設定
// =================================================================
// OS によらず同じ見た目になるよう，リポジトリの fonts/ に同梱したフォントを使う（README 参照）．
// New Computer Modern は Typst に内蔵されている．
// 本文（欧文：New Computer Modern，和文：BIZ UD明朝）
#let serif-font = ("New Computer Modern", "BIZ UDMincho")
// タイトル・見出し等（欧文・和文とも BIZ UDPゴシック）
#let sans-font = ("BIZ UDPGothic",)
// 本文中の太字（欧文：New Computer Modern，和文：BIZ UDゴシック）
#let strong-font = ("New Computer Modern", "BIZ UDGothic")
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
// 図の作成 CeTZ
#import "@preview/cetz:0.5.2"
#import "@preview/cetz-plot:0.1.3": chart, plot
#import "@preview/fletcher:0.5.8" as fletcher: edge, node

#import "@preview/codly:1.3.0": *

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
          align(top + left)[#label],
          align(top + left)[#it.body],
        )
      ]
    } else {
      // 折り返す場合：本文冒頭で揃える
      grid(
        columns: (auto, 1fr),
        column-gutter: gutter,
        align(top + left)[#label],
        align(top + left)[#it.body],
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

// 柱（ページ上部に節の番号と見出しを表示）
// そのページで始まる節があればその節を，なければ直前の節を表示する．
// 表紙・タイトル・目次のあるページには表示しない．
#let running-head = context {
  let page-no = here().page()
  let on-this-page(el) = el.location().page() == page-no
  if query(title).any(on-this-page) or query(outline).any(on-this-page) {
    return
  }
  let headings = query(heading.where(level: 1, outlined: true))
  let current = headings.filter(on-this-page)
  let previous = headings.filter(el => el.location().page() < page-no)
  let sec = if current.len() > 0 {
    current.first()
  } else if previous.len() > 0 {
    previous.last()
  } else {
    return
  }
  set text(font: sans-font, weight: "bold")
  block(width: 100%, inset: (bottom: 3pt), stroke: (bottom: 0.4pt))[
    #if sec.numbering != none {
      numbering(sec.numbering, ..counter(heading).at(sec.location()))
      h(1em)
    }
    #sec.body
  ]
}

#let setup(doc) = {
  // CJK 文字を組むときのスペース
  import "@preview/cjk-spacer:0.2.1": cjk-spacer
  show: cjk-spacer

  // 本文のフォント
  set text(lang: "en", font: serif-font)

  set par(
    justify: true, // 両端揃え
    leading: 0.8em, // 行送り
    spacing: 0.8em, // 段落間の間隔（行送りと同じにして段落間に余分な空きを入れない）
    first-line-indent: (amount: 1em, all: false),
  )

  // ページ番号
  // 本文上の見た目と PDF 内部のページラベルを揃えるため
  // set page(numbering: "--- 1 ---")
  // のようには設定しない．
  set page(numbering: "1")
  set page(
    paper: "a4",
    margin: (x: 20mm, y: 25mm), // 余白（上下 25 mm，左右 20 mm）
    header: running-head,
    footer: context align(center)[
      --- #counter(page).display() ---
    ],
  )

  // タイトル
  show title: set text(font: sans-font)
  show title: set align(center)

  // 見出し番号
  set heading(
    numbering: "1.1",
    supplement: none,
  )

  // 見出し（番号と見出しの間は 1 文字分空ける）
  show heading: it => {
    set text(font: sans-font)
    block({
      if it.numbering != none {
        counter(heading).display(it.numbering)
        h(1em)
      }
      it.body
    })
    par(text(size: 0pt, "")) // 見出しの後に字下げするために空の段落を設定
    v(-1em)
  }
  // 見出しの前後のスペース
  show heading: set block(above: 1.5em, below: 1.5em)

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
    numbering: (..n) => numbering("(1)", ..n),
    supplement: none,
  )
  show math.equation: set block(
    spacing: 1em,
  )
  set math.cases(gap: 1em)

  // リンク
  show link: set text(fill: blue)
  show ref: set text(fill: blue)
  show footnote: set text(fill: blue)

  // 脚注（本文中・脚注とも「1)」の形式．脚注側の番号は上付きにしない）
  set footnote(numbering: "1)")
  show footnote.entry: it => {
    let loc = it.note.location()
    h(it.indent)
    link(loc, numbering(it.note.numbering, ..counter(footnote).at(loc)))
    h(0.5em)
    it.note.body
  }

  // 強調
  show strong: set text(
    weight: "bold",
    font: strong-font,
  )

  // 引用文
  set quote(block: true)
  show quote: set pad(x: 5em)

  // コードブロック（DejaVu Sans Mono には和文がないので和文フォントを補う）
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
    // heading-levels: 1,
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
  // 参照時は「Figure」等をつけずに番号だけを表示する（図・表・コード・定理など）
  set ref(supplement: none)

  doc
}

// 表紙・著者情報と日付の表示
#let author(
  authors: (),
  date: none,
  cover: false,
  doc,
) = {
  if cover {
    // 表紙あり
    page(
      numbering: "i",
      footer: none,
    )[
      #align(center + horizon)[
        #line(length: 100%, stroke: 2pt + rgb("#1f4e79"))
        #v(-0.2em)
        #line(length: 100%, stroke: 1pt + rgb("#1f4e79"))
        #v(0.3em)
        #title()
        #v(1em)
        #line(length: 100%, stroke: 1pt + rgb("#1f4e79"))
        #v(-0.2em)
        #line(length: 100%, stroke: 2pt + rgb("#1f4e79"))

        #v(10em)

        #let count = authors.len()
        #let ncols = calc.min(count, 2)

        #grid(
          columns: (1fr,) * ncols,
          row-gutter: 24pt,
          column-gutter: 36pt,
          ..authors.map(author => text(14pt)[
            #author.name \
            #v(0.5em)
            #author.affiliation \
            #v(0.5em)
            #link("mailto:" + author.email)
          ]),
        )

        #if date != none {
          v(15em)
          text(12pt)[#date]
        }
      ]
    ]
    counter(page).update(1)

    pagebreak()
    doc
  } else {
    // 表紙なし：従来通り
    place(
      top + center,
      float: true,
      scope: "parent",
      clearance: 3em,
      {
        title()

        let count = authors.len()
        let ncols = calc.min(count, 2)

        grid(
          columns: (1fr,) * ncols,
          row-gutter: 24pt,
          ..authors.map(author => text(14pt)[
            #author.name \
            #author.affiliation \
            #link("mailto:" + author.email)
          ]),
        )

        if date != none {
          v(1em)
          align(center)[#date]
        }
      },
    )

    doc
  }
}

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

//========== 参考文献の設定 ============
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
  ("editor", (none, "", author-set, "", ", ", (), ".")),
  ("title", (none, "\"", title-en, ",\"", " ", (), ".")),
  ("publisher", (none, "", all-emph, "", ", ", (), ".")),
  ("year", (" ","(",all-return, "%year-doubling)", ", ", ("editor","title","publisher"), "%year-doubling).")),
  ("note", (none, " (", all-return, "), ", "", (), ").")),
  ("doi", (none, "DOI: ", doi-link, "", "", (), ".")),
  ("url", (none, "", url-link-if-no-doi, "", ", ", (), ".")),
)

#let bibtex-proceedings-ja = (
  ("editor", (none, "", author-set, "", ", ", (), ".")),
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
//=====================================


//========== showybox の設定 ============
#import "@preview/showybox:2.0.4": showybox as original-showybox
#let showybox(
  title: none,
  ..args,
  body,
) = {
  let title-arg = if title == none {
    (:)
  } else {
    (title: text(font: sans-font)[#title])
  }

  original-showybox(
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
//=======================================
