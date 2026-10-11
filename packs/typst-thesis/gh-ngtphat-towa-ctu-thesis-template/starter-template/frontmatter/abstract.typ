#import "../info.typ": *
#import "../template/i18n.typ": term

#let lang = settings.primary_lang
#let data = info.at(lang)

#heading(level: 1, numbering: none, outlined: true)[#term(lang, "abstract_title")]
#v(1cm)
#set align(left)
#set par(first-line-indent: 1cm, justify: true)

// CTU Requirement: 200-350 words
// Include: Problem, Methodology, Results, Conclusions

Write your abstract here (200-350 words as per CTU guidelines).

Structure:
1. Introduction to research topic and objectives
2. Main methodology and approach
3. Summary of results and findings  
4. Main conclusions and recommendations

#v(1cm)
#set text(style: "normal")
#par(first-line-indent: 0cm)[
  *#term(lang, "keywords_label")* #data.keywords.join(", ")
]

#pagebreak()
