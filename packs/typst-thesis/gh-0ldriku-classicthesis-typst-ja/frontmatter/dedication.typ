#import "../lib.typ": *
#let dedication_page(content) = {
  set page(margin: 3cm, header: none, footer: none)
  v(1fr)
  align(center, content)
  v(1fr)
}

#dedication_page[
  _To the user of this template: \
  May your compile errors be few \
  and your discoveries be many. \
  (Replace this text with your own dedication)_
]
