#import "../theme/template.typ": *

= tips

== 有用な関数
筆者が修論にて使用したカスタム関数のうち、ほかの人にも有用そうな奴らを紹介する。全部template.typの下の方にあるぞ。
=== mymemo, TBC
ただのブロック。mymemoは水色、TBCは橙でfillし、前者はただのメモとして使用し、後者は確認事項(要出典箇所とか、修正コメントもらった箇所とか)を視覚的にわかりやすくするのに使用。
#grid(
  columns: (50%, 50%),
  [
    ```typst
    #mymemo[mymemo]
    #TBC[要確認事項]
    ```
  ],
  [
    #mymemo[mymemo]
    #TBC[要確認事項]
  ],
)

=== todo, show_todo
todoで文書内の各位置にタスクを記載すると、`<todo>`というタグのついたテキストとして出力する。そいでもって文書内の適当な場所にて`#show_todo`することにより、`<todo>`タグをクエリして一覧表示してくれる。あとついでに文書内の各todoの箇所にリンクもつけてくれるよ。ラボで回覧してたくさんコメントをもらった時に対応し忘れることがなくなるのでとても便利。大抵概要を最後に書くと思うので、概要のページにてshowするのがいいと思われる。
#grid(
  columns: (50%, 50%),
  [
    ```typst
    #todo()[やることその1]\
    #todo()[やることその2]
    #show: show_todo
    ```
  ],
  [
    #todo()[やることその1]\
    #todo()[やることその2]
    #show: show_todo
  ],
)

筆者の普段の研究ノートではその発展系としてstatus引数を受け取るようにして、ステータスに応じて未着手/対応中/実行済の3段階に分けて表示するようにしている。

=== pbox
`#place`関数というのがあり、こいつは文書内の好きな場所にコンテンツを配置できる。position引数としてtop/horizon/bottom, left/center/rightなどが指定できるのだが、どうも内部的にはアラインメントも連動してしまうようで、例えば
```typst
#place(right)[
  #block(stroke: red, width: 50%)[
    Hello, World!
  ]
]
```
と書くと→このように表示されてしまう。
#place(right, dy: -2em)[
  #block(stroke: red, width: 50%)[
    Hello, World!
  ]
]
place(right)を使いたい時ってのは単に右側に置きたいだけであって文字は普通に左詰の方がいい(たまにcenterとかrightとかにしたいときもあるけどそれは別途指定するようにしたい)ので、こういうのを作った。といっても単にplaceの中で改めてset alignしているだけである。適宜オプションをつけてやることでblockのカスタムが可能になる#footnote[
  この挙動は、pboxの定義に引数として`..arg`を受け取れるようにしてそれをそのままblockのオプションに投げるようにすることで実現している。
  ```typst
    #let pbox(pos, width: auto, dx: 0pt, dy: 0pt, alignment: left, ..arg, body) = {
    place(pos, dx: dx, dy: dy)[
      #set align(alignment)
      #block(
        width: width,
        ..arg,
      )[#body]
    ]
  }
  ```
  ドット二つはその中身を展開することを表している。例えば`pbox(right, stroke: red, fill: blue)`と書くとargとしては"stroke: red, fill: blue"というそのままでは意味をなさない値が渡されるが、これをカンマ区切りで展開して"stroke: red", "fill: blue"という別々の引数としてblockのオプションに流してくれる、ということ。
]。

これを使えば、以下のように右配置でも左詰でテキストを書き込める。`alignment: right`と書けば右詰になるぞ。
#grid(
  columns: (auto, 50%),
  column-gutter: 10pt,
  [
    ```typst
      #pbox(right, width: 90%, stroke: red)[Hello, World!]
    ```
  ],
  [
    #pbox(right, width: 90%, stroke: red)[Hello, World!]
  ],
)


=== smaller_list
デフォルトではlistは深さによらず全て同じ文字サイズで出力される。
- タイトル #context text.size
- 本文 #context text.size
  - イントロ #context text.size
    - 背景 #context text.size
    - 動機 #context text.size
  - 内容 #context text.size
    - hogehoge #context text.size
人によっては深さによって文字サイズを小さくしたいと考えるだろう、筆者もスライド作る時にはよくそう思う。そういう時に使うもの。

#grid(
  columns: 2,
  [
    ```typst
    #show list: smaller_list()
    - タイトル #context text.size
    - 本文 #context text.size
      - イントロ #context text.size
        - 背景 #context text.size
        - 動機 #context text.size
    ```
  ],
  [
    #show list: smaller_list()
    - タイトル #context text.size
    - 本文 #context text.size
      - イントロ #context text.size
        - 背景 #context text.size
        - 動機 #context text.size
  ],
)
このように引数に何もつけなければデフォルトで0.9em, 0.85emにする。level4以降については筆者は使っていないので設定しておらずそのままだと1emで表示される。このデフォルト値を変更したければ普通にtemplateの中でデフォルト値を書き換えるかsetすればいいだけだが、デフォルト値をいじった結果templateをimportしているすべてのファイルで形状が変わったらわけわからん#footnote[筆者が普段ノート取る時にはちょっとこういうの気になるというだけで、修論テンプレとして使う場合には特に問題にはならんだろう]のでmain冒頭で設定できるように、ということで引数として`dd`,`ddd`を受け取れるようにしている。それぞれdepth2,3の文字サイズを与える。
#grid(
  columns: 2,
  [
    ```typst
    #show list: smaller_list(dd: 1.2em, ddd: 0.5em)
    - タイトル #context text.size
    - 本文 #context text.size
      - イントロ #context text.size
        - 背景 #context text.size
        - 動機 #context text.size
    ```
  ],
  [
    #show list: smaller_list(dd: 1.2em, ddd: 0.5em)
    - タイトル #context text.size
    - 本文 #context text.size
      - イントロ #context text.size
        - 背景 #context text.size
        - 動機 #context text.size
  ],
)
文字サイズはem指定でもpt指定でもおけ。ちなみに、リストの文字サイズを変更する方法をすでに紹介している先達がいた(#link("https://zenn.dev/ngoat_gg/articles/96e65c2522c527")[こちら])が、先述したようにletするときにデフォルトを固定しないといけないというのと、level3の文字サイズが`dd*ddd` emになるというのが地味に受け付けなかったのでこのようにしました。

なお、smaller_listは単にlistを表示する際にdepthの計算とかset textとかをあわせてやってくれ、と言っているだけなので、このshowルールを複数回適用してしまうとdepth.step()がlist.itemごとに複数回実行されるようになるなどして表示がバグります。初めてshowする時はルールの付与、重ねる時はtext.sizeのアプデのみ行う、という実装を試みはしたもののうまいこといかなかった。showルール適用は冒頭で一度だけ行うか、複数回やりたい場合は独立した別のコンテンツになるようにしてください。あんまりこれを複数実行したい人いないだろうとは思うが。

#v(1em)
ちなみにリストには3つほどバリエーションがあって、上に見せた番号なしリストの他番号つきリスト、説明付きリストがある。それぞれ対応する関数として`#list, #enum, #terms`というのがあるが、最後のやつ以外は別にマークダウン形式の方で良いのではと思っている。せいぜいテンプレ作成時にsetするくらい？
#grid(
  columns: 2,
  column-gutter: 10pt,
  grid.cell(stroke: 1pt, inset: 5pt)[
    番号つきリスト
    + `-`を`+`に変えるだけ
    + 勝手にインクリメントしてくれる
      + インデントも同様
  ],
  grid.cell(stroke: 1pt, inset: 5pt)[
    説明付きリスト
    / 使い方: `-`を`/`に変えるだけ
    / 使い所: いつ？筆者は使ってないしなんならこの説明書くためにドキュメント見直して知った
  ],
)

=== math-ul
ポスターの制作時に使った。下線を引くには`#underline()[hogehoge]`でいけるが、こいつ数式モードに対しては働いてくれない。
#grid(
  columns: 2,
  column-gutter: 10pt,
  [
    ```typst
    #underline()[好きな公式は$E = m c^2$です。]
    ```
  ],
  [
    #underline()[好きな公式は$E = m c^2$です。]
  ],
)
(そもそも下線の位置が微妙でちょっと下にはみ出る文字(アルファベット使う時が顕著)につくときは線が途切れてしまいかなり不恰好。まあこれ自体は引数にoffsetというのがあるので適切にsetしてやればよいのだが。)

ということで、数式モードに対しても同じように下線を引くのがこいつ。
#grid(
  columns: 2,
  column-gutter: 10pt,
  ```typst
  #math-ul()[好きな公式は$E = m c^2$です。]
  ```,
  [
    #math-ul()[好きな公式は$E = m c^2$です。]
  ],
)
まあ、数式に対して機能しないunderlineに変わってboxを配置し、底辺にのみstrokeをつけただけです。卒論・修論においては使うことないと思うけどね。

== 有用なパッケージ<chap_package>
main.typの冒頭にあるように、`#import`は自前のtypファイルのみならず他パッケージも導入することができる。ここでは自分が使用した有用パッケージを紹介する。

ちなみにパッケージの一覧が#link("https://typst.app/universe/search/?kind=packages", [typst universe])にある。面白いものが多数あるので暇な時に眺めてるといいだろう。ついでにいうと左のメニューからtemplatesを選べば文書テーマの一覧が出てくる。今更ながら最初から律儀にカスタムしなくとも公式にあるテンプレ一覧から適当に好みを見つけてimportして利用、慣れてきたらそれをカスタムしながら文法を覚えるという流れの方が多分よい。
=== unify, physica, fletcher
unifyは単位、physicaは物理関係のなんやら、fletcherはダイアグラム作成のためのパッケージ。
#link("https://qiita.com/key_271/items/8629980c4c1ff0e55f41")にいい感じにまとまった記事があるのでそちらを参照。

=== zero
#link("https://typst.app/universe/package/zero/")

数字のフォーマットをしてくれるパッケージ。numとformat-tableをよく使った。

numは(unifyにもあったが)誤差とか指数表記とかを書くための関数。unifyのより若干やこっちの方が使いやすい印象がある。さすがに個人の好みレベルだが
#import "@preview/zero:0.6.1": format-table, num
#figure(
  table(
    columns: 4,
    stroke: none,
    table.vline(x: 2),
    align: left,
    [Code], [Output], [Code], [Output],
    table.hline(),
    `num("1.2e4")`, num("1.2e4"), `num[1.2e4]`, num[1.2e4],
    `num("-5e-4")`, num("-5e-4"), `num(fixed: -2)[0.02]`, num(fixed: -2)[0.02],
    `num("9.81+-.01")`, num("9.81+-.01"), `num("9.81+0.02-.01")`, num("9.81+0.02-.01"),
    `num("9.81+-.01e2")`, num("9.81+-.01e2"), `num(base: 2)[3e4]`, num(base: 2)[3e4],
  ),
)
てかオプションめちゃあるんやね、知らんかった。num自体の設定はset-numを使うらしい。
```typst
#set-num(product: math.dot, tight: true)
```

format-tableは表内の数字位置を揃える。以下の例だと1列目は特に指定なく、2列目に関しては小数点位置で揃えるように、ということ。
#grid(
  columns: (50%, 50%),
  [
    ```typst
    #figure({
      show: format-table(none, auto)
      table(
        columns: 2,
        [1], [1.2],
        [2], [2],
        [3], [300]
      )
    })
    ```
  ],
  [
    #figure({
      show: format-table(none, auto)
      table(
        columns: 2,
        [1], [1.2],
        [2], [2],
        [3], [300],
      )
    })
  ],
)

=== cheq
#link("https://typst.app/universe/package/cheq/")

チェックリストを作れる。別になくても困らないものではあるが、たまに使ったので一応紹介。
#grid(
  columns: 2,
  column-gutter: 5pt,
  [
    ```typst
    #import "@preview/cheq:0.3.0": checklist
    #show: checklist.with(extras: true)
    - [x] タスク1
    - [ ] タスク2
    - [!] タスク3
    - [u] タスク4
    - [I] タスク5
    - [>] タスク6
    ```
  ],
  [
    #import "@preview/cheq:0.3.0": checklist
    #show: checklist.with(extras: true)
    - [x] タスク1
    - [ ] タスク2
    - [!] タスク3
    - [u] タスク4
    - [I] タスク5
    - [>] タスク6
  ],
)