#import "../base.typ": *
#import "common.typ": *

#let class_spell = "spell"
#let class_spell_list = "spell_list"
#let class_spellcasting = "spellcasting"

#let spell_tradition = (
  occult: "Occult",
  divine: "Divine",
  arcane: "Arcane",
  primal: "Primal",
)
#let spell_type = (
  spontaneous: "Spontaneous",
  prepared: "Prepared",
  innate: "Innate",
  focus: "Focus",
  ritual: "Ritual",
)

#let new_spell(
  name,
  body,
  actions: none,
  traditions: (),
  rank: none,
  traits: (),
  range: none,
  target: none,
  area: none,
  duration: none,
  save: none,
  locus: none,
  cost: none,
  prerequisites: none,
  trigger: none,
  requirements: none,
  short: none,
  spell_lists: (),
  defense: none,
  kind: "Spell",
  others: (:),
  heightened: (:),
  breakable: false,
  tags: (),
  url: none,
  image: none,
  extras: (:),
  short_desc: none,
) = (
  class: class_spell,
  name: name,
  body: body,
  actions: actions,
  traditions: clean_list(split_traits(traditions)),
  spell_lists: clean_list(split_traits(spell_lists)),
  rank: rank,
  traits: clean_list(split_traits(traits)),
  range: range,
  target: target,
  area: area,
  duration: duration,
  save: save,
  locus: locus,
  cost: cost,
  prerequisites: prerequisites,
  trigger: trigger,
  requirements: requirements,
  short: short,
  defense: defense,
  kind: kind,
  others: others,
  heightened: heightened,
  breakable: breakable,
  tags: clean_list(split_traits(tags)),
  url: url,
  image: image,
  extras: extras,
  short_desc: short_desc,
)
#let mk_spell(spell, theme: THEME, breakable: auto, short: (), hide: ()) = {
  let tradition = {
    let tmp = spell.traditions
    if tmp == none or tmp == () { none } else if type(tmp) == array { tmp.join(", ") } else { tmp }
  }
  let spell_lists = {
    let tmp = spell.spell_lists
    if tmp == none or tmp == () { none } else if type(tmp) == array { tmp.join(", ") } else { tmp }
  }
  itembox(
    spell.name,
    level: spell.rank,
    traits: spell.traits,
    kind: spell.kind,
    actions: spell.actions,
    breakable: if breakable == auto { spell.breakable } else { breakable },
    theme: theme,
    hanging: true,
    url: spell.url,
  )[
    #let body = ()
    #if exists(spell.prerequisites) { body.push[*Prerequisites* #spell.prerequisites] }
    #if exists(tradition) { body.push[*Traditions* #tradition] }
    #if exists(spell_lists) { body.push[*Spell Lists* #spell_lists] }
    #let line = (
      (
        if exists(spell.locus) [*Loci* #spell.locus],
        if exists(spell.cost) [*Cost* #spell.cost],
      )
        .filter(it => exists(it))
        .join("; ")
    )
    #body.push(line)
    #let line = (
      (
        if exists(spell.range) [*Range* #spell.range],
        if exists(spell.area) [*Area* #spell.area],
        if exists(spell.target) [*Targets* #spell.target],
      )
        .filter(it => exists(it))
        .join("; ")
    )
    #body.push(line)
    #if exists(spell.trigger) { body.push[*Trigger* #spell.trigger] }
    #let line = (
      (
        if exists(spell.save) [*Saving Throw* #spell.save],
        if exists(spell.defense) [*Defense* #spell.defense],
        if exists(spell.duration) [*Duration* #spell.duration],
      )
        .filter(it => exists(it))
        .join("; ")
    )
    #body.push(line)
    #if exists(spell.requirements) { body.push[*Requirements* #spell.requirements] }
    #for other in spell.others.keys() { body.push[*#other* #spell.others.at(other)] }
    #let body = body.filter(it => exists(it))
    #body.join(parbreak())
    #if body.len() > 0 { hr() }
    #straight(spell.body)
    #if spell.heightened.len() > 0 {
      hr()
      spell.heightened.pairs().map(pair => [*Heightened (#pair.at(0))* #pair.at(1)]).join(parbreak())
    }
  ]
}

#let new_spellcasting(
  tradition: none,
  note: none,
  dc: 10,
  heightened: auto,
  spell_lists: (),
  type: none,
  focus: none,
  image: none,
  extras: (:),
  short_desc: none,
) = (
  class: class_spellcasting,
  tradition: tradition,
  note: note,
  dc: dc,
  heightened: heightened,
  spell_lists: as_list(spell_lists),
  type: type,
  focus: focus,
  image: image,
  extras: extras,
  short_desc: short_desc,
)
#let spell_use(name, uses: none, url: none) = ("name": name, "uses": uses, url: url)
#let new_spell_list(..spells, slots: none, rank: 0, notes: (:), heightened: none) = {
  let new_spells = (:)
  for spell in spells.pos() {
    let s = if type(spell) == str or type(spell) == content {
      spell_use(spell, uses: 1)
    } else if type(spell) == array {
      spell_use(
        spell.at(0),
        uses: if spell.len() > 1 { spell.at(1) } else { none },
        url: if spell.len() > 2 { spell.at(2) } else { none },
      )
    } else {
      spell
    }
    if s.name in new_spells.keys() {
      new_spells.insert(s.name, spell_use(s.name, uses: s.uses + new_spells.at(s.name)))
    } else {
      new_spells.insert(s.name, s)
    }
  }
  (
    class: class_spell_list,
    slots: slots,
    spells: new_spells,
    rank: rank,
    notes: notes,
    heightened: heightened,
  )
}
#let mk_spell_use(
  spell_use,
  note: none,
) = [_#if exists(spell_use.url) { link(spell_use.url, spell_use.name) } else { spell_use.name };_#if exists(note) [ (#note)]#if spell_use.uses != none { if type(spell_use.uses) == int and spell_use.uses > 1 [ (#spell_use.uses/day)] else if not type(spell_use.uses) == int [ (#spell_use.uses)] }]
#let mk_spell_list(spell_list, heightened: auto, theme: THEME, breakable: auto, short: (), hide: ()) = {
  let h = if heightened == auto and spell_list.heightened == auto { none } else if spell_list.heightened == auto {
    heightened
  } else if heightened == auto { spell_list.heightened } else if exists(spell_list.heightened) {
    spell_list.heightened
  } else { heightened }
  let rank = if (
    spell_list.rank == 0
  ) [*Cantrip #if h != none [(#convert_rank(h))]*] else [*#convert_rank(spell_list.rank)*]
  let spells = ()
  for spell in spell_list.spells.values().sorted(key: s => s.name) {
    let note = if spell.name in spell_list.notes { spell_list.notes.at(spell.name) } else { none }
    spells.push(mk_spell_use(spell, note: note))
  }
  let slots = if spell_list.slots == 0 or spell_list.slots == none { none } else [ (#spell_list.slots slots)]
  [#rank #spells.join(", ");#slots]
}
#let mk_spellcasting(spellcasting, heightened: auto, theme: THEME, breakable: auto, short: (), hide: ()) = {
  heightened = if heightened == auto and spellcasting.heightened == auto { 0 } else if spellcasting.heightened == auto {
    heightened
  } else { spellcasting.heightened }
  let line = ()
  let name = ()
  if spellcasting.type != none { name.push([#spellcasting.type]) }
  if spellcasting.tradition != none { name.push([#spellcasting.tradition]) }
  if spellcasting.note != none { name.push[ (#spellcasting.note)] }
  name.push([Spells])
  if spellcasting.dc != none {
    line.push[DC #{ spellcasting.dc }, attack #{ convert_modifier(spellcasting.dc - 10, strong: true) }\;]
  }
  if exists(spellcasting.focus) { line.push[#spellcasting.focus focus points] }
  let spells = ()
  for spell_list in spellcasting.spell_lists.sorted(key: sl => -sl.rank) {
    spells.push(mk_spell_list(spell_list, heightened: heightened))
  }
  line.push(spells.join("; "))
  [*#name.join(" ")* #line.join(" ")]
}

#let Spellcasting = (
  class: class_spellcasting,
  new: new_spellcasting,
  make: mk_spellcasting,
)
#let SpellList = (
  class: class_spell_list,
  new: new_spell_list,
  make: mk_spell_list,
)

#let Spell = (
  new: new_spell,
  make: mk_spell,
  traditions: spell_tradition,
  types: spell_type,
  class: class_spell,
  spellcasting: Spellcasting,
  spell_list: SpellList,
  kinds: (
    focus: "Focus",
    spell: "Spell",
  ),
)
