#metadata("darashi")<author>

== 出版準備とワークフロー

技術書の執筆が完了したら、次は出版に向けた準備が必要です。この章では、Typstを使った出版準備のワークフローについて解説します。印刷用PDFの作成、電子書籍の作成、入稿データの準備など、実際の出版プロセスに必要な知識を紹介します。

=== 印刷用PDFの作成

技術書を印刷するためには、印刷用の高品質なPDFを作成する必要があります。印刷用PDFには、通常の画面表示用PDFとは異なる要件があります。

==== 印刷用PDFの要件

印刷用PDFを作成する際には、以下の点に注意する必要があります：

1. **解像度**: 印刷には通常300 DPI以上の解像度が必要です
2. **カラーモード**: CMYKカラーモードが推奨されます（特に商業印刷の場合）
3. **フォント埋め込み**: すべてのフォントが埋め込まれている必要があります
4. **塗り足し（ブリード）**: ページの端まで画像や背景色がある場合、塗り足しが必要です
5. **トンボ**: 断裁位置を示すトンボが必要な場合があります

==== Typstでの印刷用PDF設定

Typstでは、以下のように印刷用の設定を行うことができます：

```typ
#set document(
  title: "Typstで作る技術書デザインブック",
  author: "四谷ラボ"
)

#set page(
  paper: "jis-b5",  // JIS B5サイズ
  margin: (
    top: 2cm,
    bottom: 2cm,
    left: 2cm,
    right: 2cm
  ),
  // 塗り足しを設定（必要な場合）
  bleed: 3mm
)
```

==== 高解像度画像の使用

印刷用PDFでは、すべての画像が高解像度である必要があります：

```typ
// 印刷用の高解像度画像を使用
#image("images/high-res-image.png", width: 80%)
```

画像は以下の条件を満たすことが理想的です：

- 解像度: 300 DPI以上
- 写真: CMYK形式のTIFFまたは高品質JPEG
- 図やダイアグラム: ベクター形式（SVG）または高解像度PNG

==== PDFプリフライトチェック

印刷用PDFを作成した後は、プリフライトチェックを行うことをお勧めします。Adobe Acrobat ProやPDF-XChangeなどのツールを使用して、以下の点をチェックできます：

- フォントの埋め込み
- 画像の解像度
- カラーモード
- 塗り足しとトンボ

=== 電子書籍の作成

印刷版とは別に、電子書籍版も作成することが一般的です。Typstでは、同じソースから印刷版と電子書籍版の両方を生成できます。

==== 電子書籍用PDFの設定

電子書籍用PDFは、印刷用とは異なる設定が必要です：

```typ
#let ebook = true

#set document(
  title: "Typstで作る技術書デザインブック",
  author: "四谷ラボ"
)

#set page(
  // 電子書籍用の設定
  margin: (
    top: 1.5cm,
    bottom: 1.5cm,
    left: 1.5cm,
    right: 1.5cm
  ),
  // 塗り足しは不要
  bleed: 0pt
)

// 電子書籍用のスタイル調整
#if ebook [
  #set text(
    // 画面表示に適したフォントサイズ
    size: 11pt
  )
]
```

==== 条件付きコンテンツ

印刷版と電子書籍版で異なるコンテンツを表示したい場合は、条件分岐を使用します：

```typ
#let ebook = true

// 印刷版と電子書籍版で異なるコンテンツを表示
#if ebook [
  この内容は電子書籍版のみに表示されます。
] else [
  この内容は印刷版のみに表示されます。
]
```

==== ハイパーリンクの最適化

電子書籍では、ハイパーリンクが機能することが重要です：

```typ
#set document(
  title: "Typstで作る技術書デザインブック",
  author: "四谷ラボ"
)

// ハイパーリンクの設定
#set link(
  // 電子書籍用のリンクスタイル
  style: "underline",
  color: blue
)

これは#link("https://typst.app/")[Typstの公式サイト]へのリンクです。
```

==== 表紙の追加

電子書籍には、通常表紙が必要です：

```typ
#if ebook [
  #page(margin: 0pt)[
    #align(center + horizon)[
      #image("covers/ebook-cover.jpg", width: 100%)
    ]
  ]
  #pagebreak()
]
```

=== 入稿データの準備

商業出版やオンデマンド印刷サービスを利用する場合、入稿データの準備が必要です。

==== 入稿用PDFの要件

入稿用PDFには、出版社やプリントサービスによって異なる要件がありますが、一般的には以下の点に注意が必要です：

1. **PDFバージョン**: PDF/X-1aやPDF/X-4などの印刷用標準規格に準拠していること
2. **カラーモード**: CMYKカラーモード（特に商業印刷の場合）
3. **フォント埋め込み**: すべてのフォントが埋め込まれていること
4. **塗り足し**: 通常3mmの塗り足しが必要
5. **トンボ**: 断裁位置を示すトンボが必要
6. **解像度**: 画像は300 DPI以上

==== 表紙と本文の分離

多くの場合、表紙と本文は別々のPDFファイルとして入稿します：

```bash
# 本文PDFの生成
typst compile main.typ book-body.pdf

# 表紙PDFの生成
typst compile covers/front-cover.typ front-cover.pdf
typst compile covers/back-cover.typ back-cover.pdf
```

==== PDFの結合

電子書籍版では、表紙と本文を結合する必要があります。これには、`pdftk`などのツールを使用できます：

```bash
# 電子書籍用の本文PDFを生成
typst compile main.typ --input EBOOK=true ebook-body.pdf

# 表紙と本文を結合
pdftk A=front-cover.pdf B=ebook-body.pdf C=back-cover.pdf cat A B C output ebook.pdf
```

=== 技術書典などの同人誌即売会向けの準備

技術書典などの同人誌即売会に参加する場合、以下の準備が必要です。

==== 入稿仕様の確認

印刷所によって入稿仕様が異なるため、事前に確認が必要です：

- ページサイズ（A5、B5など）
- 塗り足しのサイズ（通常3mm）
- トンボの有無
- カラーモード（CMYKまたはRGB）
- 解像度（通常350DPI以上）
- ファイル形式（PDFなど）

==== 頒布価格と部数の決定

頒布価格と部数を決定する際には、以下の点を考慮します：

1. **印刷コスト**: ページ数、カラー/モノクロ、部数によって変動
2. **イベント参加費**: サークル参加費、交通費、宿泊費など
3. **原稿料**: 執筆者への報酬
4. **その他経費**: デザイン料、イラスト料など

==== 頒布物の告知

SNSやWebサイトで頒布物の告知を行います：

1. **サンプルページの公開**: 内容の一部を公開して興味を引く
2. **目次の公開**: 本の構成を示して内容を伝える
3. **表紙画像の公開**: 視覚的なアピール
4. **頒布価格と入手方法の案内**: 価格と購入方法を明確に伝える

=== 電子書店での販売準備

同人誌即売会だけでなく、電子書店でも販売する場合の準備について解説します。

==== 対応フォーマットの準備

電子書店によって対応フォーマットが異なります：

- **PDF**: ほとんどの電子書店で対応
- **EPUB**: KindleやKoboなどで必要な場合がある
- **MOBI**: Kindle用（現在はEPUBに移行中）

Typstから直接EPUBを生成することはできませんが、PDFからの変換ツールを使用できます：

```bash
# PDFからEPUBへの変換（Calibreを使用）
ebook-convert ebook.pdf ebook.epub --title "Typstで作る技術書デザインブック" --authors "四谷ラボ"
```

==== メタデータの準備

電子書店での販売には、以下のメタデータが必要です：

1. **タイトル**: 書籍のタイトル
2. **著者名**: 著者または団体名
3. **表紙画像**: 高解像度の表紙画像
4. **説明文**: 内容を紹介する説明文
5. **カテゴリ**: 書籍のジャンルやカテゴリ
6. **キーワード**: 検索用のキーワード
7. **価格**: 販売価格

==== サンプルの準備

多くの電子書店では、サンプルページを提供することが推奨されます：

```bash
# 最初の10ページをサンプルとして抽出
pdftk ebook.pdf cat 1-10 output sample.pdf
```

=== GitHubを活用した執筆ワークフロー

技術書の執筆では、GitHubなどのバージョン管理システムを活用することで、効率的な執筆ワークフローを構築できます。

==== リポジトリの構成

技術書のリポジトリは、以下のような構成が一般的です：

```
.
├── main.typ                  # メインファイル
├── template.typ              # テンプレート定義
├── book.yaml                 # 書籍の基本情報
├── chapters/                 # 各章のディレクトリ
│   ├── 01-introduction.typ   # 第1章
│   ├── 02-basics.typ         # 第2章
│   └── ...
├── images/                   # 画像ファイル
├── covers/                   # 表紙関連
│   ├── front-cover.typ       # 表紙
│   └── back-cover.typ        # 裏表紙
├── .github/workflows/        # GitHub Actions設定
│   └── build.yml             # ビルド設定
└── README.md                 # プロジェクト説明
```

==== GitHub Actionsによる自動ビルド

GitHub Actionsを使用して、プッシュやプルリクエスト時に自動的にPDFをビルドできます：

```yaml
# .github/workflows/build.yml
name: Build PDF

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Install Typst
        run: |
          curl -L -o typst.tar.gz https://github.com/typst/typst/releases/latest/download/typst-x86_64-unknown-linux-musl.tar.gz
          tar -xzf typst.tar.gz
          chmod +x typst
          sudo mv typst /usr/local/bin/
      
      - name: Build PDF
        run: |
          typst compile main.typ book.pdf
          
      - name: Upload PDF
        uses: actions/upload-artifact@v3
        with:
          name: book-pdf
          path: book.pdf
```

==== 共同執筆のワークフロー

複数人で執筆する場合は、以下のようなワークフローが効果的です：

1. **ブランチの活用**: 各章や機能ごとにブランチを作成
2. **プルリクエスト**: 変更をプルリクエストとして提出
3. **レビュー**: 他の執筆者によるレビュー
4. **マージ**: レビュー後にメインブランチにマージ
5. **イシュー管理**: タスクや問題点をイシューとして管理

=== まとめ

この章では、Typstを使った出版準備のワークフローについて解説しました。印刷用PDFの作成、電子書籍の作成、入稿データの準備など、実際の出版プロセスに必要な知識を紹介しました。これらの知識を活用することで、Typstを使った技術書の出版をスムーズに進めることができます。

次の章では、Typstを使った実際の制作事例を紹介します。
