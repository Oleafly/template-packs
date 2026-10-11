#import "template.typ": *
#show: seminar.with(
  title: ["Monad" à la Carte],
  authors: (
    (name: "Linyu Yang", email: "yly1228@foxmail.com"),
  ),
  date: [November XX#super[th], 2024],
  outline_: true
)


== Section 1

hello #pause world

== Section 2

#theorem[
  This is a theorem
]

#pause

#definition(title: [Natural Transformation])[
  What is this natural transformation?
]

#definition-box(title: [Not Outlined])[
  This is not outlined
]

== Section 3

#slide(composer: (1fr, 2fr))[
  hello, world

  #pause fuck

  #meanwhile

  This is a
][
  hello, world again

  #pause #pause aaa
]

== Summary

This is the summary

#show: appendix

== Appendix

This is the appendix