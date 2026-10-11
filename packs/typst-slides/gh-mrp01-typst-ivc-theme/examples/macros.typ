#import "/lib/lib.typ": ivc-color

#let toolname = [FancyPaper]

#let overviewcolor = rgb("#7593e6")
#let patientcolor = rgb("#9ee5a1")
#let introspectioncolor = rgb("#f3db70")

#let OverView = text(fill: overviewcolor.darken(20%))[Overview]
#let PatientView = text(fill: patientcolor.darken(35%))[Patient View]
#let IntrospectionView = text(fill: introspectioncolor.darken(35%))[Introspection View]

#let classHealthy = rgb("#16a34a")
#let classAD = rgb("#be123c")
#let classFTD = rgb("#a21caf")

#let glsH = text(fill: classHealthy)[HC]
#let glsAD = text(fill: classAD)[AD]
#let glsFTD = text(fill: classFTD)[FTD]

#let requirement(n) = strong[R#n]

#let demourl = link("https://hereditary-eu.github.io/demos/systems/eeglass/")[demos.hereditary-project.eu/systems/eeglass/]
#let live-demourl = link("https://hereditary.cgv.tugraz.at/all-in-on-eeg/")[hereditary.cgv.tugraz.at/all-in-on-eeg/]
#let repourl = link("https://github.com/hereditary-eu/EEGlass")[github.com/hereditary-eu/EEGlass]
#let paperurl = link(
  "https://diglib.eg.org/server/api/core/bitstreams/7d3b2ed3-7011-4cb8-b3cf-5a4a37630f3b/content",
)[doi:10.2312/vcbm.20261002]

#let placeholder(label, width: 100%, height: 4cm) = box(
  width: width,
  height: height,
  radius: 12pt,
  stroke: 0.5pt + ivc-color.lighten(50%),
  fill: tiling(size: (8pt, 8pt), place(line(start: (0%, 100%), end: (100%, 0%), stroke: 0.5pt + ivc-color.lighten(70%)))),
  align(center + horizon, box(inset: 4pt, radius: 2pt, text(fill: ivc-color, size: 0.8em, label))),
)
