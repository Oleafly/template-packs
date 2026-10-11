#metadata("Shino3（しのさん）")<author>

== Typstの基本

この章では、Typstの基本的な使い方について解説します。Typstは、マークダウンのような簡潔な文法とプログラミング言語のような強力な機能を兼ね備えた組版システムです。

=== Typstとは

Typstは、LaTeXの代替として開発された新しい組版システムです。LaTeXの複雑さを避けつつも、同様の美しい組版を実現することを目指しています。以下の特徴があります：

- **シンプルな文法**: マークダウンに似た直感的な文法
- **強力な機能**: プログラミング言語のような変数、関数、条件分岐などの機能
- **高速なコンパイル**: インクリメンタルコンパイルによる高速な処理
- **美しい出力**: 高品質なPDF出力
- **Webブラウザでの編集**: オンラインエディタも利用可能

Typstは特に技術文書や学術論文、書籍の執筆に適しています。

=== インストールと実行

Typstは、コマンドラインツールとして利用できます。以下の方法でインストールできます：

==== Windows

```bash
winget install --id Typst.Typst
```

または、[Typstの公式サイト](https://typst.app/)からインストーラーをダウンロードすることもできます。

==== macOS

```bash
brew install typst
```

==== Linux

```bash
curl -sSL https://get.typst.app/ | sh
```

インストール後、以下のコマンドでTypstファイルをコンパイルできます：

```bash
typst compile document.typ
```

リアルタイムプレビューを利用する場合は、以下のコマンドを使用します：

```bash
typst watch document.typ
```

=== 基本的な文法

Typstの文法は、マークダウンに似ていますが、より多くの機能を持っています。以下に基本的な文法を示します：

==== テキストの書式設定

```typ
// 見出し
= 第1レベル見出し
== 第2レベル見出し
=== 第3レベル見出し

// 強調
*太字*
_イタリック_
*_太字イタリック_*
~打ち消し線~
`コード`

// リスト
- 箇条書き1
- 箇条書き2
  - ネストされた箇条書き

// 番号付きリスト
1. 番号付きリスト1
2. 番号付きリスト2
   1. ネストされた番号付きリスト
```

==== 数式

Typstは、LaTeXのような数式表現をサポートしています：

```typ
// インライン数式
$x^2 + y^2 = z^2$

// ディスプレイ数式
$ sum_(i=1)^n i = (n(n+1)) / 2 $

// 複数行の数式
$ 
f(x) &= (x+a)(x+b) \
     &= x^2 + (a+b)x + ab
$
```

==== 図表

```typ
// 画像
#figure(
  image("path/to/image.jpg", width: 80%),
  caption: [キャプション]
)

// 表
#figure(
  table(
    columns: (auto, auto, auto),
    [*列1*], [*列2*], [*列3*],
    [行1列1], [行1列2], [行1列3],
    [行2列1], [行2列2], [行2列3],
  ),
  caption: [表のキャプション]
)
```

==== コードブロック

```typ
```python
def hello_world():
    print("Hello, World!")
```
```

=== プログラミング機能

Typstの強力な特徴の一つは、プログラミング言語のような機能を持っていることです。

==== 変数と関数

```typ
#let title = "Typstの基本"
#let author = "四谷ラボ"

#let greet(name) = {
  [こんにちは、#name さん！]
}

= #title
著者: #author

#greet("読者")
```

==== 条件分岐とループ

```typ
#let is_important = true

#if is_important {
  [*これは重要な情報です*]
} else {
  [これは通常の情報です]
}

#for i in range(1, 5) {
  [項目 #i\]
}
```

==== スタイル設定

```typ
#set text(
  font: "Noto Sans CJK JP",
  size: 11pt,
  lang: "ja"
)

#set heading(
  numbering: "1.1"
)

#set page(
  paper: "a4",
  margin: (top: 2.5cm, bottom: 2.5cm, left: 2.5cm, right: 2.5cm)
)
```

=== テンプレートの作成と使用

Typstでは、再利用可能なテンプレートを作成できます。テンプレートは、関数として定義します：

```typ
#let report(title, author, date, body) = {
  set document(title: title, author: author)
  set page(numbering: "1")
  
  align(center)[
    #text(2em, weight: 700)[#title]
    #v(1em)
    #text(1.2em)[著者: #author]
    #v(0.5em)
    #text(1.2em)[#date]
  ]
  
  pagebreak()
  
  outline(title: [目次], indent: true)
  
  pagebreak()
  
  body
}

#show: report.with(
  title: "レポートタイトル",
  author: "著者名",
  date: "2024年3月24日"
)

= はじめに
これはTypstで作成したレポートのサンプルです。
```

=== モジュール化と再利用

大きなプロジェクトでは、コードを複数のファイルに分割することが有用です。Typstでは、`include`と`import`を使用してファイルを分割できます：

==== include

`include`は、指定したファイルの内容をそのまま挿入します：

```typ
// main.typ
= はじめに
#include("introduction.typ")

= 方法
#include("methods.typ")
```

==== import

`import`は、指定したファイルから関数や変数をインポートします：

```typ
// template.typ
#let fancy_heading(title) = {
  align(center)[
    #text(2em, fill: blue)[#title]
    #v(1em)
    #line(length: 80%, stroke: 0.5pt)
  ]
}

// main.typ
#import "template.typ": fancy_heading

#fancy_heading("素晴らしいタイトル")
```

=== 実践的なヒント

==== 日本語組版のコツ

日本語組版では、以下の点に注意すると良いでしょう：

```typ
// 日本語フォントの設定
#set text(
  font: ("Noto Sans CJK JP", "Hiragino Sans"),
  lang: "ja"
)

// 禁則処理の設定
#set text(
  hyphenate: false  // 日本語では単語の途中で改行しない
)

// 段落の字下げ
#set par(
  first-line-indent: 1em  // 段落の最初の行を1文字分字下げ
)
```

==== 参考文献の管理

Typstでは、BibTeXのような参考文献管理もサポートしています：

```typ
#bibliography("references.bib")
```

==== 索引の作成

索引を作成するには、`index`関数を使用します：

```typ
この部分は#index("索引語")索引に登録されます。

// 文書の最後に索引を表示
#index.display()
```

=== まとめ

この章では、Typstの基本的な使い方について解説しました。Typstは、シンプルな文法と強力な機能を兼ね備えた組版システムであり、技術書の執筆に非常に適しています。

次の章では、Typstを使ったレイアウトとテンプレートの作成について、より詳しく解説します。
