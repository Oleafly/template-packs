#let reference(bibliography-file: "") = [
  // Display bibliography.
  #if bibliography-file != "" {
    show bibliography: set text(12pt)
    show bibliography: set heading(numbering: "[1]")
    show bibliography: it => {
      pagebreak()
      heading(level: 1, outlined: true, numbering: none)[参考文献]
      v(1em)
      set text(10pt)
      it
    }
    bibliography(bibliography-file, title: none, style: "ieee")
  }
]

#let graduation_thesis(
  title: "",
  student_id: "",
  your_name_jp: "",
  your_name_en: "",
  mentor_name: "",
  mentor_position: "",
  mentors: (),
  write_year: "",
  write_month: "",
  abstract: "",
  bibliography-file: "",
  is_tinymist: false,
  body
) = {
  // テキストの設定
  set text(
    font: (
      "Noto Serif JP",
      "Times New Roman",
    ),
    size: 10pt,

  )

  // ページの設定
  set page(
    paper: "a4",
    margin: (
      bottom: 1.75cm, top: 2.5cm,
      left: 3cm, right: 3cm
    ),
    numbering: none
  )

  // 段落の設定
  set par(leading: 1.008em, first-line-indent: 1em, justify: true)

  // 見出しの設定
  set heading(numbering: "1.1.1.1")
  show heading: set text(font: "Noto Serif JP", weight: "bold", size: 12pt)

  show heading.where(level: 1): it => {
    set par(first-line-indent: 0pt,leading: 0.5em)
    counter(math.equation).update(0)
    counter(figure.where(kind: table)).update(0)
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: raw)).update(0)
    v(60pt)
    text(weight: "bold", size: 22pt, font: "Hiragino Kaku Gothic Pro")[
      #if it.numbering != none {
        if it.numbering.contains("A") {
          numbering("付録A", ..counter(heading).at(it.location()))
        } else {
          numbering("第1章", ..counter(heading).at(it.location()))
        }
      }
    ]
    if is_tinymist {
      v(8pt)
    } else {
      v(12pt)
    }
    text(weight: "bold", size: 22pt, font: "Hiragino Kaku Gothic Pro")[#it.body \ ]
    if is_tinymist {
      v(8pt)
    } else {
      v(22pt)
    }
  }

  show heading.where(level: 2): it => {
    set par(first-line-indent: 0pt, leading: 0.5em)
    if is_tinymist {
      par(text(size: 1em, ""))
    } else {
      par(text(size: 1.5em, "")) 
    }   
    text(weight: "bold", size: 14pt, font: "Noto Serif JP")[
      #if it.numbering != none {
        if it.numbering.contains("A") {
          numbering("A.1.1.1", ..counter(heading).at(it.location()))
        } else {
          numbering("1.1.1.1", ..counter(heading).at(it.location()))
        }
      }
    ]
    text(weight: "bold", size: 14pt, font: "Hiragino Kaku Gothic Pro")[
      #h(10pt)
      #it.body \
      ]
    if is_tinymist {
      v(8pt)
    } else {
      par(text(size: 1em, "")) 
    }   
  }

  show heading.where(level: 3): it => {
    set par(first-line-indent: 0pt,leading: 0.5em)
    par(text(size: 0.45em, ""))    
    text(weight: "bold", size: 12pt, font: "Noto Serif JP")[
      #if it.numbering != none {
        if it.numbering.contains("A") {
          numbering("付録A.1.1.1", ..counter(heading).at(it.location()))
        } else {
          numbering("1.1.1.1", ..counter(heading).at(it.location()))
        }
        h(10pt)
      }
    ]
    text(weight: "bold", size: 12pt, font: "Hiragino Kaku Gothic Pro")[#it.body ]
    if is_tinymist {
      v(4pt)
    } else {
      par(text(size: 0.75em, "")) 
    }
  }

  // 表のfigureの設定
  show figure.where(kind: table): set figure.caption(position: top)
  show figure.where(kind: table): set figure(supplement: "表", numbering: num =>
    ((counter(heading).get().at(0),) + (num,)).map(str).join("."))

  // 図の設定
  set figure(supplement: "図", numbering: num =>
    ((counter(heading).get().at(0),) + (num,)).map(str).join("."))

  // 数式の設定
  set math.equation(numbering: num =>
    "(" + ((counter(heading).get().at(0),) + (num,)).map(str).join(".") + ")", supplement: "式")

  // ページ番号の設定
  show ref: it => {
    if it.element != none and it.element.func() == figure {
      let el = it.element
      let loc = el.location()
      let chapt = counter(heading).at(loc).at(0)

      link(loc)[#if el.kind == "image" or el.kind == "table" {
          // counting 
          let num = counter(el.kind + "-chapter" + str(chapt)).at(loc).at(0) + 1
          it.element.supplement
          " "
          str(chapt)
          "."
          str(num)
        } else if el.kind == "thmenv" {
          let thms = query(selector(<meta:thmenvcounter>).after(loc), loc)
          let number = thmcounters.at(thms.first().location()).at("latest")
          it.element.supplement
          " "
          numbering(it.element.numbering, ..number)
        } else {
          it
        }
      ]
    } else if it.element != none and it.element.func() == math.equation {
      let el = it.element
      let loc = el.location()
      let num = counter(math.equation).at(loc).at(0)

      it.element.supplement
      numbering(el.numbering, num)
    } else if it.element != none and it.element.func() == heading {
      let el = it.element
      let loc = el.location()
      let num = numbering(el.numbering, ..counter(heading).at(loc))
      if el.level == 1 {
        if el.numbering.contains("A") {
          "付録"
          str(num).replace(".", "")
        } else {
          "第"
          str(num).replace(".", "")
          "章"
        }
      } else if el.level == 2 {
        str(num)
        "節"
      } else if el.level == 3 {
        str(num)
        "項"
      }
    } else {
      it
    }
  }

  set text(font: "Hiragino Kaku Gothic Pro", weight: "medium")

  // タイトル
  place(top + center, dy: 4.7cm)[
    #box(
      width: 90%,
      outset: 2em,
      [
        #align(center, text(15pt)[
          卒業論文
        ])
        #align(center, text(25pt)[
          #title
        ])
      ]
    )
  ]

  // 著者名
  // 指導教員
  // 年月日
  // 所属
  place(bottom + center, dy: -3.7cm)[
    #box(
      width: 90%,
      outset: 2em,
      [
        #grid(
          columns: (1fr, 1fr),
          
          place(
            right,
            dx: -2em,
            text(16pt)[
              #student_id
            ]
          ),
          place(
            left,
            dx: -1em,
            dy: -0.12em,
            text(18pt)[
              #your_name_jp
            ]
          )
        )
        #v(30pt)
        #grid(
          columns: (1fr, 1fr),
          place(
            right,
            dx: -2em,
            text(16pt)[
              指導教員
            ]
          ),
          if mentors.len() > 0 {
            place(
              left,
              dx: -1em,
              text(16pt)[
                #let i = 0
                #while i < mentors.len() {
                  let mentor = mentors.at(i)
                  [#mentor.name #mentor.position]
                  i = i + 1
                  if i < mentors.len() [
                    \
                  ]
                }
              ]
            )
          } else {
            // 一人の場合はそのまま書く
            place(
              left,
              dx: -1em,
              text(16pt)[
                #mentor_name #mentor_position
              ]
            )
          }
        )

        
        #if mentors.len() > 2 {
          let voffset = mentors.len() * 25 + 5
          v(voffset * 1pt)
        } else {
          v(55pt)
        }
        #align(center, text(16pt)[
          #write_year 年 #write_month 月
        ])
        
        #v(55pt)
        #align(center, text(16pt)[
          東京大学工学部計数工学科システム情報工学コース
        ])
      ]
    )
  ]

  pagebreak()

  // Copyright
  set text(font: "Noto Serif JP", weight: "regular")
  place(
    bottom + left,
    dy: -3.6cm,
    text(10pt)[
      Copyright $copyright$ #write_year #your_name_en
    ]
  )

  pagebreak()

  // Abstract
  v(5.0cm)
  box(
    width: 100%,
  )[
    #align(center)[
      #text(10pt, font: "Hiragino Kaku Gothic Pro")[
        概要
      ]
    ]
    #v(5pt)
    #set par(first-line-indent: 0pt)
    #align(left)[
      #text(10pt, font: "Noto Serif JP")[
        #abstract
      ]
    ]
  ]
  pagebreak()

  pagebreak()

  // 目次
  v(3.9cm)
  show outline: it => {
    let elements = query(it.target)
    set par(first-line-indent: 0pt)
    text(26pt, font: "Hiragino Kaku Gothic Pro", weight: "bold")[
      #it.title
    ]
    v(2.5em)
    set par(first-line-indent: 0pt)
    set text(10pt, font: "Noto Serif JP", weight: "regular")
    // 行数を測っておく
    let rows = 0;
    for el in elements {
      if el.level == 1 {
        rows += 1.5
      } else if el.level == 2 {
        rows += 1
      }
    }
    // 最初のページだけ30行で計算
    let offset = 7 + calc.floor((rows - 35) / 42)
    for el in elements {
      let level = el.level
      let loc = el.location()
      let page = loc.page() - offset // offset
      
      if level == 1 {
        v(5pt)
        [
          #if el.numbering != none {
            let is_appendix = el.numbering.contains("A")
            text(10pt, weight: "bold")[
              #box(width: 45pt)[
                #align(left)[
                  #if is_appendix {
                    numbering("付録A", ..counter(heading).at(loc))
                  } else {
                    numbering("第1章", ..counter(heading).at(loc))
                  }
                ]
              ]
              #el.body
            ]
          } else {
            text(10pt, weight: "bold")[
              #el.body
            ]
          }
          #box(width: 1fr, repeat[])
          #page 
          \
        ]
      } else if level == 2 {
        [
          #h(10pt)
          #box(width: 35pt)[
            #align(left)[
              #let is_appendix = el.numbering.contains("A")
              #if is_appendix {
                numbering("A.1", ..counter(heading).at(loc))
              } else {
                numbering("1.1", ..counter(heading).at(loc))
              }
            ]
          ]
          #el.body
          #box(width: 0.03fr, repeat(""))
          #box(width: 0.9fr, repeat("  .  "))
          #box(width: 0.02fr, repeat(""))
          #page 
          \ 
        ]
      } // 3以上は無視
    }
  }

  outline(title: "目次")

  pagebreak()

  
  // In case you need to right- or left-align the page number, 
  // use the number-align argument of the page set rule. 
  // Alternating alignment between even and odd pages is not 
  // currently supported using this property. 
  // To do this, you'll need to specify a custom footer with 
  // your footnote and query the page counter as described in 
  // the section on conditionally omitting headers and footers.
  // ref. https://typst.app/docs/guides/page-setup-guide/
  counter(page).update(0)
  // Footerを置き換える形で実装する
  // パワープレイな理由は，章を変更した時にページの横に何かがつくのを避けるため
  set page(footer: context {
    let rows = 0;
    let _selector_1 = selector(heading.where(level: 1))
    let _headings = query(_selector_1)

    let _selector_2 = selector(heading.where(level: 2))
    let _subheadings = query(_selector_2)
    for el in _headings {
      rows += 1.5
    }
    for el in _subheadings {
      rows += 1
    }
    let offset = 7 + calc.floor((rows - 35) / 42)
    let selector_1 = selector(heading.where(level: 1)).before(here())
    let headings = query(selector_1)

    let selector_2 = selector(heading.where(level: 2)).before(here())
    let subheadings = query(selector_2)
    place(
      top,
      dy: -24.45cm
    )[
      #let page_here = counter(page).get().first()
      #let flag = headings.len() == 0
      #if headings.len() > 0 {
        let last_heading = headings.last()
        let last_loc = last_heading.location()
        let last_page = last_loc.page() - offset
        flag = last_page == page_here
        flag = flag or last_heading.numbering == none
      }

      #if calc.even(page_here) [
        #text(9pt, weight: "bold", font: "Noto Serif JP")[
          #if counter(page).get().first() == 0 {
            return
          }
          #counter(page).get().first()
          #h(0.05fr)
          #if not flag {
            // 参考文献とかのnumberingがnoneになっているかどうかで場合分け
            let last_heading = headings.last()
            if last_heading.numbering != none {
              let is_appendix = last_heading.numbering.contains("A")
              if is_appendix {
                numbering("付録A", counter(heading).get().first())
                [
                  #text(9pt, weight: "bold", font: "Noto Serif JP")[
                    #h(0.05fr)
                    #last_heading.body
                  ]
                ]
              } else {
                numbering("第1章", counter(heading).get().first())
                [
                  #text(9pt, weight: "bold", font: "Noto Serif JP")[
                    #h(0.05fr)
                    #last_heading.body
                  ]
                ]
              }
            } else {
              text(9pt, weight: "bold", font: "Noto Serif JP")[
                #headings.last().body
              ]
            }
          }
        ]
        #h(1fr)
      ] else [
        #h(1fr)
        #text(9pt, weight: "bold", font: "Noto Serif JP")[
          #if not flag {
            // 参考文献とかは無視
            if counter(heading).get().len() >= 2 {
              let last_heading = headings.last()
              let is_appendix = last_heading.numbering.contains("A")
              if is_appendix {
                numbering("A.1", ..counter(heading).get().slice(0, 2))
                text(9pt, weight: "bold", font: "Noto Serif JP")[
                  #subheadings.last().body
                ]
              } else {
                numbering("1.1", ..counter(heading).get().slice(0, 2))
                text(9pt, weight: "bold", font: "Noto Serif JP")[
                  #subheadings.last().body
                ]
              }
            }
          }
          #h(0.05fr)
          #counter(page).get().first()
        ]
      ]
    ]
  }, numbering: none, margin: (top: 4.3cm, bottom: 2.8cm, left: 3cm, right: 3cm))

  pagebreak()

  body

  // 参考文献の後ろに付録をつけたい場合は
  // graduation_thesisにはbibliography-fileを渡さず，
  // 自分でreferenceを呼び出す
  if bibliography-file != "" {
    reference(bibliography-file: bibliography-file)
  }
}

// 見出し無しheading
#let chap(body) = [
  #v(60pt)
  #heading(level: 1, outlined: true, numbering: none)[#body]
  #v(22pt)
]

#let appendix(
  body
) = {
  // 見出しの設定
  let all = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
  counter(heading).update(0)
  set heading(numbering: "A.1.1.1")

  // 表のfigureの設定
  show figure.where(kind: table): set figure.caption(position: top)
  show figure.where(kind: table): set figure(supplement: "表", numbering: num =>
    ((all.at(counter(heading).get().at(0) - 1),) + (num,)).map(str).join("."))

  // 図の設定
  set figure(supplement: "図", numbering: num =>
    ((all.at(counter(heading).get().at(0) - 1),) + (num,)).map(str).join("."))
  
  // 数式の設定
  set math.equation(numbering: num =>
    "(" + ((all.at(counter(heading).get().at(0) - 1),) + (num,)).map(str).join(".") + ")", supplement: "式")
  show heading: set text(font: "Noto Serif JP", weight: "bold", size: 12pt)
  body
}
