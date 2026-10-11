#import "../base.typ": *
#import "common.typ": *

#let class_obstacle = "obstacle"

#let new_obstacle(
  name,
  level: none,
  kind: "Obstacle",
  traits: (),
  tags: (),
  vp: none,
  vp_title: "VP",
  overcome: none,
  body,
  others: (:),
  breakable: false,
  url: none,
  image: none,
  extras: (:),
  short_desc: none,
) = (
  class: class_obstacle,
  name: name,
  level: level,
  kind: kind,
  traits: clean_list(split_traits(traits)),
  tags: clean_list(split_traits(tags)),
  vp: vp,
  vp_title: vp_title,
  overcome: overcome,
  body: body,
  others: others,
  breakable: breakable,
  url: url,
  image: image,
  extras: extras,
  short_desc: short_desc,
)
#let mk_obstacle(obstacle, theme: THEME, short: false, breakable: auto, hide: ()) = {
  itembox(
    obstacle.name,
    level: obstacle.level,
    traits: obstacle.traits,
    kind: obstacle.kind,
    breakable: if breakable == auto { obstacle.breakable } else { breakable },
    theme: theme,
    hanging: true,
    url: obstacle.url,
  )[
    #let bloc = ()
    #let line = (
      if exists(obstacle.vp) and "vp" not in hide [*#obstacle.vp_title* #obstacle.vp],
      if exists(obstacle.overcome) and "overcome" not in hide [*Overcome* #obstacle.overcome],
    )
    #bloc.push(line.filter(it => exists(it)).join("; "))
    #for p in obstacle.others.pairs() {
      bloc.push[*#p.at(0)* #p.at(1)]
    }
    #let bloc = bloc.filter(it => exists(it))
    #bloc.join(parbreak())
    #if bloc.len() > 0 { hr() }
    #straight(obstacle.body)
  ]
}

#let Obstacle = (
  class: class_obstacle,
  new: new_obstacle,
  make: mk_obstacle,
)
