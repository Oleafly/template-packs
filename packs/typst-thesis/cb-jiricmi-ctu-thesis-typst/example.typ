#import "./template/template.typ": *

#show: template.with(
  meta: (
    title: "An Interesting Thesis Title",
    author: (
      name: "Jan Novák",
      email: "someone@fel.cvut.cz",
      url: "https://my.project/url",
    ),

    // true for bachelor's thesis, false for master's thesis
    bachelor: false,
    supervisor: "Ing. Jan Novák, PhD.",

    faculty: "Faculty of Electrical Engineering",
    department: "Department of Measurement",
    study-programme: "Open Informatics",
    study-spec: "Artifitial inteligence", // studijni obor
    diff_usage: false, // when true, wont generate abstract etc.
    abbrs: (
        "SOP": "Small Outline Package",
        "TSSOP": "Thin Shrink Small Outline Package"
    ),
),

  // set to true if generating a PDF for print (shifts page layout, turns code blocks greyscale, correctly aligns odd/even pages,...)
  print: false,
  lang: "en", // set cs for czech version
  submission-date: datetime(year: 2012, month: 1, day: 21),


  abstract-en: [
    #lorem(40)
    
    #lorem(60)
  ],

  abstract-cz: [
    #lorem(40)
    
    #lorem(60)
  ],

  acknowledgement: [
    #lorem(30)
    
    #lorem(30)
  ],
)

= Introduction

#lorem(80) @template

#lorem(120)

#lorem(140)

#lorem(40)

#lorem(70)

= Background

== Part 1

#lorem(100)

=== Subpart 1

#lorem(40)

=== Subpart 2

#lorem(70)

== Part 2

#lorem(100)

= Future work

#lorem(100)

= Conclusion

#lorem(100)




// all h1 headings from here on are appendices
#start-appendix(lang:"en")[
    = Bibliography
    #bibliography("bibliography.bib")
]
= An example appendix

#lorem(100)
