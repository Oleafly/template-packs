#import "template.typ": *

#show: project.with(
  course: "Signals and Systems",
  code:"VE216",
  lab:3,
  title: "Feedback Control",
  authors: (
    (name: "Waibi", affiliation: "12345678"),
    (name: "Babu", affiliation: "87654321"),
    (name: "Ruarong Rou", affiliation: "42424242"),
  ),
  date: "April 2024",
)

= Objectives

- Understand feedback control

= Theoretical Background

== A Closed-Loop Feedback Model

#lorem(20)

== Closed-Loop Transfer Function

#lorem(20)

To calculate $G_"cl" (s)$:

$
Y(s) &= E(s)C(s)P(s) \

E(s) &= X(s)-H(s)Y(s) \

G_"cl" (s) &= Y(s)/X(s) = (C(s)P(s))/(1+C(s)P(s)H(s)) \

E(s) / X(s) &= 1/(1+C(s)P(s)H(s))
$

= Experimental Procedures

== Open-Loop System

#lorem(20)

== Feedback Control

#lorem(20)

= Experimental Results

== Open-Loop System

#lorem(20)

== Feedback Control

#lorem(20)

= Error Analysis and Discussion

#lorem(20)

= Conclusion

#lorem(20)

= Reference

- Lab+3+Manual2024.pdf, UM-SJTU Joint Institute, 2024.