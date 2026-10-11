#import "../base.typ": *
#import "common.typ": *
#import "item.typ": mk_variant, mk_activation
#import "affliction.typ": mk_affliction_inline

#let class_weapon = "weapon" // new

#let weapon_type = (
  ranged: "Ranged",
  melee: "Melee",
)
#let weapon_category = (
  simple: "Simple",
  martial: "Martial",
  advanced: "Advanced",
  improvised: "Improvised",
  unarmed: "Unarmed",
)
#let weapon_group = (
  axe: "Axe",
  bomb: "Bomb",
  bow: "Bow",
  brawling: "Brawling",
  club: "Club",
  crossbow: "Crossbow",
  dart: "Dart",
  firearm: "Firearm",
  flail: "Flail",
  hammer: "Hammer",
  knife: "Knife",
  pick: "Pick",
  polearm: "Polearm",
  shield: "Shield",
  sling: "Sling",
  spear: "Spear",
  sword: "Sword",
)
#let weapon_damage = (
  slashing: "S",
  piercing: "P",
  bludgeoning: "B",
)

#let new_configuration(
  name: none,
  damage: none,
  hands: none,
  range: none,
  reload: none,
  type: none,
  group: none,
  ammo: none,
  traits: (),
  ammo_price: none,
  ammo_bulk: none,
  damage_type: none,
  notes: (:),
  n_dice: 1,
  body: none,
  activations: (),
) = (
  name: name,
  damage: damage,
  damage_type: damage_type,
  n_dice: n_dice,
  type: type,
  group: group,
  hands: hands,
  traits: clean_list(split_traits(traits)),
  range: range,
  reload: reload,
  ammo: ammo,
  ammo_price: ammo_price,
  ammo_bulk: ammo_bulk,
  notes: notes,
  body: body,
  activations: as_list(activations),
)
#let mk_configuration(configuration, theme: THEME, breakable: auto, short: false, hide: false) = {
  let lines = (
    if exists(configuration.name) [*#configuration.name*] else if exists(
      configuration.type,
    ) [*#configuration.type*] else { none },
    if exists(configuration.traits) { print_traits(configuration.traits, theme: theme) } else { none },
    (
      [*Damage* #if exists(configuration.damage) [#configuration.n_dice;d#configuration.damage #if exists(configuration.damage_type) { configuration.damage_type }] else { none }],
      if exists(configuration.hands) [*Hands* #convert_data(configuration.hands)],
    )
      .filter(exists)
      .join("; "),
    (
      if exists(configuration.range) [*Range* #convert_data(configuration.range) ft.],
      if exists(configuration.reload) [*Reload* #convert_data(configuration.reload)],
    )
      .filter(it => exists(it))
      .join("; "),
    (
      if exists(configuration.ammo) [*Ammunition* #convert_data(configuration.ammo)],
      if exists(configuration.ammo_bulk) [*Ammo Bulk* #convert_bulk(configuration.ammo_bulk)],
      if exists(configuration.ammo_price) [*Ammo Price* #convert_price(configuration.ammo_price)],
    )
      .filter(it => it != none)
      .join("; "),
    if exists(configuration.group) [*Group* #configuration.group],
    configuration.body,
  )
  for activation in configuration.activations {
    lines.push(mk_activation(activation))
  }
  lines.filter(exists).join(parbreak())
}

#let new_weapon(
  name,
  body,
  damage: none,
  bulk: none,
  hands: none,
  range: none,
  reload: none,
  type: none,
  category: none,
  group: none,
  ammo: none,
  traits: (),
  level: none,
  price: none,
  ammo_price: none,
  ammo_bulk: none,
  short: none,
  damage_type: none,
  base: none,
  hardness: none,
  hp: none,
  others: (:),
  dc: none,
  activations: (),
  plus: false,
  variants: (),
  notes: (:),
  breakable: false,
  tags: (),
  after: none,
  kind: "Item",
  craft_requirements: none,
  n_dice: 1,
  atk_bonus: none,
  runes: (),
  spell_lists: (),
  url: none,
  configurations: (),
  image: none,
  extras: (:),
  short_desc: none,
  afflictions: (),
) = (
  class: class_weapon,
  name: name,
  body: body,
  damage: damage,
  bulk: bulk,
  hands: hands,
  range: range,
  reload: reload,
  type: type,
  category: category,
  group: group,
  ammo: ammo,
  traits: clean_list(split_traits(traits)),
  level: level,
  price: price,
  ammo_price: ammo_price,
  ammo_bulk: ammo_bulk,
  short: short,
  damage_type: damage_type,
  base: base,
  hardness: hardness,
  hp: hp,
  others: others,
  dc: dc,
  activations: as_list(activations),
  plus: plus,
  variants: as_list(variants),
  notes: notes,
  breakable: breakable,
  tags: clean_list(split_traits(tags)),
  after: after,
  kind: kind,
  craft_requirements: craft_requirements,
  n_dice: n_dice,
  atk_bonus: atk_bonus,
  runes: clean_list(split_traits(runes)),
  spell_lists: spell_lists,
  url: url,
  configurations: as_list(configurations),
  image: image,
  extras: extras,
  short_desc: short_desc,
  afflictions: as_list(afflictions),
)
#let mk_weapon(weapon, theme: THEME, breakable: auto, short: (), hide: ()) = {
  itembox(
    weapon.name,
    kind: weapon.kind,
    level: [#weapon.level#if weapon.plus == true [+]],
    traits: weapon.traits,
    breakable: if breakable == auto { weapon.breakable } else { breakable },
    theme: theme,
    hanging: true,
    url: weapon.url,
  )[
    #let bloc = ()
    #bloc.push(
      (
        if exists(weapon.base) [*Base Weapon* #weapon.base],
        if exists(weapon.price) [*Price* #convert_price(weapon.price)],
      )
        .filter(it => exists(it))
        .join("; "),
    )
    #bloc.push(
      (
        if exists(
          weapon.damage,
        ) [*Damage* #if exists(weapon.damage) [#weapon.n_dice;d#weapon.damage #if exists(weapon.damage_type) { weapon.damage_type }] else { none }],
        [*Bulk* #convert_bulk(weapon.bulk)],
        if exists(weapon.hands) [*Hands* #convert_data(weapon.hands)],
      )
        .filter(exists)
        .join("; "),
    )
    #bloc.push(
      (
        if exists(weapon.range) [*Range* #convert_data(weapon.range) ft.],
        if exists(weapon.reload) [*Reload* #convert_data(weapon.reload)],
      )
        .filter(it => exists(it))
        .join("; "),
    )
    #bloc.push(
      (
        if exists(weapon.type) [*Type* #convert_data(weapon.type)],
        if exists(weapon.category) [*Category* #convert_data(weapon.category)],
        if exists(weapon.group) [*Group* #convert_data(weapon.group)],
      )
        .filter(exists)
        .join("; "),
    )
    #if exists(weapon.ammo) [
      #let line = (
        (
          if weapon.ammo == none { none } else [*Ammunition* #convert_data(weapon.ammo)],
          if weapon.ammo_bulk == none { none } else [*Ammo Bulk* #convert_bulk(weapon.ammo_bulk)],
          if weapon.ammo_price == none { none } else [*Ammo Price* #convert_price(weapon.ammo_price)],
        )
          .filter(it => it != none)
          .join("; ")
      )
      #bloc.push(line)
    ]
    #let line = ()
    #if exists(weapon.hardness) { line.push[*Hardness* #weapon.hardness] }
    #if exists(weapon.hp) { line.push[*HP(BT)* #weapon.hp;(#{ weapon.hp / 2 })] }
    #if exists(weapon.dc) { line.push[*Check Bonus* #convert_modifier(weapon.dc - 10);(DC#weapon.dc)] }
    #bloc.push(line.join("; "))
    #if exists(weapon.atk_bonus) and weapon.atk_bonus != 0 {
      bloc.push[*Attack Bonus* #convert_modifier(weapon.atk_bonus)]
    }
    #if exists(weapon.runes) { bloc.push[*Runes* #weapon.runes.map(it => lower(it)).join(", ")] }
    #for other in weapon.others.keys() { bloc.push[*#other* #weapon.others.at(other)] }
    #bloc.filter(it => exists(it)).join(parbreak())
    #if bloc.len() > 0 { hr() }
    #straight(weapon.body)
    //#weapon.configurations.map(c => mk_configuration(c, theme: theme, breakable: breakable)).filter(exists).join(hr())
    #if exists(weapon.craft_requirements) [#parbreak()*Craft Requirements* #weapon.craft_requirements#parbreak()]
    #if exists(weapon.activations) { weapon.activations.map(var => mk_activation(var)).join(parbreak()) }
    #let b = ()
    #for spell_list in weapon.spell_lists {
      b.push(mk_spell_list(spell_list))
    }
    #for affliction in weapon.afflictions {
      b.push(mk_affliction_inline(affliction))
    }
    #let b = b.filter(it => exists(it))
    #if b.len() > 0 {
      hr()
      b.join(parbreak())
    }
    #if exists(weapon.after) {
      hr()
      weapon.after
    }
    #if weapon.configurations.len() > 0 {
      hr()
      weapon.configurations.map(var => mk_configuration(var)).join(hr())
    }
    #if exists(weapon.variants) {
      hr()
      weapon.variants.map(var => mk_variant(var)).join(hr())
    }
  ]
}

#let Weapon = (
  new: new_weapon,
  make: mk_weapon,
  categories: weapon_category,
  damages: weapon_damage,
  groups: weapon_group,
  types: weapon_type,
  class: class_weapon,
  hands: (
    zero: 0,
    one: 1,
    one_plus: [1+],
    two: 2,
  ),
)
