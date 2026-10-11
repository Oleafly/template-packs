#import "../config.typ": *

// A reusable function for creating a signature box.
#let signature-box(supervisor-name, supervisor-title, date: none, signature-image: none) = {
  rect(
    width: 100%,
    height: 40%,
    radius: 8pt,
    stroke: 1.5pt + luma(150)
  )[
    #pad(rest: 1.5cm)[
      #stack(
        dir: ttb,
        spacing: 1.5cm,
        align(center, text(14pt)[I authorize the student to submit their internship report.]),
        [
          #supervisor-title: #h(4pt) *#supervisor-name*
        ],
        grid(
          columns: (1fr, 1fr),
          align(left)[
            Date: #if date != none [#date] else [\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_]
          ],
          align(right)[
            Signature and Stamp :\
            #if signature-image != none [
              #v(-1.5em)
              #image(signature-image, width: 60%)
            ]
          ]
        )
      )
    ]
  ]
}

// Use the function to create the two signature boxes.
#stack(
  spacing: 2cm,
  dir: ttb,
  signature-box(
    professional_supervisor, 
    "Professional supervisor",
    date: "1st September 2025",
    signature-image: none
  ),
  signature-box(academic_supervisor, "Academic supervisor"),
)
