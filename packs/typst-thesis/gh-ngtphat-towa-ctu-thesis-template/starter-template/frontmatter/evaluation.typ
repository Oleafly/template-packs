#import "../info.typ": *
#import "../template/i18n.typ": term

#let lang = settings.primary_lang
#let data = info.at(lang)

#set page(numbering: "i")
#heading(level: 1, numbering: none, outlined: true)[#term(lang, "evaluation_title")]
#v(1cm)
#set align(left)
#for _ in range(20) {
  line(length: 100%, stroke: 0.5pt + gray)
  v(0.8cm)
}
#v(2cm)
#set align(right)
#text(size: 13pt)[
  #term(lang, "advisor_label") \ #v(2cm)
  #line(length: 6cm) \ #data.advisor.name
]
#pagebreak()
