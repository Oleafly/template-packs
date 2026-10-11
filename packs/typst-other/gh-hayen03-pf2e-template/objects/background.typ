#import "../base.typ": *
#import "common.typ": *

#let class_background = "background"

#let new_background(
  name,
  body,
  traits: (),
  short: none,
  tags: (),
  breakable: false,
  kind: "Background",
  url: none,
  image: none,
  extras: (:),
  short_desc: none,
) = (
  class: class_background,
  name: name,
  body: body,
  traits: clean_list(split_traits(traits)),
  short: short,
  tags: clean_list(split_traits(tags)),
  breakable: breakable,
  kind: kind,
  url: url,
  image: image,
  extras: extras,
  short_desc: short_desc,
)
#let mk_background(background, theme: THEME, breakable: auto, short: (), hide: ()) = {
  itembox(
    background.name,
    background.body,
    traits: background.traits,
    kind: background.kind,
    theme: theme,
    breakable: if breakable == auto { background.breakable } else { breakable },
    url: background.url,
  )
}

#let Background = (
  class: class_background,
  new: new_background,
  make: mk_background,
)
