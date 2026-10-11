#import "blog_template.typ": doc_tmplate, insert_image

#show: doc => doc_tmplate(
  title: [
    Towards Improved Modelling
  ],
  category: ("distribed system", "database"),
  keywords: ("raft", "consensu"),
  authors: (
    (
      name: "Theresa Tungsten",
      affiliation: "Artos Institute",
      email: "tung@artos.edu",
    ),
    (
      name: "Eugene Deklan",
      affiliation: "Honduras State",
      email: "e.deklan@hstate.hn",
    )
  ),
  abstract: lorem(100),
  doc,
)


= Introduction
#lorem(90)

== Motivation
#lorem(140)

== Solution
#lorem(100)
#insert_image("./assets/img.png", "test", "test image") <test>

=== Problem Statement
@test this show test result.
#lorem(50)

= Related Work
#lorem(200)
真的假的

= Reference
+ System Arch: #link("https://www.baidu.com")