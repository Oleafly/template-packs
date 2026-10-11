#import "style/style.typ": init, contents-style, chapter-style, print-chap-header, insert-cover, insert-title-page, colophon

#let book-title = "苦行同人誌"
#let book-author = "苦行同人誌倶楽部"
#let book-contact = "X: author1(@hogehogehogexxx), author2(@piyopiyohogehoge12)"
#let book-publisher = "Tom"
#let book-edition = "初版"
#let book-printing = "第一刷"
#let book-publish-date = datetime(year: 2026, month: 1, day: 25)

// 各種設定
#show: init

//表紙生成
#insert-cover("/images/covers/top.png")

#show: contents-style

//扉表紙
#insert-title-page(
  title: book-title,
  author: book-author,
  date: book-publish-date
)

//空白ページ
#pagebreak()

//まえがきページ
#set heading(numbering: none)
#include "preface.typ"


// もくじ生成
#show: chapter-style
#outline(title: "目次", indent: auto)
#pagebreak()

// 各章の連結(include)
#print-chap-header(include "chap1.typ")
#pagebreak()
#print-chap-header(include "chap2.typ")
#pagebreak()
#print-chap-header(include "chap3.typ")
#pagebreak()

//あとがきページ
#set heading(numbering: none)
#include "afterword.typ"

#page(numbering: none)[
  #colophon(
    title: book-title,
    edition: book-edition,
    printing: book-printing,
    author: book-author,
    contact: book-contact,
    publisher: book-publisher,
    date: book-publish-date
  )]

//裏表紙生成
#insert-cover("/images/covers/back.png")