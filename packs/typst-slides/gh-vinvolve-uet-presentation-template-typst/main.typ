#import "coolUET/coolUET.typ": *
#import "config.typ": * 

#show: slides.with(
  title: title,
  authors: authors,
  date: date, 
  subtitle: subtitle
)

#show raw: set block(fill: silver.lighten(65%), width: 100%, inset: 1em)

== Outline
#outline(depth: none,
  
)
// ################ content ##############
#include "content/introduction.typ"
#include "content/Method.typ"



== references
#bibliography("ref.bib")