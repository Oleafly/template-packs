#import "@preview/chronos:0.2.1"
#import "../lib.typ": code

= シーケンス図

外部パッケージの `chronos` を使うと、シーケンス図を Typst のソースから直接描けます。
画像ファイルを別に持たずに済むので、図の変更が本文と同じ差分として残ります。

== 基本の形

#figure(
  chronos.diagram({
    import chronos: *
    _par("u", display-name: "利用者", shape: "actor")
    _par("a", display-name: "アプリ")
    _par("d", display-name: "在庫 DB", shape: "database")

    _seq("u", "a", comment: "注文を送信")
    _seq("a", "a", comment: "入力を検証")
    _note("right", [ここで妥当性を確認する], pos: "a")

    _alt(
      "在庫あり", {
        _seq("a", "d", comment: "在庫を確保", enable-dst: true)
        _seq("d", "a", comment: "確保完了", dashed: true, disable-src: true)
        _seq("a", "u", comment: "受付完了", dashed: true)
      },
      "在庫なし", {
        _seq("a", "u", comment: "在庫不足", dashed: true)
      },
    )
  }),
  caption: [注文処理の流れ],
) <fig-order>

#ref(<fig-order>) では、利用者・アプリ・在庫 DB の三者がやり取りしています。
登場人物の形（棒人間・矩形・円筒）、自己メッセージ、ノート、条件分岐が
いずれも記法だけで表現されています。

== 書き方

参加者を `_par` で宣言し、メッセージを `_seq` で並べます。
`shape` に `"actor"` や `"database"` を渡すと見た目が変わります。

#code(file: "chapters/10-diagram.typ")[
```typst
#chronos.diagram({
  import chronos: *
  _par("u", display-name: "利用者", shape: "actor")
  _par("a", display-name: "アプリ")
  _seq("u", "a", comment: "注文を送信")
  _seq("a", "u", comment: "受付完了", dashed: true)
})
```
]

`_alt` で条件分岐、`_loop` で繰り返しを囲めます。
活性区間は `enable-dst` と `disable-src` で開閉します。
