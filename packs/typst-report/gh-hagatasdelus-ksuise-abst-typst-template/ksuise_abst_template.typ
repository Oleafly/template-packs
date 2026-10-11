// Usage:
//   #import "lib/ksu_abstract_template.typ": ksu_abstract, ja_bibliography
//   #show: ksu_abstract.with(
//     title: [論文タイトル],
//     student_id: "123456",
//     name: "京産太郎",
//     lab_name: "ほげ",
//     lab_name_footer: "ほげ",
//     page_number: 1,
//   )

#let fonts = (
  mincho: (
    "Harano Aji Mincho",
    "Hiragino Mincho ProN",
  ),
  gothic: (
    "Harano Aji Gothic",
    "Hiragino Kaku Gothic ProN",
  ),
  serif: "Times New Roman",
  mono: (
    "HackGen Console NF",
    "Menlo",
  ),
)

#let ja_bibliography(path, style: "ieee") = {
  heading(level: 1, numbering: none)[参考文献]
  set text(lang: "en")
  bibliography(path, title: none, style: style, full: true)
}

/// 抄録テンプレート関数
///
/// Parameters:
/// - title (content): 論文タイトル。ゴシック体・太字で表示。
/// - student_id (str): 学生証番号。著者欄に表示。
/// - name (str): 著者氏名。著者欄に表示。
/// - lab_name (str): 研究室名。著者欄に「(研究室名)研」形式で表示。
/// - lab_name_footer (str): フッター用研究室名。フッターに「研究室名研 - 1」形式で表示。
/// - page_number (int): ページ番号。フッターのページ番号として表示。
/// - body (content): 本文。
///
/// Returns:
/// - content: テンプレートが適用された文書
///
/// Example:
/// ```typst
/// #show: ksu_abstract.with(
///   title: [論文タイトル],
///   student_id: "18xxxxx",
///   name: "著者名",
///   lab_name: "ほげ",
///   lab_name_footer: "ほげ",
///   page_number: 3,
/// )
/// ```
#let ksu_abstract(
  title: [],
  student_id: "",
  name: "",
  lab_name: "",
  lab_name_footer: "",
  page_number: 1,
  body,
) = {
  set page(
    paper: "a4",
    margin: (
      top: 30mm,
      bottom: 30mm,
      left: 25mm,
      right: 25mm,
    ),
    columns: 2,
    header: {
      set text(size: 8.5pt, font: fonts.mincho)
      let academic_year = datetime.today().year() - int(datetime.today().month() < 4)
      grid(
        columns: (1fr, 1fr),
        align(left)[#(academic_year)年度 情報理工学特別研究II 報告書抄録], align(right)[京都産業大学 情報理工学部],
      )
    },
    footer: {
      set text(size: 9.5pt, font: fonts.mincho)
      align(center)[#(lab_name_footer)研 - #page_number]
    },
  )

  set columns(gutter: 9mm)

  place(
    top + center,
    float: true,
    scope: "parent",
    block(
      width: 100%,
      {
        v(1.2em)

        set text(font: fonts.gothic, size: 16pt, weight: 500)
        set par(leading: 0.6em)
        align(center)[#title]

        v(0.3em)

        set text(font: fonts.mincho, size: 11pt, weight: "regular")
        align(center)[学生証番号 #student_id #h(1em) #name (#(lab_name)研)]
        v(1em)
      },
    ),
  )

  set text(lang: "ja", font: fonts.mincho, size: 10pt)

  set par(
    first-line-indent: (
      all: true,
      amount: 1em,
    ),
    justify: true,
  )

  show heading: set text(font: fonts.gothic, weight: 500)
  show heading: set block(above: 1.0em, below: 0.8em)
  set heading(numbering: "1.1  ")

  show heading.where(level: 1): it => {
    set text(size: 14pt)
    it
  }

  show heading.where(level: 2): it => {
    set text(size: 11pt)
    it
  }

  set math.equation(numbering: "(1)")

  body
}
