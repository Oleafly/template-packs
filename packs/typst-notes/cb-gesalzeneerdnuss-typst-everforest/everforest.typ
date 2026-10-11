// #import "@preview/fletcher:0.5.7" as fletcher: diagram, node, edge // all sort of diagrams
// #import "@preview/finite:0.4.1": automaton // finite state machines
// #import "@preview/lilaq:0.2.0" as lq // crazy Diagrams
// #import "@preview/lovelace:0.3.0": * // easy Pseudocode
// #import "@preview/showybox:2.0.4": showybox // pretty boxes
#import "@preview/zebraw:0.6.1": * 
#show: zebraw // codeboxes with line numbers and language display

// Sainnhe Everforest Dark Hard
#let bg          = rgb("#272e33")
#let raw-bg      = rgb("#2e383c")
#let box-bg      = rgb("#464e53")
#let text-color  = rgb("#d3c6aa")

#let ever(author: none, topic: none, doc) = {
  set text(12pt, fill: text-color, lang: "de")
  set page(fill: bg, margin: 2cm, numbering: "1", header: [#topic #h(1fr) #author])
  set raw(theme: "everforest_dark.tmTheme")
  set enum(numbering: "1.a.i)")
  set line(stroke: text-color)
  set table(
    stroke: text-color, 
    fill: (x, y) => if x == 0 or y == 0 { bg.lighten(17%) },
    // Header row is lighter
  )
  set math.equation(numbering:"(1)")
  show link: underline
  heading(outlined: false)[#topic]
  if topic != none {
    line(length: 100%)
  }
  v(1em)
  doc
}

#let def(type: none, name: none, emph: false, body) = {
  let a = arguments(radius: 2mm, stroke: none, fill: box-bg, inset: 0.5em, width: 100%, breakable: false)
  let b = arguments(radius: 2mm, stroke: text-color, fill: box-bg, inset: 0.5em, width: 100%, breakable: false)

  v(-2mm)
  if emph == false {
  block(..a)[ 
    #set text(13pt)
    #name $wide$ #h(1fr) $wide$ #type
    #set text(12pt)
    #v(-2mm)
    #body
  ]
} else {
  block(..b)[ 
    #set text(13pt)
    #name $wide$ #h(1fr) $wide$ #type
    #set text(12pt)
    #v(-2mm)
    #body
  ]
}
  
}

// general purpose
#let ang(it) = [$chevron.l #it chevron.r$]
#let eval(it) = [$[|#it|]$]
#let BIN = [BIN]
#let widerspruch = [#text(fill: red)[$arrow.zigzag$]]
#let sc(it) = [#smallcaps[#it]]
#let quer(it) = [$overline[#it]$]
#let cross = [$times$]

// calligraphy letter shorthands
#let aA = [$cal(A)$]
#let bB = [$cal(B)$]
#let cC = [$cal(C)$]
#let iI = [$cal(I)$]
#let jJ = [$cal(J)$]
#let kK = [$cal(K)$]
#let lL = [$cal(L)$]
#let mM = [$cal(M)$]
#let nN = [$cal(N)$]
#let pP = [$cal(P)$]
#let rR = [$cal(R)$]
#let sS = [$cal(S)$]
#let tT = [$cal(T)$]
#let zZ = [$cal(Z)$]

// complexity Theory
#let DTIME = [DTIME]
#let NTIME = [NTIME]
#let coNTIME = [coNTIME]
#let NP = [NP]
#let coNP = [coNP]
#let P = [P]
#let time = [time]
#let pr = [$ attach(<=, tr: p, br: m) $]

// Logik
// #show math.models: $tack.double$
#let AL = [AL]
#let AVar = [#smallcaps[AVar]]
#let FO = [FO]
#let FO(it) = [FO\[#it\]]

// Stochastik und Statistik
#let Ex(it) = [$EE[#it]$]
#let Var = [$VV"ar"$]
#let Cov = [Cov]
#let Corr = [Corr]

#show: doc => ever(
  doc,
)
