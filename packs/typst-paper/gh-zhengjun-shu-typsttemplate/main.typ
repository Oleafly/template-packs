#import "style/cvpr.typ": cvpr
#import "style/default_set.typ": *

#show: cvpr.with(
  paperType: "final",
  title: "Author Guidelines for CVPR Proceedings",
  author_info: [
    #grid(columns: 2, gutter: 3em)[
      #text(size: confFontSize.normal)[
        First Author \
        Instritution1 \
        Instribution1 address \
        #text(size: confFontSize.small)[
          #textlink[firstauthor\@il.org]
        ]
      ]
    ][
      #text(size: confFontSize.normal)[
        Second Author \
        Instritution2 \
        Instribution2 address \
        #text(size: confFontSize.small)[
          #textlink[secondauthor\@i2.org]
        ]
      ]
    ]
  ],
  paperId: "*****",
)

#include "./sec/0_abstract.typ"
#include "./sec/1_intro.typ"
#include "./sec/2_formatting.typ"
#include "./sec/3_finalcopy.typ"

#bibliography("main.bib", title: "References")
