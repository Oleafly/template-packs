#import "./utils.typ": *

// 図表・数式の番号の数え方
//// 図の番号の数え方
#let image_num(_) = {
  context {
    let chapt = counter(heading).at(here()).at(0)
    let c = counter("image-chapter" + str(chapt))
    let n = c.at(here()).at(0)
    str(chapt) + "." + str(n + 1)
  }
}

//// 表の番号の数え方
#let table_num(_) = {
  context {
    let chapt = counter(heading).at(here()).at(0)
    let c = counter("table-chapter" + str(chapt))
    let n = c.at(here()).at(0)
    str(chapt) + "." + str(n + 1)
  }
}

//// 式の番号の数え方
#let equation_num(_) = {
  context {
    let chapt = counter(heading).at(here()).at(0)
    let c = counter(math.equation)
    let n = c.at(here()).at(0)
    "(" + str(chapt) + "." + str(n) + ")"
  }
}

// 図表
//// 図
#let img(img, caption: "") = {
  figure(
    img,
    caption: [#caption],
    supplement: [#image_suppl],
    numbering: if chapt_fig_count == true {
      image_num
    } else {
      "1"
    },
    kind: "image",
  )
}

//// 表
#let tbl(tbl, caption: "") = {
  figure(
    tbl,
    caption: [#caption],
    supplement: [#table_suppl],
    numbering: if chapt_fig_count == true {
      table_num
    } else {
      "1"
    },
    kind: "table",
  )
}

// 各ページの設定
//// 表紙
#let cover_layout(cover) = {
  if cover == true {
    align(center)[
      // フォント指定
      #set text(font: font_type.roman)
      #set text(weight: "extrabold")
      #show regex("[\p{scx:Han}\p{scx:Hira}\p{scx:Kana}]"): set text(font: font_type.ja_title, weight: "bold")

      //表紙のデザイン
      #let PAPER_TYPE = "論文"
      #v(24em)
      #text(size: 32pt)[
        #TITLE
      ]
      #v(10em)
      #text(size: 14pt)[
        #format_year(YEAR, convert_jp_year, academic_year) #DEGREE#PAPER_TYPE\
        #UNIV #SCH #DEPT\
        #LAB
      ]
      #v(12pt)
      #text(size: 16pt)[
        #AUTHOR
      ]
    ]
    pagebreak()
  }
}

//// アブストラクト
#let abs_layout(abs_ja) = {
  if abs_ja == true {
    counter(heading).update(1)
    show heading: it => [
      #set align(center)
      #it
    ]
    [= 摘要]
    set text(size: font_size.text)
    [#include "../contents/abstract_ja.typ"]
    if auto_pagebreak {
      pagebreak()
    }

  }
}

//// 目次
#let toc_layout(toc) = {
  if toc == true {
    counter(heading).update(1)
    [= 目次]
    // 章，節，項のスタイル設定
    let chapter(body) = {
      mixed_bold(body, font_type.roman, font_type.ja_title)
    }
    let section(body) = {
      mixed(body, font_type.roman, font_type.ja_text)
    }

    // 目次のスタイル設定
    set text(size: font_size.text)
    set par(leading: line_space, first-line-indent: 0pt)

    context {
      // 目次以降の見出しをelementsとして取得
      let elements = query(heading.where(outlined: true).after(here()))

      for el in elements {
        let page_num = {
          counter(page).at(el.location()).first()
        }
        link(el.location())[#{
            let chapt_num = if el.numbering != none {
              numbering(el.numbering, ..counter(heading).at(el.location()))
            } else {
              none
            }

            if el.level == 1 {
              set text(weight: "black")
              if chapt_num != none {
                chapter(chapt_num)
                h(0.25em)
              }
              chapter(el.body)
              box(width: 1fr, box(width: 1fr, repeat[#i]))
              [#page_num]
            } else if el.level == 2 {
              h(1.25em)
              section(chapt_num)
              h(0.25em)
              section(el.body)
              box(width: 1fr, "  " + box(width: 1fr, repeat[.#h(0.5em)]) + "  ")
              [#page_num]
            } else if el.level == 3 {
              h(2.5em)
              section(chapt_num)
              h(0.25em)
              section(el.body)
              box(width: 1fr, "  " + box(width: 1fr, repeat[.#h(0.5em)]) + "  ")
              [#page_num]
            } else if el.level == 4 {
              set text(weight: "black")
              v(0.05em)
              chapter(el.body)
            }
          }]

        linebreak()
      }
    }
  }
}

//// 付録
#let appendix_layout(appendix) = {
  counter(heading).update(0)
  set heading(numbering: "A.1")
  if auto_pagebreak {
    pagebreak()
  } else {
    v(2em, weak: true)
  }
  appendix
}
