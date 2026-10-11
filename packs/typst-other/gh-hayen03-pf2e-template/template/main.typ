//#import "@preview/pf2e:1.0.0" : *
#import "../lib.typ": *

#show: it => pf2e(
  it,
  title: "PF2E Typst Template",
  subtitle: "",
  authors: (),
  columns: 1,
  title_page: false,
  content_table: true,
)

#banner[= PF2E Typst Template]
#col[
  #lorem(128)
  = First Level Heading
  #lorem(64)
  == Second Level Heading
  #lorem(64)
  === Third Level Heading
  #lorem(128)
  ==== 1st Level
  #let cool_feat = new_feat(
    "Cool Feat",
    level: 1,
    traits: "uncommon, human, other trait"
  )[
    This is a really cool feat. Check it out.

    #lorem(24)
  ]
  #mk(cool_feat)
]