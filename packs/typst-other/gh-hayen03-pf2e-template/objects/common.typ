#import "../base.typ": *

#let split_number(n, group: 3, sep: ",") = {
  let parts = ()
  let count = 0
  while n > 0 {
    if count == group {
      parts.push(sep)
      count = 0
    } else {
      let d = calc.rem(n, 10)
      parts.push([#d])
      n = calc.trunc(n/10)
      count = count + 1
    }
  }
  parts.rev().join()
}

#let convert_price(amount) = {
  if not exists(amount) {
    return null
  }
  if type(amount) != int and type(amount) != float {
    return amount
  }
  let a = calc.abs(amount)
  let gp = calc.floor(a)
  let sp = calc.floor(calc.rem(a*10, 10))
  let cp = calc.floor(calc.rem(a*100, 10))
  if gp > 0 [#split_number(gp);gp]
  if sp > 0 [#sp;sp]
  if cp > 0 [#cp;cp]
  if gp == 0 and sp == 0 and cp == 0 {null}
}
#let convert_bulk(amount) = {
  if amount == "L" {
    "L"
  } else if type(amount) == int or type(amount) == float {
    let a = calc.abs(amount)
    if a == 0 {
      null
    } else if a < 1 {
      "L"
    } else {
      calc.floor(a)
    }
  } else if not exists(amount) {
    null
  } else {
    amount
  }
}
#let convert_modifier(amount, strong: false) = {
  if type(amount) == int or type(amount) == float {
    let a = calc.trunc(amount)
    if a == 0 and strong != true {
      null
    } else if a >= 0{
      [+#a]
    } else {
      [#a]
    }
  } else if not exists(amount) {
    null
  } else {
    amount
  }
}
#let convert_data(data) = {
  if data == none {null} else {data}
}
#let convert_rank(rank) = {
  if rank == 1 [1st]
  else if rank == 2 [2nd]
  else if rank == 3 [3rd]
  else if not exists(rank) {none}
  else [#rank;th]
}
#let list_traits(traits) = {
  let traits = clean_list(split_traits(traits))
  if not exists(traits) {
    return none
  } else {
    traits.join(", ")
  }
}
#let as_list(value) = {
  let t = type(value)
  if t == array {
    value
  }
  else if value == none {
    none
  }
  else {
    (value,)
  }
}

#let get_leveled_list(item_list, level) = {
  item_list.filter(item => item.at("level") == level)
}

#let rarities = (
  common: none,
  uncommon: "uncommon",
  rare: "rare",
)
#let proficiencies = (
  untrained: none,
  trained: "trained",
  expert: "expert",
  master: "master",
  legendary: "legendary",
  mythic: "mythic",
)
#let damage_types = (
  acid: "acid",
  bludgeoning: "bludgeoning",
  cold: "cold",
  electricity: "electricity",
  fire: "fire",
  force: "force",
  spirit: "spirit",
  vitality: "vitality",
  void: "void",
  sonic: "sonic",
  radiant: "radiant",
  aether: "aether",
  slashing: "slashing",
  piercing: "piercing",
)

#let mk_itembox(name: none, body, actions: none, kind: none, level: none, traits: (), breakable, theme: THEME, url: none) = {
  itembox(
    name, 
    actions: actions, 
    kind: kind, 
    level: level, 
    traits: traits,  
    breakable: breakable, 
    theme: theme, 
    hanging: true,
    url: url,
  )[
    #let body = as_list(body)
    #body.map(lines => {
      let lines = as_list(lines)
      lines.map(line => {
        if not exists(line) {none}
        else if type(line) == dict {
          line.pairs().map((entry, value) => {
            if exists(entry) and exists(value) [*#entry* #value] else {none}
          }).filter(it => exists(it)).join("; ")
        } else if type(line) == array {
          line.map(entry => {
            if type(entry) == dict [*#entry.name* #entry.value]
            else {entry}
          }).filter(it => exists(it)).join("; ")
        } else {line}
      }).filter(it => exists(it)).join(parbreak())
    }).filter(it => exists(it)).join(hr())
  ]
}