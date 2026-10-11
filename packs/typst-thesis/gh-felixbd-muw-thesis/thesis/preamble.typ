// see: https://www.meduniwien.ac.at/web/fileadmin/content/kommunikation/vorlagen/220314_Farbdefinitionen.pdf

// see: https://www.meduniwien.ac.at/web/fileadmin/content/kommunikation/vorlagen/220303_MedUni_Styleguide.pdf
// (pp. 14)

#let dunkelblau = rgb("#111d4e")  //  17/29/78 100/85/0/58
#let hellblau   = rgb("#5fb4e5")  // 95/180/229 55/5/5/0
#let gruen      = rgb("#3cbfae")  // 60/191/174 65/0/40/0
#let coral      = rgb("#f0a794")  // 240/167/148 0/40/35/0

#let dunkelblau0 = rgb("#111d4e")  // 17/29/78 100/85/0/58

#let hellblau0 = rgb("#5fb4e5")  // 95/180/229 55/5/5/0
#let hellblau1 = rgb("#97CFEC")  // 151/207/236 44/4/4/0
#let hellblau2 = rgb("#B5DCF1")  // 181/220/241 33/3/3/0
#let hellblau3 = rgb("#CFE8F6")  // 207/232/246 22/2/2/0
#let hellblau4 = rgb("#E7F3FB")  // 231/243/251 11/1/1/0

#let gruen0 = rgb("#2f8e91")  // 60/191/174 65/0/40/0
#let gruen1 = rgb("#84C9BC")  // 132/201/188 52/0/32/0
#let gruen2 = rgb("#A8D7CD")  // 168/215/205 39/0/24/0
#let gruen3 = rgb("#C8E5DF")  // 200/229/223 26/0/16/0
#let gruen4 = rgb("#E4F2EF")  // 228/242/239 13/0/8/0

#let coral0 = rgb("#f0a794")  // 240/167/148 0/40/35/0
#let coral1 = rgb("#F8C0B0")  // 248/192/176 0/32/28/0
#let coral2 = rgb("#FAD1C4")  // 250/209/196 0/24/21/0
#let coral3 = rgb("#FCE1D8")  // 252/225/216 0/16/14/0
#let coral4 = rgb("#FDF0EB")  // 253/240/235 0/8/7/0


// --------------------------------------------------------------------------------

// page margins
// #import "@preview/marginalia:0.2.3" as marginalia: note, notefigure, wideblock

// for shorthand math notation
#import "@preview/quick-maths:0.2.1": shorthands

// for prooftrees
#import "@preview/curryst:0.5.1": rule, prooftree

// for checklists in md style
#import "@preview/cheq:0.2.2": checklist

// for code blocks / listings
#import "@preview/zebraw:0.5.5": zebraw

// for nice tables in md format
#import "@preview/tablem:0.2.0": tablem, three-line-table

// for book layout
#import "@preview/bookly:2.0.0": *

// for dropped capitals
#import "@preview/droplet:0.3.1": dropcap as dropcap-original

// for theorems / proofs / definitons
#import "@preview/lemmify:0.1.8": *
#let (
  theorem, lemma, corollary,
  remark, proposition, example,
  proof, rules: thm-rules
) = default-theorems("thm-group", lang: "en")


#import "@preview/shadowed:0.2.0": shadowed as shadowed-original

#let shadowed(..args) = shadowed-original(
  radius: 4pt, inset: 12pt, ..args
)

/*
#import "@preview/equate:0.3.2": equate

#show: equate.with(
  breakable: true,
  sub-numbering: true
)
*/

// #set math.equation(numbering: "(1.1)")


#let show-only-on-page-n(page-number: 1, body: none) = context {
  if counter(page).at(here()).first() == page-number { body }
}

#let dropcap-counter = counter("dropcap-counter")
#dropcap-counter.update(0)

#let dropcap(x) = {
  dropcap-counter.step()
  
  dropcap-original(
    // hanging-indent: 1em,
    // overhang: 8pt,
    // font: "Fira Code",
    height: 3,
    justify: true,
    gap: 4pt,
    transform: letter => context {
      let height = measure(letter).at("height", default: 3mm)
      let current-chapter-mod-3 = calc.rem( counter(heading).at(here()).first(), 3)
  
      grid(columns: 2, gutter: 6pt,
        align(center + horizon,
          text(fill: dunkelblau.lighten(20%))[
            #if current-chapter-mod-3 == 0 {
              $bb(#letter)$
            }
            #if current-chapter-mod-3 == 1 {
              $frak(#letter)$
            }
            #if current-chapter-mod-3 == 2 {
              $cal(#letter)$
            }
          ]
         // text(font: "Goudy Initialen")[h]
        ),
        // Use "place" to ignore the line's height when
        // the font size is calculated later on.
        place(horizon, line(
          angle: 90deg,
          length: height + 6pt,
          stroke: dunkelblau.lighten(60%) + 1pt
        )),
      )
    }
  )[#x]
}



#let my-config(
  is-draft: false,
  doc
) = {
  set page(paper: "a4")
  
  show: thm-rules

  // add outlines (table of theorems, etc.) to toc
  show outline: set heading(outlined: true)

  // line numbers
  set par.line(numbering: if is-draft { "a" } else { none })

  // show: marginalia.setup.with(
    // inner: ( far: 5mm, width: 15mm, sep: 5mm ),
    // outer: ( far: 5mm, width: 15mm, sep: 5mm ),
    // top: 2.5cm,
    // bottom: 2.5cm,
    // book: false,
    // clearance: 12pt,
    /* inner: (far: 11mm, width: 20mm, sep: 8mm),
    outer: (far: 11mm, width: 40mm, sep: 8mm),
    top: 32mm + 11pt,
    bottom: 16mm,
    book: true, */
    // clearance: 30pt,
  // )

  /* show: marginalia.show-frame.with(
    stroke: 2pt + gray.transparentize(70%), // if is-draft {  } else { none }
  ) */
  
  // draft info in background
  set page(
    background: if not is-draft { none } else {
      rotate(24deg,
        pdf.artifact(
          text(45pt, fill: rgb(80%, 20%, 20%, 25%))[
            Unpublished working draft. \
            Not for distribution.
          ]
        )
      )
    }
  )

  
  
  show quote: e => {
    shadowed[
      #sym.quote.chevron.r.double
      #h(0pt, weak: true)
      #e.body
      #h(0pt, weak: true)
      #sym.quote.chevron.l.double
      #if e.attribution != none [
        #set align(right)
        --- #e.attribution
      ]
    ]
  }

  show: shorthands.with(
    ($+-$, $plus.minus$),
    ($-+$, $minus.plus$),
    ($|-$, math.tack),
    // ($Xb$, $bold(X)$),
    // ($yb$, $bold(y)$),
  )

  show: checklist.with(
    marker-map: (
      " ": sym.ballot,
      "x": sym.ballot.cross,
      "-": sym.bar.h,
      "/": sym.slash.double
    )
  )

  show heading: set text(
    fill: dunkelblau.lighten(10%),
    font: (
      "Libre Baskerville",
      "Libertinus Serif"
    ),
  )

  /*
  set text(
    font: (
      "Libertinus Serif",
      // "Fira Sans",
      // "Atkinson Hyperlegible Next",
      // "Atkinson Hyperlegible",
      // "Libertinus Serif",
      "New Computer Modern",
      "New Computer Modern Sans",
      "DejaVu Sans Mono",
      "Fira Sans",
    ),
    // slashed-zero: true,
  )
  */

  show raw: set text(
    font: (
      "Fira Code",
      "IBM Plex Mono",
      "IBM Plex Sans Devanagari"
    ),
  )
  
  /*
  show math.equation: set text(font:
    (
      // "Atkinson Hyperlegible",
      // "Fira Math",
    )
  )
  */
  
  set par(justify: true)

  set cite(style: "alphanumeric")

  doc
}

