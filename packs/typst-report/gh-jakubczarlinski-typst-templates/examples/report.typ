#import "../report.typ": template

#let title = "Example Title"
#let author = "Sample Author"
#show: template.with(title: title, author: author)

#outline(depth: 3)

#pagebreak(weak: true)

= Introduction

Hello world! This is an example of a report template in Typst.
