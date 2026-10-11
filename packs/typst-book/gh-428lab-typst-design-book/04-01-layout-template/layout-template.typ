#metadata("darashi")<author>

== Typstで作る技術書のレイアウトとテンプレート

この章では、Typstを使って技術書のレイアウトを作成する方法と、再利用可能なテンプレートの作り方について解説します。

=== レイアウトの基本

Typstでは、`set page`関数を使ってページのレイアウトを設定できます。技術書に適したレイアウトを作るには、以下の要素を考慮する必要があります：

- ページサイズ
- マージン
- ヘッダーとフッター
- フォントとテキストスタイル

```typ
set page(
  paper: "jis-b5",  // JIS B5サイズ
  margin: (bottom: 1.5cm, top: 2cm),
  header: context {
    // ヘッダーの内容
  },
  footer: context {
    // フッターの内容
  }
)
```

=== テキストスタイルの設定

技術書では、読みやすさを重視したテキストスタイルが重要です。Typstでは`set text`関数を使って、フォント、サイズ、行間などを設定できます：

```typ
set text(
  lang: "ja",
  font: ("Source Han Sans", "Noto Sans CJK JP"),
  size: 10pt,
  leading: 1em,  // 行間
)
```

=== 見出しのスタイル設定

章や節の見出しは、書籍の構造を視覚的に伝える重要な要素です。`show heading`を使って見出しのスタイルをカスタマイズできます：

```typ
// 章見出し（レベル1）
show heading.where(level: 1): it => {
  text(2em, weight: 700, it.body)
}

// 節見出し（レベル2）
show heading.where(level: 2): it => {
  block(
    fill: luma(224),
    inset: (x: 12pt, y: 6pt),
    text(weight: 900, 2em, it.body)
  )
}
```

=== コードブロックのスタイル

技術書では、コードブロックの表示が特に重要です。`show raw`を使って、コードブロックのスタイルを設定できます：

```typ
show raw.where(block: true): it => {
  v(1em)
  let lang = it.lang
  stack(
    spacing: none,
    if lang != none {
      block(
        width: 100%,
        fill: luma(224),
        inset: 5pt,
        text(weight: "bold", size: 0.8em, lang)
      )
    },
    block(
      width: 100%,
      fill: luma(240),
      inset: 12pt,
      it
    )
  )
  v(1em)
}
```

=== 図表のキャプション

図や表には適切なキャプションを付けることで、読者の理解を助けます：

```typ
show figure: it => {
  it.body
  align(center)[
    #it.caption
  ]
  v(1.5em)
}
```

=== 再利用可能なテンプレートの作成

Typstでは、関数を定義することで再利用可能なテンプレートを作成できます。このプロジェクトでは、`techbook`関数を定義して書籍全体のスタイルを設定しています：

```typ
#let techbook(
  ebook: false,
  title: "Book Title",
  author: "Author",
  date: none,
  paper-size: "jis-b5",
  body,
) = {
  // スタイル設定
  set document(title: title, author: author, date: date)
  set text(...)
  set page(...)
  
  // 表紙
  page(align(center + horizon)[
    #text(2em)[*#title*]
    #v(2em, weak: true)
    #text(1.6em, author)
  ])
  
  // 目次
  outline(indent: auto, title: [目次 #v(2em)], depth: 2)
  
  // 本文
  body
}
```

この関数を使うことで、一貫したスタイルの書籍を簡単に作成できます：

```typ
#show: techbook.with(
  title: [Typstで作る技術書デザインブック],
  author: "四谷ラボ",
  date: datetime(year: 2024, month: 11, day: 3)
)
```

=== 章タイトルページのデザイン

特別な章タイトルページを作成するための関数も定義できます：

```typ
#let chapter-title-page(title, image_path) = context {
  chapter-number-counter.step()
  let content = heading(title)
  pagebreak()
  block(
    height: 100%,
    width: 100%
  )[
    #h(-20cm)
    #content
    #v(0pt)
    #align(left)[
      #text(6.5em, weight: 200, "Chapter\n")
      #text(20em, weight: 900, chapter-number-counter.display("01"), fill: luma(192))
    ]
    #align(center + horizon)[
      #v(5em)
      #image(image_path, height: 60%)
    ]
    #align(right + bottom)[
      #set par(leading: 0.1em)
      #text(8.4em, weight: 700, content.body)
    ]
  ]
}
```

=== 奥付の作成

日本の書籍には奥付が必要です。以下のように関数を定義して奥付を作成できます：

```typ
#let create_colophon(ebook) = {
  set page(numbering: none, header: none, footer: none)
  
  // 書籍情報
  text([#date.display("[year]年[month padding:none]月[day padding:none]日") 発行])
  
  // 著者・発行者情報
  text(size: 0.9em, [
    #text(weight: 700, "著者") \
    著者名 \
    #v(0.3em)
    #text(weight: 700, "発行") \
    発行者名 \
  ])
}
```

=== まとめ

Typstを使うことで、プログラミング的なアプローチで美しく一貫性のある技術書を作成できます。このプロジェクトで提供されているテンプレートを活用することで、デザインに時間をかけることなく、内容に集中して執筆することができます。

次の章では、具体的なコンテンツの書き方と、Typstの特徴を活かした表現方法について解説します。
