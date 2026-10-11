#import "@preview/codelst:2.0.2": sourcecode

= typst の書き方

== ディレクトリ構造

テンプレートのディレクトリ構造は以下のようになっています。

```bash
├── main.typ # ルートとなるファイル
├── chap1 # 第１章
│   ├── chap1.typ # 第１章の文章を記述するファイル
│   └── img # 第１章で使用する画像を保存するディレクトリ
├── chap2
:
├── epiloge # あとがき
│   └── epiloge.typ
├── prologe # まえがき
│   └── prologe.typ
├── main.pdf # 出力されるPDFファイル
├── png # 画像を出力するディレクトリ
└── template.typ # テンプレートファイル
```

== インポート

#sourcecode()[```typ
  #import "/template.typ": note, callout
  ```]

== 本文の書き方

#sourcecode()[```typ
  = 章
  == 節
  === 項
  ```]

== 画像の挿入

#sourcecode()[```typ
  #figure(
    image("img/img.png", width: 50%),
    caption: [画像の挿入],
  )
  ```]

== 文ブロック

typst starter で独自に定義した文ブロックです。

#sourcecode()[```typ
  #callout(title: コールアウトのタイトル)[
    コールアウトは、重要な部分を強調するために使います。
  ]
  ```]
