#import "@preview/lovelace:0.3.1": *

#let commentcolor = rgb("#009900")
#let keywordcolor = rgb("#EB008B")
#let errorcolor = rgb("#FF0000")
#let stringcolor = rgb("#8c0099")

#let psc(
  title: none,
  booktabs: true,
  line-numbering: "1",
  line-numbering-alignment: horizon + right,
  line-number-supplement: "Step",
  stroke: gray + 1pt,
  hooks: .5em,
  indentation: 1em,
  line-gap: .5em,
  body,
) = pseudocode-list(
  [#body],
  title: if title != none { smallcaps(title) } else { none },
  booktabs: booktabs,
  line-numbering: line-numbering,
  line-numbering-alignment: line-numbering-alignment,
  line-number-supplement: line-number-supplement,
  stroke: stroke,
  hooks: hooks,
  indentation: indentation,
  line-gap: line-gap,
)

#let cm(body) = [
  #text(fill: commentcolor,
        font: ("CMU Typewriter Text", "DejaVu Sans Mono"))[\/\/#body]
]

#let keyword(body) = [
  #text(fill: keywordcolor, weight: "semibold")[#body]
]

#let psfor(body) = [
  #keyword[For] #body #keyword[do]
]

#let psforeach(body) = [
  #keyword[For each] #body #keyword[do]
]

#let pswhile(body) = [
  #keyword[While] #body #keyword[do]
]

#let psif(body) = [
  #keyword[If] #body #keyword[then]
]

#let pselseif(body) = [
  #keyword[Else if] #body #keyword[then]
]

#let pselse = [
  #keyword[Else]
]

#let psreturn(body) = [
  #keyword[Return] #body
]

#let psbreak = [
  #keyword[Break]
]

#let pscontinue = [
  #keyword[Continue]
]

#let psfntxt(body) = [
  #text(font: ("CMU Typewriter Text", "DejaVu Sans Mono"), weight: "semibold")[#body]
]

#let psfn(name, params) = [
  #keyword[Function] #psfntxt[#name] (#text(font: ("CMU Typewriter Text", "DejaVu Sans Mono"))[#params])
]

#let psstruct(name, fields) = [
  #keyword[Struct] #psfntxt[#name] #if (fields == []) {} else [{#fields}]
]

#let pserror(body) = [
  #text(fill: errorcolor, weight: "semibold")[Error] #body
]

#let psprint(body) = [
  #keyword[Print] #body
]

#let psstring(body) = [
  #text(fill: stringcolor, font: ("CMU Typewriter Text", "DejaVu Sans Mono"))[#body]
]

#let psfncall(name, args) = [
  #psfntxt[#name] (#text(font: ("CMU Typewriter Text", "DejaVu Sans Mono"))[#args])
]

#let psstructinst(name, fieldvals) = [
  #psfntxt[#name] {#fieldvals}
]

#let psbigtext(body) = [
  #text(weight: "semibold")[#body]
]

#let psto = [
  #psbigtext[To]
]
