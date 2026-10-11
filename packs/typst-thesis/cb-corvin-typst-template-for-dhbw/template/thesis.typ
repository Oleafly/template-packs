#import "layout.typ": setup-layout
#import "titlepage.typ": titlepage
#import "directories.typ": directories
#import "bibliography.typ": render-bibliography
#import "declaration.typ": declaration

#let thesis(meta, body) = {
  titlepage(meta)

  directories(meta)

  setup-layout([

    #body

    #render-bibliography(meta)
  ])
  declaration(meta)
}