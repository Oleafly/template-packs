#import "../base.typ": *
#import "common.typ": *

#let class_feat = "feat"

#let new_feat(
  name,
  body,
  traits: (),
  actions: none,
  kind: "Feat",
  level: none,
  prerequisites: none,
  trigger: none,
  requirements: none,
  short: none,
  frequency: none,
  others: (:),
  breakable: false,
  tags: (),
  special: none,
  url: none,
  image: none,
  extras: (:),
  short_desc: none,
) = (
  class: class_feat,
  name: name,
  body: body,
  traits: clean_list(split_traits(traits)),
  actions: actions,
  kind: kind,
  level: level,
  prerequisites: prerequisites,
  trigger: trigger,
  requirements: requirements,
  frequency: frequency,
  short: short,
  others: others,
  breakable: breakable,
  tags: clean_list(split_traits(tags)),
  special: special,
  url: url,
  image: image,
  extras: extras,
  short_desc: short_desc,
)
#let mk_feat(feat, theme: THEME, breakable: auto, short: (), hide: ()) = {
  itembox(
    feat.name,
    actions: feat.actions,
    traits: feat.traits,
    kind: feat.kind,
    level: feat.level,
    breakable: if breakable == auto { feat.breakable } else { breakable },
    theme: theme,
    hanging: true,
    url: feat.url,
  )[
    #let bloc = ()
    #if exists(feat.prerequisites) { bloc.push[*Prerequisites* #feat.prerequisites] }
    #if exists(feat.frequency) { bloc.push[*Frequency* #feat.frequency] }
    #if exists(feat.requirements) { bloc.push[*Requirements* #feat.requirements] }
    #if exists(feat.trigger) { bloc.push[*Trigger* #feat.trigger] }
    #for other in feat.others.keys() { bloc.push[*#other* #feat.others.at(other)] }
    #bloc.filter(it => exists(it)).join(parbreak())
    #if bloc.len() > 0 { hr() }
    #straight(feat.body)
    #if exists(feat.special) [#parbreak();*Special* #feat.special]
  ]
}

#let Feat = (
  new: new_feat,
  make: mk_feat,
  class: class_feat,
)
