#import "../../src/tudelft-phd-thesis.typ": delft-blue, front-heading

#show heading.where(level: 1): front-heading
#heading(level: 1, numbering: none)[Curriculum Vitæ]

#v(3mm)
#grid(
  columns: (1fr, 26mm),
  column-gutter: 8mm,
  align: (center + horizon, right + horizon),
  [#text(size: 14pt, weight: "bold")[Marie S. CURIE]],
  rect(width: 26mm, height: 34mm, fill: delft-blue.lighten(88%), stroke: 0.6pt + delft-blue, radius: 2pt)[#align(center + horizon)[#text(size: 7pt, fill: delft-blue)[Portrait placeholder]]],
)

#v(2mm)
#text(size: 9.4pt)[
  #let entry(dates, content) = grid(columns: (6em, 1fr), column-gutter: 1em, dates, content)
  #let section(title) = { v(0.55em); text(size: 12pt, weight: "bold", fill: delft-blue)[#title]; v(0.25em) }

  #entry[1867][Born in Warsaw, Poland.]

  #section[Education]
  #entry[1891 to 1894][Studies in physics and mathematics, University of Paris.]
  #entry[1903][Doctorate in physical sciences, University of Paris. \
  #text(style: "italic")[Illustrative thesis:] Studies in Radioactivity and Measurement.]

  #section[Professional Experience]
  #entry[1898 to 1906][Researcher and lecturer, fictional Radiological Laboratory, Paris.]
  #entry[1906 onward][Professor of general physics, illustrative University of Paris appointment.]

  #section[Honours]
  #entry[1903][Illustrative international recognition for research in radiation phenomena.]
  #entry[1911][Illustrative recognition for work on chemical elements.]
]
