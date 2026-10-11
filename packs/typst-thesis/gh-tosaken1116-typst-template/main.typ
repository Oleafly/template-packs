#import "libs/cover.typ": cover
#import "libs/abstract.typ": abstract
#import "libs/index.typ": index
#import "libs/config.typ": view
#show: view.with()

// 表紙
#cover()
#counter(page).update(1)
#set page(numbering: "i")

// アブストラクト
#abstract()

// 目次
#index()

#set page(numbering: "1")
#counter(page).update(1)


#let chapters = ("docs/chapters/chapter1.typ",)

#for chapter in (chapters) {
  pagebreak()
  include (chapter)
}


