#import "../just_pres.typ": *

#set text(font : "Libre baskerville")

#show: slides.with(
  title: "Typst",
  subtitle: "Typesetting made simple",
  authors: "Anush M",
)

== OUTLINE

#outline()

= Typesetting

== Users for typesetting
#linebreak()
#import "@preview/twig:0.1.0": list-to-tree, tree-to-cetz
#import "@preview/cetz:0.4.0"
#set align(center+top)
// suffix tree for "babidibidi"
#cetz.canvas({
  import cetz.draw: *
  tree-to-cetz(
    list-to-tree([
      - #[]
        / \ : *common usage*
        / \ : *developers*
        / \ : *research*
    ]),
    draw-node: (node, ..) => {
      circle((), radius: 0.3, fill: blue, stroke: none)
      content((), text(black, [
        #linebreak()
        #linebreak()
        #node.content
        #linebreak()
        ]))
    },
    grow: 4,
    spread: 3.5,
    parent-position: "center",
  )
})

#set align(center)
= Typst

== similarities with markdown
#table(
  columns: 2,
  column-gutter: 20pt,
  row-gutter : 25pt,
  inset:2pt,
  stroke: none,
  [*Markdown*], [*Typst*],
  [#set text(size:15pt);#raw(block: true, lang: "md" ,"# header1 ")], [#set text(size:15pt);#raw(block: true, lang: "typst" ,"= header1 ")],
  [#set text(size:15pt);#raw(block: true, lang: "md", "## header2 "); ], [#set text(size:15pt);#raw(block: true, lang: "typst" ,"== header2 ")],
  [#set text(size:15pt);#raw(block: true, lang: "md", "### header3 ")], [#set text(size:15pt);#raw(block: true, lang: "typst" ,"=== header3 ")],
  [#set text(size:15pt);#raw(block: true, lang: "md", "#### header4 ")], [#set text(size:15pt);#raw(block: true, lang: "typst" ,"==== header4 ")],
  [*Markdown*], [*Typst*],
  [#set text(size:15pt);#raw(block: true, lang: "md", " - bullet1 \n - bullet2 \n - bullet3")], [#set text(size:15pt);#raw(block: true, lang: "typst" ," - bullet1 \n - bullet2 \n - bullet3")],
  [#set text(size:15pt);#raw(block: true, lang: "md", "_emphasise things_ ")], [#set text(size:15pt);#raw(block: true, lang: "typst" ,"_emphasise things_")],
  [#set text(size:15pt);#raw(block: true, lang: "md", "**bold text**\n")], [#set text(size:15pt);#raw(block: true, lang: "typst" ,"*bold text*\n")],
  [],[],
  [*Markdown*], [*Typst*],
  [#set text(size:15pt);#raw(block: true, lang: "md", " ```python\nprint(\"hello\") \n``` ")], [#set text(size:15pt);#raw(block: true, lang: "typst" ," ```python\n print(\"hello\") \n ```")],
  [#set text(size:15pt);#raw(block: true, lang: "md", " --- ")], [#set text(size:15pt);#raw(block: true, lang: "typst" ," ---")],
)

== Differences to markdown
=== Generic differences
#linebreak()
#table(
  columns: 2,
  column-gutter: 20pt,
  row-gutter : 25pt,
  inset:2pt,
  stroke: none,
  [*Markdown*], [*Typst*],
  [#set text(size:15pt);#raw(block: true, lang: "md" ,"[link name](https://example.com)")], [#set text(size:15pt);#raw(block: true, lang: "typst" ,"#link(\"https://example.com\")[link name]")],
  [#set text(size:15pt);#raw(block: true, lang: "md", "~strike through~"); ], [#set text(size:15pt);#raw(block: true, lang: "typst" ,"#strike(\"strike through\")")],
)
#linebreak()
= Typst Syntax
== basic logic
#let x = 5
#table(
  columns: 2,
  column-gutter: 2pt,
  row-gutter : 20pt,
  inset:3pt,
  stroke: none,
  [*Code*], [*Output*],
  [#set text(size:15pt);#raw(block: true, lang: "typst" , "#let x = 5"+"\n" + "#x")], [#x],
  [#set text(size:15pt);#raw(block: true, lang: "typst", "#let x = 5\n#if x > 3 { \"big\" } else { \"small\" }\n")], [#let x = 5; #if x > 3 { "big" } else { "small" }],
  [#set text(size:15pt);#raw(block: true, lang: "typst","#let arr = (1, 2, 3);\n#arr"); ], [#let arr = (1, 2, 3); #arr],
  [*Code*], [*Output*],
  [#set text(size:15pt);#raw(block: true, lang: "typst", "#let dict = (name: \"Typst\", year: 2022)\n#dict")], [#let dict = (name: "Typst", year: 2022); #dict],
  [#set text(size:15pt);#raw(block: true, lang: "typst", "#let dict = (name: \"Typst\", year: 2022)\n#dict.keys()\n#dict.values()\n ")], [#let dict = (name: "Typst", year: 2022); #dict.keys(); #dict.values()],
  [*Code*], [*Output*],
  [#set text(size:14pt);#raw(block: true, lang: "typst", "#let add = (a, b) => a + b\n#add(2, 3)\n")], [#let add = (a, b) => a + b; #add(2, 3)],
  [#set text(size:15pt);#raw(block: true, lang: "typst", "#let arr = (1, 2, 3)\n#arr.map(x => x * 2)\n")], [#let arr = (1, 2, 3); #arr.map(x => x*2)],
  [#set text(size:15pt);#raw(block: true, lang: "typst", "#(1, 2, 3).map(x => str(x)).join(\" \")\n")], [#(1, 2, 3).map(x => str(x)).join(" ")],
)
== Solving the N-Queens problem in typst


```typc
#let n-queens(n) = {
  let is-safe(board, row, col) = {
    for r in range(0,row) {
      let c = board.at(r)
      if c == col or calc.abs(r - row) == calc.abs(c - col) {
        return false
      }
    }
    return true
  }

  let solve(board, row) = {
    if row >= n {
      return (board,)
    }
    let solutions = ()
    for col in range(0,n) {
      if is-safe(board, row, col) {
        solutions += solve(board + (col,), row + 1)
      }
    }
    return solutions
  }

  solve((), 0)
}


#let n = 5

#let solutions = n-queens(n)

#align(center)[
  Found #solutions.len() solutions for a #n x #n board.
]

[#solutions]


```

#let n-queens(n) = {
let is-safe(board, row, col) = {
  for r in range(0,row) {
    let c = board.at(r)
    if c == col or calc.abs(r - row) == calc.abs(c - col) {
      return false
    }
  }
  return true
}

let solve(board, row) = {
  if row >= n {
    return (board,)
  }
  let solutions = ()
  for col in range(0,n) {
    if is-safe(board, row, col) {
      solutions += solve(board + (col,), row + 1)
  }
  }
  return solutions
}

solve((), 0)
}


#let n = 5

#let solutions = n-queens(n)

#align(center)[
  Found #solutions.len() solutions for a #n x #n board.
]


#solutions
= Math and emojis

== Math symbols in typst

#linebreak()
#table(
  columns: 2,
  column-gutter: 25pt,
  row-gutter : 50pt,
  inset:2pt,
  stroke: none,
  [*Typst*], [*Output*],
  [#set text(size:15pt);#raw(block: true, lang: "typst" ,"$ (a + b)^2\n= a^2\n+ text(fill: #maroon, 2 a b)\n+ b^2 $\n")], [$ (a + b)^2
  = a^2
  + text(fill: #maroon, 2 a b)
  + b^2 $
],
  [*Typst*], [*Output*],
  [#set text(size:15pt);#raw(block: true, lang: "typst" ,"$ f(x, y) := \n cases(1 \"if\" (x dot y)/2 <= 0,\n 2 \"if\" x \"is even\", \n 3 \"if\" x in NN, \n 4 \"else\",) $"
)], [

  $ f(x, y) := cases(
  1 "if" (x dot y)/2 <= 0,
  2 "if" x "is even",
  3 "if" x in NN,
  4 "else",
) $

],

)
#linebreak()

== Emojis
u

#table(
  columns: 2,
  column-gutter: 25pt,
  row-gutter : 50pt,
  inset:2pt,
  stroke: none,
  [*Typst*], [*Output*],
  [#set text(size:15pt);#raw(block: true, lang: "typst" ,"$ sum^10_(🥸=1)\n#rect(width: 4mm,\nheight: 2mm)/🥸\n= 🧠 maltese $")],[
    $ sum^10_(🥸=1)
  #rect(width: 4mm, height: 2mm)/🥸
  = 🧠 maltese $

  ])
  
= Why not LaTeX

== some advantages
#set align(center+horizon)
- Typst has more dedicated syntax for complex types
#linebreak()
- Typst compiles faster 
#linebreak()
- Lower learning curve
#linebreak()
== some disadvantages
- Plotting systems 
#linebreak()
- Including PDFs as images
#linebreak()
- Changing page margins without a pagebreak
#linebreak()

= Fun with Typst

= Miscellaneous

== References

#show link:underline

You can get the template for this presentation #link("https://github.com/anushm55/typst_presentation_template")[here]

#linebreak()

#link("https://typst.app/docs")[Typst Documentation]

#linebreak()


#link("https://www.overleaf.com/learn")[Overleaf documentation]


#linebreak()

#link("https://typst.app/universe/")[Typst Universe]
