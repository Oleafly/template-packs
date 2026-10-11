#import "../core/core.typ": *
#import "../game/proficiencies.typ": *

#let proficiencies(..proficiencies) = page(
  header: section(loc("ui.pages.proficiencies"))
)[

  #columned(separator: false)[
    #let proficiencyBlockStyle(body) = {
      set text(hyphenate: false)
      set text(top-edge: 0.5em)

      body
    }

    #let toolProficiencyBlock(proficiency) = [
      #show: proficiencyBlockStyle
      #v(0.8em)
      #abilityHeader(proficiency.title)\
      #if proficiency.source != none [
        #abilitySource(proficiency.source)
      ]

      #for item in proficiency.items [
        - #item\
      ]

      #for action in proficiency.actions [
        #table(
          stroke: none,
          inset: 0pt,
          gutter: 0.75em,
          columns: (1fr, auto),
          [*#actionName(action.name)*],
          mapOrNone(
            action.dc,
            v => actionName[dc #v]
          ),
          ..arrayOrNone(action.body).map(v => table.cell(colspan: 2, v))
        )
      ]

      #for skillEffect in proficiency.skillsEffects [
        *#skillEffect.skills.pos().join(", ")*:
        #skillEffect.body\
      ]
    ]

    #let simpleProficiencyBlock(proficiency) = [
      #show: proficiencyBlockStyle
      #v(0.8em)
      #simpleProficiencyTitle(proficiency.title)\
      #if proficiency.source != none [
        #abilitySource(proficiency.source)
      ]
    ]

    #renderItems(proficiencies.pos(), proficiency => [
      #if proficiency.class == tool {
        toolProficiencyBlock(proficiency)
      } else {
        simpleProficiencyBlock(proficiency)
      }\
    ])
  ]
]
