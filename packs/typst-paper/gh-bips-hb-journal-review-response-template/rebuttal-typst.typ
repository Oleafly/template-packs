#import "rebuttal-template.typ": *

#show: conf.with(
  manuscript-id: "LOREM-IPSUM-1234569",
  paper-title: "A Paper about Things and Stuff",
)

// Just in case the editor has written something:
// #issue[Dear Dr. NAME,]

// #reviewer(n: 1) sets the number used in R<n>-Q<q> tags and the heading.
// Pass name: to append a parenthetical, e.g. when reviewers are identified
// by the editor's comment file rather than a plain number:
//   #reviewer(n: 1, name: "1-review-5")  // -> "Reviewer 1 (1-review-5)"
#reviewer(n: 1)

#issue(lbl: <R1-Q1>)[The thing is bad in ways because of stuff]

#answer[
  We fixed the thing about the stuff.
  As the reviewer noted, #quote[the thing is bad], and we have addressed this.

  #changed[
    Our stuff has a variety of things, and also stuff.
  ]
]

// If you want to separate reviewers cleanly
// #pagebreak()

#reviewer(n: 2)

#issue[I don't like your face]

#answer[
  Oh no

  #issuetodo[
    Get face replacements
  ]
]

#issue[I don't like everyone elses's face]

#answer[
  Oh no as well (see also our response to @R1-Q1).

  #issueothers[
    Move to Guatemala and become sheep herders
  ]
]
