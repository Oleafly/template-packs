#import "../base.typ": *
#import "common.typ": *

#let class_settlement = "settlement"

#let new_settlement(
  name,
  tags: (),
  traits: (),
  level: none,
  kind: "Settlement",
  government: none,
  population: none,
  languages: none,
  religions: none,
  threats: none,
  npcs: (:),
  others: (:),
  description: none,
  breakable: false,
  url: none,
  image: none,
  extras: (:),
  short_desc: none,
) = (
  class: class_settlement,
  name: name,
  kind: kind,
  level: level,
  traits: clean_list(split_traits(traits)),
  tags: clean_list(split_traits(tags)),
  government: government,
  population: population,
  languages: languages,
  religions: religions,
  threats: threats,
  npcs: npcs,
  others: others,
  description: description,
  breakable: breakable,
  url: url,
  image: image,
  extras: extras,
  short_desc: short_desc,
)
#let mk_settlement(settlement, theme: THEME, short: false, hide: (), breakable: auto) = {
  itembox(
    settlement.name,
    level: settlement.level,
    traits: settlement.traits,
    kind: settlement.kind,
    breakable: if breakable == auto { settlement.breakable } else { breakable },
    theme: theme,
    hanging: true,
    url: settlement.url,
  )[
    #let bloc = ()
    #bloc.push(straight(settlement.description))
    #if exists(settlement.government) and "government" not in hide { bloc.push[*Government* #settlement.government] }
    #if exists(settlement.population) and "population" not in hide { bloc.push[*Population* #settlement.population] }
    #if exists(settlement.languages) and "languages" not in hide { bloc.push[*Languages* #settlement.languages] }
    #if exists(settlement.religions) and "religions" not in hide { bloc.push[*Religions* #settlement.religions] }
    #if exists(settlement.threats) and "threats" not in hide { bloc.push[*Threats* #settlement.threats] }
    #for other in settlement.others.pairs() { bloc.push[*#other.at(0)* #other.at(1)] }
    #for npc in settlement.npcs.pairs() { bloc.push[*#npc.at(0)* #npc.at(1)] }
    #bloc.filter(it => exists(it)).join(parbreak())
  ]
}

#let Settlement = (
  class: class_settlement,
  new: new_settlement,
  make: mk_settlement,
)
