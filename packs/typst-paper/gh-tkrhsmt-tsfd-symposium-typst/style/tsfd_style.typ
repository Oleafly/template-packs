
// フォント
#let mincho = ("Times New Roman", "Harano Aji Mincho")
#let gothic = ("Helvetica", "Harano Aji Gothic")
#let mathf = ("Latin Modern Math")
#let codef = ("Noto Mono for Powerline")

// 日本語間のコード改行
#let cjkre = regex("[ ]*([\p{Han}\p{Hiragana}\p{Katakana}]+(?:[,\(\)][ ]*[\p{Han}\p{Hiragana}\p{Katakana}]+)*)[ ]*")

// 外部パッケージ
#import "@preview/equate:0.2.1": equate
#import "@preview/roremu:0.1.0": roremu
#import "@preview/physica:0.9.4": *
#import "@preview/unify:0.7.0": *

//初期設定
#let tsfd_init(body, num: 0, date: "0000年3月1日") = {

  //言語設定
  set text(lang: "ja", cjk-latin-spacing: auto, fallback: false)
  // ページサイズ設定
  set page(
    paper:"a4",
    margin: (left: 15mm, right: 15mm, top: 20mm, bottom: 20mm),
    header: {
      set align(right)
      set text(size: 9pt)
      table(
        inset: 0pt,
        row-gutter: 0.5em,
        align: left,
        stroke: none,
        date,
        [第#str(num)回 生研TSFDシンポジウム]
      )
    }
  )

  //パラグラフ設定
  set par(
    justify: true,
    first-line-indent: 1em,
    leading: 1em,
  )

  // テキスト設定
  set text(
    size: 9pt,
    font: mincho
  )

  // 章・節見出し設定
  set heading(numbering: "1.", supplement: [第])
  show heading: (it => {
    set text(font: gothic, size: 10pt, weight: "medium")
    set par(first-line-indent: 0em)
    if it.numbering != none{
      context counter(heading).display() + [　] +it.body
    }
    else{
      it.body
    }
  })
  show heading.where(level: 1): it => {

    set align(center)
    set text(font: gothic, size: 10pt, weight: "medium")
    set par(first-line-indent: 0em)
    if it.numbering != none{
      context counter(heading).display() + [　] +it.body
    }
    else{
      it.body
    }
    v(1em)
  }

  // 数式設定
  show math.equation: set text(font: mathf)
  show math.equation: set block(spacing: 2em)
  set math.equation(numbering: "(1)")
  show heading.where(level: 1): it => {
    counter(math.equation).update(0)
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)
    counter(figure.where(kind: raw)).update(0)
    it
  }
  set math.equation(numbering: num =>
    "(" + (str(counter(heading).get().at(0)) + "." + str(num)) + ")"
  )
  show math.equation.where(block: true): set align(left)// set block equation align
  show math.equation.where(block: true): it => {// set block equation space
    grid(
      columns: (2em, auto),
      [],it
    )
  }
  show: equate.with(breakable: true, number-mode: "line")
  show math.equation.where(block: false): it => {
    let ghost = hide(text(font: "Adobe Blank", "\u{375}")) // 欧文ゴースト
    ghost; it; ghost
  }

  // 図表設定
  set figure.caption(separator: [　])
  show figure: set block(breakable: true)
  show figure.where(kind: table): set figure.caption(position: top)
  show figure.where(kind: raw): set figure.caption(position: top)
  show figure.where(kind: raw): set figure(supplement: [コード])
  show figure.caption: it => {// if figure caption is image ...
    set par(leading: 4.5pt, justify: true)
    set text(size: 11.4pt)
    grid(
      columns: 2,
      {
        if it.kind == table{
          [Table ] + context counter(figure.where(kind: table)).display() + [　]
        }
        else if it.kind == raw{
          [Code ] + context counter(figure.where(kind: raw)).display() + [　]
        }
        else{
          [Fig. ] + context counter(figure.where(kind: image)).display() + [　]
        }
      },
      align(left)[#it.body]
    )
  }
  set figure(numbering: num =>
    str(counter(heading).get().at(0)) + "." + str(num)
  )

  //コードの設定
  show raw.where(block: true): it => {
    set text(font: codef)
      set table(stroke: (x, y) => (
        //left: if x == 1 { 0.5pt } else { 0pt },
        //right: if x == 1 { 0.5pt } else { 0pt },
        top: if y == 0 and x == 1{ 0.5pt } else { 0pt },
        bottom: if x == 1 { 0.5pt } else { 0pt },
      ))
      table(
        columns: (5%, 95%),
        align: (right, left),
        ..for value in it.lines {
          (text(fill: black,str(value.number)), value)
        }
      )
  }
  show raw.where(block: false): it =>{
    set text(font: codef)
    h(0.5em)
    it
    h(0.5em)
  }

  //リストの設定
  set list(indent: 2em, body-indent: 0.75em, spacing: 1em, marker: ([•]))
  set enum(indent: 2em, body-indent: 0.75em, spacing: 1em)

  //下線設定
  set underline(offset: 4pt)

  // 脚注設定
  let footnote-numbering(.., last) = "*" * last
  set footnote(numbering: footnote-numbering)

  // 日本語間のコード改行を無効化
  show cjkre: it => it.text.match(cjkre).captures.at(0)

  body

}

#let tsfd_title(
  title: [],
  title-en: [],
  author: (),
) = {

  set align(center)
  set text(size: 16pt)

  //タイトル
  v(2em)
  title
  v(1em)

  //英語タイトル
  set text(size: 12pt)
  v(1em)
  title-en

  //日本語著者
  set text(size: 9pt)
  v(1em)
  set text(size: 10pt)
  v(1em)
  set text(size: 12pt)
  let institution-re = ()//institutionに重複があるか判定
  let output-arr = ()//出力する著者の配列

  for value in author{//著者の数だけ繰り返す

    let output-contents = value.author-ja//出力する著者名

    if institution-re.contains(value.author-institution) {
      for index in range(institution-re.len()){
        if institution-re.at(index) == value.author-institution {
          output-contents += super("*") * (index + 1)
        }
      }
    } else {
      output-contents += footnote[#value.author-institution]
      institution-re.push(value.author-institution)
    }
    output-arr.push(output-contents)
  }
  output-arr.join([・])//著者名を結合して出力

  //英語著者
  linebreak()
  set text(size: 9pt)
  output-arr = ()

  for value in author{//著者の数だけ繰り返す
    output-arr.push(value.author-en)
  }
  output-arr.join([, ], last: [ and ])//著者名を結合して出力

  v(2em)
}
