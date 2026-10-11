#import "conf.typ": conf

#show: conf.with(
  title: [My Research Note],
  author: (
    name: "Adil Shamji",
    email: "adil02.shamji@gmail.com",
    affiliation: "Linköping University",
  ),
  version: "0.1",
  lang: "en",
  rectangle_color: green,
)
#pagebreak()
= First heading
#lorem(100)
Some text here.

== Second heading
#lorem(100)
More text here.
