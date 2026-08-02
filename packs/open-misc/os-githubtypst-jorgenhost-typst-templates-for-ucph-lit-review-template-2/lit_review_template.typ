

#set text(size: 11pt)
#let subheader(content) = [
  #text(weight: "bold")[#content]
  #v(-0.5em)
  #line(length: 100%, stroke: 0.4pt)
]

= Note template for a paper [Citation]

#set par(justify: true)

#subheader([Research question & motivation])


#subheader([Context and contribution])
*Gap:* 

*Contribution:* 

#subheader([Methodology])
#grid(
  columns: (1.5fr, 1fr),
  gutter: 8pt,
  [
    #text(style: "italic")[Theoretical Approach]
    - *Model:* 
    - *Key Assumptions:*
      - 
    - *Mechanisms:* 
  ],
  [
    #text(style: "italic")[Empirical Strategy]
    - *Data:* 
    - *Key Variables:* 
    - *Identification:* 
  ],
)

#subheader([Key findings])

#subheader[Closing thoughts]

// ADD BIBLIOGRAPHY IF NEEDED //
// #bibliography("../bibliography.bib", style: "harvard-cite-them-right")