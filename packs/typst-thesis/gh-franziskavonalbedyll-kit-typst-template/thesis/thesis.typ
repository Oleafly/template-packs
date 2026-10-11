#import "@preview/lilaq:0.5.0" as lq

#import "/kit-typst-template/alr-thesis.typ" as kit-thesis-template
  
#set cite(style: "/assets/harvard.csl")


#show: kit-thesis-template.thesis.with(
 title: "Title of the Thesis",
 thesis-type: "Master's thesis",
 author: "Author Name",
 // if you don't have a company, you can set it to none or remove the line entirely.
 company: "Zeiss",
 company-logo: "/assets/logos/zeiss/zeiss_logo.svg",
 include-declaration: false,
 referee: "Referee Name",
 second-referee: "Second Referee Name",
 internal-advisor: "Internal Advisor Name",
 external-advisor:  "External Advisor Name",
 start-date: datetime(year:2026, month:1, day:1),
 end-date: datetime(year:2026, month:6, day:30),
)


// // #set par(justify: true)
// #let audience = "kit"

#include("chapters/1_Introduction/main.typ")

#include("chapters/2_Fundamentals/main.typ")

#include("chapters/3_Related_Work/main.typ")

#include("chapters/4_Methods/main.typ")

#include("chapters/5_Results/main.typ")

#include("chapters/6_Discussion/main.typ")

#include("chapters/7_Conclusion_and_future_work/main.typ")

#include("chapters/9_Acknowledgements.typ")

#bibliography("/assets/works.bib")

// Before the appendix include, reset and change numbering
#set heading(numbering: (..nums) => {
  let n = nums.pos()
  if n.len() == 1 {
    numbering("A.", n.first())
  } else {
    "A." + numbering("1.1", ..n.slice(1))
  }
})
#counter(heading).update(0)

#include("chapters/A_Appendix/main.typ")
