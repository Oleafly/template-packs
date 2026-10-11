#import "lib/lib.typ": *

#let title = "Title of Paper"
#let subtitle = "Subtitle of Paper"
#let author = "Teemu Teekkari"
#let language = "English"
#let teacher = "Dr. Professor"
#let supervisor = "Super Visor"
#let keywords = ("keywords", "for", "paper")
#let date = datetime.today()

#let title-fi = "Työn otsikko"
#let subtitle-fi = "Työn alaotsikko"
#let keywords-fi = ("avainsanat", "tälle", "paperille")

#color-header(title: title, subtitle: subtitle, author: author, language: language, dark: false,
color: colors.red)

#show: styling-headers

#header(title: title, subtitle: subtitle, author: author, language: language)

#intro(
  title: title,
  author: author,
  teacher: teacher,
  supervisor: supervisor,
  keywords: keywords,
  language: "English",
  abbreviations: (),
  date: date,
  subtitle: subtitle,
)

#intro(
  title: title-fi,
  author: author,
  teacher: teacher,
  supervisor: supervisor,
  keywords: keywords-fi,
  language: "Finnish",
  abbreviations: (),
  date: date,
  subtitle: subtitle-fi,
)

#outline()


#show: styling-main

= Introduction

#lorem(100)

#pagebreak()

== Section
#lorem(50)

=== Subsection
#lorem(10)

= Foo

= Conclusion


#end(
  "bibfile.bib",
  [
    = First Appendix
    #lorem(100),

    == Subsection of First Appendix

    = Second Appendix
    #lorem(100),
  ],
)

