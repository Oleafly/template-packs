#import "@preview/markly:0.3.0"
#import "../content/content.typ": ttrpg-book

#let markly-context = markly.setup(
  // Paper size
  stock-width: 6in,
  stock-height: 9in,

  // Amount of bleed
  bleed: 0pt,

  // Content size
  content-width: 6in,
  content-height: 9in,

  // Marks
  bleed-marks: false,
  cut-marks: false,
  registration-marks: false,
)

#ttrpg-book(
  "eng",
  markly-context,
  "Contents",
  "Page",
)
