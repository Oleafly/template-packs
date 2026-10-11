#import "../core/core.typ": *

#let abilities(title: loc("ui.pages.abilities"), ..abilities) = page(
  header: section(title)
)[
  #let abilityBlock(ability) = [
    #set text(hyphenate: false)
    #set text(top-edge: 0.5em)
    #v(0.8em)
    #abilityHeader(ability.title)\
    #if ability.source != none [
      #abilitySource(ability.source)
    ]

    #ability.body
  ]

  #columned(separator: false)[
    #renderItems(abilities.pos(), ability => [ #abilityBlock(ability)\ ])
  ]
]
