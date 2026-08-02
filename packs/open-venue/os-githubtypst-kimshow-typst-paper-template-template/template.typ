#import "@preview/subpar:0.2.0" //subfigureのパッケージ

// Store theorem environment numbering
#let thmcounters = state("thm",
  (
    "counters": ("heading": ()),
    "latest": ()
  )
)

// Setting theorem environment
// identifier: 定理の種類を識別する文字列
// base: カウンターの基準となる要素
// base_level: 基準要素の階層レベル
// fmt: 定理の表示形式を定義する関数
#let thmenv(identifier, base, base_level, fmt) = {

  let global_numbering = numbering

  return (
    ..args,
    body,
    number: auto,
    numbering: "1.1",
    refnumbering: auto,
    supplement: identifier,
    base: base,
    base_level: base_level
  ) => {
    let name = none
    if args != none and args.pos().len() > 0 {
      name = args.pos().first()
    }
    if refnumbering == auto {
      refnumbering = numbering
    }
    let result = none
    if number == auto and numbering == none {
      number = none
    }
    if number == auto and numbering != none {
      result = context {
        let heading-counter = counter(heading).get()
        return thmcounters.update(thmpair => {
          let counters = thmpair.at("counters")
          // Manually update heading counter
          counters.at("heading") = heading-counter
          if not identifier in counters.keys() {
            counters.insert(identifier, (0, ))
          }

          let tc = counters.at(identifier)
          if base != none {
            let bc = counters.at(base)

            // Pad or chop the base count
            if base_level != none {
              if bc.len() < base_level {
                bc = bc + (0,) * (base_level - bc.len())
              } else if bc.len() > base_level{
                bc = bc.slice(0, base_level)
              }
            }

            // Reset counter if the base counter has updated
            if tc.slice(0, -1) == bc {
              counters.at(identifier) = (..bc, tc.last() + 1)
            } else {
              counters.at(identifier) = (..bc, 1)
            }
          } else {
            // If we have no base counter, just count one level
            counters.at(identifier) = (tc.last() + 1,)
            let latest = counters.at(identifier)
          }

          let latest = counters.at(identifier)
          return (
            "counters": counters,
            "latest": latest
          )
        })
      }

      number = context {
        global_numbering(numbering, ..thmcounters.get().at("latest"))
      }
    }

    return figure(
      result +  // hacky!
      fmt(name, number, body, ..args.named()) +
      [#metadata(identifier) <meta:thmenvcounter>],
      kind: "thmenv",
      outlined: false,
      caption: none,
      supplement: supplement,
      numbering: refnumbering,
    )
  }
}

// Definition of theorem box
// identifier: 定理の種類
// head: 定理のヘッダーテキスト
// blockargs: ブロックの追加引数
#let thmbox(
  identifier,
  head,
  ..blockargs,
  supplement: auto,
  padding: (top: 0.5em, bottom: 0.5em),
  namefmt: x => [(#x)],
  titlefmt: strong,
  bodyfmt: x => x,
  separator: [#h(0.1em):#h(0.2em)],
  base: "heading",
  base_level: none,
) = {
  if supplement == auto {
    supplement = head
  }
  let boxfmt(name, number, body, title: auto, ..blockargs_individual) = {
    if not name == none {
      name = [ #namefmt(name)]
    } else {
      name = []
    }
    if title == auto {
      title = head
    }
    if not number == none {
      title += " " + number
    }
    title = titlefmt(title)
    body = bodyfmt(body)
    pad(
      ..padding,
      block(
        width: 100%,
        inset: 1.2em,
        radius: 0.3em,
        breakable: false,
        ..blockargs.named(),
        ..blockargs_individual.named(),
        [#title#name#separator#body]
      )
    )
  }
  return thmenv(
    identifier,
    base,
    base_level,
    boxfmt
  ).with(
    supplement: supplement,
  )
}

// プレーンスタイルの定理環境設定
#let thmplain = thmbox.with(
  padding: (top: 0em, bottom: 0em),
  breakable: true,
  inset: (top: 0em, left: 1.2em, right: 1.2em),
  namefmt: name => emph([(#name)]),
  titlefmt: emph,
)

// 数式番号のフォーマット設定
// 章番号.式番号 の形式で表示
#let equation_num(_) = {
  context {
    let chapt = counter(heading).get().at(0)
    let c = counter(math.equation)
    let n = c.get().at(0)
    "(" + str(chapt) + "." + str(n) + ")"
  }
}

// 表番号のフォーマット設定
// 章番号.表番号 の形式で表示（appendice環境ではA.1などの形式）
#let table_num(_) = {
  context {
    let chapt = counter(heading).get().at(0)
    let c = counter("table-chapter" + str(chapt))
    let n = c.get().at(0)

    // appendice環境かどうかを確認
    let is_appendix = counter("appendices").get().at(0) > 0

    if is_appendix {
      // appendice環境では章番号をアルファベットに変換
      let appendix_letter = "ABCDEFGHIJ".at(chapt - 1)
      appendix_letter + "." + str(n + 1)
    } else {
      str(chapt) + "." + str(n + 1)
    }
  }
}

// 図番号のフォーマット設定
// 章番号.図番号 の形式で表示（appendice環境ではA.1などの形式）
#let image_num(_) = {
  context {
    let chapt = counter(heading).get().at(0)
    let c = counter("image-chapter" + str(chapt))
    let n = c.get().at(0)

    // appendice環境かどうかを確認
    let is_appendix = counter("appendices").get().at(0) > 0

    if is_appendix {
      // appendice環境では章番号をアルファベットに変換
      let appendix_letter = "ABCDEFGHIJ".at(chapt - 1)
      appendix_letter + "." + str(n + 1)
    } else {
      str(chapt) + "." + str(n + 1)
    }
  }
}

// 表のグローバルスタイル設定
#set table(
  stroke: (x, y) => {
    (
      top: if y == 0 { 1pt }
           else if y == 1 { 0.5pt }
           else { 0pt },
      bottom: 1pt
    )
  }
)

// 表の基本フォーマット設定
#let tbl(tbl, caption: "") = {
  figure(
    tbl,
    caption: caption,
    supplement: [表],
    numbering: table_num,
    kind: "table",
    outlined: true
  )
}

// 画像の基本フォーマット設定
#let img(img, caption: "") = {
  figure(
    if type(img) == "content" {
      // For contents such as commutative graphs
      align(center, img)
    } else {
      // For normal images
      img
    },
    caption: caption,
    supplement: [図],
    numbering: image_num,
    kind: "image",
  )
}

// 概要ページの生成
// abstract_ja: 日本語概要
// abstract_en: 英語概要
// keywords_ja: 日本語キーワード
// keywords_en: 英語キーワード
#let abstract_page(abstract_ja, abstract_en, keywords_ja: (), keywords_en: ()) = {
  if abstract_ja != [] {
    show <_ja_abstract_>: {
      align(center)[
        #text(size: 20pt, "概要")
      ]
    }
    [= 概要 <_ja_abstract_>]

    v(30pt)
    set text(size: 12pt)
    set par(justify: true)
    abstract_ja
    par(first-line-indent: 0em)[
      #text(weight: "bold", size: 12pt)[
      キーワード:
      #keywords_ja.join(", ")
      ]
    ]
  } else {
    show <_en_abstract_>: {
      align(center)[
        #text(size: 18pt, "Abstract")
      ]
    }
    [= Abstract <_en_abstract_>]

    set text(size: 12pt)
    h(1em)
    abstract_en
    par(first-line-indent: 0em)[
      #text(weight: "bold", size: 12pt)[
        Key Words:
        #keywords_en.join("; ")
      ]
    ]
  }
}

// コンテンツを文字列に変換する補助関数を修正
#let to-string(content) = {
  if content == none {
    ""
  } else if type(content) == "string" {
    content
  } else if content.has("text") {
    content.text
  } else if content.has("children") {
    content.children.map(to-string).join("")
  } else if content.has("body") {
    to-string(content.body)
  } else if content == [ ] {
    " "
  } else {
    // 数式などのコンテンツを文字列として扱う
    repr(content)
  }
}

// 目次の生成
#let toc() = {
  align(left)[
    #text(size: 20pt, weight: "bold")[
      #v(30pt)
      目次
      #v(30pt)
    ]
  ]

  set text(size: 12pt)
  set par(leading: 1.24em, first-line-indent: 0pt)

  context {
    let elements = query(heading.where(outlined: true))
    for el in elements {
      let before_toc = query(heading.where(outlined: true).before(here())).find((one) => {one.body == el.body}) != none
      let page_num = if before_toc {
        numbering("i", counter(page).at(el.location()).first())
      } else {
        counter(page).at(el.location()).first()
      }

      link(el.location())[#{
        // acknoledgement has no numbering
        let chapt_num = if el.numbering != none {
          numbering(el.numbering, ..counter(heading).at(el.location()))
        } else {none}

        if el.level == 1 {
          set text(weight: "black")
          if chapt_num == none or chapt_num == "A"{} else {
            chapt_num + "  "
          }
          to-string(el.body)
        } else if el.level == 2 {
          h(2em) + chapt_num + " " + to-string(el.body)
        } else if el.level == 3 {
          h(5em) + chapt_num + " " + to-string(el.body)
        } else if el.level == 4 {
          h(8em) + chapt_num + " " + to-string(el.body)  // level 4のインデント追加
        }}]
      box(width: 1fr, h(0.5em) + box(width: 1fr, repeat[.]) + h(0.5em))
      [#page_num]
      linebreak()
    }
  }
}

// 図目次の生成を修正
#let toc_img() = {
  align(left)[
    #text(size: 20pt, weight: "bold")[
      #v(30pt)
      図目次
      #v(30pt)
    ]
  ]

  set text(size: 12pt)
  set par(leading: 1.24em, first-line-indent: 0pt)

  context {
    let elements = query(
      figure.where(
        outlined: true,
        kind: "image"
      )
    )
    for el in elements {
      let loc = el.location()
      let chapt = counter(heading).at(loc).at(0)
      let num = counter(el.kind + "-chapter" + str(chapt)).at(loc).at(0) + 1
      let page_num = counter(page).at(loc).first()

      // appendice環境かどうかを確認
      let is_appendix = counter("appendices").at(loc).at(0) > 0

      let figure_num = if is_appendix {
        // appendice環境では章番号をアルファベットに変換
        let appendix_letter = "ABCDEFGHIJ".at(chapt - 1)
        appendix_letter + "." + str(num)
      } else {
        str(chapt) + "." + str(num)
      }

      link(loc)[
        #figure_num
        #h(1em)
        #el.caption.body
      ]
      box(width: 1fr, h(0.5em) + box(width: 1fr, repeat[.]) + h(0.5em))
      [#page_num]
      linebreak()
    }
  }
}

// 表目次の生成を修正
#let toc_tbl() = {
  align(left)[
    #text(size: 20pt, weight: "bold")[
      #v(30pt)
      表目次
      #v(30pt)
    ]
  ]

  set text(size: 12pt)
  set par(leading: 1.24em, first-line-indent: 0pt)

  context {
    let elements = query(
      figure.where(
        outlined: true,
        kind: "table"
      )
    )
    for el in elements {
      let loc = el.location()
      let chapt = counter(heading).at(loc).at(0)
      let num = counter(el.kind + "-chapter" + str(chapt)).at(loc).at(0) + 1
      let page_num = counter(page).at(loc).first()

      // appendice環境かどうかを確認
      let is_appendix = counter("appendices").at(loc).at(0) > 0

      let figure_num = if is_appendix {
        // appendice環境では章番号をアルファベットに変換
        let appendix_letter = "ABCDEFGHIJ".at(chapt - 1)
        appendix_letter + "." + str(num)
      } else {
        str(chapt) + "." + str(num)
      }

      link(loc)[
        #figure_num
        #h(1em)
        #el.caption.body
      ]
      box(width: 1fr, h(0.5em) + box(width: 1fr, repeat[.]) + h(0.5em))
      [#page_num]
      linebreak()
    }
  }
}

// 空の段落を生成（スペース調整用）
#let empty_par() = {
  v(-1em)
  box()
}


// 論文全体の構成を定義
#let master_thesis(
  // The master thesis title.
  title: "ここにtitleが入る",

  // The paper`s author.
  author: "ここに著者が入る",

  // The author's information
  university: "",
  school: "",
  department: "",
  department2: "",
  id: "",
  mentor: "",
  mentor-post: "",
  class: "修士",
  date: (datetime.today().year(), datetime.today().month(), datetime.today().day()),

  paper-type: "論文",

  // Abstruct
  abstract_ja: [],
  abstract_en: [],
  keywords_ja: (),
  keywords_en: (),

  // The paper size to use.
  paper-size: "a4",

  // The path to a bibliography file if you want to cite some external
  // works.
  bibliography-file: none,

  // The paper's content.
  body,
) = {
  // citation number
  show ref: it => {
    if it.element != none and it.element.func() == figure {
      let el = it.element
      let loc = el.location()
      let chapt = counter(heading).at(loc).at(0)

      link(loc)[#if el.kind == "image" or el.kind == "table" {
        let num = counter(el.kind + "-chapter" + str(chapt)).at(loc).at(0) + 1
        it.element.supplement
        " "
        str(chapt)
        "."
        str(num)
      } else if el.kind == "thmenv" {
        let thms = query(selector(<meta:thmenvcounter>))
        let number = thmcounters.at(thms.first().location()).at("latest")
        it.element.supplement
        " "
        numbering(it.element.numbering, ..number)
      } else {
        super(it)
      }]
    } else if it.element != none and it.element.func() == math.equation {
      let el = it.element
      let loc = el.location()
      let chapt = counter(heading).at(loc).at(0)
      let num = counter(math.equation).at(loc).at(0)

      it.element.supplement
      " ("
      str(chapt)
      "."
      str(num)
      ")"
    } else if it.element != none and it.element.func() == heading {
      let el = it.element
      let loc = el.location()
      let num = numbering(el.numbering, ..counter(heading).at(loc))
      if el.level == 1 {
        "第"
        str(num)
        "章"
      } else if el.level == 2 {
        str(num)
        "節"
      } else if el.level == 3 {
        str(num)
        "項"
      } else if el.level == 4 {
        str(num)
      }
    } else {
      super(it)
    }
  }

  // counting caption number
  show figure: it => {
    set align(center)
    if it.kind == "image" {
      set text(size: 12pt)
      it.body
      it.supplement
      " " + it.counter.display(it.numbering)
      " " + it.caption.body
      context {
        let chapt = counter(heading).at(it.location()).at(0)
        let c = counter("image-chapter" + str(chapt))
        c.step()
      }
    } else if it.kind == "table" {
      set text(size: 12pt)
      it.supplement
      " " + it.counter.display(it.numbering)
      " " + it.caption.body
      set text(size: 10.5pt)
      it.body
      context {
        let chapt = counter(heading).at(it.location()).at(0)
        let c = counter("table-chapter" + str(chapt))
        c.step()
      }
    } else {
      it
    }
  }

  // Set the document's metadata.
  set document(title: title, author: author)

  // Set the body font. TeX Gyre Pagella is a free alternative
  // to Palatino.
  set text(font: (
    "Times New Roman", // Windows
    // "Nimbus Roman", // Ubuntu
    // "Hiragino Mincho ProN", // Mac
    "Yu Mincho", // Windows
    // "Noto Serif CJK JP", // Ubuntu
    ), size: 12pt)

  // Configure the page properties.
  set page(
    paper: paper-size,
    margin: (bottom: 1.75cm, top: 2.25cm),
  )

  // The first page.
  [
    #set page(
      margin: (
        top: 2.25cm,
        bottom: 1.75cm,
        left: 2.25cm,
        right: 2.25cm,
      )
    )

    // 最上段に左寄せで「令和6年度 修士論文」
    #align(left)[
      #v(20pt)
      #text(size: 20pt)[令和　6年度 #class#paper-type]
    ]

    // 中央にタイトル
    #align(center)[
      #v(160pt)
      #text(size: 24pt, weight: "bold")[
        #title
      ]
    ]

    // 下段に右寄せで「指導教員名」「提出年月」
    #align(right)[
      #v(160pt)
      #text(size: 20pt)[
        指導教員　#mentor　#mentor-post
      ]

      #text(size: 20pt)[
        #date.at(0)年　#date.at(1)月
      ]

      #v(20pt)

      // 1行開けて「所属」
      #text(size: 20pt)[
        #university　#school　#department
      ]

      // 1行開けて「所属」
      #text(size: 20pt)[
        #department2
      ]

      #v(60pt)

      // 1行開けて「提出者 氏名」
      #text(size: 20pt)[
        提出者　#author
      ]
      #pagebreak(to: "odd")
    ]

  ]

  set page(
    numbering: "i",
  )

  counter(page).update(1)
  // Show abstruct
  abstract_page(abstract_ja, abstract_en, keywords_ja: keywords_ja, keywords_en: keywords_en)
  pagebreak()

  // Configure paragraph properties.
  set par(leading: 0.78em, first-line-indent: 12pt, justify: true)
  set par(spacing: 0.78em)

   // Configure chapter headings.
  set heading(numbering: (..nums) => {
    nums.pos().map(str).join(".") + " "
  })
  show heading.where(level: 1): it => {
    //フォントをゴシック体にする
    // 常に右ページから始まる
    {
      // 空白ページは何も表示しない
      set page(header: {})
      pagebreak(to: "odd", weak: true)
    }
    counter(math.equation).update(0)
    set text(weight: "bold", size: 20pt)
    set block(spacing: 1.5em)
    let pre_chapt = if it.numbering != none {
          text()[
            #v(25pt)
            第#numbering(it.numbering, ..counter(heading).at(it.location()))章
          ]
        } else {none}
    set align(right)
    if to-string(it.body) == "Appendix" {
      set heading(numbering: "A.1")
      text()[
        #v(25pt)
        #it.body \
      ]
    } else {
      text()[
        #pre_chapt \
        #it.body \
      ]
    }
  }
  show heading.where(level: 2): it => {
    set text(weight: "bold", size: 16pt)
    set block(above: 2.0em, below: 0.5em)
    it
  }

  show heading.where(level: 3): it => {
    set text(weight: "bold", size: 14pt)
    set block(above: 1.5em, below: 0.5em)
    it
  }

  show heading: it => {
    set text(weight: "bold", size: 12pt)
    set block(above: 1.5em)
    it
    par(text(size: 0pt, ""))
  }


  // Start with a chapter outline.
  toc()
  pagebreak(to: "even")
  toc_img()
  pagebreak(to: "even")
  toc_tbl()
  pagebreak(to: "odd")

  set page(
    numbering: "1",
    header: context {
      // 現在のページ番号を取得
      let current_page = counter(page).at(here()).first()
      let is_odd = calc.rem(current_page, 2) == 1  // 奇数判定をcalc.rem()で行う

      // 第1レベルと第2レベルの見出しをそれぞれ取得
      let h1s = query(heading.where(level: 1))
      let h2s = query(heading.where(level: 2))

      // 現在のページに関連する見出しを格納する変数を初期化
      let current_h1 = none
      let current_h2 = none

      // 全ての見出しをループで処理
      for h in h1s {
        let h_page = counter(page).at(h.location()).first()
        if h_page <= current_page {
          current_h1 = h
        }
      }

      for h in h2s {
        let h_page = counter(page).at(h.location()).first()
        if h_page <= current_page {
          current_h2 = h
        }
      }

      // 現在のページで章が始まるかチェック
      let is_chapter_start = false
      for h in h1s {
        let h_page = counter(page).at(h.location()).first()
        if h_page == current_page {
          is_chapter_start = true
          break
        }
      }

      // 関連する見出しが存在する場合の処理
      if current_h1 != none {
        // 参考文献と謝辞ページの場合も偶奇ページに合わせて配置
        if current_h1.body == [参考文献] or current_h1.body == [謝辞] {
          grid(
            columns: (1fr),
            if is_odd {
              align(right)[#text(size: 10pt, weight: "semibold")[
                #box(current_h1.body)
                #h(6pt)
                #box(move(dy: 1pt, line(length: 10pt, stroke: 2pt, angle: 90deg)))
                #h(12pt)
                #box[#current_page]
              ]]
            } else {
              align(left)[#text(size: 10pt, weight: "semibold")[
                #box[#current_page]
                #h(12pt)
                #box(move(dy: 1pt, line(length: 10pt, stroke: 2pt, angle: 90deg)))
                #h(6pt)
                #box(current_h1.body)
              ]]
            },
            v(2pt),
            line(length: 100%, stroke: 0.5pt)
          )
        } else {
          let h1_num = counter(heading).at(current_h1.location())
            .map(n => numbering("1", n)).join()

          // Appendixの場合は章番号をアルファベットに変換
          let is_appendix = current_h1.body == [Appendix]
          let appendix_letter = if is_appendix {
            "ABCDEFGHIJ".at(int(h1_num) - 1)
          } else { none }

          // ヘッダーテキストの生成
          let header_text = if is_appendix {
            if is_odd and current_h2 != none {
              // 奇数ページ: 節情報を表示
              let h2_counter = counter(heading).at(current_h2.location())
              let h2_num = h2_counter.at(-1)
              [#appendix_letter.#h2_num #current_h2.body]
            } else {
              // 偶数ページ: Appendix本体のみ
              [#current_h1.body]
            }
          } else {
            if is_odd and current_h2 != none {
              // 奇数ページ: 節情報を表示
              let h2_counter = counter(heading).at(current_h2.location())
              let h2_num = h2_counter.at(-1)
              [#h1_num.#h2_num #current_h2.body]
            } else {
              // 偶数ページ: 章情報を表示
              [第 #h1_num 章 #current_h1.body]
            }
          }

          // ヘッダーの表示
          grid(
            columns: (1fr),
            if is_chapter_start {
              // 章が始まるページではページ番号のみ表示（Appendixの場合は例外）
              if is_odd {
                if current_h1.body == [Appendix] {
                  align(right)[#text(size: 10pt, weight: "semibold")[
                    #box(current_h1.body)
                    #h(6pt)
                    #box(move(dy: 1pt, line(length: 10pt, stroke: 2pt, angle: 90deg)))
                    #h(12pt)
                    #box[#current_page]
                  ]]
                } else {
                  align(right)[#text(size: 10pt, weight: "semibold")[
                    #box(move(dy: 1pt, line(length: 10pt, stroke: 2pt, angle: 90deg)))
                    #h(12pt)
                    #box[#current_page]
                  ]]
                }
              } else {
                if current_h1.body == [Appendix] {
                  align(left)[#text(size: 10pt, weight: "semibold")[
                    #box[#current_page]
                    #h(12pt)
                    #box(move(dy: 1pt, line(length: 10pt, stroke: 2pt, angle: 90deg)))
                    #h(6pt)
                    #box(current_h1.body)
                  ]]
                } else {
                  align(left)[#text(size: 10pt, weight: "semibold")[
                    #box[#current_page]
                    #h(12pt)
                    #box(move(dy: 1pt, line(length: 10pt, stroke: 2pt, angle: 90deg)))
                  ]]
                }
              }
            } else if is_odd {
              align(right)[#text(size: 10pt, weight: "semibold")[
                #box(header_text)
                #h(6pt)
                #box(move(dy: 1pt, line(length: 10pt, stroke: 2pt, angle: 90deg)))
                #h(12pt)
                #box[#current_page]
              ]]
            } else {
              align(left)[#text(size: 10pt, weight: "semibold")[
                #box[#current_page]
                #h(12pt)
                #box(move(dy: 1pt, line(length: 10pt, stroke: 2pt, angle: 90deg)))
                #h(6pt)
                #box(header_text)
              ]]
            },
            v(2pt),
            line(length: 100%, stroke: 0.5pt)
          )
        }
      }
    },
    footer: none  // フッターを無効化
  )

  counter(page).update(1)

  set math.equation(supplement: [式], numbering: equation_num)

  body

  // // Display bibliography.
  // if bibliography-file != none {
  //   show bibliography: set text(12pt)
  //   bibliography(bibliography-file, title: "参考文献", style: "csl/chemical-engineering-journal.csl")
  // }
  }
}

#let appendices(body) = {
  pagebreak()
  counter(heading).update(0)
  counter("appendices").update(1)

  // 図表のカウンターをリセット
  // 最初の章（A）の図表カウンターをリセット
  counter("image-chapter1").update(0)
  counter("table-chapter1").update(0)

  // 念のため、他の章のカウンターもリセット（B, C, ...）
  for i in range(2, 11) {
    counter("image-chapter" + str(i)).update(0)
    counter("table-chapter" + str(i)).update(0)
  }

  set heading(numbering: "A.1")

  [#body]
}

// LATEX character
#let LATEX = {
  [L];box(move(
    dx: -4.2pt, dy: -1.2pt,
    box(scale(65%)[A])
  ));box(move(
  dx: -5.7pt, dy: 0pt,
  [T]
));box(move(
  dx: -7.0pt, dy: 2.7pt,
  box(scale(100%)[E])
));box(move(
  dx: -8.0pt, dy: 0pt,
  [X]
));h(-8.0pt)
}



