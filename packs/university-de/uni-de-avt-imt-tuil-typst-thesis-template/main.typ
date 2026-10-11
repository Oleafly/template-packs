
#import "template/lib.typ": *


#show: thesis.with(
  title: "A guide to the thesis template",
  authors: (
    (name: "James T. Kirk", course-of-studies: "Media Technology"),
  ),
  type-of-thesis: "Bachelorarbeit",
  bibliography: bibliography("refs.bib"),
  date: datetime.today(), // or datetime(year: 2025, month: 10,  day: 4) to fix the date
  language: "en", // en, de
  supervisor: (professor: "Steve Göring", university: "Prof. Dr. Daniel Düsentrieb"),
  abstract: "hello",
  abstract_de: "deutscher abstract"
)



= Fundamentals

== hhh

= ho

Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

test
hello

blubber

@raake2014quality

- A
- B



#figure(
  image("imgs/03.png"),
  caption: [A nice figure!],
) <fig:test>

@fig:test is amazing