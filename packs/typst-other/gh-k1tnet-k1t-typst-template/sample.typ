#import "setting.typ": *
#import "macros.typ": *

#show: project.with(
  title: "typst-template",
  theme-number: "XEPX-XX",
  ja-project-theme: "日本語のタイトルを入力するとこんな感じで表示される",
  en-project-theme: "When you enter the title of an English paper, it will be displayed like this.",
  supervisor: (("工大 一郎 教授"), ("工大 次郎 教授"),),
  authors: (
    (class: "XEPX-XX", name: "今井 竜也", ruby: "IMAI Tatsuya"),
    (class: "YEPY-YY", name: "工大 太郎", ruby: "KOUDAI Taro"),
    (class: "ZEPZ-ZZ", name: "工大 花子", ruby: "KOUDAI Hanako"),
  ),
  abstract: [#lorem(70)],
  keywords: ("TeX", "Typing", "Template"),
)

// ファイル名のタプル
#let chapters = ("chapter/01-chapter.typ", "chapter/02-chapter.typ",)

// for loopでチャプター読み込み
#for chapter in (chapters) {
  include(chapter)
}

// もちろん直接書いてもOK

=== Contributions
#lorem(40)

== Related Work
#lorem(100)

#figure(placement: top, scope: "parent", caption: [1段組み], table(
  stroke: none,
  columns: 3,
  table.hline(),
  [名前],
  [味],
  [産地],
  table.hline(),
  [おおきなおおきなおおきなおおきなおおきなおおきなおおきなおおきなおおきなリンゴ],
  [92.1],
  [青森],
  [おおきなおおきなおおきなおおきなおおきなおおきなおおきなおおきなおおきなみかん],
  [92.6],
  [愛媛],
  [おおきなおおきなおおきなおおきなおおきなおおきなおおきなおおきなおおきないちご],
  [90.3],
  [金沢],
  table.hline(),
))<表の説明>

// 次の段から開始
#colbreak()

次の段から文章が書けます。

#colbreak()

3ページ目です。

これは参考文献です。@harry

これも参考文献です。@electronic

このように呼び出すと末尾の`#bibliography`部分で参照されます。

これはymlファイルで管理しましたが、bibファイルでも可能です。

#bibliography("refernces.yml", title: "参考文献", style: "ieee")
