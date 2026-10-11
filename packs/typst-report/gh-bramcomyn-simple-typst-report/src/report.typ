#import "configuration.typ": configuration

#set document(title: "Report Template Title")
#show: configuration.with(
  authors: (
    (
      name: "Bram Comyn",
      affiliation: "Ghent University",
      email: "bram.comyn@ugent.be"
    ),
  ),
  abstract: "This is a sample abstract for the report template."
)

= Introduction
#lorem(90)

== Motivation
#lorem(140)

== Problem Statement
#lorem(50)

= Related Work
#lorem(180)
