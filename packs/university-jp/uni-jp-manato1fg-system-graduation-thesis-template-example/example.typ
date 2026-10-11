#import "@preview/physica:0.9.2": *
#import "systemB.typ": *

#show: graduation_thesis.with(
  title: "タイトル",
  your_name_jp: "東大太郎",
  your_name_en: "Taro Todai",
  student_id: "XX-XXXXXX",
  mentor_name: "東大花子",
  mentor_position: "教授",
  // 指導教員が複数いる場合は次のように書きます
  // mentors: (
  //   (name: "東大花子", position: "教授"),
  //   (name: "東大次郎", position: "准教授"),
  // ),
  write_year: "2024",
  write_month: "1",
  abstract: "ここに概要を書く．",
  bibliography-file: "", // 付録がない場合はここで指定しておくと自動的に末尾に挿入される
  is_tinymist: true,  // tinymistの場合はtrue, Typst LSPの場合はfalse
)

= 序章
これは計数工学科システム情報コースの卒業論文をTypstに移植したものです．
== 題名
```
#import "systemB.typ": *

#show: graduation_thesis.with(
  title: "タイトル",
  your_name_jp: "東大太郎",
  your_name_en: "Taro Todai",
  student_id: "XX-XXXXXX",
  mentor_name: "東大花子",
  mentor_position: "教授",
  write_year: "2024",
  write_month: "1",
  abstract: "ここに概要を書く．",
  bibliography-file: "./references.bib",
)
```
というようにファイルの先頭に書くと，卒業論文の書式が設定されます．
=== bibliography-file について
`@Kingma2014` のような感じで引用すると勝手に参考文献に追加されます@Kingma2014．私はMendeleyから使う文献をまとめてBibTeX形式で出力して，それを指定しています．使わない論文は表示されないので，この方法がいいかなと思っています．

== ページについて
本家(LaTeX)版では奇数ページは右側に，偶数ページは左側にページ番号が表示されるようになっているので，それを再現しています．
#pagebreak()
例えばこんな感じで，章をまたぐ際はどこの章に属しているかがわかるようになっています．
#pagebreak()
奇数ページの場合はどこの節に属しているかがわかるようになっています．
#pagebreak()

= 本文
章が変わるページの場合はページのみが表示されるはずです．なお，`#heading`を入れても改ページされるようにはなっていないので自分で`#pagebreak()`してください．
== 数式
$
nabla dot vb(B) = 0
$
式番号は章ごとにリセットされます．

== 図
図も挿入できます．
#figure(image("example.jpg"), caption: "図の説明")

#pagebreak()
== 表
#figure(
  table(
    columns: (1fr, 1fr),
    table.header([*A*], [*B*]),
    [content 1], [content 2],
  ),
  caption: "表の説明は上にきます"
)


#pagebreak()

// 見出しのないheading
#chap[謝辞]
`#chap`を使うと見出しのないheadingが作れます．
何か不明な点や不具合があればissue立ててください．主に#link("https://zenn.dev/chantakan/articles/ed80950004d145")を参考にしました．

#reference(bibliography-file: "./references.bib")
#pagebreak()
#appendix()[
  = 付録
  付録は`#appendix`を使うと追加されますが，`graduation_thesis.with`の引数に`bibliography-file`を指定していると末尾に参考文献が出てきてしまうので，手動で書く必要があります．
```
#import "systemB.typ": *

#show: graduation_thesis.with(
  ...
  bibliography-file: "", // ここを空文字列にする
)

...

#reference(bibliography-file: "./references.bib") // 明示的に指定

#appendix()[
  = 付録のタイトル
  == 付録の中身
  付録の中身です
]
```
  == 付録の中身
  このように指定すると，付録の中身が表示されます．
]
