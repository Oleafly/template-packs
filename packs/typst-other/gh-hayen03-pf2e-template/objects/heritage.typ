#import "../base.typ": *
#import "common.typ": *

#let class_heritage = "heritage"

#let new_heritage(
  name,
  body,
  traits: (),
  short: none,
  tags: (),
  breakable: true,
  addons: (),
  url: none,
  image: none,
  extras: (:),
  short_desc: none,
) = (
  class: class_heritage,
  name: name,
  body: body,
  traits: clean_list(split_traits(traits)),
  short: short,
  tags: clean_list(split_traits(tags)),
  breakable: breakable,
  addons: as_list(addons),
  url: url,
  image: image,
  extras: extras,
  short_desc: short_desc,
)
#let mk_heritage(heritage, theme: THEME, breakable: auto, short: (), hide: ()) = {
  block(
    breakable: if breakable == auto { heritage.breakable } else { breakable },
    {
      heading(
        if exists(heritage.url) { link(heritage.url, heritage.name) } else { heritage.name },
        depth: 2,
        bookmarked: false,
        outlined: false,
      )
      print_traits(heritage.traits, theme: theme)
      if exists(heritage.traits) { parbreak() }
      heritage.body
    },
  )
  [#heritage.addons.join(parbreak())]
}

#let Heritage = (
  class: class_heritage,
  new: new_heritage,
  make: mk_heritage,
)
