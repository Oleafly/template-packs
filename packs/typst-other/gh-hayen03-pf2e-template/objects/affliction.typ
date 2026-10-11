#import "../base.typ": *
#import "common.typ": *

#let class_affliction = "affliction"

#let new_affliction(
  name,
  level: none,
  traits: (),
  save: none,
  dc: none,
  max_duration: none,
  stages: (),
  kind: "Affliction",
  onset: none,
  tags: (),
  others: (:),
  notes: (:),
  url: none,
  extras: (:),
  image: none,
  short_desc: none,
  description: [],
) = (
  name: name,
  class: class_affliction,
  level: level,
  traits: clean_list(split_traits(traits)),
  save: save,
  dc: dc,
  max_duration: max_duration,
  stages: as_list(stages),
  kind: kind,
  onset: onset,
  tags: clean_list(split_traits(tags)),
  others: others,
  notes: notes,
  url: url,
  extras: extras,
  image: image,
  short_desc: short_desc,
  description: description,
)

#let new_stage(body, duration: none) = (
  body: body,
  duration: duration,
)

#let mk_affliction_inline(affliction, short: false) = {
  let prelude = (
    [*#affliction.name*],
    if exists(affliction.traits) [(#affliction.traits.join(", "))],
    if exists(affliction.level) [(level #affliction.level)],
  )
  let save = [*Saving Throw* #(if exists(affliction.save) { affliction.save }, if exists(affliction.dc) [DC #affliction.dc]).filter(exists).join(" ")]
  let parts = (
    if exists(affliction.save) or exists(affliction.dc) { save },
    if exists(affliction.onset) [*Onset* #affliction.onset],
    if exists(affliction.max_duration) [*Maximum Duration* #affliction.max_duration],
  )
  for (i, stage) in affliction.stages.enumerate() {
    parts.push[*Stage #{ i + 1 }* #stage.body#if exists(stage.duration) [ (#stage.duration)]]
  }
  [#prelude.filter(exists).join(" ") #parts.filter(exists).join("; ")]
}

#let mk_affliction(affliction, theme: THEME, breakable: auto, short: (), hide: ()) = {
  itembox(
    affliction.name,
    kind: affliction.kind,
    level: affliction.level,
    traits: affliction.traits,
    breakable: if breakable == auto { false } else { breakable },
    theme: theme,
    hanging: true,
    url: affliction.url,
  )[
    #let save = [*Saving Throw* #(if exists(affliction.save) { affliction.save }, if exists(affliction.dc) [DC #affliction.dc]).filter(exists).join(" ")]
    #let bloc = (
      if exists(affliction.save) or exists(affliction.dc) { save },
      (
        if exists(affliction.onset) [*Onset* #affliction.onset],
        if exists(affliction.max_duration) [*Maximum Duration* #affliction.max_duration],
      )
        .filter(exists)
        .join("; "),
    )
    #for (i, stage) in affliction.stages.enumerate() {
      bloc.push[*Stage #{ i + 1 }* #stage.body#if exists(stage.duration) [ (#stage.duration)]]
    }
    #bloc.filter(exists).join(parbreak())
  ]
}

#let Affliction = (
  new: new_affliction,
  make: mk_affliction,
  stage: new_stage,
  class: class_affliction,
)
