#import "../base.typ": *
#import "common.typ": *
#import "item.typ": mk_variant, mk_activation
#import "affliction.typ": mk_affliction_inline

#let class_shield = "shield"

#let new_shield(
  name,
  body,
  traits: (),
  price: none,
  ac_bonus: none,
  speed_penalty: none,
  bulk: none,
  hardness: none,
  hp: none,
  level: none,
  short: none,
  others: (:),
  activations: (),
  plus: false,
  variants: (),
  breakable: false,
  tags: (),
  after: none,
  craft_requirements: none,
  runes: (),
  spell_lists: (),
  url: none,
  image: none,
  extras: (:),
  short_desc: none,
  afflictions: (),
) = (
  class: class_shield,
  name: name,
  body: body,
  traits: clean_list(split_traits(traits)),
  price: price,
  ac_bonus: ac_bonus,
  speed_penalty: speed_penalty,
  bulk: bulk,
  hardness: hardness,
  hp: hp,
  level: level,
  short: short,
  others: others,
  activations: as_list(activations),
  plus: plus,
  variants: as_list(variants),
  breakable: breakable,
  tags: clean_list(split_traits(tags)),
  after: after,
  kind: "Item",
  craft_requirements: craft_requirements,
  runes: clean_list(split_traits(runes)),
  spell_lists: spell_lists,
  url: url,
  image: image,
  extras: extras,
  short_desc: short_desc,
  afflictions: as_list(afflictions),
)
#let mk_shield(shield, theme: THEME, breakable: auto, short: (), hide: ()) = {
  itembox(
    shield.name,
    traits: shield.traits,
    level: [#shield.level#if shield.plus == true [+]],
    kind: shield.kind,
    breakable: if breakable == auto { shield.breakable } else { breakable },
    theme: theme,
    hanging: true,
    url: shield.url,
  )[
    #let body = ()
    #if exists(shield.price) { body.push[*Price* #convert_price(shield.price)] }
    #let line = ()
    #if exists(shield.ac_bonus) { line.push[*AC Bonus* #convert_modifier(shield.ac_bonus)] }
    #if exists(shield.speed_penalty) { line.push[*Speed Penalty* #convert_modifier(shield.speed_penalty)] }
    #if exists(shield.bulk) { line.push[*Bulk* #convert_bulk(shield.bulk)] }
    #body.push(line.filter(it => exists(it)).join("; "))
    #let line = ()
    #if exists(shield.hardness) { line.push[*Hardness* #shield.hardness] }
    #if exists(shield.hp) {
      line.push[*HP(BT)* #{
          let hp = shield.hp
          if hp == none { null } else {
            let hp = calc.floor(calc.abs(hp))
            let bt = hp / 2
            [#hp\(#bt)]
          }
        }]
    }
    #body.push(line.filter(it => exists(it)).join("; "))
    #for other in shield.others.keys() { body.push[*#other* #shield.others.at(other)] }
    #let body = body.filter(it => exists(it))
    #if exists(shield.runes) { bloc.push[*Runes* #shield.runes.map(it => lower(it)).join(", ")] }
    #body.join(parbreak())
    #if body.len() > 0 { hr() }
    #straight(shield.body)
    #if exists(shield.craft_requirements) [#parbreak()*Craft Requirements* #shield.craft_requirements#parbreak()]
    #if exists(shield.activations) { shield.activations.map(var => mk_activation(var)).join(parbreak()) }
    #let b = ()
    #for spell_list in shield.spell_lists {
      b.push(mk_spell_list(spell_list))
    }
    #for affliction in shield.afflictions {
      b.push(mk_affliction_inline(affliction))
    }
    #let b = b.filter(it => exists(it))
    #if b.len() > 0 {
      hr()
      b.join(parbreak())
    }
    #if exists(shield.after) {
      hr()
      shield.after
    }
    #if exists(shield.variants) {
      hr()
      shield.variants.map(var => mk_variant(var)).join(hr())
    }
  ]
}

#let Shield = (
  new: new_shield,
  make: mk_shield,
  class: class_shield,
)
