// ========================================
// 輪講資料テンプレート
// ========================================

#import "config.typ": rinko-config

// ========================================
// 輪講資料のメイン関数
// ========================================
#let rinko(
  // タイトル
  title: rinko-config.document.title,

  // 著者
  author: rinko-config.document.author,

  // 所属
  affiliation: rinko-config.document.affiliation,

  // 日付（noneの場合は今日の日付）
  date: rinko-config.document.date,

  // 本文
  body
) = {

  // ========================================
  // ページ設定（ヘッダー・フッター含む）
  // ========================================
  set page(
    paper: rinko-config.page.paper,
    margin: rinko-config.page.margin,
    header: if rinko-config.header-footer.show-header {
      [
        #set text(size: rinko-config.header-footer.header-size)
        #let header-left-text = if rinko-config.header-footer.header-left != none {
          rinko-config.header-footer.header-left
        } else {
          affiliation
        }
        #grid(
          columns: (1fr, 1fr),
          align: (left, right),
          header-left-text,
          if rinko-config.header-footer.show-date-in-header {
            let display-date = if date != none {
              let (y, m, d) = date
              str(y) + "年" + str(m) + "月" + str(d) + "日"
            } else {
              datetime.today().display("[year]年[month]月[day]日")
            }
            display-date
          }
        )
        #line(length: 100%, stroke: rinko-config.header-footer.line-stroke)
      ]
    },
    footer: if rinko-config.header-footer.show-page-number {
      [
        #line(length: 100%, stroke: rinko-config.header-footer.line-stroke)
        #align(center)[#context counter(page).display()]
      ]
    }
  )

  // ========================================
  // フォント設定
  // ========================================
  set text(
    font: rinko-config.font.main-font,
    size: rinko-config.font.main-size,
    lang: "ja",
  )

  // ========================================
  // 見出し設定
  // ========================================
  set heading(numbering: rinko-config.heading.numbering)

  show heading.where(level: 1): it => {
    set text(
      size: rinko-config.font.heading-sizes.level1,
      weight: "bold",
    )
    set block(
      above: rinko-config.heading.level1-spacing-above,
      below: rinko-config.heading.level1-spacing-below,
    )
    it
  }

  show heading.where(level: 2): it => {
    set text(
      size: rinko-config.font.heading-sizes.level2,
      weight: "bold",
    )
    set block(
      above: rinko-config.heading.level2-spacing-above,
      below: rinko-config.heading.level2-spacing-below,
    )
    it
  }

  show heading.where(level: 3): it => {
    set text(
      size: rinko-config.font.heading-sizes.level3,
      weight: "bold",
    )
    set block(
      above: rinko-config.heading.level3-spacing-above,
      below: rinko-config.heading.level3-spacing-below,
    )
    it
  }

  // ========================================
  // 段落設定
  // ========================================
  set par(
    leading: rinko-config.paragraph.leading,
    spacing: rinko-config.paragraph.spacing,
    first-line-indent: rinko-config.paragraph.first-line-indent,
    justify: rinko-config.paragraph.justify,
  )

  // ========================================
  // 図表設定
  // ========================================
  show figure.where(kind: image): it => {
    set align(center)
    set text(size: rinko-config.figure.image-caption-size)
    it.body
    [図 ]
    context counter(figure.where(kind: image)).display(rinko-config.figure.numbering)
    [ ]
    it.caption.body
  }

  show figure.where(kind: table): it => {
    set align(center)
    set text(size: rinko-config.figure.table-caption-size)
    [表 ]
    context counter(figure.where(kind: table)).display(rinko-config.figure.numbering)
    [ ]
    it.caption.body
    v(0.3em)
    set text(size: rinko-config.figure.table-body-size)
    it.body
  }

  // ========================================
  // コードブロック設定
  // ========================================
  show raw.where(block: true): it => {
    set text(size: rinko-config.code.font-size)
    block(
      width: 100%,
      fill: rinko-config.code.background,
      stroke: rinko-config.code.stroke,
      inset: rinko-config.code.inset,
      radius: rinko-config.code.radius,
      it
    )
  }

  // ========================================
  // タイトルページ
  // ========================================
  align(center)[
    #v(1cm)
    #text(size: 20pt, weight: "bold")[
      #title
    ]
    #v(0.8cm)
    #text(size: 12pt)[
      #affiliation
    ]
    #v(0.3cm)
    #text(size: 12pt)[
      #author
    ]
    #v(0.3cm)
    #text(size: 11pt)[
      #{
        if date != none {
          let (y, m, d) = date
          str(y) + "年" + str(m) + "月" + str(d) + "日"
        } else {
          datetime.today().display("[year]年[month]月[day]日")
        }
      }
    ]
  ]

  v(1.5cm)

  // ========================================
  // 本文
  // ========================================
  body
}

// ========================================
// ヘルパー関数
// ========================================

// 強調ボックス
#let emphasis-box(content) = {
  block(
    fill: rinko-config.color.emphasis-background,
    inset: 10pt,
    radius: 5pt,
    width: 100%,
  )[
    #content
  ]
}

// 警告ボックス
#let warning-box(content) = {
  block(
    fill: rinko-config.color.warning-background,
    stroke: 1pt + rinko-config.color.warning-stroke,
    inset: 10pt,
    radius: 5pt,
    width: 100%,
  )[
    *注意:* #content
  ]
}

// 枠付きボックス
#let bordered-box(content, title: none) = {
  block(
    stroke: 1pt + black,
    inset: 10pt,
    radius: 5pt,
    width: 100%,
  )[
    #if title != none [
      *#title*
      #v(0.3em)
    ]
    #content
  ]
}
