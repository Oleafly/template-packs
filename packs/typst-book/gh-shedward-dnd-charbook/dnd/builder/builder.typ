#import "../game/game.typ": *
#import "../data/data.typ": spellbook
#import "../page/spells.typ": spellFromSpellbook
#import "render.typ": charbook

#let _normalizeArray(v) = if v == none { () } else { v }

#let build(..mutations) = {
  assert(mutations.pos().len() > 0, message: "build() requires introduce() as first argument")
  let result = mutations.pos().fold(none, (s, mut) => mut(s))
  assert(type(result) == dictionary, message: "build() first argument must be introduce()")
  let (currentSource: _, ..char) = result
  char
}

#let introduce(
  name: none,
  class: none,
  subclass: none,
  race: none,
  type: none,
  alignment: none,
  story: none,
  spellcasting: none,
  level: 0,
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
) = (_state) => (
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
  skillProfs: _normalizeArray(skillProfs),
  skillExpert: _normalizeArray(skillExpert),
  saveProfs: _normalizeArray(saveProfs),
  profBonus: profBonus,
  speed: speed,
  hitDices: hitDices,
  maxHp: maxHp,
  initiative: initiative,
  baseArmorClass: baseArmorClass,
  abilities: (),
  proficiencies: (),
  spells: (cantrips: (), byLevel: (:)),
  cover: none,
  biography: none,
  currentSource: none,
)

#let upgrade(name, ..mutations) = (state) => {
  let s = (..state, currentSource: name)
  mutations.pos().fold(s, (s2, mut) => mut(s2))
}

// Scalar

#let setLevel(n) = (state) => (..state, level: n)
#let setClass(name) = (state) => (..state, class: name)
#let setSubclass(name) = (state) => (..state, subclass: name)
#let setRace(name) = (state) => (..state, race: name)
#let setType(name) = (state) => (..state, type: name)
#let setAlignment(name) = (state) => (..state, alignment: name)
#let setStory(name) = (state) => (..state, story: name)
#let setSpeed(speed) = (state) => (..state, speed: speed)
#let setHitDice(hd) = (state) => (..state, hitDices: hd)
#let setSpellcasting(sc) = (state) => (..state, spellcasting: sc)

#let addMaxHP(amount) = (state) => {
  let current = if state.maxHp == none { 0 } else { state.maxHp }
  (..state, maxHp: current + amount)
}

#let levelUp() = (state) => (..state, level: state.level + 1)

#let setBiography(
  backstory: none,
  traits: (),
  bonds: (),
  ideals: (),
  goals: (),
  flaws: (),
) = (state) => (..state, biography: (
  backstory: backstory,
  traits: traits,
  bonds: bonds,
  ideals: ideals,
  goals: goals,
  flaws: flaws,
))

#let setCover(..args) = (state) => (..state, cover: args.named())

// Stats

#let addStatBonus(stat, amount) = (state) => {
  let stats = state.stats
  stats.insert(stat, stats.at(stat) + amount)
  (..state, stats: stats)
}

// Skills / saves

#let addSkillProfs(..skills) = (state) => {
  (..state, skillProfs: state.skillProfs + skills.pos())
}

#let addExpertise(..skills) = (state) => {
  (..state, skillExpert: state.skillExpert + skills.pos())
}

#let addSaveProfs(..stats) = (state) => {
  (..state, saveProfs: state.saveProfs + stats.pos())
}

// Abilities

#let addAbility(title, body) = (state) => {
  let ab = ability(title, source: state.currentSource, body)
  (..state, abilities: state.abilities + (ab,))
}

#let removeAbility(title) = (state) => {
  (..state, abilities: state.abilities.filter(a => a.title != title))
}

#let replaceAbility(title, newTitle, body) = (state) => {
  let source = state.currentSource
  (..state, abilities: state.abilities.map(a => {
    if a.title == title {
      ability(newTitle, source: source, body)
    } else {
      a
    }
  }))
}

// Proficiencies

#let addProficiency(prof) = (state) => {
  let patched = (..prof, source: state.currentSource)
  (..state, proficiencies: state.proficiencies + (patched,))
}

// Spells

#let addSpell(level, sp) = (state) => {
  let patched = (..sp, source: state.currentSource)
  let spells = state.spells
  if type(level) == int {
    let key = str(level)
    let existing = spells.byLevel.at(key, default: ())
    spells.byLevel.insert(key, existing + (patched,))
  } else {
    spells.cantrips = spells.cantrips + (patched,)
  }
  (..state, spells: spells)
}

#let addSpellById(id, ..etc) = (state) => {
  let matches = spellbook().filter(s => s.id == id)
  assert(matches.len() > 0, message: "spell not found in spellbook: " + id)
  let entry = matches.first()
  let level = if entry.level == 0 { cantrip } else { entry.level }
  addSpell(level, spellFromSpellbook(entry, ..etc))(state)
}

#let addClassSpells(class, level) = (state) => {
  let spellLevel = if type(level) == int { level } else { 0 }
  spellbook()
    .filter(s => s.level == spellLevel and s.classes.any(c => c.class == class))
    .fold(state, (s, entry) => {
      let slotLevel = if entry.level == 0 { cantrip } else { entry.level }
      addSpell(slotLevel, spellFromSpellbook(entry))(s)
    })
}

#let removeSpellById(id) = (state) => {
  let spells = state.spells
  let notId = s => s.at("id", default: none) != id
  spells.cantrips = spells.cantrips.filter(notId)
  for (lvl, spellList) in spells.byLevel {
    spells.byLevel.insert(lvl, spellList.filter(notId))
  }
  (..state, spells: spells)
}
