#import "../core/core.typ": *
#import "spellConstants.typ": *
#import "character.typ": *

#let atHigherLevels(body) = emph(loc("spell.dsl.higher_levels", subs: (body: body)))

#let required(body) = [
  #loc("spell.dsl.required"): #underline(text(weight: "bold", body))
]

#let characterRoll(character, formula) = {
  let e = formula

  let varianceMin(n, max) = n
  let varianceMax(n, max) = max * n

  e = e.replace(
    regex("(\d+)d(\d+)"),
    g => "variance("+ g.captures.at(0) + "," + g.captures.at(1) + ")"
  )
  for stat in stats {
    e = e.replace(stat, str(statModifier(character, stat)))
  }

  let spellStat = spellcastingStat(character)
  if spellStat != none {
    e = e.replace("MOD", str(statModifier(character, spellStat)))
  }

  let evalVariance(variance) = eval(
    e.replace("variance", variance),
    scope: (
      min: varianceMin,
      max: varianceMax
    )
  )

  let minVal = evalVariance("min")
  let maxVal = evalVariance("max")
  if minVal == maxVal {
    [#formula]
  } else {
    [#formula #caption[(#minVal - #maxVal)]]
  }
}

#let characterFormula(character, formula) = {
  let e = formula

  for stat in stats {
    e = e.replace(stat, str(statModifier(character, stat)))
  }

  let spellStat = spellcastingStat(character)
  if spellStat != none {
    e = e.replace("MOD", str(statModifier(character, spellStat)))
  }

  if character.level != none {
    e = e.replace("LVL", str(character.level))
  }

  let profBonus = method(character, c => c.profBonus)
  if profBonus != none {
    e = e.replace("PROF", str(profBonus))
  }

  eval(e)
}

#let roll(formula) = resolveForCharacter(c => characterRoll(c, formula))

#let formula(formula) = resolveForCharacter(c => characterFormula(c, formula))

#let dc(dcFormula) = [#loc("spell.dsl.dc") #formula(dcFormula)]

#let damage(formula, damageType, ranged: false, saving: none, saved: halfDamage, upgraded: none) = [
  *
  #if ranged [
    #loc("spell.dsl.ranged"),
  ]
  #if saving != none [
    #statName(saving)
    #if saved == halfDamage {
      [(½)]
    }
    #loc("spell.dsl.or")
  ]
  #roll(formula) #damageTypeShortName(damageType)
  *
]

#let heal(formula) = [
  *#loc("spell.dsl.heal") #roll(formula) #loc("spell.dsl.hp")*
]

#let effect(condition, saving: none) = [
  *#if saving != none [#statName(saving) #loc("spell.dsl.or")]
  #conditionName(condition)*
]

// Advantage / disadvantage
#let rollTargetName(t) = if t == attack {
  loc("spell.dsl.attack")
} else {
  statName(t)
}

#let advantage(on) = [
  *#loc("spell.dsl.advantage"): #rollTargetName(on)*
]

#let disadvantage(on) = [
  *#loc("spell.dsl.disadvantage"): #rollTargetName(on)*
]

// Resistance / vulnerability / immunity
#let resist(..types) = [
  *#loc("spell.dsl.resist"): #types.pos().map(damageTypeShortName).join[, ]*
]

#let weakness(..types) = [
  *#loc("spell.dsl.weakness"): #types.pos().map(damageTypeShortName).join[, ]*
]

#let immune(..types) = [
  *#loc("spell.dsl.immune"): #types.pos().map(damageTypeShortName).join[, ]*
]

#let immuneEffect(..conditions) = [
  *#loc("spell.dsl.immune"): #conditions.pos().map(conditionName).join[, ]*
]

// Curing conditions / diseases
#let cure(..items) = [
  *#loc("spell.dsl.cure"): #items.pos().map(cureName).join[, ]*
]

// Movement speed
#let speed(value, ..rest) = {
  let movType = rest.pos().at(0, default: walking)
  let val = if type(value) == int or type(value) == float {
    [#value #loc("spell.unit.feet")]
  } else {
    [#value]
  }
  let label = loc("spell.movement." + movType)
  [*#label: #val*]
}

// Light
#let light(bright: 0, dim: 0) = [
  *#loc("spell.dsl.light"): #bright/#dim #loc("spell.unit.feet")*
]

// Forced movement
#let move(direction, distance: 0, saving: none) = [
  *#if saving != none [#statName(saving) #loc("spell.dsl.or")]
  #if direction == toYou [#loc("spell.dsl.pull")] else [#loc("spell.dsl.push")]
  #distance #loc("spell.unit.feet")*
]

// DSL evaluation scope for spell body strings.
// Defined here so it stays in sync with the functions above automatically.
#let spellBodyDSLScope = (
  damage: damage,
  heal: heal,
  formula: formula,
  atHigherLevels: atHigherLevels,
  acid: acid, bludgeoning: bludgeoning, cold: cold, frost: cold, fire: fire,
  force: force, lightning: lightning, necrotic: necrotic,
  piercing: piercing, poison: poison, psychic: psychic,
  radiant: radiant, slashing: slashing, thunder: thunder,
  STR: STR, DEX: DEX, CON: CON, INT: INT, WIS: WIS, CHA: CHA,
  halfDamage: halfDamage, noDamage: noDamage,
  effect: effect,
  blinded: blinded, charmed: charmed, deafened: deafened,
  frightened: frightened, grappled: grappled, incapacitated: incapacitated,
  invisible: invisible, paralyzed: paralyzed, petrified: petrified,
  poisoned: poisoned, prone: prone, restrained: restrained,
  stunned: stunned, unconscious: unconscious,
  advantage: advantage, disadvantage: disadvantage,
  attack: attack,
  resist: resist, weakness: weakness, immune: immune, immuneEffect: immuneEffect,
  cure: cure, disease: disease,
  light: light,
  speed: speed, flying: flying, swimming: swimming, climbing: climbing, burrowing: burrowing,
  move: move, toYou: toYou, fromYou: fromYou,
  target: target, touch: touch, self: self, point: point, sight: sight, unlimited: unlimited,
  circle: circle, ring: ring, square: square, cube: cube, sphere: sphere,
  straightLine: straightLine, cone: cone, cylinder: cylinder, rectangle: rectangle,
)
