#import "../../src/tudelft-phd-thesis.typ": delft-blue

The hypothetical apparatus combines a shielded sample chamber, a detector, a timing unit, and a calibration source. The layout is intentionally schematic: it shows how a dissertation figure can be built directly in Typst without a separate drawing program.

#figure(
  align(center)[
    #grid(
      columns: (36mm, 10mm, 36mm, 10mm, 36mm),
      align: center + horizon,
      rect(width: 34mm, height: 18mm, fill: delft-blue.lighten(85%), radius: 3pt)[#align(center + horizon)[Sample]],
      text(size: 18pt, fill: delft-blue)[→],
      rect(width: 34mm, height: 18mm, fill: delft-blue.lighten(85%), radius: 3pt)[#align(center + horizon)[Detector]],
      text(size: 18pt, fill: delft-blue)[→],
      rect(width: 34mm, height: 18mm, fill: delft-blue.lighten(85%), radius: 3pt)[#align(center + horizon)[Recorder]],
    )
  ],
  caption: [Schematic of the illustrative measurement chain.],
) <fig:apparatus>

The detector response is assumed to be approximately linear over the range of interest. A calibration relationship can be written as $y = a x + c$, where $a$ represents sensitivity and $c$ represents a baseline offset. In a real dissertation, this section would document calibration, uncertainty, and any instrument-specific limitations.

== Design choices

The format supports ordinary headings, citations, cross-references, and figures. The historical work of Becquerel @becquerel1896 is included in the example bibliography only to demonstrate a conventional reference workflow.
