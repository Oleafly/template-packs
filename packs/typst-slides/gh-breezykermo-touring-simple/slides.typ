#import "@preview/touying:0.6.1": *
#import "simple-theme.typ": *

// Dark mode configuration
#let accent-color = rgb("#ffd700")
#let bg-color = rgb("#2b2b2b")
#let text-color = rgb("#e0e0e0")
#let dimmed-color = rgb("#808080")

#show: simple-theme.with(
  aspect-ratio: "16-9",
  primary: accent-color,
  background-color: bg-color,
  text-color: text-color,
  dimmed-color: dimmed-color,
  footer: [],
  footer-right: none,
)

#set align(center)
#set text(size: 20pt, font: "Inter Variable")

// Global blockquote styling
#show quote.where(block: true): it => {
  set align(center)
  block(
    width: 80%,
    inset: 20pt,
    fill: rgb("#3a3a3a"),
    radius: 5pt,
    stroke: .5pt + accent-color,
  )[
    #set text(style: "italic", size: 18pt)
    #set align(left)
    #it.body
  ]
}

// Style level 1 headings (title slide) with accent color
// These MUST come after the theme show rule
#show heading.where(level: 1): set text(fill: accent-color, weight: "bold")

// Style level 2 headings (slide titles) with accent color
#show heading.where(level: 2): set text(fill: accent-color, weight: "bold")

= The machine that therefore I am 

== 

== 
#quote(block: true)[
[I]n circulation M-C-M both the money and the commodity function only as different modes of existence of value itself, the money as its general mode of existence, the commodity as its particular or, so to speak, disguised mode.
It is constantly changing from one form into the other, without becoming lost in this movement; it thus becomes transformed into an *automatic subject*....
By virtue of being value, it has acquired the occult ability to add value to itself.
It brings forth living offspring, or at least *lays golden eggs*. \ \
---p.255 (Penguin Classics edition)
]
== 
#show math.equation: set text(30pt)
$ #let color(x) = text(fill: accent-color, $#x$)
vec("Marx", "Descartes", "Freud", delim: "{")
  "Turing"
  vec("machine", "test", "pattern", delim: "{")
  "automatic" 
  vec("subject", "language", "intelligence", delim: "{")$
== 
$ vec(color("Marx"), "Descartes", "Freud", delim: "{")
  color("Turing")
  vec(color("machine"), "test", "pattern", delim: "{")
  color("automatic")
  vec(color("subject"), "language", "intelligence", delim: "{")$
==

==
$ color("Turing") vec( "Babbage",  delim: "{") "Marx"$

== 
#show math.equation: set text(45pt)
$vec("store", "control", "executive unit", delim: "{")$
== 
$vec(color("store"), "control", "executive unit", delim: "{")$
== 
$vec("store", color("control"), "executive unit", delim: "{")$
== 
$vec("store", "control", color("executive unit"), delim: "{")$
== 
$color("automatic") vec("store", "control", "executive unit", delim: "{") "machine"$
==
#show math.equation: set text(30pt)
$ "Turing" vec( color("Babbage"),  delim: "{") "Marx"$
==
$ "Turing" vec( "Babbage",  delim: "{") color("Marx")$
==
#quote(block: true)[
All fully developed machinery consists of essentially three parts: the *motor mechanism*, the *transmitting mechanism*, and finally the tool or *working machine*.
The motor mechanism acts as the driving force of the mechanism as a whole.
It either generates its own motive power, like the steam-engine, the caloric-engine, the electro-magnetic machine, etc., or it recieves its impulse from some already existing natural force, like the water-wheel from the descent of water down an incline, the windmill from the wind, and so on. \ \
---p.494 (Penguin Classics edition)
]
==
// #quote(block: true)[
// A system of machinery, whether it is based simply on the co-operation of similar machines, as in weaving, or on a combination of different machines, as in spinning, constitutes in itself a vast automaton as soon as it is driven by a self-acting prime mover. \ \
// ---p.502 (Penguin Classics edition)
// ]
#show math.equation: set text(30pt)

$"Turing" vec("store", "control", color("executive unit"), delim: "{") vec("working machine", "transmitting mechanism", color("motor mechanism"), delim: "{") "Marx"$

==
// TODO: make text left-aligned and in bottom left. 
#set text(15pt)
Lachlan Kermode \
Brown University \
*lachlan_kermode\@brown.edu*

