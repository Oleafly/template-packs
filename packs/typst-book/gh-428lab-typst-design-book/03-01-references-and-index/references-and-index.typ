#metadata("Shino3（しのさん）")<author>

== 索引と参考文献

技術書において、索引と参考文献は読者が情報を効率的に探したり、さらに学習を深めたりするための重要な要素です。この章では、Typstを使って索引と参考文献を作成する方法について解説します。

=== 索引の作成

索引は、特定のキーワードやトピックがどのページに登場するかを示す一覧です。技術書では、読者が特定の情報を素早く見つけるために重要な役割を果たします。

==== 基本的な索引の作成

Typstでは、`index`関数を使って索引項目を登録し、`index.display`関数で索引を表示します：

```typ
この部分は#index("Typst")Typstに関する説明です。

// 文書の最後に索引を表示
#index.display()
```

索引項目は、テキスト中の該当する単語の直前に配置します。`index`関数自体は出力に表示されません。

==== 階層的な索引項目

索引項目は階層的に構造化できます：

```typ
#index("プログラミング", "Typst")
Typstはプログラミング的なアプローチで文書を作成できます。

#index("プログラミング", "Python")
Pythonは人気のプログラミング言語です。
```

これにより、「プログラミング」という主見出しの下に「Typst」と「Python」という副見出しが作成されます。

==== 参照（「〜を見よ」）の追加

索引項目間の参照を追加することもできます：

```typ
#index("マークアップ言語")
#index("マークアップ言語", "Typst", see: "Typst")
```

これにより、「マークアップ言語」の下に「Typst → Typstを見よ」という参照が作成されます。

==== 索引のカスタマイズ

索引の表示形式をカスタマイズするには、`index.display`関数にパラメータを渡します：

```typ
#index.display(
  title: [索引],
  columns: 2
)
```

このコードは、「索引」というタイトルを付け、2段組で索引を表示します。

==== 索引作成のベストプラクティス

効果的な索引を作成するためのヒントをいくつか紹介します：

1. **一貫性を保つ**: 同じ概念には常に同じ索引語を使用する
2. **階層構造を活用**: 関連する概念をグループ化する
3. **重要な概念を優先**: すべての単語を索引化するのではなく、重要な概念に焦点を当てる
4. **読者の視点で考える**: 読者がどのような言葉で情報を探すかを考慮する
5. **相互参照を活用**: 関連する概念間の参照を追加する

=== 参考文献の管理

学術論文や技術書では、参考文献を適切に引用し、文献リストを作成することが重要です。Typstでは、BibTeXと同様の方法で参考文献を管理できます。

==== 参考文献データの準備

参考文献データは、BibTeX形式（.bib）またはTypstの独自形式で準備できます：

```typ
// BibTeX形式のファイルを使用
#bibliography("references.bib")

// または、Typst内で直接定義
#bibliography(
  ("knuth1984texbook", 
   type: "book",
   author: "Donald E. Knuth",
   title: "The TeXbook",
   publisher: "Addison-Wesley",
   year: "1984"),
  
  ("lamport1994latex",
   type: "book",
   author: "Leslie Lamport",
   title: "LaTeX: A Document Preparation System",
   publisher: "Addison-Wesley",
   year: "1994")
)
```

==== 文中での引用

文中で参考文献を引用するには、`cite`関数を使用します：

```typ
Knuthによれば、TeXは美しい文書を作成するためのシステムです#cite("knuth1984texbook")。

複数の文献を同時に引用することもできます#cite("knuth1984texbook", "lamport1994latex")。
```

==== 引用スタイルのカスタマイズ

引用スタイルをカスタマイズするには、`set cite`と`set bibliography`を使用します：

```typ
// 引用スタイルの設定
#set cite(style: "numerical")  // 数字形式 [1], [2], ...
// または
#set cite(style: "author-year")  // 著者-年形式 (Knuth, 1984), ...

// 参考文献リストのスタイルの設定
#set bibliography(style: "ieee")  // IEEE形式
// または
#set bibliography(style: "apa")  // APA形式
```

Typstでは、以下の引用スタイルがサポートされています：

- `numerical`: 数字形式 [1], [2], ...
- `author-year`: 著者-年形式 (Knuth, 1984), ...
- `chicago-author-date`: シカゴスタイル著者-日付形式
- `chicago-note`: シカゴスタイル注釈形式

また、以下の参考文献リストスタイルがサポートされています：

- `ieee`: IEEE形式
- `apa`: APA形式
- `mla`: MLA形式
- `chicago-author-date`: シカゴスタイル著者-日付形式
- `chicago-note`: シカゴスタイル注釈形式

==== 日本語の参考文献

日本語の参考文献を扱う場合、以下の点に注意が必要です：

1. 著者名は「姓, 名」の形式で記述する
2. タイトルは日本語のままでよい
3. 必要に応じて、`language`フィールドに`"ja"`を指定する

```typ
#bibliography(
  ("tanaka2020typst",
   type: "book",
   author: "田中, 太郎",
   title: "Typstによる日本語組版入門",
   publisher: "技術書出版",
   year: "2020",
   language: "ja")
)
```

==== 参考文献リストの表示

文書の最後に参考文献リストを表示するには、`bibliography`関数を使用します：

```typ
= 参考文献
#bibliography("references.bib", style: "ieee")
```

==== 参考文献管理のベストプラクティス

効果的な参考文献管理のためのヒントをいくつか紹介します：

1. **一貫したフォーマット**: すべての参考文献エントリに同じフィールドセットを使用する
2. **一意なキー**: 各参考文献に一意な識別キーを使用する
3. **完全な情報**: 必要なすべての情報（著者、タイトル、出版年など）を含める
4. **BibTeXツールの活用**: Zotero、Mendeley、JabRefなどのツールを使用して.bibファイルを管理する
5. **引用の確認**: すべての参考文献が本文中で引用されていることを確認する

=== 脚注と文末注

参考文献の他に、脚注や文末注も情報を補足するために重要です。

==== 脚注の追加

脚注を追加するには、`footnote`関数を使用します：

```typ
これは重要な文章です#footnote[これは脚注の内容です。]。
```

脚注は自動的にページの下部に配置され、番号が付けられます。

==== 文末注の作成

文末注（章末注や文書末注）を作成するには、少し工夫が必要です：

```typ
#let endnotes = state("endnotes", ())

#let endnote(content) = {
  locate(loc => {
    let number = counter(footnote).at(loc).at(0) + 1
    counter(footnote).step()
    [#super[#number]]
    endnotes.update(notes => notes + ((number, content),))
  })
}

// 文中での使用
これは重要な文章です#endnote[これは文末注の内容です。]。

// 章末や文書末に文末注を表示
#locate(loc => {
  let notes = endnotes.at(loc)
  if notes != () [
    == 文末注
    #for (number, content) in notes [
      #super[#number] #content
      
    ]
  ]
})
```

==== 脚注のカスタマイズ

脚注の表示形式をカスタマイズするには、`set footnote`を使用します：

```typ
#set footnote(
  numbering: "i",  // ローマ数字 i, ii, iii, ...
  separator: line(length: 30%)  // 区切り線の長さ
)
```

=== 用語集の作成

技術書では、専門用語を説明する用語集（グロッサリー）も有用です。Typstには用語集を自動生成する機能はありませんが、手動で作成することができます：

```typ
= 用語集

#let term(name, description) = {
  [
    #text(weight: "bold")[#name]
    #h(1em)
    #description
    #v(0.5em)
  ]
}

#term("Typst", [
  マークアップ言語とプログラミング言語の特徴を兼ね備えた組版システム。
])

#term("LaTeX", [
  TeX上に構築された文書作成システム。学術論文や技術文書の作成に広く使われている。
])

#term("マークアップ言語", [
  テキストの構造や書式を指定するための言語。HTML、XML、Markdownなどがある。
])
```

より高度な用語集を作成するには、索引機能と組み合わせることもできます：

```typ
#let glossary_terms = ()

#let glossary_term(term, definition) = {
  // 用語を索引に追加
  index(term)
  
  // 用語を太字で表示
  text(weight: "bold")[#term]
  
  // 用語集用のデータを保存
  glossary_terms.push((term: term, definition: definition))
}

// 文中での使用
#glossary_term("Typst", "マークアップ言語とプログラミング言語の特徴を兼ね備えた組版システム。")は、文書作成を効率化します。

// 文書末に用語集を表示
= 用語集
#for term in glossary_terms.sorted(key: t => t.term) [
  #text(weight: "bold")[#term.term]
  #h(1em)
  #term.definition
  #v(0.5em)
]
```

=== クロスリファレンス

技術書では、文書内の他の部分（章、節、図表など）への参照も重要です。Typstでは、`label`と`ref`を使ってクロスリファレンスを作成できます：

==== 見出しへの参照

```typ
= はじめに <intro>

// 中略

「#ref(<intro>)」で説明したように...
```

==== 図表への参照

```typ
#figure(
  image("path/to/image.jpg", width: 80%),
  caption: [サンプル画像]
) <sample-image>

// 中略

#ref(<sample-image>)に示すように...
```

==== 参照のカスタマイズ

参照の表示形式をカスタマイズするには、`ref`関数にパラメータを渡します：

```typ
// 「図1」のように表示
#ref(<sample-image>, supplement: [図])

// 「第1章」のように表示
#ref(<intro>, supplement: [第], suffix: [章])
```

=== まとめ

この章では、Typstを使って索引、参考文献、脚注、用語集、クロスリファレンスを作成する方法について解説しました。これらの要素を適切に活用することで、読者が情報を効率的に探したり、さらに学習を深めたりするための手助けとなります。

次の章では、Typstを使ったレイアウトとテンプレートの作成について解説します。
