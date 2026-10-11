
#let is_spell_for_class(spell, class: none, subclass: none) = {
  let is_class_matching(spell_class) = {
    if (spell_class.at("subclass", default: none) != none) {
      spell_class.class == class and spell_class.subclass == subclass
    } else if (spell_class.at("class", default: none) != none) {
      spell_class.class == class
    } else {
      true
    }
  }

  spell.classes.any(is_class_matching)
}

#let is_spell_for_level(spell, level: 0) = {
  spell.level <= level
}

#let is_spell_at_level(spell, level: 0) = {
  spell.level == level
}

#let spellbook() = {
  json("/resources/data/spellbook.json")
}
