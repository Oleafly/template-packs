#set page(header: none) // このページにはヘッダーを表示しない

#block(
  height: 100%,
  width: 100%,
  inset: 2em
)[
  == 四谷ラボの過去作品

  四谷ラボでは、これまでにも様々な技術書を出版してきました。その中でも特に人気のあるシリーズが「Hello Nostr, Yo Bluesky」です。

  #grid(
    columns: (1fr, auto),
    gutter: 1em,
    [
      === Hello Nostr, Yo Bluesky シリーズ

      分散型SNSの世界を探求するシリーズです。NostrとBlueskyという二つの分散型プロトコルに焦点を当て、その仕組みや使い方、開発方法などを解説しています。

      最新刊の「Hello Nostr, Yo Bluesky 3 - 未来を担う分散型SNS」では、分散型SNSの最新動向や、実際の活用事例、開発者向けのチュートリアルなどを掲載しています。
    ],
    [
      #box(
        stroke: 1pt,
        radius: 4pt,
        clip: true,
        image("/other/00A_helloNostr-Yobluesky3_cover.png", width: 12em)
      )
    ]
  )

  これらの書籍も、本書と同様にTypstを使用して制作されています。Typstの柔軟性と拡張性により、美しく読みやすい技術書を効率的に作成することができました。

  四谷ラボの書籍に関する最新情報は、以下のWebサイトでご確認いただけます：
  
  #align(center)[
    #text(weight: 700, "https://books.428lab.net")
  ]
]
