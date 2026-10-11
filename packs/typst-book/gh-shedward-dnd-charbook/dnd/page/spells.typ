#import "../core/core.typ": *
#import "../game/game.typ": *
#import "../data/data.typ": *

#let spellColumns = (9mm, 20mm, 8mm, 1fr, 1fr, 9mm)

#let spellBlock(spell) = block(
  breakable: false,
  width: 100%,
  above: 0pt,
  below: 0pt,
  inset: 0pt,
  spacing: 0pt,
)[
  #line(length: 100%, stroke: strokes.hairline)
  #grid(
    columns: spellColumns,
    align: top + left,
    inset: (top: paddings(0), bottom: paddings(1), left: paddings(0.5), right: paddings(0.5)),
    grid.cell(rowspan: 2, align: horizon + center)[#spell.prep],
    grid.cell(rowspan: 2, align: horizon + left)[
      #set par(justify: false)
      #spell.name\
      #spellCaption(spell.school)
    ],
    grid.cell(align: left)[#spell.castTime],
    spell.duration,
    spell.range,
    spell.components,
    grid.cell(align: right, inset: (top: paddings(0.25)))[
      #if (spell.castType == none) [-] else [#spell.castType]
    ],
    grid.cell(colspan: 3, inset: (top: paddings(0.25)), spell.body),
  )
]

#let spellPropBox(content, dy: -0.5em) = {
  box(height: 15mm)[
    #framed(fitting: expand)[]
    #place(bottom + center, dy: dy)[
      #propCap(content.at("caption", default: none))
    ]

    #place(horizon + center, dy: 0.5 * dy)[
      #propBody(content.at("content", default: none))
    ]

    #place(top + center, dy: -dy)[
      #propCap(content.at("topCaption", default: none))
    ]
  ]
}

#let spellSlotsSection(character, additional: (:)) = {
  if character.spellcasting != none and character.spellcasting.slots != none {
    let slots = method(character, c => c.spellcasting.slots)

    framed(fitting: expand-h)[
      #propCap(loc("ui.spells.slots"))
      #hstack(
        size: (auto,),
        align: horizon,
        gutter: paddings(2),
        ..(slots.keys()
            .map(
              level => vstack(
                gutter: paddings(0.5),

                spellSlots(slots.at(level)),
                [ *#propCap(roman(int(level)))* ]
              )
            )
        ),
        ..(additional.keys()
            .map(
              key => vstack(
                gutter: paddings(0.5),

                spellSlots(additional.at(key)),
                [ *#propCap(key)* ]
              )
            )
        ),
      )
    ]
  }
}

#let spellcasting(character) = {
  let propBox = (
  (
    (
      content: statModifier(character, spellcastingStat(character)),
      caption: [#loc("ui.spells.ability") - #statName(spellcastingStat(character))]
    ),
    (
      content: spellAtkBonus(character),
      caption: loc("ui.spells.atkbonus")
    ),
    (
      content: spellDC(character),
      caption: loc("ui.spells.savedc")
    )
  )
  + character.spellcasting.props.map(p => {
    (
      content: method(character, c => p.content),
      caption: method(character, c => p.caption)
    )
  })
  ).filter(v => v != none)

  framed(fitting: expand-h)[
    #vstack(
      row-gutter: paddings(1),
      skipNone: true,
      grid(
        columns: (1fr, 1fr, 1fr),
        inset: 0.25em,
        character.class,
        grid.hline(stroke: strokes.thin),
        character.spellcasting.focus,
        grid.cell(rowspan: 2)[
          #if character.spellcasting.ritualCasting [
            #loc("ui.spells.ritualcasting")
          ]
        ],
        propCap(loc("ui.spells.class")), propCap(loc("ui.spells.focus"))
      ),
      grid(
        columns: (1fr,) * propBox.len(),
        column-gutter: paddings(1),
        ..(propBox.map(spellPropBox))
      )
    )
  ]
}

#let spellsTable(..spells) = {
  show: spellBody
  set text(hyphenate: false)

  grid(
    columns: spellColumns,
    align: top + left,
    inset: paddings(0.75),
    grid.cell(align: center, tableHeader(loc("ui.spells.prepared"))),
    tableHeader(loc("ui.common.name")),
    grid.cell(align: center, tableHeader(loc("ui.spells.time"))),
    tableHeader(loc("ui.spells.duration")),
    tableHeader(loc("ui.spells.range")),
    tableHeader(loc("ui.spells.components")),
  )
  for spell in spells.pos() {
    spellBlock(spell)
  }
}

#let spellsSection(
  level: none,
  bottom: none,
  ..spells
) = {
  let levelRow = if level == none {()} else {
    (
      grid(
        columns: (1fr, 1fr),
        align: (left, right),
        level.name,
        level.slots
      ),
    )
  }
  [
    #grid(
      columns: 1,
      inset: paddings(1),
      ..levelRow,
      spellsTable(..spells)
    )
  ]
}

// Processed spellbook formatters

#let schoolFromSpellbook(s) = {
  let schools = (
    abjuration: abjuration, conjuration: conjuration,
    divination: divination, enchantment: enchantment,
    evocation: evocation, illusion: illusion,
    necromancy: necromancy, transmutation: transmutation,
  )
  let key = s.at("school", default: none)
  if key != none { schools.at(key, default: none) }
}

// Spellbook formatters

#let castingTimeFromSpellbook(m) = {
  let withValueIfNeeded = (label) => {
    if m.value > 1 {
      [ #m.value #label ]
    } else {
      label
    }
  }
  if m.type == "action" {
    withValueIfNeeded(action)
  } else if m.type == "bonus_action" {
    withValueIfNeeded(bonusAction)
  } else if m.type == "reaction" {
    withValueIfNeeded(reaction)
  } else if m.type == "minute" {
    minute(m.value)
  } else if m.type == "hour" {
    hour(m.value)
  } else {
    withValueIfNeeded(m.value)
  }
}

#let castTypeFromSpellbook(m) = {
  let castType = ()

  if m.is_ritual {
    castType.push(ritual)
  }

  if m.with_concentration {
    castType.push(concentration)
  }

  castType.join()
}

#let durationFromSpellbook(m) = {
  if "duration" not in m or m.duration == none {
    permanent
  } else if m.duration == 0 {
    instant
  } else if m.duration < 60 {
    round(m.duration / 6)
  } else if m.duration < 3600 {
    minute(m.duration / 60)
  } else if m.duration < 86400 {
    hour(m.duration / 3600)
  } else {
    day(m.duration / 86400)
  }
}

#let targetFromSpellbook(s) = {
  if s.at("target", default: none) == none {
    none
  } else {
    eval(
      s.target,
      scope: (
        self: self,
        touch: touch,
        target: target,
        point: point,
        circle: circle,
        ring: ring,
        square: square,
        cube: cube,
        sphere: sphere,
        straightLine: straightLine,
        cone: cone,
        sight: sight,
        unlimited: unlimited,
        cylinder: cylinder,
        rectangle: rectangle
      )
    )
  }
}

#let componentsFromSpellbook(s) = {
  s.components.components.join()
}

#let requiredComponentsFromSpellbook(s) = {
  let isRequired = false
  let isConsumed = false

  if s.components.material_required == true {
    isRequired = true
  }
  if s.components.material_consumed == true {
    isConsumed = true
  }

  if isRequired or isConsumed {
    [ *
      #loc("ui.spells.requires")
      #s.components.material
      #if isConsumed {
        loc("ui.spells.consumed")
      }
      *
    ]
  }
}

#let spellFromSpellbook(s, ..etc) = {
  let sp = spell(
    s.name,
    school: schoolFromSpellbook(s),
    castTime: castingTimeFromSpellbook(s.casting_time),
    castType: castTypeFromSpellbook(s),
    duration: durationFromSpellbook(s),
    range: targetFromSpellbook(s),
    components: componentsFromSpellbook(s),
    ..etc,
  )[
    #if "body" in s {
      eval(s.body, scope: spellBodyDSLScope, mode: "markup")
    }
    #requiredComponentsFromSpellbook(s)
  ]
  (id: s.id, ..sp)
}

#let allSpells() = {
  for i in range(10) [
    #subsection[#i #loc("spell.level.label")]
    #spellsTable(
      ..(
        spellbook().filter(
          is_spell_at_level.with(level: i)
        ).map(
          s => spellFromSpellbook(s, prep: preparing)
        )
      )
    )
  ]
}

#let allSpellsFromSpellbook(class, subclass, lvl) = {
  for i in range(lvl) [
    #subsection[#i #loc("spell.level.label")]
    #spellsTable(
      ..(
        spellbook().filter(
          is_spell_for_class.with(class: class, subclass: subclass)
        ).filter(
          is_spell_at_level.with(level: i)
        ).map(
          s => spellFromSpellbook(s, prep: preparing)
        )
      )
    )
  ]
}

#let spellPages(char) = {
  let charSpells = char.at("spells", default: none)
  if charSpells == none { return }

  let hasSpells = (
    charSpells.cantrips.len() > 0
    or charSpells.byLevel.values().any(list => list.len() > 0)
  )
  if not hasSpells { return }

  set page(header: section(loc("ui.pages.spells")))
  pagebreak()

  spellcasting(char)
  spellSlotsSection(char)

  if charSpells.cantrips.len() > 0 {
    spellsSection(level: cantrip, ..charSpells.cantrips)
  }

  for lvl in charSpells.byLevel.keys().map(int).sorted() {
    let spellList = charSpells.byLevel.at(str(lvl))
    if spellList.len() > 0 {
      spellsSection(level: spellLevel(lvl), ..spellList)
    }
  }
}
