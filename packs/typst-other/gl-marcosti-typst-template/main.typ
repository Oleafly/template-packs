#import "config.typ" as config

#set document(
  title: config.title,
  author: config.author
)

#set page(
  numbering: config.page_numbering,
)

#pad(y: 40%, align(center, title()))

#outline()

#for section in config.sections {
  pagebreak()
  include "sections/" + section
}
