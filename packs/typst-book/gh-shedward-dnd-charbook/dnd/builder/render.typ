#import "../core/core.typ"
#import "../core/loc.typ": loc
#import "../game/game.typ": *
#import "../page/page.typ"

#let charbook(
  char,
  locale: "ru",
  cover: none,
  biography: none,
) = {
  show: core.charbook
  core.setLocale(locale)
  setCharacter(char)

  let coverArgs = if cover != none { cover } else { char.at("cover", default: none) }
  if coverArgs != none {
    page.cover(char.name, ..coverArgs)
  } else {
    page.cover(char.name, title: char.class, subtitle: char.subclass)
  }

  page.attacks
  page.charlist(char)
  page.inventory

  let charSpells = char.at("spells", default: none)
  if charSpells != none {
    let hasSpells = (
      charSpells.cantrips.len() > 0
      or charSpells.byLevel.values().any(list => list.len() > 0)
    )
    if hasSpells {
      page.spellPages(char)
    }
  }

  let abilities = char.at("abilities", default: ())
  if abilities.len() > 0 {
    page.abilities(..abilities)
  }

  let proficiencies = char.at("proficiencies", default: ())
  if proficiencies.len() > 0 {
    page.proficiencies(..proficiencies)
  }

  let bio = if biography != none { biography } else { char.at("biography", default: none) }
  if bio != none {
    if type(bio) == dictionary {
      let _section(key, items) = if items.len() > 0 {
        biographySection(loc(key))[
          #for item in items { biographySubsection(item.at(0), item.at(1)) }
        ]
      }
      let traits = bio.at("traits", default: ())
      let bonds = bio.at("bonds", default: ())
      let ideals = bio.at("ideals", default: ())
      let goals = bio.at("goals", default: ())
      let flaws = bio.at("flaws", default: ())
      if bio.backstory != none { page.backstory(bio.backstory) }
      if (traits + bonds + ideals + goals + flaws).len() > 0 {
        page.personality[
          #_section("ui.biography.traits", traits)
          #_section("ui.biography.bonds", bonds)
          #_section("ui.biography.ideals", ideals)
          #colbreak()
          #_section("ui.biography.goals", goals)
          #_section("ui.biography.flaws", flaws)
        ]
      }
    } else {
      bio
    }
  }

  page.quests
  page.quests
}
