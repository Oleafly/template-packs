#import "@preview/clean-acmart:0.0.1": acmart

#let acmartVS(body, ..args) = {
  show: acmart.with(..args)
  set block(spacing: 1em)
  set figure(gap: 1em)
  show heading: it => {
    set block(above: .5em)
    set text(size: 1.2em)
    it
  }
  show heading.where(level: 1): smallcaps
  body
}