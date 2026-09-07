#set page(paper: "a3", flipped: true, margin: 18mm)
#set text(size: 16pt)
#set par(leading: 0.7em)
#let accent = rgb("245b63")
#let pale = rgb("edf5f4")
#let panel(title, body) = block(width: 100%, inset: 14pt, fill: pale, radius: 6pt)[
  #text(size: 23pt, weight: "bold", fill: accent)[#title]
  #v(6pt)
  #body
]

#text(size: 36pt, weight: "bold")[Where does the walking route need a closer look?]
#v(5pt)
#text(size: 19pt)[Mapping afternoon shade along a campus path]
#v(5pt)
Example research group · Demonstration poster
#v(12pt)
#line(length: 100%, stroke: 2pt + accent)
#v(12pt)

#grid(
  columns: (1fr, 1.25fr, 1fr), gutter: 16pt,
  panel([The question], [
    Which sections of a walking route have the least shade during afternoon
    observations?

    *Method*
    - Mark ten fixed observation points.
    - Visit each point on three clear afternoons.
    - Record shaded fraction, time, and surface type.
    - Repeat the first point at the end of each walk.

    This study measures shade. It does not measure pedestrian comfort.
  ]),
  panel([A pattern worth checking], [
    #text(size: 27pt, weight: "bold")[Shade varies along the route.]
    #v(12pt)
    #grid(
      columns: (1fr, 1fr, 1fr), align: bottom, gutter: 10pt,
      [#rect(width: 100%, height: 105pt, fill: accent, stroke: none)
      #align(center)[*72%*
North]],
      [#rect(width: 100%, height: 45pt, fill: rgb("d28650"), stroke: none)
      #align(center)[*31%*
Central]],
      [#rect(width: 100%, height: 85pt, fill: accent, stroke: none)
      #align(center)[*58%*
South]],
    )
    #v(10pt)
    Illustrative shaded fractions for three route sections. These are example
    values, not findings from an actual study.
  ]),
  panel([What comes next], [
    *Check the measurement*

    Repeat observations under a wider range of weather conditions and compare
    how two observers classify partial shade.

    *Ask the next question*

    Add direct comfort measurements before evaluating any proposed intervention.

    *Share the work*

    Replace this text with a stable link to the protocol, data, and analysis.
  ]),
)

#v(14pt)
#text(size: 12pt, fill: luma(100))[Standalone Typst poster. Replace the example study, figures, and attribution before presenting.]
