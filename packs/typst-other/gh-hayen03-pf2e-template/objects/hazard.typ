#import "../base.typ": *
#import "common.typ": *
#import "item.typ": class_activation, mk_activation
#import "creature.typ": Creature, mk_ability

#let class_hazard = "hazard"

#let new_hazard(
  name,
  level: none,
  traits: (),
  stealth: none,
  description: none,
  disable: none,
  ac: none,
  hardness: none,
  activations: (),
  action: none,
  routine: none,
  reset: none,
  others: (:),
  tags: (),
  notes: (:),
  hp: none,
  saves: (:),
  immunities: (),
  weaknesses: (:),
  resistances: (:),
  kind: "Hazard",
  short: false,
  breakable: false,
  url: none,
  image: none,
  extras: (:),
  actions_count: none,
  additional_effect: none,
  short_desc: none,
) = (
  class: class_hazard,
  name: name,
  kind: kind,
  level: level,
  traits: clean_list(split_traits(traits)),
  tags: clean_list(split_traits(tags)),
  stealth: stealth,
  description: description,
  disable: disable,
  ac: ac,
  hp: hp,
  saves: saves,
  immunities: clean_list(split_traits(immunities)),
  weaknesses: weaknesses,
  resistances: resistances,
  hardness: hardness,
  activations: as_list(activations),
  action: action,
  routine: routine,
  reset: reset,
  others: others,
  notes: notes,
  short: short,
  breakable: breakable,
  url: url,
  image: image,
  extras: extras,
  actions_count: actions_count,
  additional_effect: additional_effect,
  short_desc: short_desc,
)
#let mk_hazard(hazard, theme: THEME, short: auto, breakable: auto, hide: ()) = itembox(
  hazard.name,
  level: hazard.level,
  traits: hazard.traits,
  kind: hazard.kind,
  breakable: if breakable == auto { hazard.breakable } else { breakable },
  theme: theme,
  hanging: true,
  url: hazard.url,
)[
  #let blocs = ()
  #let bloc = ()
  #if exists(hazard.stealth) and "stealth" not in hide {
    bloc.push[*Stealth* #convert_modifier(hazard.stealth) (DC #{ hazard.stealth + 10 })#if "stealth" in hazard.notes [ (#hazard.notes.stealth)]]
  }
  #if exists(hazard.description) and "description" not in hide { bloc.push[*Description* #hazard.description] }
  #blocs.push(bloc.filter(it => exists(it)).join(parbreak()))
  #let bloc = hazard.others.pairs().map(it => [*#it.at(0)* #it.at(1)])
  #blocs.push(bloc.filter(it => exists(it)).join(parbreak()))
  #let bloc = ()
  #if exists(hazard.disable) and "disable" not in hide {
    bloc.push[*Disable* #hazard.disable]
  }
  #let line = ()
  #if exists(hazard.ac) and "ac" not in hide {
    line.push[*AC* #hazard.ac#if "ac" in hazard.notes [ (#hazard.notes.ac)]]
  }
  #if exists(hazard.saves) and "saves" not in hide {
    line.push[*Saving Throws* #hazard.saves.pairs().map(p => [#p.at(0) #convert_modifier(p.at(1))#if lower(p.at(0)) in hazard.notes [ (#hazard.notes.at(lower(p.at(0))))]]).join(", ")]
  }
  #bloc.push(line.filter(it => exists(it)).join("; "))
  #let line = ()
  #if exists(hazard.hardness) and "hardness" not in hide {
    line.push[*Hardness* #hazard.hardness#if "hardness" in hazard.notes [ (#hazard.notes.hardness)]]
  }
  #if exists(hazard.hp) and "hp" not in hide {
    line.push[*HP* #hazard.hp#if "hp" in hazard.notes [ (#hazard.notes.hp)]]
  }
  #if exists(hazard.resistances) {
    line.push[*Resistances* #hazard.resistances.keys().map(res => [#res #convert_data(hazard.resistances.at(res))#if "resistances" in hazard.notes and res in hazard.notes.resistances [ (#hazard.notes.resistances.at(res))]]).join(", ")]
  }
  #if exists(hazard.weaknesses) {
    line.push[*Weaknesses* #hazard.weaknesses.keys().map(weak => [#weak #convert_data(hazard.weaknesses.at(weak))#if "weaknesses" in hazard.notes and weak in hazard.notes.weaknesses [ (#hazard.notes.weaknesses.at(weak))]]).join(", ")]
  }
  #if exists(hazard.immunities) {
    line.push[*Immunities* #hazard.immunities.map(immu => [#immu#if "immunities" in hazard.notes and immu in hazard.notes.immunities [ (#hazard.notes.immunities.at(immu))]]).join(", ")]
  }
  #bloc.push(line.filter(it => exists(it)).join("; "))
  #blocs.push(bloc.filter(it => exists(it)).join(parbreak()))
  #let bloc = (
    if exists(hazard.action) and "action" not in hide {
      if type(hazard.action) == dictionary and "class" in hazard.action {
        if hazard.action.class == class_activation { mk_activation(hazard.action, short: short) } else if (
          hazard.action.class == Creature.ability.class
        ) { mk_ability(hazard.action, short: short) }
      } else { hazard.action }
    },
    if exists(hazard.routine)
      and "routine" not in hide [*Routine*#if exists(hazard.actions_count) [ (#hazard.actions_count)] #hazard.routine],
  )
  #blocs.push(bloc.filter(it => exists(it)).join(parbreak()))
  #let bloc = hazard.activations.map(act => {
    if type(act) == dictionary and "class" in act {
      if act.class == class_activation { mk_activation(act, short: short) } else if (
        act.class == Creature.ability.class
      ) {
        mk_ability(act, short: short)
      }
    } else { act }
  })
  #blocs.push(bloc.filter(it => exists(it)).join())
  #blocs.push(if exists(hazard.additional_effect) [*Additional Effext* #hazard.additional_effect])
  #blocs.push(if exists(hazard.reset) [*Reset* #hazard.reset])
  #blocs.filter(it => exists(it)).join(hr())
]

#let Hazard = (
  class: class_hazard,
  new: new_hazard,
  make: mk_hazard,
)
