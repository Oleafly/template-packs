/*
// 仕上がりサイズ: B5
#let trim-width = 182mm
#let trim-height = 257mm
#let bleed = 3mm // 塗り足し
// 仕上がりサイズでの余白
#let margin-top = 25mm
#let margin-bottom = 25mm
#let margin-horizon = 20mm

// font-sizeも
*/

// 仕上がりサイズ: A5
#let trim-width = 148mm
#let trim-height = 210mm
#let bleed = 3mm // 塗り足し
// 仕上がりサイズでの余白
#let margin-top = 16mm
#let margin-bottom = 16mm
#let margin-horizon = 16mm

#let text-font = "Hiragino Mincho ProN" // Todo
#let font-size = 9pt

#let toc() = context {
  v(2em) // 適切な垂直スペース
  set text(size: 1em, weight: "bold")
  align(center)[もくじ]
  v(1em)
  outline(depth: 3) // h3まで出す。
  pagebreak()
}

#let foreword(content) = {
  content
  pagebreak()
}

#let colophon_item(key, value) = {
  set text(1em)
  align(left)[
    #block(height: 0.5em)[
      #grid(
        columns: (38mm, 1fr),
        align(left)[#key],
        align(left)[#value]
      )
    ]
  ]
}
#let horizontal_line(
  height: 5mm,
  length: 100%,
  stroke: 0.5pt,
  double: false
) = {
  let line-body = if double {
    stack(
      dir: ttb,
      spacing: 2pt,
      line(length: length, stroke: stroke),
      line(length: length, stroke: stroke)
    )
  } else {
    line(length: length, stroke: stroke)
  }

  align(horizon)[#block(height: height, line-body)]
}

// 要職人芸 or なんかいい自動でやる方法。本当はfloatingにしたいような気もする。
#let image-height = 20em

#let img(name, caption, label_, height: image-height) = {
  let lbl = "fig:" + label_
  [
    #figure(
      image(name, height: height, fit: "contain"),
      caption: caption,
    )#label(lbl)
  ]
}

#let book(
  title: "本のタイトル",
  subtitle: "サブタイトル",
  author: "久我山 菜々",
  publisher: "いっと☆わーくす！",
  history: (
    ("2038年1月19日", "初版発行"),
  ),
  printer: "TODO: 最高の印刷所",
  contact: "mail@example.com",
  isdn: none,
  colophon-before: none,
  colophon-extra: none,
  foreword-file: none,
  body
) = {
  set document(
    title: title,
    author: author,
    date: auto,
  )
  set page(
    width: trim-width + bleed * 2,
    height: trim-height + bleed * 2,
    margin: (
      top: margin-top + bleed,
      bottom: margin-bottom + bleed,
      x: margin-horizon + bleed,
    ),
    header-ascent: 40%,
    footer-descent: 30%,
  )
  set text(
    lang: "ja",
    font: text-font,
    size: font-size,
  )

  // いい感じにするシリーズ
  show raw.where(block: true): block.with(
    fill: luma(95%),
    inset: 1em,
    width: 100%,
    radius: 4pt,
    breakable: true,
  )

  show raw.where(block: false): body => {
    // set text(size: 0.9em)
    body
  }

  // quoteをブロックにしてアミカケにする。
  show quote: it => block(
    fill: luma(0, 5%),
    inset: 1em,
    radius: 4pt,
    width: 100%,

    {
      set text(0.95em)
      it.body

      // attributionがある場合だけ、右寄せで表示
      if it.attribution != none {
        align(right)[
          #text(size: 0.9em, fill: luma(100))[
            — #it.attribution
          ]
        ]
      }
    }
  )
  // いい感じにするシリーズここまで

  {
    let titlepageitem(body, size: 22pt, vt: 0%) = {
      set align(center)
      set text(size: size)
      v(vt)
      body
    }
    [
      #titlepageitem(title, size: 22pt, vt: 20%)
      #titlepageitem(subtitle, size: 18pt)
      #titlepageitem(author, size: 14pt, vt: 40%)
      #pagebreak()
    ]
  }

  if foreword-file != none {
    foreword(
      include foreword-file
    )
  }

  set page(numbering: "i")
  counter(page).update(1)
  toc()

  set page(numbering: "1")
  set heading(numbering: "1.1")
  counter(page).update(1)

  // 章をまたぐと数字リセット
  show heading.where(level: 1): it => {
    counter(footnote).update(0)
    counter(figure.where(kind: image)).update(0)
    counter(math.equation).update(0)
    it
  }
  set figure(numbering: (..nums) => {
    let chapter = counter(heading).get().first()
    numbering("1.1", chapter, ..nums)
  })
  set math.equation(numbering: (..nums) => {
    let chapter = counter(heading).get().first()
    numbering("(1.1)", chapter, ..nums)
  })

  body

  // 後付
  set page(
    header: none,
    background: none,
    numbering: none
  )
  // 奥付
  if colophon-before != none { colophon-before }
  v(1fr)

  text(1.5em)[#title]
  if subtitle != none { text(1.2em)[ 〜 #subtitle 〜] }
  horizontal_line(double: true)

  for (date, desc) in history {
    colophon_item(date, desc)
  }

  colophon_item("著作・発行", author)
  colophon_item("サークル", publisher)
  colophon_item("印刷", printer)
  colophon_item("連絡先", contact)
  if isdn != none {
    colophon_item("ISDN", isdn)
  }

  horizontal_line()

  [
    落丁・乱丁の際は在庫がある限りお取り替えいたします。上記のメールアドレスまでご連絡ください。\
  ]
  grid(
    columns: (1fr, auto),
    align: (left + horizon, right + horizon),

    [
      この書籍は、クリエイティブ・コモンズ 表示 4.0 国際 ライセンスの下に提供されています。
      このライセンスのコピーを見るためには、 #link("https://creativecommons.org/licenses/by/4.0/deed.ja") にアクセスしてください。
    ],
    image("by.svg", alt: "クリエイティブ・コモンズ 表示 4.0 国際 ライセンス", width: 20mm)
  )
  if isdn != none {
    [
      ISDN (国際標準同人誌番号)については#link("https://isdn.jp/about.html")を参照ください。
    ]
  }
  if colophon-extra != none { colophon-extra }
}

// utilities

#let float-figure(
  img,
  caption: none,
  label: none,
  width: 35%,
  margin-left: 1em
) = {
  let fig = if label != none {
    [#figure(
      img,
      caption: caption,
    ) #label]
  } else {
    figure(
      img,
      caption: caption,
    )
  }

  place(
    top + right,
    float: true,
    clearance: 0.5em,
    dx: -margin-left,
    pad(
      left: margin-left,
      box(
        width: width,
        fig
      )
    )
  )
}

// 要出典したい。
#let citation_needed = super(text(size: 1em)[\[要出典\]])
