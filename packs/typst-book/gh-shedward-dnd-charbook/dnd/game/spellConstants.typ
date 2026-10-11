#import "../core/core.typ": *

// Cast time
#let action = loc("spell.casttime.action")
#let bonusAction = loc("spell.casttime.bonus")
#let reaction = loc("spell.casttime.reaction")

// Durations
#let instant = loc("spell.duration.instant")
#let permanent = loc("spell.duration.permanent")
#let round(r) = [#r#loc("spell.duration.suffix.round")]
#let minute(m) = [#m#loc("spell.duration.suffix.minute")]
#let hour(h) = [#h#loc("spell.duration.suffix.hour")]
#let day(d) = [#d#loc("spell.duration.suffix.day")]
#let always = sym.infinity
#let unlimited = sym.infinity

// Cast type
#let ritual = loc("spell.casttype.ritual")
#let concentration = loc("spell.casttype.concentration")

// School
#let abjuration = loc("spell.school.abjuration")
#let conjuration = loc("spell.school.conjuration")
#let necromancy = loc("spell.school.necromancy")
#let evocation = loc("spell.school.evocation")
#let transmutation = loc("spell.school.transmutation")
#let divination = loc("spell.school.divination")
#let enchantment = loc("spell.school.enchantment")
#let illusion = loc("spell.school.illusion")

// Damage types
#let acid = "acid"
#let bludgeoning = "bludgeoning"
#let cold = "cold"
#let fire = "fire"
#let force = "force"
#let lightning = "lightning"
#let necrotic = "necrotic"
#let piercing = "piercing"
#let poison = "poison"
#let psychic = "psychic"
#let radiant = "radiant"
#let slashing = "slashing"
#let thunder = "thunder"

#let damageTypeName(type) = loc("spell.damage." + type)
#let damageTypeShortName(type) = loc("spell.damage.short." + type)

// Preparation
#let alwaysPrepared = sym.infinity
#let preparing = {
  box(circle(radius: paddings(1), stroke: strokes.thin))
}
#let freePreparation(body, count: 1) = [
  #body\
  #spellCaption[#count #loc("spell.slot.free")]
]

// Range
#let self = loc("spell.range.self")
#let touch = loc("spell.range.touch")

#let rangeDescr(range) = if (range == 0) [
  #self
] else [
  #(range)#loc("spell.unit.feet")
]

#let countDescr(count) = if (count>1) [#sym.times#count] else []

#let mile(m) = 5279 * m

#let target(range, count: 1) = [#(rangeDescr(range))#icon("target")#countDescr(count)]
#let point(range, count: 1) = [#(rangeDescr(range))#icon("point")#countDescr(count)]
#let area(iconName) = (size, range: 0) => [#(rangeDescr(range))/#(size)ft#icon(iconName)]
#let sight = loc("spell.range.sight")

#let circle = area("circle")
#let ring = area("ring")
#let square = area("square")
#let cube = area("cube")
#let sphere = area("sphere")
#let straightLine = area("arrow-right")
#let cone = area("cone")
#let cylinder = (radius, height, range: 0) => [#(rangeDescr(range))/#(radius)x#(height)ft#icon("cylinder")]
#let rectangle = (x, y, z, range: 0) => [#(rangeDescr(range))/#(x)x#(y)x#(z)ft#icon("cube")]

#let volume(size) = [#(size)ft#icon("cube")]

// Sources
#let class = [Class]
#let race = [Race]
#let story = [Story]

#let cantrip = (
  name: subsection(loc("spell.level.cantrip")),
  slots: none
)

#let spellSlots(count) = box(framed(checkboxes(count), stroke: strokes.normal))

#let spellLevel(
  level,
  slots: none
) = (
  name: subsection(loc("spell.level.numbered", subs: (arabic: str(level), roman: roman(level)))),
  slots: if slots != none { spellSlots(slots) }
)

#let spell(
  name,
  prep: none,
  school: none,
  castTime: action,
  castType: none,
  duration: none,
  range: none,
  components: none,
  source: class,
  body
) = (
  prep: prep,
  name: name,
  school: school,
  castTime: castTime,
  castType: castType,
  duration: duration,
  range: range,
  components: components,
  source: source,
  body: body
)

// Conditions
#let blinded = "blinded"
#let charmed = "charmed"
#let deafened = "deafened"
#let frightened = "frightened"
#let grappled = "grappled"
#let incapacitated = "incapacitated"
#let invisible = "invisible"
#let paralyzed = "paralyzed"
#let petrified = "petrified"
#let poisoned = "poisoned"
#let prone = "prone"
#let restrained = "restrained"
#let stunned = "stunned"
#let unconscious = "unconscious"

#let conditionName(c) = loc("spell.condition." + c)

// Damage save results
#let noDamage = "noDamage"
#let halfDamage = "halfDamage"

// Advantage / disadvantage targets
#let attack = "attack"

// Movement types
#let flying = "flying"
#let swimming = "swimming"
#let climbing = "climbing"
#let burrowing = "burrowing"
#let walking = "walking"

// Forced movement directions
#let toYou = "toYou"
#let fromYou = "fromYou"

// Conditions / diseases
#let disease = "disease"
#let cureName(c) = loc("spell.condition." + c)
