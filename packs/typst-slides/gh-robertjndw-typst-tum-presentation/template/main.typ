#import "/theme.typ": *

#show: tum-theme.with(
  title: [My awesome topic I want to put into a presentation],
  authors: ("Max Mustermann",),
  school: [TUM School of Musterverfahren],
  chair: [Lehrstuhl für Mustertechnik],
  footer-infos: ("Excellence",),
)

#title-slide()

#outline-slide()

= Introduction

== Motivation

This is the first slide of the presentation.

#pause
It is a very important slide.

#pause
It is the best slide.

#speaker-note[Notes for this slide go here.]

= Main Part

== Details

#lorem(60)

#focus-slide[Thank you!]

// Image slides scale the image to fit below the title:
// == Photo
// #image-slide(image("/images/photo.jpg", alt: "Description"))
