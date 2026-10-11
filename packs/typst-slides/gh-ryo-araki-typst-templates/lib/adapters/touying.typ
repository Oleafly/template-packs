#import "@preview/touying:0.7.4": *
#import themes.university: *
#import "@preview/showybox:2.0.4": showybox
#import "@preview/physica:0.9.8": *
#import "@preview/pinit:0.2.2": *
#import "@preview/cetz:0.5.2"
#import "../components/boxes.typ": *
#import "../components/math.typ": pinit-highlight-equation-from, colormath

#let cetz-canvas = touying-reducer.with(reduce: cetz.canvas, cover: cetz.draw.hide.with(bounds: true))
