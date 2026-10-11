#import "qcv.typ": *

#show: qcv.with()

#header("John Doe",
      email: "John.Doe@mail.com",
      webpage: "https://john.doe.org",
      orcid: "1111-1111-1111-1111")

#let max_year = 2024
#let min_year = 2017

#let entry(..args) = {
  raw_entry(min_year, max_year, ..args)
}

= Education

#entry(2020, 2023, title:"Phd Student", details: lorem(30))

#entry(2018, 2020, title:"Master Degree", details: lorem(20))

= Professional Experience

#entry(2019, 2019, title:"Intern", details: lorem(20))

= Publications

#bibliography("references.bib", full: true, style: "ieee", title: none)

