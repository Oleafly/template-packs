#import "../core/core.typ"
#import "character.typ": statName, skillName

#let tool = "tool"
#let weapon = "weapon"
#let armor = "armor"
#let music = "music"
#let stat = "stat"
#let skill = "skill"
#let language = "language"

#let toolsProficiency(
  title,
  source: none,
  items: (),
  actions: (),
  skillsEffects: ()
) = (
  class: tool,
  title: title,
  source: source,
  items: items,
  actions: actions,
  skillsEffects: skillsEffects
)

#let any = "~"

#let toolsAction(
  name,
  dc: none,
  ..args
) = (
  name: name,
  dc: dc,
  body: if args.pos().len() > 0 {
    args.pos().last()
  } else {
    none
  }
)

#let skillEffect(..skills, body) = (
  skills: skills,
  body: body
)

#let simpleProficiency(title, source: none) = (
  class: none,
  title: title,
  source: source
)

#let weaponProficiency(title, source: none) = (
  class: weapon,
  title: title,
  source: source
)

#let armorProficiency(title, source: none) = (
  class: armor,
  title: title,
  source: source
)

#let musicProficiency(title, source: none) = (
  class: music,
  title: title,
  source: source
)

#let savingProficiency(savingStat, source: none) = (
  class: stat,
  title: core.loc("ui.proficiency.saving", subs: (stat: statName(savingStat))),
  source: source
)

#let skillProficiency(profficientSkill, source: none) = (
  class: skill,
  title: skillName(profficientSkill),
  source: source
)

#let languageProficiency(language, source: none) = (
  class: language,
  title: language,
  source: source
)
