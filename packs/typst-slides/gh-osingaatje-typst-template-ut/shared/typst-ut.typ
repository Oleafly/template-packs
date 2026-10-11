// HELPER METHODS
// inspired from https://forum.typst.app/t/how-to-reference-multiple-figures-at-once/7854/3
#let multiref(..args, join: ",", last: " and") = context{
  let tags = args.pos()
  let fig = query(tags.first()).first()
  let suppl = fig.supplement
  
  if tags.len() >= 2 { suppl + "s" } else { suppl }  // assumes we get the plural by adding an "s" to the singular form
  ref(tags.first(), supplement: "")  // figure number, alternatively our do something with the fig.counter
  for key in tags.slice(1, -1) {
    ref(key, supplement: join)
  }
  ref(tags.last(), supplement: last)
  // Figure 1; Figures 1 and 2; Figures 1, 2 and 3
}

// colors
#let blue = rgb("#007D9C")
#let lightblue = rgb("#E2EBFF")
#let darkblue = rgb("#005D7D")
#let navy = rgb("#002345")
#let darkgray = rgb("#404040")

#let colors = (
  blue: blue, 
  lightblue: lightblue,
  darkblue: darkblue, 
  navy: navy, 
  darkgray: darkgray
)

#let appendix(body) = {
  set heading(numbering: "A.1:", supplement: [Appendix])
  counter(heading).update(0)
  body
}

#let styling(citestyle: none, bibstyle: none, doc) = {
  if bibstyle == none {
    bibstyle = "bib/modified-ieee-all-authors.csl"
  }
  if citestyle == none {
    citestyle = "bib/modified-ieee.csl"  
  }

  // default citation style
  set cite(style: citestyle)
  set bibliography(style: bibstyle)

  // citation / reference / code fragment / figure caption styling (link styling at bottom of conf.typ)
  show cite: c => text(fill: blue, c)
  show ref: r => box(text(fill: blue, r))
  show raw: r => text(font: "Jetbrains Mono", r)
 
  show math.equation: m => text(font:"New Computer Modern Math", m) 

  show raw.where(block: true): code => {
    show raw.line: it => {
      text(fill: gray)[#it.number]
      h(1em)
      it.body
    } 
    code
  }

  show bibliography: b => [  #set par(leading: 0.5em); #b ]

  // footnote magic: settings the font size of the character
  set footnote(numbering: (t) =>
    box(height: 5pt, width: 3pt, inset: (top: -10pt),
      text(fill: blue, size: 28pt, str(t))
    )
  ) // some weird thing with the UT fonts I guess.
  set footnote.entry(clearance: 0.2em, separator: box(inset: (top: 1pt, bottom: 1pt), line(length: 35% + 0pt, stroke: 0.025em+navy)))

  //region: FONTS
  show title: t => text(
    font: "UniversNW02-720CdHeavy", 
    fill: white, 
    t
  )

  show heading.where(level: 1): t => text(
    font: "UniversNW02-720CdHeavy",
    block(below: .5em, upper(t))
  )
  show heading: t => text(
    font: "UniversNW02-320CdLt",
    t
  )
  show text: t => text(
    font: "UniversNextW02",
    t
  )
  //endregion

  //region: TABLES
  // fix line spacing in table newlines
  show table: t => {
    set par(leading: 0.35em)
    t
  }

  show table.cell.where(y: 0): c => { 
    set block(fill: rgb("#252525"))
    set text(fill: white)
    c
  }
  //endregion

  doc
}
