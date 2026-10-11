#import "../theme/template.typ": *

= 応用
本章では特に必須ではないが筆者が修論執筆において使用した、あるいはテンプレ整備時に見つけたテクニックを紹介する。


== 目次いじり
筆者は修論において目次を結構いじっていた。本テンプレではとりあえず色を出さずデフォルト設定を採用しているが、筆者と似たような拘りを持つ人がいた場合に参考になればという思いで、それらをまとめておく。
#v(1em)
要件は以下の3点である:
- チャプターごとにスペースを入れる
- 目次において「第1章 タイトル ......... 1」の点線はlevel 1に対しては不要
  - こいつらはまあ、見やすさの問題
- 図目次、表目次において「図 1.1」とかじゃなく「1.1」と表示する
  - 図目次なんだから図なのは明確じゃん。


=== チャプターごとにスペース+点線一部削除
これは容易。outlineへのエントリのうちlevel 1であるものに対して次のように設定すれば良い。
```typst
#show outline.entry.where(level: 1): set block(above: 1.5em)
#show outline.entry.where(level: 1): set outline.entry(fill: none)
```
#[
  #show outline.entry.where(level: 1): set block(above: 1.5em)
  #show outline.entry.where(level: 1): set outline.entry(fill: none)
  #block(inset: 15pt, stroke: blue)[#outline(title: none, depth: 2)]
]

どう？結構スッキリしててよくない？筆者はこれが好み。

ちなみに今level3のheadingが消えて表示されているのは、depthオプションを指定したから。
```typst
#outline(title: none, depth: 2)
```


=== 図1.1 → 1.1
これが結構大変だった。さっきの設定のまま同様に図目次を見せると状況がわかる。
#[
  #show outline.entry.where(level: 1): set block(above: 1.5em)
  #show outline.entry.where(level: 1): set outline.entry(fill: none)
  #block(inset: 15pt, stroke: blue)[#outline(title: none, target: figure.where(kind: image))]
]
うん、*全部level 1だね*。当然こんなスカスカの目次を作りたいわけないので、先ほどのようにチャプターごとに空白ってのをやりたければ自力でチャプターの切れ目を探してくる必要がある。いうてもチャプターが変わるごとにカウンタをリセットするようにしてあるので、下の番号が1かどうかを見ればよいのでこれは容易。

もう一点、「図 1.1」の「図」だけ外すというのが意外とめんどくさい。単にoutlineを表示する際に`set figure(supplement: none)`とすればいいように思うかもしれないが、outlineは文書内にあるfigureをクエリして拾ってくるものなので今更setしたところで表示されるものは同じである。そのためentryに対して自らshowルールを適用する他ない(と筆者は思っている)。そしてその際、チャプター番号は本文では数字、付録ではアルファベットなので、そこが本文か付録かの判定を行う必要がある。この判定は各figureの位置するチャプターを拾ってきてそのナンバリングのタイプがfunctionかstrかを見ることによって可能
#footnote[
  余談。当初は本文か付録かの判定に"is-app"というstate関数を使用していた。文書内のfigureをクエリして各エントリとその直前のfigureについてチャプター番号を取得して比較、減少した時にfalseからtrueに変更するという具合であった。実は筆者の修論ではこの手法が採用されていたのだが、本テンプレを作成するにあたり、
  - 本文(の最後にfigureが登場する章)がN章
  - 付録でfigureが初めて登場するのがN番目
  である状態において先のチャプター番号比較を通過してしまい、例えば図2.1の次が図B.1であるときにB.1でなく再び2.1になってしまうというバグがあることに気付いた。そんな謎構成の修論を書く人はきっといないだろうが、一応修正しておいた。
]。

実装は以下
#footnote[
  余談その2。outlineの見せ方においてlinkを使うようにしたが、linkはmain-templateの中において青文字+下線で表示するようにしたのでここでは改めて`#show link: it => it.body`することでshowをリセットした。実際の運用にあたっては、outlineはmain-templateの前にのみ登場するのでここは不要である。
]。使いたければstate.typでoutlineを実行する前にこのshowルールを適用すれば良い。

```typst
#show outline.entry: it => context {
    let loc = it.element.location()
    let current_chapter = query(heading.where(level: 1).before(loc)).last()
    let chapter_num = if type(current_chapter.numbering) == function {
      counter(heading).at(it.element.location()).at(0)
    } else if type(current_chapter.numbering) == str {
      let app_num = counter(heading).at(it.element.location()).at(0)
      numbering("A", app_num)
    } else {"panic!!"}
    let fignum = numbering("1.1", ..it.element.counter.at(loc))

    if fignum == "1" {v(1em)}
    link(it.element.location(), it.indented(
      [#chapter_num] + "." + [#fignum],
      it.inner()
    ))
  }
  #block(inset: 15pt)[
    #show link: it => it.body
    #outline(title: none, target: figure.where(kind: image))
  ]
```

#block(stroke: blue, inset: 5pt)[
  #show outline.entry: it => context {
    let loc = it.element.location()
    let current_chapter = query(heading.where(level: 1).before(loc)).last()
    let chapter_num = if type(current_chapter.numbering) == function {
      counter(heading).at(it.element.location()).at(0)
    } else if type(current_chapter.numbering) == str {
      let app_num = counter(heading).at(it.element.location()).at(0)
      numbering("A", app_num)
    } else {"panic!!"}
    let fignum = numbering("1.1", ..it.element.counter.at(loc))

    if fignum == "1" {v(1em)}
    link(it.element.location(), it.indented(
      [#chapter_num] + "." + [#fignum],
      it.inner()
    ))
  }
  #block(inset: 15pt)[
    #show link: it => it.body
    #outline(title: none, target: figure.where(kind: image))
  ]
]


== footnoteいじり
どうでもいいが自分はfootnoteで結構遊んでいた。デフォルトだと#footnote[数字]こうなるが、ここは標準でいろいろ遊べる。
#set footnote(numbering: "①")
例えば`#set footnote(numbering: "①")`とすれば#footnote[丸数字]になるし、他にも
#set footnote(numbering: "१")
`#set footnote(numbering: "१")`とすれば#footnote[何数字だよこれ]になる。

自分の修論では、
#set footnote(numbering: (..arg) => {
  let daiji = ([壱], [弍], [参], [肆], [伍], [陸], [漆], [捌], [玖], [拾])
  let idx = arg.pos().at(0) - 1
  if idx > 9 { [拾] + daiji.at(idx - 10) } else { daiji.at(idx) }
})
```typst
#set footnote(numbering: (..arg) => {
  let daiji = ([壱], [弍], [参], [肆], [伍], [陸], [漆], [捌], [玖], [拾])
  let idx = arg.pos().at(0) - 1
  if idx > 9 { [拾] + daiji.at(idx - 10) } else { daiji.at(idx) }
})
```
として大字を用いていた#footnote[ぶっちゃけ1ページに10個も脚注しねえしidx>9の設定は不要ではある。]。

なんとこれを応用して、例えばインデックスにテキストでなくimageを用いることだって可能。
```typst
#set footnote(numbering: (..arg) => {
  let image = (image("../fig/test.jpg", width: 20pt), [弍], [参], [肆], [伍], [陸], [漆], [捌], [玖], [拾])
  let idx = arg.pos().at(0) - 1
  image.at(idx)
})
```
#set footnote(numbering: (..arg) => {
  let image = (image("../fig/test.jpg", width: 20pt), [弍], [参], [肆], [伍], [陸], [漆], [捌], [玖], [拾])
  let idx = arg.pos().at(0) - 1
  image.at(idx)
})
結果#footnote[あああ]
キッショ。流石にこれは使うことないな。


#figure(image("../fig/test.jpg"), caption: flex_caption()[appfig_test][図目次テスト用の図])
#figure(table([]), caption: flex_caption()[apptable_test][表目次テスト用の表])
