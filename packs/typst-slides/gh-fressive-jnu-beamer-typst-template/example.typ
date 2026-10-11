#import "@preview/touying:0.6.1": *
#import "jnu-theme.typ": *

#import "@preview/numbly:0.1.0": numbly

#show: jnu-theme.with(
  aspect-ratio: "16-9",
  config-info(
    title: [Beam Template],
    subtitle: [Subtitle here],
    author: [Author],
    date: datetime.today().display("[year]年[month]月[day]日"),
    institution: [Jiangnan University],
  ),
)

#set heading(numbering: numbly("{1}.", default: "1.1"))
#set text(font: ("Liberation Sans", "Noto Sans CJK SC"), size: 18pt)
#show math.equation: set text(font: "New Computer Modern Math")


#title-slide()

#outline-slide(title: [目录])

= Section A

== Subsection A.1

A slide without a title but with *important* information.

= Section B

== Subsection B.1

#lorem(80)

// #focus-slide[
//   Wake up!
// ]

== Subsection B.2

We can use `#pause` to #pause display something later.

#pause

Just like this.

#meanwhile

Meanwhile, #pause we can also use `#meanwhile` to #pause display other content synchronously.

#show: appendix

= Appendix

== Appendix

Please pay attention to the current slide number.
