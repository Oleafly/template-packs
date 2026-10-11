#import "@preview/abbr:0.2.3"
#import "/utils.typ": load-bibliography, cite-abbr, cite-title, chapter-ref, zebraw, TODO, todo

#load-bibliography(main: false)

= Introduction
<ch:introduction>

#lorem(20)

== Different ways of citing a bibliography entry

This is a default citation #cite(<zygos>). \
This cites the abbrevated title #cite-abbr(<zygos>, enclosing: true). \
You can choose to have enclosing brackets or not #cite-abbr(<zygos>, enclosing: false). \
This cites the full title #cite-title(<zygos>, include-citation: true). \
This prints the full title without a citation at the end #cite-title(<zygos>, include-citation: false). \

== Other features

#chapter-ref(<ch:introduction>) is a reference to this chapter.

#TODO[this is a TODO note]

#lorem(15) #todo[this is an inline todo] #lorem(20) #todo(color: blue)[this is a blue inline todo] #lorem(15)

#abbr.a[KIT] is an abbreviation.
The next time it is used it is automatically shortened to #abbr.a[KIT].

Code snippets with highlightable lines can be done like this:

#zebraw(
  highlight-lines: (2,)
)[
  ```typst
  #zebraw(
    highlight-lines: (2,)
  )[
    // place a code block here
  ]
  ```
]
