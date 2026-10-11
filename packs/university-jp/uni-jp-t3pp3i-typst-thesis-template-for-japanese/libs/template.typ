//モジュールをインポート
#import "./layout.typ": *

///////////////////////////////////

// 論文全体の設定
#let thesis(body) = {

  // PDFのメタデータ
  set document(title: TITLE, author: AUTHOR)

  // 紙面の大きさと余白の設定
  set page(paper: paper_size, margin: (bottom: margin_bottom, top: margin_top, left: margin_left, right: margin_right))

  // 行間，段落間，字下げ，両端揃えの設定
  set par(leading: line_space, spacing: line_space, first-line-indent: 1em, justify: true)

  // 句読点の設定 (左の要素を右の要素に置き換え)
  show "、": "，"
  show "。": "．"

  // ブロック内の余白の設定
  set block(inset: 0pt)

  // 表の線を一旦すべて消す
  set table(stroke: none)

  // フォントの設定
  set text(
    font: (font_type.roman, font_type.ja_text), // 英数字と日本語のフォント
    size: font_size.text, // テキストのフォントサイズ
    lang: "ja", // 言語
  )
  // 数式の設定
  set math.equation(
    supplement: eq_suppl,
    numbering: if chapt_eq_count == true {
      equation_num
    } else {
      "(1)"
    },
  )

  // 数式のフォント
  show math.equation: set text(font: font_type.math)

  // 数式がページをまたぐことを許可するかどうか
  show math.equation: set block(breakable: false)

  // 数式の間のスペース
  show math.equation.where(block: true): set block(spacing: font_size.text)

  // インライン数式と本文の間のスペースを調整
  show math.equation.where(block: false): it => {
    [#text(font: font_type.ja_text)[ ]#it#text(font: font_type.ja_text)[ ]]
  }

  // 章の設定
  show heading.where(level: 1): it => {
    // 章番号が1でない場合にページ区切り
    if auto_pagebreak and str(counter(heading).at(here()).at(0)) != "1" {
      pagebreak()
    }
    // 数式番号のリセット
    if chapt_eq_count == true {
      counter(math.equation).update(0)
    }
    // 空白の挿入
    if not auto_pagebreak and str(counter(heading).at(here()).at(0)) != "1" {
      v(1em, weak: true)
    }
    set text(size: font_size.chapter)
    headline(it)
  }
  // 節の設定
  show heading.where(level: 2): it => {
    set text(size: font_size.section)
    headline(it)
  }
  // 項の設定
  show heading.where(level: 3): it => {
    set text(size: font_size.subsection)
    headline(it)
  }

  // 文中の参照番号表示
  show ref: it => {
    if it.element != none and it.element.func() == figure {
      // 図表の場合
      let el = it.element // 図表の要素
      let loc = el.location() // 図表の位置
      let chapt = counter(heading).at(loc).at(0) // 章番号

      link(loc)[
        // "image" または "table" の場合
        #if el.kind == "image" or el.kind == "table" {

          // "image"の場合は image_suppl_ref、"table"の場合は table_suppl_ref を使用
          let kind_ref = if el.kind == "image" {
            image_suppl_ref
          } else {
            table_suppl_ref
          }

          // chapt_fig_countが true かどうかで表示形式を分岐
          let num = if chapt_fig_count == true {
            // chapt_fig_countが true の場合、章ごとの番号を生成
            let chapter_num = counter(el.kind + "-chapter" + str(chapt)).at(loc).at(0) + 1
            str(chapt) + "." + str(chapter_num)
          } else {
            // chapt_fig_countが false の場合、全体の通し番号を使用
            let global_num = counter(figure.where(kind: el.kind)).at(loc).at(0)
            str(global_num)
          }

          // 種類ごとの補足参照とスペースを挿入
          kind_ref
          h(0.25em)
          num

        } else {
          // "image" でも "table" でもない場合、対象オブジェクトをそのまま表示
          it
        }
      ]
    } else if it.element != none and it.element.func() == math.equation {
      // 数式の場合
      let el = it.element // 数式の要素
      let loc = el.location() // 数式の位置
      let chapt = counter(heading).at(loc).at(0) // 章番号
      let num = counter(math.equation).at(loc).at(0) // 数式番号

      if chapt_eq_count == true {
        it.element.supplement + " (" + str(chapt) + "." + str(num) + ")"
      } else {
        it.element.supplement + " (" + str(num) + ")"
      }
    } else if it.element != none and it.element.func() == heading {
      // 見出しの場合
      let el = it.element
      let loc = el.location()
      let num = numbering(el.numbering, ..counter(heading).at(loc))
      if el.level == 1 {
        str(num) + "章"
      } else if el.level == 2 {
        str(num) + "節"
      } else if el.level == 3 {
        str(num) + "項"
      }
    } else {
      it
    }
  }

  // 図表のキャプション位置と番号の振り方の設定
  show figure: it => {
    set text(size: font_size.text)
    //// カウンタ表示の文字列を変数に格納
    let counter_text = it.supplement + " " + it.counter.display(it.numbering) + " "
    if it.kind == "image" {
      // 図の場合
      //// 図の題名全体
      let img_label = block(
        align(
          left,
          if imgtbl_suppl_bold {
            //// フラグで太字を制御
            strong[#counter_text]
          } else {
            counter_text
          } + h(0.25em) + it.caption.body,
        ),
        breakable: false,
      )
      //// 図の題名は図より下に表示
      block(align(center)[#v(line_space, weak: true)#it.body#v(line_space, weak: true)#img_label])
      v(line_space, weak: true)

      context {
        let chapt = counter(heading).at(here()).at(0)
        let c = counter("image-chapter" + str(chapt))
        c.step()
      }

    } else if it.kind == "table" {
      // 表の場合
      //// 表の題名全体
      let tbl_label = block(
        align(
          left,
          if imgtbl_suppl_bold {
            //// フラグで太字を制御
            strong[#counter_text]
          } else {
            counter_text
          } + h(0.25em) + it.caption.body,
        ),
        breakable: false,
      )

      //// 表の題名は上に表示
      block(align(center)[#v(line_space, weak: true)#tbl_label#v(line_space / 2, weak: true)#it.body])
      v(line_space, weak: true)

      context {
        let chapt = counter(heading).at(here()).at(0)
        let c = counter("table-chapter" + str(chapt))
        c.step()
      }
    } else {
      it
    }
  }

  ///////////////////////////////////
  // 全体のレイアウト
  if auto_pagebreak {
    // 論文の構成
    // 表紙
    cover_layout(COVER)

    // 摘要
    abs_layout(ABS_JA)

    // 目次
    toc_layout(TOC)

    // ページ番号の表示
    set page(footer: [#align(center)[#context {
          counter(page).display("1")
        }]])
    counter(page).update(1)

    // ヘッダー番号の表示
    set heading(numbering: (..nums) => {
      nums.pos().map(str).join(".")
    })
    counter(heading).update(0)

    // 本文
    body

  } else {
    // 論文の構成
    // 表紙
    cover_layout(COVER)

    // ページ番号の表示
    set page(footer: [#align(center)[#context {
          counter(page).display("1")
        }]])
    counter(page).update(1)

    // 摘要
    abs_layout(ABS_JA)

    // 目次
    toc_layout(TOC)

    // ヘッダー番号の表示
    set heading(numbering: (..nums) => {
      nums.pos().map(str).join(".")
    })
    counter(heading).update(0)

    // 本文
    body

  }
}

