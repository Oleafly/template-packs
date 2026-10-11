#import "../core/core.typ": *
#import "../game/game.typ"

#let statDescription(character, stat) = {
  vstack(
    pad(top: 0.5em)[
      #propBody(game.statModifier(character, stat))
    ],
    pad(top: 1em)[
      #game.statValue(character, stat)
    ]
  )
}

#let saveDescription(character, stat) = {
  skillBody(saveModifier(character, stat))
}

#let proficiencyMark(character, value, proffMethod) = {
  let proffs = method(character, proffMethod)
  if proffs != none and proffs.contains(value) {
    [+]
  }
}

#let statsGrid(
  character,
  names: game.stats
) = framed(fitting: expand)[
  #grid(
    columns: 100%,
    gutter: paddings(1),
    rows: 1fr,
    ..names.map(c => [
      #framed(fitting: expand, insets: 0pt, stroke: strokes.normal)[
        #grid(
          columns: 100%,
          rows: (1fr, auto),
          statDescription(character, c),
          grid.hline(stroke: strokes.normal),
          pad(y: paddings(1), charStat(game.statName(c)))
        )
      ]
    ])
  )
]

#let savingRolls(character) = table(
  columns: (1fr, 10mm, 1fr, 10mm),
  stroke: innerRowStrokes(),
  // ---
  ..(for stat in game.stats {
    (
      statBody[#game.saveModifier(character, stat)],
      statCaption[#game.statName(stat)#proficiencyMark(character, stat, c => c.saveProfs)]
    )
  })
)

#let deathSavesCheckboxes(caption) = grid.cell(colspan: 2)[
  #propCap(caption)
  #box[
    #rect(width: 12mm, height: 1mm)
    #place(center + horizon)[
      #checkboxes(3, size: 2.5mm, padding: 100%, shape: circle.with(fill: white))
    ]
  ]
]

#let deathSaves() = grid(
  columns: (auto, auto),
  rows: (auto, auto),
  gutter: paddings(1),
  // ---
  propCap(loc("ui.charlist.destinypoints")), propCap(loc("ui.charlist.inspiration")),
  checkboxes(3), checkboxes(1),
  deathSavesCheckboxes(loc("ui.charlist.success")),
  deathSavesCheckboxes(loc("ui.charlist.failure"))
)

#let rollsCaption(caption: none, body) = figure(
  caption: propCap(caption),
  supplement: none,
  numbering: none,
  body
)

#let saves(character) = grid(
  columns: (1fr, auto, auto),
  gutter: paddings(0.5),
  inset: paddings(0.5),
  // ---
  rollsCaption(caption: loc("ui.charlist.savingroll"))[
    #savingRolls(character)
  ],
  line(length: 100%, angle: 90deg, stroke: strokes.hairline),
  rollsCaption(caption: loc("ui.charlist.deathsaves"))[
    #deathSaves()
  ]
)

#let skillsGrid(character) = grid(
  columns: 100%,
  rows: (auto, 1fr),
  row-gutter: paddings(1),
  // ---
  framed(fitting: expand-h)[
    #saves(character)
  ],
  framed(fitting: expand, insets: (x: paddings(2), y: 0pt))[
    #table(
      columns: (18mm, 1fr, 10mm),
      rows: 1fr,
      stroke: innerRowStrokes(),
      align: (auto, left, center),
      // ---
      ..(for skill in game.skills {
        (
          skillBody(game.skillModifier(character, skill.skill)),
          [
            #game.skillName(skill.skill)
            #proficiencyMark(character, skill.skill, c => c.skillProfs)
          ],
          statCaption(
            fill: colors.secondary,
            game.statName(skill.stat)
          )
        )
      })
    )
  ]
)

#let propsSeparator = line(stroke: strokes.thin, length: 100% + paddings(2), angle: 0deg)

#let healthPropBox = propBox.with(shape: heart, dy: -0.25em)

#let propsGrid(character) = framed(fitting: expand)[
  #grid(
    columns: 100%,
    rows: (auto, auto, 1fr, auto, auto, auto, 1fr, auto),
    row-gutter: paddings(1),
    // ---
    propBox(
      content: game.initiativeModifier(character),
      caption: loc("ui.charlist.initiative")
    ),
    badge(
      width: 4mm,
      height: 4mm,
      content: [ #method(character, c => c.baseArmorClass, default: game.baseArmorClass) ]
    )[
      #propBox(
        shape: shield, dy: -0.25em,
        caption: loc("ui.charlist.ac")
      )
    ],
    propsSeparator,
    healthPropBox(
      content: method(character, c => c.maxHp),
      caption: loc("ui.charlist.max")
    ),
    badge(
      width: 60%,
      height: 4mm,
      content: method(character, c => c.hitDices)
    )[
      #healthPropBox(caption: loc("ui.charlist.current"))
    ],
    healthPropBox(caption: loc("ui.charlist.temporary")),
    propsSeparator,
    propBox(
      content: game.profBonus(character),
      caption: loc("ui.charlist.profbonus")
    ),
    propBox(
      content: game.walkingSpeed(character),
      caption: loc("ui.charlist.movement")
    )
  )
]

#let charlist(
  character
) = page[
  #grid(
    columns: (20mm, 1fr, 21mm),
    rows: (auto, 1fr),
    gutter: paddings(1),
    // ---
    grid.cell(colspan: 2)[
      #characterName(character.name)
        #table(
          columns: (1fr, 1fr),
          align: (left, right),
          inset: 2pt,
          stroke: none,
          [ #character.class, #character.subclass ], character.alignment,
          [ #character.race, #character.type ], character.story,
        )
    ],
    grid.cell[
      #pad(paddings(1))[
        #propBox(
          content: character.level,
          caption: loc("ui.charlist.level")
        )
      ]
    ],
    statsGrid(character), skillsGrid(character), propsGrid(character)
  )
]
