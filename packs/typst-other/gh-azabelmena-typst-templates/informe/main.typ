#import "lib.typ": *

#show: doc => informe(
  title: "Title Here",
  organization: "Your Organization Here",
  committee: "Your Committee",
  institution: "Your Institution",
  faculty: "Your Faculty",
  type: [Type of Document],
  logo_left: "figures/logo.png",
  logo_right: "figures/cat.jpg",
  doc
)

= #lorem(4)

#lorem(2000)

= #lorem(3)

#lorem(30)

== #lorem(4)

#lorem(50)

= #lorem(1)

#lorem(100)

#signature()

#show: appendix
= Example Appendix

#lorem(50)

#show: errata
= Errata

#lorem(30)
