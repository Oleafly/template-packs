#import "../settings/macros.typ": *

// style.typ から conf 関数をインポート
#import "../settings/style.typ": conf
#import "@preview/codelst:2.0.2": sourcecode

// ここでドキュメント全体に conf を適用
#show: conf

#report-title("Example", "学籍番号", "名前")
= h1
== h2
===  h3
数式は $E= m c ^ 2$ のようにインラインで書けます。
また、独立した数式は以下のように表示されます。
$ E = m c^2 $


- unordered list 1

+ ordered list 1

#figure(
  caption: [time.html],
  numbering: none,
  sourcecode[```html
  <!DOCTYPE html>
  <html>
  <h1>このようにかけるよ</h1>
  </html>
  ```]
)

@fig:arrow のように参照できる
#figure(
  image("../assets/arrow.png", width: 30%),
  caption: [arrow image],
)<fig:arrow>