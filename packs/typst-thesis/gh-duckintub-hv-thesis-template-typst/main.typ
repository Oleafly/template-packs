#import "lib.typ": *

#show: hv-template.with(
  title: [I Recreated the University West Thesis Template in Typst #sym.dash A Blazingly Fast Successor to LaTeX],

  front-figure: [
    // image("../logo.png", height: 8cm, width: 16cm),
    #rect(height: 8cm, width: 16cm, stroke: gray)[
      #align(left)[An optional figure, max 8,0 · 16,0 cm (remove this rect if not used)]
    ]
  ],
  
  authors: ([Anders Andersson], [Bosse Bosseson]),
  examiner: [Cedric Cedricsson],
  advisor: [David Davidsson],
  
  programme: [
    Computer Engineering – programming and network technology 180 hp \
    (or Bachelor year in network technology, 60 hp)
  ],
  field: [Computer Engineering],
  education-level: [First cycle],
  course-code: [EHD500, 15 HE credits],
  keywords: [Typst, LaTeX, Typesetting, Fast, Rust],
  publisher: [Department of Engineering Science, University West \
  SE-461 86 Trollhättan, Sweden],
  
  
  abstract: [
    Here the student is supposed to write a summary in English (*even* if you write your thesis in Swedish). Hopefully, the student has arrived at some interesting conclusions, so that the upper half of this page will be stuffed with appropriate information.
    *Note: you need to have an English title on top of this page.*
    
    *MAX* 250 Words, *no* paragraphs. Do *NOT* write in future tense. The summary *must* fit on this page together with the box below. For more info see #underline[#link("https://journals.ieeeauthorcenter.ieee.org/create-your-ieee-journal-article/create-the-text-of-your-article/structure-your-article/#abstract")[IEEE - Structure Your Article \#Abstract]].
    
    This page needs to come directly after the title page (excluding Swedish summary). It contains a summary of your work. The box below should show some complementing meta data about the thesis.
    This layout is not allowed to be changed. However, the information in the box below must be adapted, see `main.typ`.
  ],


  // === Swedish section ===
  se-title: [Jag Återskapde Högskolan Västs Examensmall i Typst #sym.dash Ett Räsersnabbt Alternativ till LaTeX],
  se-programme: [
    Datateknik, högskoleingenjör – programmering och nätverksteknik, 180 hp \
    (eller Nätverkstekniskt påbyggnadsår, 60 hp)
  ],
  se-field: [Datateknik],
  se-education-level: [Grundnivå],
  se-course-code: [EDH500, 15 hp],
  se-keywords: [Svenska, Nyckelord, Skrivs, Här, På, Detta, Vis],
  se-publisher: [
    Institutionen för ingenjörsvetenskap, Högskolan Väst \
    461 86 Trollhättan
  ],

  
  se-abstract: [
    Här skriver du möjligen din sammanfattning på svenska. 
  
    MAX 250 ord. Ingen styckesindelning. Skriv INTE i futurum.
  
    Detta är en dokumentsida som skall sitta direkt efter titelsidan. Den innehåller först och främst en sammanfattning av innehållet i rapporten, och kompletteras med lämpliga upp­gifter i rutan nedan.
    
    Layouten på titel- och dokumentsidor får inte ändras, men sidorna måste anpassas efter vilket program och ämne som arbetet tillhör samt vilken utbildningsnivå som avses. Kolla i `globals.typ`
  ],

  
  preface: [
    I thank myself for ...
  ],

  // TODO: Consider if you need theese.
  // list-of-figures: true,
  // list-of-tables: true,
  // list-of-abbreviations: [
  //   #grid(
  //     columns: (auto, auto),
  //     row-gutter: 0.8em,
  //     inset: (x: 1em, y: 0pt),
  //     [*This*], [That],
  //     [*Something*], [Other],
  //     [*Foo*], [Bar],
  //   )
  // ],
  // chapter-numbering: true,
  
  bib-file: bibliography("Template.bib", title: [References]),
  
  appendix: (
    [
      = Aaaaaaaaaa <apx:a>
      #pagebreak()
      Complex logic please!
      #pagebreak()
      Yeah, one appendix can have multiple pages. Pretty #emoji.fire!
    ],
    [
      = Bababababa <apx:b>
      #include "appendix-b.typ"
    ],
    [
      = Cacacacaca <apx:c>
      #figure(
        text(size: 20pt)[#emoji.poo],
        caption: [BAJS OCKSÅ!]
      )
    ],
  )
)

#include "introduction.typ"

== Purpose of study
== Research questions
== Limitations
== Contributions

= Background
This is just an example. It was used to check the logic for chapter counting of figures and tables. Typst is really cool! I reference it @rect. And I do it again @rect.
#figure(
  caption: [Example. Remember, figure captions go below.],
  rect(
    fill: gradient.linear(..color.map.flare), width: 80%, height: 6cm
  )
)<rect>

= Method

= Results

= Discussion

= Conclusion