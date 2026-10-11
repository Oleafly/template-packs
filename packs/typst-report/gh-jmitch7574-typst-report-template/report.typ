#import "template.typ": report

#show: report.with(
    title: "Using Typst",
    author: "Your name and student number here"
)

// Write your report body here

#pagebreak()

#bibliography(
    "bibliography.bib",
    title: [References],
    style: "harvard-cite-them-right"
)