#import "../base.typ": *
#import "common.typ": *
#import "item.typ": mk_variant, mk_activation
#import "affliction.typ": mk_affliction_inline

#let class_armor = "armor"

#let armor_group = (
  cloth: "Cloth",
  leather: "Leather",
  chain: "Chain",
  composite: "Composite",
  plate: "Plate",
  skeletal: "Skeletal",
  wood: "Wood",
)
#let armor_proficiency = (
  unarmored: "Unarmored",
  light: "Light",
  medium: "Medium",
  heavy: "Heavy",
)
#let new_armor(
  name,
  body,
  price: none,
  ac_bonus: none,
  dex_cap: none,
  check_penalty: none,
  speed_penalty: none,
  bulk: none,
  group: none,
  traits: (),
  short: none,
  level: none,
  proficiency: none,
  strength: none,
  hardness: none,
  hp: none,
  others: (:),
  activations: (),
  plus: false,
  variants: (),
  breakable: false,
  tags: (),
  after: none,
  kind: "Item",
  craft_requirements: none,
  save_bonus: none,
  runes: (),
  spell_lists: (),
  url: none,
  image: none,
  extras: (:),
  short_desc: none,
  afflictions: (),
) = (
  name: name,
  body: body,
  price: price,
  ac_bonus: ac_bonus,
  dex_cap: dex_cap,
  check_penalty: check_penalty,
  speed_penalty: speed_penalty,
  bulk: bulk,
  group: group,
  traits: clean_list(split_traits(traits)),
  class: class_armor,
  short: short,
  level: level,
  proficiency: proficiency,
  strength: strength,
  hardness: hardness,
  hp: hp,
  others: others,
  activations: as_list(activations),
  plus: plus,
  variants: as_list(variants),
  breakable: breakable,
  tags: clean_list(split_traits(tags)),
  after: after,
  kind: kind,
  craft_requirements: craft_requirements,
  save_bonus: save_bonus,
  runes: clean_list(split_traits(runes)),
  spell_lists: spell_lists,
  url: url,
  image: image,
  extras: extras,
  short_desc: short_desc,
  afflictions: as_list(afflictions),
)
#let mk_armor(armor, theme: THEME, breakable: auto, short: (), hide: ()) = {
  itembox(
    armor.name,
    kind: armor.kind,
    level: [#armor.level#if armor.plus == true [+]],
    traits: armor.traits,
    breakable: if breakable == auto { armor.breakable } else { breakable },
    theme: theme,
    hanging: true,
    url: armor.url,
  )[
    #let body = ()
    #if armor.price != none { body.push[*Price* #convert_price(armor.price)] }
    #let line = (
      (
        if armor.proficiency == none { none } else [*Type* #armor.proficiency],
        if armor.ac_bonus == none { none } else [*AC Bonus* #convert_modifier(armor.ac_bonus)],
        if armor.dex_cap == none { none } else [*Dex Cap* #convert_modifier(armor.dex_cap)],
      )
        .filter(it => exists(it))
        .join("; ")
    )
    #body.push(line)
    #let line = (
      (
        if armor.check_penalty == none { none } else [*Check Penalty* #convert_modifier(armor.check_penalty)],
        if armor.speed_penalty == none { none } else [
          *Speed Penalty* #convert_modifier(armor.speed_penalty) #if armor.speed_penalty != 0 [ ft.]
        ],
      )
        .filter(it => exists(it))
        .join("; ")
    )
    #body.push(line)
    #let line = (
      (
        if armor.strength == none { none } else [*Str Requirement* #convert_modifier(armor.strength)],
        if armor.bulk == none { none } else [*Bulk* #convert_bulk(armor.bulk)],
        if armor.group == none { none } else [*Group* #armor.group],
      )
        .filter(it => exists(it))
        .join("; ")
    )
    #body.push(line)
    #let line = ()
    #if exists(armor.hardness) { line.push[*Hardness* #armor.hardness] }
    #if exists(armor.hp) { line.push[*HP(BT)* #armor.hp;(#{ armor.hp / 2 })] }
    #if line.len() > 0 { body.push(line.join("; ")) }
    #if exists(armor.save_bonus) and armor.save_bonus != 0 {
      body.push[*Save Bonus* #convert_modifier(armor.save_bonus)]
    }
    #if exists(armor.runes) { body.push[*Runes* #armor.runes.map(it => lower(it)).join(", ")] }
    #for other in armor.others.keys() { body.push[*#other* #armor.others.at(other)\ ] }
    #let body = body.filter(it => exists(it))
    #body.join(parbreak())
    #if body.len() > 0 { hr() }
    #straight(armor.body)
    #if exists(armor.craft_requirements) [#parbreak()*Craft Requirements* #armor.craft_requirements#parbreak()]
    #if exists(armor.activations) { armor.activations.map(var => mk_activation(var)).join(parbreak()) }
    #let b = ()
    #for spell_list in armor.spell_lists {
      b.push(mk_spell_list(spell_list))
    }
    #for affliction in armor.afflictions {
      b.push(mk_affliction_inline(affliction))
    }
    #let b = b.filter(it => exists(it))
    #if b.len() > 0 {
      hr()
      b.join(parbreak())
    }
    #if exists(armor.after) {
      hr()
      armor.after
    }
    #if exists(armor.variants) {
      hr()
      armor.variants.map(var => mk_variant(var)).join(hr())
    }
  ]
}

#let Armor = (
  new: new_armor,
  make: mk_armor,
  proficiencies: armor_proficiency,
  groups: armor_group,
  class: class_armor,
)
