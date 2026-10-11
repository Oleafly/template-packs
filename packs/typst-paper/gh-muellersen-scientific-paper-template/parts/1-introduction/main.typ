#import "../../config/environment.typ" as env
#import "../../config/state.typ": bib_state

#context bib_state.get()

= Introduction <introduction>
#v(0.5em)
#par(first-line-indent: 0em)[
  #heading("MiniChapterName", outlined: false, level: 5) <MiniChapterNameRef>
  #lorem(150) @mustermann2025
]
#lorem(100) #footnote[#lorem(10)]


== Subsection
Reference equations @def_amount

$ "amount" = sum^n_(i=1) x_i dot c_i $ <def_amount>

Inline math can be done like this $x = sum^n_(i=1) x_i$ ok

=== Examples

_Enumerations_

#enum(indent: 1em, numbering: it => strong[#it.], spacing: 1.5em, tight: false)[
  *Verbesserung der Klassifikation, indem mehr _tatsächlich pure_ Funktionen als _pure_ klassifiziert werden sollen.*
][
  *Reduzierung der Laufzeit.*
]

Inline code like this ```py print("Hello World!")```

#list(indent: 1em, spacing: 1.5em, tight: false)[
  foooooooooooooooooooooooooooooooooooooooo
][
  boooooooooooooooooooooooooooooooooooooooo
]

=== Figures

#figure(
  image("images/fooClass.png", width: 50%),
  caption: [Codeexample.]
) <FigureRef>


#import "@preview/subpar:0.2.2"
#subpar.super(
  kind: raw,
  grid(
    columns: (auto, auto),
    gutter: 10pt,
    [
      #figure(
        ```py
        def foo(x):
            y = 10
            result = x + y
            return result
        ```,
        caption:[_Pure_]
      ) <SimplePureFunctionListing>
    ],
    [
      #figure(
        ```py
        def foo(x):
            y = global_variable # impure
            result = x + y
            return result
        ```,
        caption: [_Impure_]
      ) <ImpureFunctionGlobalReadListing>
    ],
  ),
  caption: [Nested Figures.],
  label: <PureImpureExample>
)

=== Listings

#figure(
  ```py
  from math import inf
  def foo(lol: int) -> list[int] | None:
      return "wtf" + str(lol)
  ```,
  caption: [ok]
) <listingRef>

=== Tables

#figure(
  table(
    columns: (auto, auto, auto),
    column-gutter: (auto, 2.2pt, auto),
    inset: 7pt,
    align: horizon,
    table.header(
      table.cell(colspan: 2, "Schlüssel"),
      "Wert"
    ),
    [*_function_*], [*_amount_*], [*_return value_*],
    [_find_change_], [4], [[2, 2]],
    [_find_change_], [3], [[1, 2]],
    [_find_change_], [2], [[2]],
    [_find_change_], [1], [[1]],
    [_find_change_], [0], [[ ]]
  ), 
  caption: [hm]
) <TableRef>