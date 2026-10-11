#set page(
  paper: "us-letter",
  margin: 0.75in
)

#set document(title: "Sign-in Sheet")
#let checkbox = box(
  width: 12pt,
  height: 12pt,
  stroke: 0.5pt,
)

#text(18pt, align(center)[
  Sign-in Sheet: #box(height: 12pt, align(bottom, 
    line(length: 25%, stroke: 0.5pt + gray)
  ))
])
#table(
  columns: (auto, 1fr, 1fr),
  inset: 5pt,
  stroke: 0.5pt,
  strong("#"), strong("Name"), strong("Email address (for invitation to groupchat)"),
  
  // Data rows - empty rows for people to fill out
  align: (center, left, right),
  ..for i in range(75) {
    (
      str(i + 1), "", text(gray)[\@ucsb.edu]
    )
  }
)
