#import "../theme/template.typ": *


= 基本の記法 <chap_2>
本章では基本的な文書の書き方を簡単にまとめる。本テンプレを使うだけなら、この章を読めば最低限のものは作れるようになるはず。もちろん見た目をこだわりたいとかあればその限りではない。


基本はmarkdown形式で文章を書ける。
=の数でheadingのレベルを指定してセクション分けをしよう。
== ==だとlevel2
=== ===だとlevel3
==== ====でlevel4と続けてもいいがまあ普通は3までよな
各headingの文字サイズは
```typst
#show heading.where(level: 3): set text(50pt)
```
とかすればレベル別に指定可能。
#[
  #show heading.where(level: 3): set text(50pt)
  === ほらね
]
こういうshowルール、setルールを適用すると普通は以下全てのコンテンツに適用されてしまう。
今の場合見出し2.1.2だけ50ptで表示したければ、
```typst
#[
  #show heading.where(level: 3): set text(50pt)
  === ほらね
]
=== こいつには適用されない。
```
こうやってコンテンツブロックで囲ってやれば、ルールがそのブロック内でのみ適用されるので便利。
=== こいつには適用されない。
ちなみに今現在のheadingの文字サイズ設定はtemplate.typのmain-templateに記述してある。大きさに不満があるならそこをいじってください(本文冒頭で上書きsetしてもいいのだが)

== figure <sec_figure>
図は`#image`、表は`#table`、コードは`#raw`を使って表示可能。だが基本的にはfigureの中身に記述するようにしよう。

=== image
図を挿入するには
```typst
#image("./fig/test.jpg", width: 50%)
```
と書く。
#image("../fig/test.jpg", width: 50%)
#place(center, dx: 3em, dy: -3em)[←かわいい]
widthはそのまま、画像の幅。50%という指定はページ幅に対する半分サイズってこと。別に他にも引数あるが(heightとか)基本的にwidthしか指定したことないな。

ただのノートくらいならこれでいいだろうが、論文にする場合は`#figure`を使うべし。
#grid(
  column-gutter: 10pt,
  columns: 2,
  [
    ```typst
    #figure(
      image("../fig/test.jpg"),
      caption: [カービイじゃねえカービィだにどとまちがえるなくそが]
    )<kirby_fig>
    ```
  ],
  [
    #figure(
      image("../fig/test.jpg"),
      caption: [カービイじゃねえカービィだにどとまちがえるなくそが],
    )<kirby_fig>
  ],
)
captionがつけられるようになるほか、referenceが可能となる。`<kirby_fig>`とタグをつけたので、`@kirby_fig`と書けば@kirby_fig のように自動で画像位置にリンクをつけられる。あと普通に、figureを使わず単にimageしてしまうと冒頭の図目次に反映されない
#footnote[もしかしたら筆者が知らないだけで、figureだけでなくimageに対してoutlineできる方法あるのかもだが、今のところ真面目な文書でfigureにしない理由が筆者には思い当たらないので特に理由なければこの運用をすることをお勧めします]。

ちなみに、使ったついでに言うと今の2列表示は`#grid`でやってます。下の例でcolumnsを2, rowsを指定しなければよい。
```typst
#grid(
  columns: 3, // 単に行数/列数で記述もできるし
  rows: (20%, 10%), // 比率で記述することも可能
  stroke: red,
  inset: 5pt // コンテンツと枠線の距離を指定できる。5pt以上入れといた方が見やすい。
  [
    左上ブロック
  ],
  [
    #image("../fig/test.jpg"),
  ],
  [
    右上ブロック\
    各コンテンツブロックは独立なので、例えば`#set align(right)`を叩いても\
    #v(1em)
    #set align(right)
    ここだけ右詰めの文書になり、後ろのブロックは普通に左詰めになる。
  ],
  [
    左下ブロック\
    問題なく左詰め
  ],
  [
    中央下ブロック\
    `rows: (20%, 10%),`としたので、1行目、2行目の高さがページに対する20%, 10%になっている。
  ],
  [
    右下ブロック
  ]
)
```
#grid(
  columns: 3,
  rows: (20%, 10%),
  stroke: red,
  inset: 5pt,
  [
    左上ブロック
  ],
  [
    ここで`#image("../fig/test.jpg", width: 50%)`と書いた場合、このセルの幅に対する50%で描画することになる。
    #image("../fig/test.jpg", width: 50%)
  ],
  [
    右上ブロック\
    各コンテンツブロックは独立なので、例えば`#set align(right)`を叩いても\
    #v(1em)
    #set align(right)
    ここだけ右詰めの文書になり、後ろのブロックは普通に左詰めになる。
  ],
  [
    左下ブロック\
    問題なく左詰め
  ],
  [
    中央下ブロック\
    `rows: (20%, 10%),`としたので、1行目、2行目の高さがページに対する20%, 10%になっている。
  ],
  [
    右下ブロック
  ],
)
わかりやすさのためにstrokeをredにしたよ。
#v(1em)

なお、(headingやtableなどもそうだが)例えば今「図1.1」とあるのを「figure 1.1」などに変えたい場合は、setルールでfigureのsupplement引数をいじればよい。
```typst
#set figure(supplement: [頭])
#figure(
  image("../fig/test.jpg", width: 50%),
  caption: [カービイじゃねえカービィだにどとまちがえるなくそが],
)
```
#[
  #set figure(supplement: [頭])
  #figure(
    image("../fig/test.jpg", width: 50%),
    caption: [カービイじゃねえカービィだにどとまちがえるなくそが],
  )
]
あと、まだtypstが標準装備してない便利機能としてキャプションを本文と図見出しとで変える機能がある。これは今のところ`flex_caption`というのを実装して対応している。
```typst
// template.typにあるぞい
#let in-outline = state("in-outline", false)
#let flex_caption(short, long) = context {
  if in-outline.get() [#short] else [#long]
}
```
state関数はそのまま状態を保持するもの。template.typにおいては一番外側のスコープで定義したので、実質(template.typをimportした)文書内のどの場所にでもその状態を持ってきて使用できる。flex_captionがやっているのはin-outlineがtrueかどうかで吐き出すコンテンツを受け取る引数のどちらにするかを決めるだけである。
そして、state.typにて
```typst
#show outline: it => {
  in-outline.update(true)
  it
  in-outline.update(false)
}
```
と書いておくことで、outlineを表示する際先にin-outlineがtrueになってから出力、その後はfalseに戻してから終了するように設定している。flex_captionとこのshowルールを組み合わせることで、図目次を出力する際は`#short`を、outlineを表示し終えた本文中では`#long`が出力されるという仕組み。使い方としてはcaptionの中身に記述するだけ。
#grid(
  column-gutter: 10pt,
  columns: 2,
  [
    ```typst
    #figure(
      image("../fig/test.jpg", width: 50%),
      caption: flex_caption(
        [図目次用短いキャプション],
        [本文用長いキャプション],
      )
    )
    ```
  ],
  [
    #figure(
      image("../fig/test.jpg", width: 50%),
      caption: flex_caption(
        [図目次用短いキャプション],
        [本文用長いキャプション],
      ),
    )
  ],
)
尚このテンプレは元々stateを大量に使っていたが、より明確な設計にするためにできるだけstateを使わないようにしようという思想のもと出来たものなのでここ以外では登場しない。flex_captionはstateなしで実装できるのかしら。知らんし1個くらい許せよって感じなのでそのままにしてある。

=== table
表は`#table`を使う。結構できることが多く全てを紹介するのは非常に面倒なので、基本的なことに留める(いうてこれ以外もだいたいそんな感じなのだが)。

tableで主に用いる引数はcolumn, align, fill, strokeあたり。それぞれ列数、セル内の文字位置、セルの色、罫線を指定する。#link("https://typst.app/docs/reference/model/table/")[ドキュメント]に例がたくさんあるので、これをみながら遊ぶとよい。
#grid(
  columns: 2,
  column-gutter: 10pt,
  [
    ```typst
    #figure(
      table(
        columns: 3,
        stroke: none,
        align: {center},
        fill: (x,y) => {
          if x == 0 {aqua}
          else if calc.odd(y) {silver}
          else {none}
        },
        table.hline(),
        [型],[宣言],[ビット幅],
        table.hline(),
        [文字型],[char],[8],
        [整数型],[int],[32],
        [倍精度実数型],[double],[64],
        [倍々精度実数型],[long double],[96],
      ),
      caption: [データ型]
    )
    ```
  ],
  [
    #figure(
      table(
        columns: 3,
        stroke: none,
        align: { center },
        fill: (x, y) => {
          if x == 0 { aqua } else if calc.odd(y) { silver } else { none }
        },
        table.hline(),
        [型], [宣言], [ビット幅],
        table.hline(),
        [文字型], [char], [8],
        [整数型], [int], [32],
        [倍精度実数型], [double], [64],
        [倍々精度実数型], [long double], [96],
      ),
      caption: [データ型],
    )
  ],
)
すげーなtypst。tableの場合はcaptionを上に置くってルールがあるけどそれも勝手にやってくれるのかー。………いいえ、普通にmain-templateの中でshowしてるだけです
```typst
#show figure.where(kind: table): set figure.caption(position: top)
```
課題としては、今の所strokeとしての二重線がサポートされておらず、無理やりやるならcolumn-gutterでなんとかするしかないという点が挙げられる。これも早くアプデしてほしい。

ところで、ふつー論文見たいなちゃんとした文章で書くtableにおいて全ての辺を書くことはまずないだろうし、いらないところを消すよりはいるところに`table.hline(), table.vline()`する方が見やすいと思うんで、いっそmain-templateで合わせて`stroke: none`にsetしてしまってもいい気はする。


=== raw
rawコードは`#raw`でもいけるが大抵は\`raw code\`とバッククォートで囲んで表示する。
バッククォート一つでインライン表記 `inline`になるし、三つでブロック表記
```
block
```
になる。今ブロックの時にグレーのブロックに収められた形で表示されてるのはmain-templateでそう記述しているからです
```typst
#show raw.where(block: true): it => {
  block(inset: 5pt, fill: silver.lighten(30%), radius: 3pt)[#it]
}
```
デフォルトでは特にfillされない。好みに合わせてこの辺の記述をいじるか消すかしてね。

image, table同様こいつについてもoutlineできるが、筆者の修論においては不要だったため特に記述してない。やりたければstate.typのoutlineのとこでkindをrawに指定すればおけ。


=== figureのバグ
一点、困ったことがある。figureにはplacementオプションがあり、none, top, bottom, autoから選べる。@fig_placement はtopにしてみた結果であり、組版結果としては指示通り綺麗にできているように見えるが、このリンクを押してみると適切に画像位置に飛ばないことがわかる。どうやらfigureがリンクしてくれる位置は組版結果としての出力位置ではなくコード内でfigureを出力せよと指示された場所になるらしいのである。これはtypstのバグ。普通に早く修正してほしい。
#figure(
  image("../fig/test.jpg", width: 30%),
  placement: bottom,
  caption: [placement: bottom],
)<fig_placement>

対処法としてはfigureにmetadataを埋め込み、組版結果としての出力位置を保持しておき、refする先をそれに塗り替えるようshowルールを適用する、というのがあるらしいがなぜか筆者はこれがうまく動かせなかったので簡単にfigureをplaceで囲む方式をとっている。
#grid(
  columns: (50%, 50%),
  column-gutter: 10pt,
  stroke: red,
  [
    ```typst
    #place(auto, float: true)[
      #figure(
        image("../fig/test.jpg", width: 40%),
        caption: [place+figure]
      )
    ]
    ```
    普通placeすると他のコンテンツから浮くのだが、floatオプションをtrueにすることで浮かせることなく記述することができる。autoにするといい感じに勝手にポジションを決めてくれるので便利。文章がある程度固まったら好みに合わせて適宜top/bottomだのleft/center/rightだのすればよい。
  ],
  [
    #place(auto, float: true)[
      #figure(
        image("../fig/test.jpg", width: 40%),
        caption: [place+figure],
      )
    ]
  ],
)

== 数式<sec_equation>
数式を書くには\$\$で囲めば良い。`$E = m c ^2$`と、`$`マークと中身の間に空白なく書けばインラインで$E = m c^2$となり、
```typst
$ x^n + y^n = z^n $
```
と空白込みで、あるいは
```typst
$
  x^n + y^n = z^n
$ <equation1>
```
と改行を入れて書けばblockとして
$
  x^n + y^n = z^n
$ <equation1>
のように表示される。blockにしたequationについてはfigureと同様にrefができる。`@equation1`で@equation1 という感じ。

便利かつ序盤は不便に感じる点として、texとは異なりバックスラッシュとかなくとも基本文字入れるとまず変数として処理される。数式中でギリシャ文字とか使うには単に`$mu$`とかってすれば$mu$と出力される。慣れないうちは文字式$m u$を出したいのに$mu$が出力されちゃうとか結構あると思う。普通に空白込みで`$m u$`と書けばよいが、慣れるまでは若干苦労するだろう。

数式番号についてはmain-templateにて以下のように記述した。
```typst
#set math.equation(numbering: it => {
  let count = counter(heading.where(level: 1)).at(here()).first()
  numbering("(1.1)", count, it)
})
#show math.equation.where(block: true): set block(breakable: true)
#show math.equation.where(block: false): set math.frac(style: "horizontal")
#show math.equation: set text(font: ("New Computer Modern Math", "Hiragino Mincho ProN"))
```
上から順に
- 該当チャプター内での通し番号it, チャプター番号countを用いて(count, it)という番号を振る、という規則を記述
  - itがチャプター内通し番号になるのは、heading_components.typにてlevel1 headingが来るたびに`counter(math.equation).update(0)`を叩くように指定したため。
- ブロック表記の数式について、複数ページに分割して出力されることを許可
- インライン表記の数式について、分数を$a / b$の形で出力する
- 数式モード内でのフォント指定。日本語はヒラギノ明朝で
を意味している。


=== texと比較(数式)
ちょっと脱線。typstの数式は(別に数式に限らないが)texに比べてタイプ量が若干少なく済む。以前ついったーで「texでぜみ資料作るの大変(>\_<)」的なことを言ってる人がいたので、その人が書いてたコードを例に取って比較してみる。
#import "@preview/physica:0.9.8": *
$
  i planck dv(tilde(psi)(bold(x),t), t)
  &= i planck dv(, t) (psi(bold(x), t)e^(-i bold(K)(t) dot bold(x)))\
  &= i planck [(dv(psi(bold(x), t), t))e^(-i bold(K)(t) dot bold(x))
    + psi(bold(x), t)dv(, t)(e^(-i bold(K)(t)dot t))]\
  &= (i planck dv(psi(bold(x), t), t)e^(-i bold(K)(t)dot bold(x)))
  + psi(bold(x), t)(i planck e^(-i bold(K)(t)dot bold(x))(-i dv(bold(K)(t), t)dot bold(x)))\
  &= (i planck dv(psi(bold(x), t), t))e^(-i bold(K)(t) dot bold(x))
  + psi(bold(x), t)e^(-i bold(K)(t)dot bold(x))(planck dv(bold(K)(t), t)dot bold(x))
$
こいつを出力するrawコードを以下に示す。括弧内は文字数(vscodeによるカウント)。

tex(875)
```tex
\begin{align*}
i\hbar\frac{d\tilde{\psi}(\boldsymbol{x},t)}{dt}
&= i\hbar\frac{d}{dt} \left(\psi(\boldsymbol{x},t\e^{-i\boldsymbol{K}(t)\cdot\boldsymbol{x}}\right)\\
&= i\hbar \left[\left(\frac{d\psi(\boldsymbol{x},t)}{dt}\right)e^{-i\boldsymbol{K}(t)\cdot\boldsymbol{x}} + \psi(\boldsymbol{x},t) \frac{d}{dt}\left(e^{-i\boldsymbol{K}(t)\cdot\boldsymbol{x}} \right) \right]\\
&= \left(i\hbar\frac{d\psi(\boldsymbol{x},t)}{dt} \right)e^{-i\boldsymbol{K}(t)\cdot\boldsymbol{x}} + \psi(\boldsymbol{x},t)\left(i\hbar e^{-i\boldsymbol{K}(t)\cdot\boldsymbol{x}}\left(-i\frac{d\boldsymbol{K}(t)}{dt}\cdot\boldsymbol{x} \right) \right)\\
&= \left(i\hbar\frac{d\psi(\boldsymbol{x},t)}{dt}\right)e^{-i\boldsymbol{K}(t)\cdot\boldsymbol{x}} + \psi(\boldsymbol{x},t)e^{-i\boldsymbol{K}(t)\cdot\boldsymbol{x}}\left(\hbar\frac{d\boldsymbol{K}(t)}{dt}\cdot\boldsymbol{x} \right)
\end{align*}
```

typst(542)
```typst
$
  i planck dv(tilde(psi)(bold(x),t), t)
  &= i planck dv(,t) (psi(bold(x),t)e^(-i bold(K)(t) dot bold(x)))\
  &= i planck [(dv(psi(bold(x),t),t))e^(-i bold(K)(t) dot bold(x))
      + psi(bold(x),t)dv(,t)(e^(-i bold(K)(t)dot t))]\
  &= (i planck dv(psi(bold(x),t),t)e^(-i bold(K)(t)dot bold(x)))
      + psi(bold(x),t)(i planck e^(-i bold(K)(t)dot bold(x))(-i dv(bold(K)(t),t)dot bold(x)))\
  &= (i planck dv(psi(bold(x),t),t))e^(-i bold(K)(t) dot bold(x))
      + psi(bold(x),t)e^(-i bold(K)(t)dot bold(x))(planck dv(bold(K)(t),t)dot bold(x))
$
```

300文字以上セーブできました#footnote[planckとかdvとかはtexのphysicsパッケージのように外部パッケージが必要。こちらではphysicaというやつになる。詳しくは@chap_package へ。]。

ちなみにtexにないtypstの強みとして計算が可能な点が挙げられます。
```typst
#let char_tex = 875
#let char_typ = 542
#let reduce_rate = calc.round( (char_tex - char_typ)/char_tex * 100 , digits: 2)
#text(red)[texに比べてtypstでは#reduce_rate;%文字数が減りました。]
```
#let char_tex = 875
#let char_typ = 542
#let reduce_rate = calc.round((char_tex - char_typ) / char_tex * 100, digits: 2)
#text(red)[texに比べてtypstでは#reduce_rate;%文字数が減りました。]

これがまた素晴らしいもんで、ある程度書いたのちにどっか計算ミスが発覚！とかなった場合に関連する場所全て計算し直すとかしなくても大元の数字(今の例で言うchar_texとか)を変更してしまえば全ての箇所に変更が行き渡るのでとても助かる。`calc.~~`と書くことで計算できる。どんな計算ができるかについては#link("https://typst.app/docs/reference/foundations/calc/", [こちら])を参照。

== リンク
`#link("https://hogehoge.jp", [リンク先])`で#link("https://hogehoge.jp", [リンク先])こうなる。リンクが下線+青字となっているのは再びmain-template内で
```typst
#show link: it => {
  underline[#text(blue, it)]
}
```
としてるから。
ちなみにlinkとrefは別物なので、カスタムする際は一応注意。

== reference
figureや数式に対するrefの方法は@sec_figure, @sec_equation にて既に触れた。そして今やったように、headingに対しても同様にrefできる。
```typst
== heading <tag_heading>
@tag_heading
```
英語にあわせてか、日本語であっても「章 1」、「節 1.1」のように出力される(章についてはshowルールを適用してあるから「第1章」となってるが)。気になるようならこれもmain-template内でsupplementをいじろう。筆者は気にならなかったのでそのまま使っている。

参考文献についても適切に引用する必要がある。基本は同じで\@に続けてタグを示してやればよい。今、references.bibに
```
@mastersthesis{bibref-tag,
  author = {東大太郎},
  school = {東京大学},
  title = {ぼくのかんがえたさいきょうのしゅうしろんぶん},
  year = {2020},
  type={修士論文}
}
```
と書いてあるなら、文書内で`@bibref-tag`と書けば@bibref-tag といい感じに引用番号を振ってくれる。まあ、`\ref{}`だったのが`@~`になるだけなのでこの辺は分かりやすいだろう。

== par
段落に関する設定は`par`から。このテンプレでは以下の設定を使っている。
```typst
#set par(
  spacing: 0.65em,
  first-line-indent: (amount: 1em, all: true),
  justify: true,
)
```
first-line-indentというのが段落始めにインデントを入れる設定。デフォルトでは英語文書に倣ってかセクション最初のパラグラフに関してはインデントしないようになっているが、`all: true`を入れることでこれを回避している。英語で書く場合にはこれを外しておこう。

== page
ページ設定は`page`を使う。今の設定は以下
```typst
#set page(
paper: "a4",
margin: (top: 25mm, bottom: 10mm, inside: 25mm, outside: 15mm),
columns: 1,
numbering: "1",
number-align: top + right,
header: context {
  if header_components.is_even_page() {
    if header_components.is_chapter_page() {
      header_components.header_even_h1()
    } else {
      header_components.header_even_noh1()
    }
  } else {
    if header_components.is_chapter_page() {
      header_components.header_odd_h1()
    } else {
      header_components.header_odd_noh1()
    }
  }
  counter(footnote).update(0)
},
)
```
最終的に製本することを考えて余白をinside/outsideで指定しており、対応してheaderもいろいろ変な設定をしている。
不要と思うのであれば、余白はleft/rightで指定すればいいしheaderの設定もデフォルトに戻せばよい。

あと最後のはfootnoteをページごとに数字リセットするようにする設定。