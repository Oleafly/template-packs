#import "../base.typ": *
#import "common.typ": *
#import "spell.typ": mk_spell_list
#import "affliction.typ": mk_affliction_inline

#let class_item = "item"
#let class_variant = "variant"
#let class_activation = "activation"

#let item_grades = (
  minor: "Minor",
  lesser: "Lesser",
  moderate: "Moderate",
  greater: "Greater",
  major: "Major",
  "true": "True",
)

#let new_item(
  name,
  body,
  price: none,
  bulk: none,
  usage: none,
  activate: none,
  level: none,
  traits: (),
  variants: (),
  dc: none,
  short: none,
  variant: none,
  kind: "Item",
  plus: false,
  requirements: none,
  activations: (),
  others: (:),
  hardness: none,
  hp: none,
  notes: (:),
  breakable: false,
  tags: (),
  after: none,
  craft_requirements: none,
  runes: (),
  spell_lists: (),
  url: none,
  extras: (:),
  image: none,
  short_desc: none,
  afflictions: (),
) = (
  class: class_item,
  variant: variant,
  name: name,
  body: body,
  price: price,
  bulk: bulk,
  usage: usage,
  activate: activate,
  level: level,
  traits: clean_list(split_traits(traits)),
  variants: as_list(variants),
  dc: dc,
  short: short,
  kind: kind,
  plus: plus,
  requirements: requirements,
  activations: as_list(activations),
  others: others,
  hardness: hardness,
  hp: hp,
  notes: notes,
  breakable: breakable,
  tags: clean_list(split_traits(tags)),
  after: after,
  craft_requirements: craft_requirements,
  runes: clean_list(split_traits(runes)),
  spell_lists: spell_lists,
  url: url,
  image: image,
  extras: extras,
  short_desc: short_desc,
  afflictions: as_list(afflictions),
)
#let new_activation(
  name: none,
  actions: a,
  traits: (),
  frequency: none,
  requirements: none,
  trigger: none,
  prerequisites: none,
  duration: none,
  body,
  notes: (:),
  tags: (),
  url: none,
  image: none,
  extras: (:),
  cost: none,
  short_desc: none,
) = (
  class: class_activation,
  name: name,
  actions: actions,
  traits: clean_list(split_traits(traits)),
  frequency: frequency,
  requirements: requirements,
  trigger: trigger,
  prerequisites: prerequisites,
  body: body,
  duration: duration,
  notes: notes,
  tags: clean_list(split_traits(tags)),
  url: url,
  image: image,
  extras: extras,
  cost: cost,
  short_desc: short_desc,
)
#let new_variant(
  name,
  body,
  dc: none,
  price: none,
  bulk: none,
  usage: none,
  level: none,
  short: none,
  hardness: none,
  hp: none,
  others: (:),
  notes: (:),
  tags: (),
  craft_requirements: none,
  ac: none,
  url: none,
  image: none,
  extras: (:),
  spell_lists: (),
  activations: (),
  short_desc: none,
  afflictions: (),
) = (
  class: class_variant,
  name: name,
  body: body,
  dc: dc,
  price: price,
  bulk: bulk,
  usage: usage,
  level: level,
  short: short,
  hardness: hardness,
  hp: hp,
  others: others,
  notes: notes,
  tags: clean_list(split_traits(tags)),
  craft_requirements: craft_requirements,
  ac: ac,
  url: url,
  image: image,
  extras: extras,
  spell_lists: as_list(spell_lists),
  activations: as_list(activations),
  short_desc: short_desc,
  afflictions: as_list(afflictions),
)
#let mk_activation(activation, theme: THEME, breakable: auto, short: false, hide: false) = {
  let name = [Activation#if exists(activation.name) [---#activation.name]]
  let pre = (activation.actions,)
  if exists(activation.traits) { pre.push[(#activation.traits.join(", "))] }
  if (
    short == true
  ) [*#if exists(activation.url) { link(activation.url, name) } else { name }* #pre.filter(it => exists(it)).join(" ")] else {
    let body = ()
    if exists(activation.prerequisites) { body.push([ *Prerequisites* #activation.prerequisites]) }
    if exists(activation.requirements) { body.push([ *Requirements* #activation.requirements]) }
    if exists(activation.frequency) { body.push([ *Frequency* #activation.frequency]) }
    if exists(activation.duration) { body.push([ *Duration* #activation.duration]) }
    if exists(activation.trigger) { body.push([ *Trigger* #activation.trigger]) }
    if exists(activation.cost) { body.push([ *Cost* #activation.cost]) }
    if exists(activation.body) { body.push([#if body.len() > 0 [*Effect*] #activation.body]) }
    body = body.filter(it => exists(it))
    pre = pre.filter(it => exists(it))
    [*#name*#if exists(pre) [ #pre.join(" ")]#if not exists(activation.traits) and body.len() > 0 [;]#body.join("; ")]
  }
}
#let mk_variant(variant, theme: THEME, breakable: auto, short: false, hide: false) = {
  [
    #let bloc = ()
    #bloc.push(
      (
        if not exists(variant.name) { none } else if type(variant.name)
          == int [*Rank* #convert_rank(if exists(url) { link(url, variant.name) } else { variant.name })] else [*#if variant.name in item_grades.values() [Grade] else [Type]* #if exists(url) { link(url, variant.name) } else { variant.name }],
        if not exists(variant.bulk) {
          none
        } else [*Bulk* #convert_bulk(variant.bulk)#if "bulk" in variant.notes [ (#variant.notes.bulk)]],
        if not exists(variant.price) {
          none
        } else [*Price* #convert_price(variant.price)#if "price" in variant.notes [ (#variant.notes.price)]],
        if not exists(variant.level) {
          none
        } else [*Level* #convert_data(variant.level)#if "level" in variant.notes [ (#variant.notes.level)]],
      )
        .filter(it => exists(it))
        .join("; "),
    )
    #bloc.push(
      (
        if variant.usage == none { none } else [*Usage* #variant.usage],
      )
        .filter(it => exists(it))
        .join("; "),
    )
    #if exists(variant.dc) { bloc.push[*Check Bonus* #convert_modifier(variant.dc - 10) (DC #variant.dc)] }
    #bloc.push(
      (
        if exists(variant.ac) [*AC* #variant.ac#if "ac" in variant.notes [ (#variant.notes.ac)]] else { none },
        if not exists(variant.hardness) {
          none
        } else [*Hardness* #variant.hardness#if "hardness" in variant.notes [ (#variant.notes.hardness)]],
        if not exists(variant.hp) {
          none
        } else [*HP(BT)* #variant.hp;(#{ variant.hp / 2 })#if "hp" in variant.notes [ (#variant.notes.hp)]],
      )
        .filter(it => exists(it))
        .join("; "),
    )
    #for other in variant.others.keys() { bloc.push[*#other* #variant.others.at(other)] }
    #if exists(variant.craft_requirements) { bloc.push[*Craft Requirements* #variant.craft_requirements] }
    #bloc.push(straight(variant.body))
    #for activation in variant.activations {
      bloc.push(mk_activation(activation))
    }
    #for spell_list in variant.spell_lists {
      bloc.push(mk_spell_list(spell_list))
    }
    #for affliction in variant.afflictions {
      bloc.push(mk_affliction_inline(affliction))
    }
    #bloc.filter(it => exists(it)).join(parbreak())
  ]
}
#let mk_item(item, theme: THEME, breakable: auto, short: false, hide: ()) = {
  itembox(
    [#item.name#if exists(item.variant) [ (#item.variant)]],
    kind: item.kind,
    level: [#item.level#if item.plus == true [+]],
    traits: item.traits,
    breakable: if breakable == auto { item.breakable } else { breakable },
    theme: theme,
    hanging: true,
    url: item.url,
  )[
    #let bloc = ()
    #if exists(item.price) {
      bloc.push[*Price* #convert_price(item.price)#if "price" in item.notes [ (#item.notes.price)]]
    }
    #bloc.push(
      (
        if not exists(item.usage) { none } else [*Usage* #convert_data(item.usage)],
        if not exists(item.bulk) {
          none
        } else [*Bulk* #convert_bulk(item.bulk)#if "bulk" in item.notes [ (#item.notes.bulk)]],
      )
        .filter(it => exists(it))
        .join("; "),
    )
    #if exists(item.dc) {
      bloc.push[*Check Bonus* #convert_modifier(item.dc - 10) (DC #item.dc)#if "dc" in item.notes [ (#item.notes.dc)]]
    }
    #for key in item.others.keys() { bloc.push[*#key* #item.others.at(key)] }
    #if exists(item.activate) { bloc.push[*Activate* #item.activate] }
    #if exists(item.requirements) { bloc.push[*Requirements* #item.requirements] }
    #bloc.push(
      (
        if exists(
          item.hardness,
        ) [*Hardness* #item.hardness#if "hardness" in item.notes [ (#item.notes.hardness)]] else { none },
        if exists(item.hp) [*HP(BT)* #item.hp;(#{ item.hp / 2 })#if "hp" in item.notes [ (#item.notes.hp)]] else {
          none
        },
      )
        .filter(it => exists(it))
        .join("; "),
    )
    #let bloc = bloc.filter(it => exists(it))
    #if exists(item.runes) { bloc.push[*Runes* #item.runes.map(it => lower(it)).join(", ")] }
    #bloc.join(parbreak())
    #if bloc.len() > 0 { hr() }
    #straight(item.body)
    #if exists(item.craft_requirements) [#parbreak()*Craft Requirements* #item.craft_requirements#parbreak()]
    #if exists(item.activations) { item.activations.map(var => mk_activation(var)).join(parbreak()) }
    #let b = ()
    #for spell_list in item.spell_lists {
      b.push(mk_spell_list(spell_list))
    }
    #for affliction in item.afflictions {
      b.push(mk_affliction_inline(affliction))
    }
    #let b = b.filter(it => exists(it))
    #if b.len() > 0 {
      hr()
      b.join(parbreak())
    }
    #if exists(item.after) {
      hr()
      item.after
    }
    #if exists(item.variants) {
      hr()
      item.variants.map(var => mk_item_variant(var)).join(hr())
    }
  ]
}

#let Item = (
  new: new_item,
  variant: (
    new: new_variant,
    class: class_variant,
    make: mk_variant,
  ),
  activation: (
    new: new_activation,
    class: class_activation,
    make: mk_activation,
  ),
  make: mk_item,
  grades: item_grades,
  class: class_item,
)
