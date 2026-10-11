#metadata("Shino3（しのさん）")<author>

== 制作事例と実践テクニック

この章では、Typstを使った実際の制作事例と実践的なテクニックを紹介します。四谷ラボが手がけた「Hello Nostr, Yo Bluesky」シリーズの制作過程や、他の技術書の事例から学べるポイントを解説します。

=== 「Hello Nostr, Yo Bluesky」シリーズの制作事例

四谷ラボでは、分散型SNSに関する技術書「Hello Nostr, Yo Bluesky」シリーズを制作しています。このシリーズの制作過程を通じて、Typstを使った技術書制作の実践的なノウハウを紹介します。

==== プロジェクト概要

「Hello Nostr, Yo Bluesky」シリーズは、NostrとBlueskyという二つの分散型SNSプロトコルに焦点を当てた技術書シリーズです。以下の特徴があります：

- B5サイズ、約100〜150ページの技術書
- 複数の執筆者による共同執筆
- コードサンプル、図表、スクリーンショットを多用
- 印刷版と電子版の両方を提供
- 技術書典などの同人誌即売会で頒布

==== プロジェクト構成

プロジェクトのディレクトリ構成は以下の通りです：

```
.
├── main.typ                  # メインファイル
├── template.typ              # テンプレート定義
├── book.yaml                 # 書籍の基本情報
├── contributors.yaml         # 執筆者情報
├── chapters/                 # 各章のディレクトリ
│   ├── 01-introduction/      # 第1章
│   │   ├── introduction.typ  # 第1章本文
│   │   └── images/           # 第1章の画像
│   ├── 02-nostr/             # 第2章
│   │   ├── nostr.typ         # 第2章本文
│   │   └── images/           # 第2章の画像
│   └── ...
├── images/                   # 共通の画像ファイル
├── covers/                   # 表紙関連
│   ├── front-cover.typ       # 表紙
│   └── back-cover.typ        # 裏表紙
└── .github/                  # GitHub関連ファイル
```

==== 執筆ワークフロー

「Hello Nostr, Yo Bluesky」シリーズでは、以下のような執筆ワークフローを採用しています：

1. **企画・構成**: 全体の構成と各章の担当者を決定
2. **執筆**: 各執筆者がGitHubリポジトリをクローンして担当章を執筆
3. **レビュー**: プルリクエストを通じて他の執筆者がレビュー
4. **編集**: 全体の統一感を出すための編集作業
5. **デザイン**: 表紙デザインや全体のレイアウト調整
6. **校正**: 誤字脱字や技術的な誤りのチェック
7. **入稿**: 印刷所への入稿データ作成
8. **電子版作成**: 電子書籍版の作成

==== テンプレートの活用

「Hello Nostr, Yo Bluesky」シリーズでは、一貫したデザインを実現するために、カスタムテンプレートを作成しています：

```typ
#let techbook(
  title: "Book Title",
  author: "Author",
  date: none,
  body,
) = {
  // ドキュメント設定
  set document(title: title, author: author)
  
  // テキスト設定
  set text(
    font: ("Noto Sans CJK JP", "Hiragino Sans"),
    size: 10pt,
    lang: "ja"
  )
  
  // コードブロックのスタイル
  show raw.where(block: true): it => {
    block(
      width: 100%,
      fill: rgb("#f5f5f5"),
      radius: 5pt,
      inset: 10pt,
      it
    )
  }
  
  // 表紙
  page(align(center + horizon)[
    #text(2.5em, weight: 700)[#title]
    #v(2em)
    #text(1.5em)[#author]
    #v(1em)
    #text(1.2em)[#date]
  ])
  
  // 目次
  pagebreak()
  outline(
    title: [目次],
    indent: true
  )
  
  // 本文
  pagebreak()
  body
}
```

このテンプレートを使用することで、シリーズ全体で一貫したデザインを実現しています。

==== 図表の作成と管理

「Hello Nostr, Yo Bluesky」シリーズでは、多くの図表を使用しています。図表の作成と管理には以下のアプローチを採用しています：

1. **ダイアグラム**: Draw.io（diagrams.net）で作成し、SVG形式で保存
2. **スクリーンショット**: 高解像度で撮影し、必要に応じてトリミングや注釈を追加
3. **コード図**: Carbon（carbon.now.sh）などのツールでコードのスクリーンショットを作成
4. **画像管理**: 各章ごとに専用のディレクトリを作成し、関連画像を管理

図表の挿入例：

```typ
#figure(
  image("chapters/02-nostr/images/nostr-architecture.svg", width: 80%),
  caption: [Nostrのアーキテクチャ概要]
) <nostr-architecture>

// 後で参照する場合
@nostr-architecture に示すように、Nostrは...
```

==== コードサンプルの管理

技術書では、コードサンプルの管理も重要です。「Hello Nostr, Yo Bluesky」シリーズでは、以下のアプローチを採用しています：

1. **コードの検証**: すべてのコードサンプルは実際に動作することを確認
2. **シンタックスハイライト**: 言語を明示してシンタックスハイライトを適用
3. **行番号**: 必要に応じて行番号を表示
4. **コードの説明**: コードの前後に十分な説明を追加

コードサンプルの例：

```typ
// JavaScriptコードのサンプル
```javascript
import { SimplePool } from 'nostr-tools';

const pool = new SimplePool();

// リレーサーバーに接続
const relays = [
  'wss://relay.damus.io',
  'wss://relay.nostr.info'
];

// イベントを取得
const events = await pool.list(relays, [
  {
    kinds: [1],
    limit: 10
  }
]);

console.log(events);
```

このコードは、Nostrのリレーサーバーから最新の10件の投稿を取得します。
```

==== 印刷と電子版の両立

「Hello Nostr, Yo Bluesky」シリーズでは、印刷版と電子版の両方を提供しています。両方のフォーマットに対応するために、以下の工夫を行っています：

1. **条件分岐**: `#if ebook { ... } else { ... }` を使用して、電子版と印刷版で異なる内容を表示
2. **リンク**: 電子版ではクリック可能なリンクを活用
3. **カラー設定**: 印刷版ではCMYKカラー、電子版ではRGBカラーを使用
4. **QRコード**: 印刷版では長いURLの代わりにQRコードを使用

電子版向けの設定例：

```typ
#let ebook = true

#if ebook [
  // 電子版向けのリンク設定
  #set link(
    style: "underline",
    color: blue
  )
  
  // 電子版向けの注釈
  #block(
    fill: rgb("#e6f7ff"),
    inset: 10pt,
    radius: 5pt,
    [
      *電子版限定コンテンツ*: この部分は電子版のみに表示されます。
      オンラインリソースへのリンクを含んでいます。
    ]
  )
]
```

=== 他の制作事例から学ぶポイント

「Hello Nostr, Yo Bluesky」シリーズ以外にも、Typstを使った様々な制作事例があります。ここでは、他の事例から学べるポイントを紹介します。

==== 学術論文の事例

Typstは学術論文の執筆にも適しています。以下は学術論文の制作事例から学べるポイントです：

1. **引用と参考文献**: BibTeX形式の参考文献データを活用
2. **数式**: LaTeX風の数式表現を活用
3. **図表番号**: 章ごとに図表番号をリセット（例: 図1.1, 図1.2, 図2.1, ...）
4. **ヘッダーとフッター**: ページ番号や章タイトルを含むヘッダー/フッターの設定

学術論文向けのテンプレート例：

```typ
#let paper(
  title: "Paper Title",
  authors: (),
  abstract: none,
  keywords: (),
  bibliography-file: none,
  body
) = {
  // ドキュメント設定
  set document(title: title)
  
  // テキスト設定
  set text(
    font: "New Computer Modern",
    size: 11pt
  )
  
  // タイトルと著者
  align(center)[
    #text(18pt, weight: 700)[#title]
    #v(1em)
    #authors.join(", ")
    #v(2em)
  ]
  
  // 要旨
  if abstract != none [
    #heading(
      outlined: false,
      [Abstract]
    )
    #abstract
    #v(1em)
  ]
  
  // キーワード
  if keywords != () [
    #text(weight: 700)[Keywords: ]
    #keywords.join(", ")
    #v(2em)
  ]
  
  // 本文
  body
  
  // 参考文献
  if bibliography-file != none [
    pagebreak()
    heading(
      outlined: true,
      [References]
    )
    bibliography(bibliography-file, style: "ieee")
  ]
}
```

==== 技術マニュアルの事例

Typstは技術マニュアルの作成にも適しています。以下は技術マニュアルの制作事例から学べるポイントです：

1. **階層的な見出し**: 深い階層構造を持つ見出しの活用
2. **警告・注意ボックス**: 警告や注意を目立たせるためのスタイル設定
3. **手順リスト**: 番号付きリストを使った手順の説明
4. **サイドノート**: 余白を活用したサイドノートの表示

技術マニュアル向けのスタイル例：

```typ
// 警告ボックス
#let warning(content) = block(
  width: 100%,
  fill: rgb("#fff3e0"),
  stroke: rgb("#ff9800"),
  radius: 5pt,
  inset: 10pt,
  [
    #text(weight: 700, fill: rgb("#e65100"))[警告: ]
    #content
  ]
)

// 注意ボックス
#let note(content) = block(
  width: 100%,
  fill: rgb("#e1f5fe"),
  stroke: rgb("#03a9f4"),
  radius: 5pt,
  inset: 10pt,
  [
    #text(weight: 700, fill: rgb("#01579b"))[注意: ]
    #content
  ]
)

// 手順リスト
#let steps(..steps) = {
  let step-counter = counter("step")
  
  for step in steps.pos() {
    step-counter.step()
    block(
      width: 100%,
      inset: (left: 0pt),
      [
        #text(weight: 700)[ステップ #step-counter.display(): ]
        #step
      ]
    )
  }
}
```

使用例：

```typ
#warning[
  このコマンドは、すべてのデータを削除します。実行前に必ずバックアップを取ってください。
]

#note[
  この機能は、バージョン2.0以降でのみ利用可能です。
]

#steps(
  [サーバーにSSH接続します。],
  [設定ファイルを編集します: `nano config.json`],
  [サービスを再起動します: `systemctl restart myservice`]
)
```

==== 電子書籍専用の事例

電子書籍専用の制作事例からは、以下のポイントを学べます：

1. **インタラクティブ要素**: クリック可能なリンクや目次の活用
2. **カラー設定**: 画面表示に最適化されたカラー設定
3. **レスポンシブデザイン**: 様々な画面サイズに対応するレイアウト
4. **メタデータ**: 電子書籍のメタデータの設定

電子書籍向けの設定例：

```typ
#set document(
  title: "電子書籍タイトル",
  author: "著者名",
  keywords: ("Typst", "電子書籍", "技術書"),
  date: datetime.today()
)

// リンクのスタイル
#set link(
  style: "underline",
  color: blue
)

// 目次のスタイル
#set outline(
  indent: true,
  title: [目次]
)
```

=== 実践テクニック

ここでは、Typstを使った技術書制作の実践的なテクニックを紹介します。

==== 効率的な執筆環境の構築

効率的に執筆するためには、適切な環境構築が重要です：

1. **エディタ**: VS CodeなどのエディタにTypst拡張機能をインストール
2. **プレビュー**: リアルタイムプレビューを活用（`typst watch main.typ`）
3. **バージョン管理**: GitHubなどでバージョン管理
4. **CI/CD**: GitHub Actionsなどで自動ビルド

VS Code向けの設定例（.vscode/settings.json）：

```json
{
  "editor.formatOnSave": true,
  "editor.tabSize": 2,
  "files.associations": {
    "*.typ": "typst"
  },
  "typst-lsp.rootPath": "/path/to/typst",
  "typst-preview.watch": true
}
```

==== コンポーネントの再利用

繰り返し使用する要素は、コンポーネントとして定義すると効率的です：

```typ
// コードブロックコンポーネント
#let code-block(language, code) = {
  block(
    width: 100%,
    fill: rgb("#f5f5f5"),
    radius: 5pt,
    inset: 10pt,
    raw(language, code)
  )
}

// 使用例
#code-block("javascript", ```
function hello() {
  console.log("Hello, World!");
}
```)
```

==== 条件付きコンテンツ

印刷版と電子版で異なるコンテンツを表示する場合は、条件分岐を活用します：

```typ
#let ebook = true

// 印刷版と電子版で異なるコンテンツを表示
#if ebook [
  #link("https://example.com")[オンラインリソースはこちら]
] else [
  オンラインリソース: https://example.com
]
```

==== 複雑なレイアウト

複雑なレイアウトを実現するには、`grid`、`columns`、`place`などの機能を活用します：

```typ
// 2段組レイアウト
#columns(2, gutter: 1em)[
  左側のコンテンツ
  #colbreak()
  右側のコンテンツ
]

// グリッドレイアウト
#grid(
  columns: (1fr, 1fr),
  rows: (auto, auto),
  gutter: 1em,
  [左上], [右上],
  [左下], [右下]
)

// 絶対位置指定
#block(
  width: 100%,
  height: 10cm,
  [
    #place(top + left, [左上])
    #place(top + right, [右上])
    #place(bottom + left, [左下])
    #place(bottom + right, [右下])
    #place(center, [中央])
  ]
)
```

==== パフォーマンス最適化

大きな文書の場合、パフォーマンスを最適化することが重要です：

1. **モジュール化**: 大きな文書を複数のファイルに分割
2. **画像最適化**: 適切なサイズと形式で画像を保存
3. **キャッシュ活用**: Typstのキャッシュ機能を活用
4. **条件付きコンパイル**: 開発中は一部のセクションのみをコンパイル

開発中に特定のセクションのみをコンパイルする例：

```typ
#let debug = true
#let current-section = "introduction"

#if debug [
  // デバッグモードでは特定のセクションのみを表示
  #if current-section == "introduction" [
    = はじめに
    // はじめにの内容
  ]
] else [
  // 本番モードではすべてのセクションを表示
  = はじめに
  // はじめにの内容
  
  = 本文
  // 本文の内容
  
  = まとめ
  // まとめの内容
]
```

=== まとめ

この章では、Typstを使った実際の制作事例と実践的なテクニックを紹介しました。四谷ラボの「Hello Nostr, Yo Bluesky」シリーズの制作過程や、他の技術書の事例から学べるポイントを解説しました。これらの知識を活用することで、Typstを使った技術書制作をより効率的に進めることができます。

Typstは比較的新しいツールですが、その柔軟性と強力な機能により、様々な種類の技術書制作に適しています。本書で紹介した技術やノウハウを活用して、あなただけの素晴らしい技術書を作成してください。
