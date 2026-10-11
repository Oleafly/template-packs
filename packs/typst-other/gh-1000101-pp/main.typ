#import "template/pp.typ": pp, customquote

#show: pp.with(
  uni:[Universal University], // name of the institution / uni
  subname:[Suantum Quiance Paper], // for instance course/assignment name
  title:[One line of title \ second line of title],
  subtitle:[I like longer titles],
  author:[Stud Ent],
  abstract_title:[Abstract],
  abstract:lorem(80),
  //language: "sk", // if not specified, then en will be used, possible: "en", "fr", "cs", "sk", ...
  //date:[] // if not specified, then current date will be used, use blank to blank out
)

#set text(
  font: "Latin Modern Roman",
  lang: "en",
)


= Introduction

#customquote["_Interesting_"@book1[p.123]]

#lorem(100)

#lorem(100)


#pagebreak()

= Chapter I

#lorem(50)
#quote[#lorem(3)]@article1[p.1]

#lorem(50)
#quote[#lorem(10)]@article1[p.2]
#lorem(10)
#quote[#lorem(5)]@article1[p.4]

= Chapter II

#lorem(50)

#lorem(50)
#footnote[footnote]

#lorem(50)
#quote[#lorem(5)]@article1[p.1]

#pagebreak()


= Conclusion

#customquote[_#lorem(10)_@book1[p.321]]

#lorem(20)
#lorem(10)

#lorem(100)


#pagebreak()


#bibliography("lib.bib", title:"Bibliography", style: "chicago-notes")
