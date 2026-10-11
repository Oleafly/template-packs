#import "@preview/cades:0.3.1": qr-code
#import "./template.typ": *

#let download-url = "https://example.com/"
#show: book.with(
  title: "象のたまご",
  subtitle: "おいしい象のたまご",
  contact: "contact@nna774.net",
  printer: "最高の印刷所",
  history: (
    ("2038年1月19日", "初版発行"),
  ),
  colophon-before: grid(
    columns: (1fr, auto),
    gutter: 1em,
    align: (left + horizon, right + bottom),
    [
      ここに一言書けるよ。
    ],
  ),
  colophon-extra: grid(
      columns: (1fr, auto),
      gutter: 1em,
      align: (left + horizon, right + bottom),

      [
        PDF版はこのQRコード、または以下のURLからダウンロードできます。\
        #link(download-url)\
        記事中にURLを多用しているので、リンクとなっているPDFもご活用ください。
      ],
      qr-code(download-url, width: 2cm)
    ),
  isdn: "1234567890",
  foreword-file: none // "foreword.typ",
)

// #include "kiji-1.typ"
// #include "kiji-2.typ"

// #pagebreak()

// #include "atogaki.typ"

= 第1章

本文をここに書きます。

```
irb(main):001> require 'securerandom'
=> true
irb(main):002> SecureRandom.send(:choose, "象のたまごはおいしいぞう".chars, 10)
=> "いごはまのおうはのお"
```

`SecureRandom.send(:choose, "象のたまごはおいしいぞう".chars, 10)`

`long long string is long long long string is long long long string is long long long string is long long long string is long long long string is long long long string is long`

- りすと
- あいてむ
- あいてむむ
 - ふかい
 - ふかいい
- あさい

URI: #link("https://nna774.net/img/1012_filtered.jpg")

image #figure(
  image("1012_filtered.jpg", width: 20%),
  caption: [1012 image.],
) <fig>

ほげほげげほげ @fig に言及#footnote[これは脚注]
