#set page(
  paper: "a4",
  margin: (
    left: 25mm,
    right: 25mm,
    top: 25mm,
    bottom: 25mm,
  )
)

#let link_color = rgb("ffe8a9")

// link_color must be set in template

#let styled_link(url, text, underline_color: link_color ) = {
  link(url)[
    #context {
      let text_width = measure(text).width
      box[
        #place(
          top + left,
          dy: -0.25em,
          dx: 0.25em,
          rect(
            width: text_width,
            height: 6pt,
            fill: underline_color,
            stroke: none
          )
        )
      ]
      text
    }]
}

#let bubble_tag(name, color: rgb("#e6e6e6"), text_color: rgb("#595959")) = {
    box(
      fill: color,
      stroke: none,
      radius: 5pt,
      inset: (x: 4pt, top: 3pt, bottom: 0pt),
      height: 1.1em,
      outset: 0pt,
      baseline: 0%,
      text(name, font: "Menlo", size: 8pt, fill: text_color)
    )
}

#set text(
  font: "New Computer Modern",
  size: 11pt
)
#set par(leading: 0.55em)

#align(right)[
  #text("Jane Doe", size: 2.2em) \
  #v(-1.5pt) #text(style: "italic")[Data Scientist] | Berlin \
  #link("mailto:jane.doe@icloud.com")[jane.doe\@icloud.com] \
            #styled_link("https://github.com/", "GitHub") | 
          #styled_link("https://www.linkedin.com/", "LinkedIn") | 
              #styled_link("https://janedoe.com", "Portfolio")
      ]

#show heading.where(level: 1): it => [
  #set text(size: 21pt, weight: "regular")
  #block(
    above: 28pt,
    below: 18.5pt,
  )[
    #it.body
  ]
]

#set table(
  stroke: (x, y) => if x > 0 { (left: 0.4pt + rgb("#c8c8c8")) } else { none },
  align: (right, left),
  inset: (x: 1em, y: 1pt),
)

#heading(level: 1, numbering: none)[Skills]
<skills>
#align(right)[#table(
  columns: (auto, 11cm + 2em),
[#smallcaps[Languages]], [#link("https://janedoe.com/tag/Python")[#bubble_tag("Python")]
#bubble_tag("R") #bubble_tag("SQL")],
[#smallcaps[Libraries]], [#bubble_tag("Pandas") #bubble_tag("NumPy") #bubble_tag("PyTorch")
#link("https://janedoe.com/tag/TensorFlow")[#bubble_tag("TensorFlow")]]
)]
#heading(level: 1, numbering: none)[Work Experience]
<work-experience>
#align(right)[#table(
  columns: (auto, 11cm + 2em),
[#smallcaps[01/2019 -- Today]], [#smallcaps[DeepSight Analytics] \ #emph[Senior Data Scientist] \
#pad(y: 0.25em)[
- Built predictive models to optimize customer lifetime value
- #styled_link("https://externallink.com", "Led a team of 4 data scientists")
  to deploy a real-time fraud detection system using PyTorch and Kafka
- Migrated legacy models to cloud-based architecture using AWS SageMaker

]
#bubble_tag("AWS") #bubble_tag("SageMaker") #bubble_tag("PyTorch")],
table.cell(colspan: 2, stroke: none, block(height: 1em, [])),
[#smallcaps[06/2016 -- 12/2018]], [#smallcaps[InData Solutions] \ #emph[Data Scientist] \
#pad(y: 0.25em)[
- Developed a
  #styled_link("https://externallink.com", "recommender system") that
  improved user engagement by 20%
- Designed and maintained ETL data pipelines

]
#bubble_tag("Recommender Systems") #bubble_tag("ETL") #bubble_tag("SQL")
#bubble_tag("Data Pipelines")]
)]
#heading(level: 1, numbering: none)[Education]
<education>
#align(right)[#table(
  columns: (auto, 11cm + 2em),
[#smallcaps[2014 -- 2016]], [#smallcaps[Freie Universität Berlin] \ #emph[M.Sc. in Data Science]],
table.cell(colspan: 2, stroke: none, block(height: 1em, [])),
[#smallcaps[2010 -- 2014]], [#smallcaps[Technische Universität Dresden] \ #emph[B.Sc. in Statistics]]
)]
#heading(level: 1, numbering: none)[Other]
<other>
#align(right)[#table(
  columns: (auto, 11cm + 2em),
[#smallcaps[Certifications]], [TensorFlow Developer Certificate \ AWS Certified Data Analytics --
Specialty],
table.cell(colspan: 2, stroke: none, block(height: 1em, [])),
[#smallcaps[Interests]], [Data ethics, generative AI, urban informatics]
)]