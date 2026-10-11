#import "style/tsfd_style.typ":*
#import "bib_style/bib_style.typ":*

#show: tsfd_init.with(num: 40, date: "2025年3月4日")
#show: bib_init

#tsfd_title(
  title: [タイトル（和文）],
  title-en: [タイトル（英文）],
  author: (
    (
      author-ja: [著者],
      author-en: [英文著者名],
      author-institution: [株式会社１２３４]
    ),
    (
      author-ja: [共著者],
      author-en: [英文共著者名],
      author-institution: [東京大学生産技術研究所　１２３４系部門]
    ),
    (
      author-ja: [共著者],
      author-en: [英文共著者名],
      author-institution: [株式会社５６７８]
    ),
  ),
)
#show: columns.with(2)

= は~じ~め~に

１２３４５６７８９０１２３４５６７８９０１２３\
１２３４５６７８９０１２３４５６７８９０１２３４５６

#v(30em)

= １２３４５６７

１２３４５６７８９０１２３４５６７８９０１１１１１１１１１１１１１１１１１１１１１１１１１１１１１１１

#v(6em)

== １２３４５６

１２３４５６７８９０１２３４５６７８９０１２３４５１２３４５６７８９０１２３４５６７８９０１２３４５６

#bibliography-list(
    bib-tex[
        @article{sample,
          author = {１２３４ほか2名},
          title = {生産研究},
          volume = {58},
          number = {1},
          year = {2006},
          pages = {49-441},
        }
    ],
)
