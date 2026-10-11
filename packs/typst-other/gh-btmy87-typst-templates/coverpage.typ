// typst file to generate a cover page for TCM documents
#set page(paper: "us-letter", margin: 1.5in)
#set text(font: "Arimo", size: 11pt)

#align(center + horizon)[
  #text(size: 18pt, weight: "bold")[
    My Cover Page
  ]
]

#set align(center + bottom)
#set par(justify: true)

#upper[
  The following document may contain math!
  The author of this document is not responsible for any
  physical, mental, psychological or emotional damage that
  may result from consuming math.  The reader of this document
  accepts these terms upon continuing to read the document.  Processed
  in a facility that also processes treenuts, milk, and peanuts.
]
