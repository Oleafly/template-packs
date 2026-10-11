#import "../core/core.typ": *

#let setCharacter(currentCharacter) = [
  #metadata(currentCharacter) <character>
]

#let resolveForCharacter(fn) = context {
  let characterRecords = query(<character>)
  let currentCharacter = if characterRecords.len() > 0 {
    characterRecords.first().value
  } else {
    panic("Character is not specified")
  }

  fn(currentCharacter)
}

#let STR = "STR"
#let DEX = "DEX"
#let CON = "CON"
#let INT = "INT"
#let WIS = "WIS"
#let CHA = "CHA"

#let stats = (STR, DEX, CON, INT, WIS, CHA)

#let acrobatics = "acrobatics"
#let animalHandling = "animalHandling"
#let arcana = "arcana"
#let athletics = "athletics"
#let deception = "deception"
#let history = "history"
#let insight = "insight"
#let intimidation = "intimidation"
#let investigation = "investigation"
#let medicine = "medicine"
#let nature = "nature"
#let perception = "perception"
#let persuasion = "persuasion"
#let performance = "performance"
#let religion = "religion"
#let sleightOfHand = "sleightOfHand"
#let stealth = "stealth"
#let survival = "survival"

#let skills = (
  (skill: athletics, stat: STR),

  (skill: acrobatics, stat: DEX),
  (skill: sleightOfHand, stat: DEX),
  (skill: stealth, stat: DEX),

  (skill: history, stat: INT),
  (skill: arcana, stat: INT),
  (skill: nature, stat: INT),
  (skill: investigation, stat: INT),
  (skill: religion, stat: INT),

  (skill: perception, stat: WIS),
  (skill: survival, stat: WIS),
  (skill: medicine, stat: WIS),
  (skill: insight, stat: WIS),
  (skill: animalHandling, stat: WIS),

  (skill: performance, stat: CHA),
  (skill: intimidation, stat: CHA),
  (skill: deception, stat: CHA),
  (skill: persuasion, stat: CHA)
)

#let statForSkill(skill) = {
  skills.filter(i => i.skill == skill).first().stat
}

#let movementSpeed(
  walking: none,
  flying: none,
  swimming: none,
  climbing: none
) = (
  walking: walking,
  flying: flying,
  swimming: swimming,
  climbing: climbing
)

#let spellcasting(
  focus: none,
  ritualCasting: false,
  props: (),
  stat: none,
  slots: none
) = (
  focus: focus,
  ritualCasting: ritualCasting,
  props: props,
  stat: stat,
  slots: slots
)

#let byCharacterLevel(character, x) = {
  if character.level == none {
    none
  } else if type(x) == function {
    x(character.level)
  } else if type(x) == dictionary {
    switchInt(character.level, x)
  } else {
    panic("Not supported")
  }
}

#let byLevelMethod(x) = character => byCharacterLevel(character, x)

#let _standardProfBonus = byLevelMethod(("1": 2, "5": 3, "9": 4, "13": 5, "17": 6))

#let character(
  name: none,
  class: none,
  subclass: none,
  race: none,
  type: none,
  alignment: none,
  story: none,
  spellcasting: none,
  level: 1,
  stats: none,
  skillProfs: none,
  skillExpert: (),
  saveProfs: none,
  profBonus: _standardProfBonus,
  speed: none,
  hitDices: none,
  maxHp: none,
  initiative: none,
  baseArmorClass: auto,
) = (
  name: name,
  class: class,
  subclass: subclass,
  race: race,
  type: type,
  alignment: alignment,
  story: story,
  spellcasting: spellcasting,
  level: level,
  stats: stats,
  skillProfs: skillProfs,
  skillExpert: skillExpert,
  saveProfs: saveProfs,
  profBonus: profBonus,
  speed: speed,
  hitDices: hitDices,
  maxHp: maxHp,
  initiative: initiative,
  baseArmorClass: baseArmorClass
)

#let byLevel(x) = resolveForCharacter(byLevelMethod(x))

#let atLevel(level, body) = resolveForCharacter(c => if c.level == level {
  body
})

#let afterLevel(level, body) = resolveForCharacter(c => if c.level >= level {
  body
})

#let statValue(character, stat) = {
  if stat != none and character.stats != none {
    character.stats.at(stat, default: none)
  }
}

#let statModifier(character, stat) = {
  let value = statValue(character, stat)
  if value != none {
    calc.floor((value - 10) / 2)
  }
}

#let initiativeModifier(character) = {
  statModifier(character, DEX)
}

#let baseArmorClass(character) = {
  10 + statModifier(character, DEX)
}

#let profBonus(character) = {
  method(character, c => c.profBonus)
}

#let walkingSpeed(character) = {
  let speed = method(character, c => c.speed)
  if speed != none {
    speed.walking
  }
}

#let hitDices(type) = byLevelMethod(l => hstack(size: (1fr, auto), none, [/#l#type]))

#let maxHp(firstLevelHp, nextLevelHp) = character => {
  let con = statModifier(character, CON)
  if con != none and character.level != none {
    let firstLevel = firstLevelHp + con
    let nextLevels = (nextLevelHp + calc.max(con, 1)) * (character.level - 1)
    firstLevel + nextLevels
  }
}

#let saveModifier(character, stat) = {
  let profBonus = method(character, c => c.profBonus)
  let modifier = statModifier(character, stat)

  if profBonus != none and modifier != none and character.saveProfs != none {
    let isTrained = character.saveProfs.contains(stat)
    modifier + if isTrained { profBonus } else { 0 }
  }
}

#let skillModifier(character, skill) = {
  let profBonus = method(character, c => c.profBonus)
  let stat = statForSkill(skill)
  let modifier = statModifier(character, stat)

  if profBonus != none and modifier != none and character.skillProfs != none {
    let isTrained = character.skillProfs.contains(skill)
    let mult = if character.skillExpert.contains(skill) { 2 } else { 1 }
    modifier + if isTrained { mult * profBonus } else { 0 }
  }
}

#let spellcastingStat(character) = {
  if character.spellcasting != none {
    character.spellcasting.stat
  }
}

#let spellAtkBonus(character) = {
  let profMod = profBonus(character)
  let stat = spellcastingStat(character)
  let statMod = statModifier(character, stat)

  if profMod != none and statMod != none {
    profMod + statMod
  }
}

#let spellDC(character) = {
  let profMod = profBonus(character)
  let stat = spellcastingStat(character)
  let statMod = statModifier(character, stat)

  if profMod != none and statMod != none {
    8 + profMod + statMod
  }
}

#let statName(stat) = {
  if stat != none {
    loc("char.stat." + lower(stat))
  }
}

#let skillName(skill) = {
  loc("char.skill." + lower(skill))
}
