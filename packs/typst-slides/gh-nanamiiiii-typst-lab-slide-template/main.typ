#import "@preview/touying:0.7.4": *
#import "theme.typ": kasaken-theme, title-slide

#show: kasaken-theme.with(
  page-title-left: 0.4in,
  config-info(
    title: [タイトル],
    author: [名前],
    institution: [うにょ〜ん],
    date: datetime.today(),
  ),
)

#title-slide()

== ページタイトル
- 1st
  - 2nd
    - 3rd

