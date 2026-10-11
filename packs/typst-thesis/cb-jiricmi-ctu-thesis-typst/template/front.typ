#let translations = (
  "cs": (
    "thesis-bachelor": "Bakalářská práce",
    "thesis-master": "Diplomová práce",
    "supervisor": "Vedoucí práce",
    "study-programme": "Studijní program",
    "branch-of-study": "Obor studia",
    "specialization": "Specializace",
    "acknowledgement": "Poděkování",
    "declaration": "Prohlášení",
    "declaration-text": "Prohlašuji, že jsem závěrečnou práci vypracoval(a) samostatně a uvedl(a) všekeré použité informační zdroje v souladu s Metodickým pokynem o dodržování etických principů při přípravě vysokoškolských závěrečných prací a Rámcovými pravidly používání umělé inteligence na ČVUT pro studijní a pedagogické účely v Bc a NM studiu.",
    "ai-declaration-text": "Prohlašuji, že jsem v průběhu příprav a psaní závěrečné práce použil nástroje umělé inteligence. Vygenerovaný obsah jsem ověřil. Stvrzuji, že jsem si vědom, že za obsah závěrečné práce plně zodpovídám.",
    "prague": "v Praze",
    "abstract": "Abstrakt",
    "abbrs": "Seznam zkratek",
    "images": "Seznam obrázků",
    "code": "Seznam úryvků kódu",
    "tables": "Seznam tabulek",
    "cvut": [#text("České vysoké učení")~#text("technické v")~#text("Praze")]
  ),
  "en": (
    "thesis-bachelor": "Bachelor's Thesis",
    "thesis-master": "Master's Thesis",
    "supervisor": "Supervisor",
    "study-programme": "Study programme",
    "branch-of-study": "Branch of study",
    "specialization": "Specialization",
    "acknowledgement": "Acknowledgement",
    "declaration": "Declaration",
    "declaration-text": "I declare that the presented work was developed independently and that I have listed all sources of information used within it in accordance with the methodical instructions for observing the ethical principles in the preparation of university theses.",
    "ai-declaration-text": "Prohlašuji, že jsem v průběhu příprav a psaní závěrečné práce použil nástroje umělé inteligence.Vygenerovaný
obsah jsem ověřil. Stvrzuji, že jsem si vědom, že za obsah závěrečné práce plně zodpovídám.",
    "prague": "In Prague",
    "abstract": "Abstract",
    "abbrs": "List of Abbreviations",
    "tables": "List of Tables",
    "code": "List of Code Listings",
    "images": "Table of Figures",
    "cvut":[#text("Czech Technical University in")~#text("Prague")])
)

#let localized(key, lang) = {
  let translation = translations.at(lang)
    translation.at(key)
  }
}

#let title-page(
  print,
  lang,
  title: "",
  author: (
    name: "",
    email: "",
    url: "",
  ),
  submission-date: datetime.today(),
  bachelor: false,
  diff_usage: false,
  supervisor: "",
  faculty: "",
  department: "",
  study-programme: "",
  branch-of-study: "",
  study-spec: "",
  abbrs: (),
) = {
  // render as a separate page
  // inner margin is 8mm due to binding loss, but without
  //  the bent page extra, which is not an issue for the title page
  let inside-margin = if print {8mm} else {0mm}
  show: page.with(margin: (top: 0mm, bottom: 0mm, inside: inside-margin, outside: 0mm))

  set text(font: "Technika", weight: "extralight", size: 10.3pt, fallback: false)

  // shorthand to vertically position elements
  let b(dy, content, size: none, weight: none) = {
    set text(size: size) if size != none
    set text(weight: weight) if weight != none
    place(dy: dy, text(content))
  }
  grid(
    columns: (1.5fr, 10fr),
    gutter: 10pt,
    [
        
        #v(30mm)
        #align(right)[
            #rect(width: 15%, height: 80%, fill: blue)
        ]
    ],
    [
        #align(left)[
            #b(33mm, size: 12.5pt, weight: "medium")[
                #if not diff_usage [
                    #if bachelor [
                        #localized("thesis-bachelor", lang)
                    ] else [
                        #localized("thesis-master", lang)
                    ]
                ]   

                
            ]
            #b(35mm)[
                #grid(columns: (3.5fr, 2fr, 10fr), [
                    #image("./res/symbol_cvut_konturova_verze_cb.svg", width: 110pt)
                ],
                [
                  #v(10mm)
                #text(size: 16pt, weight: "medium", fill: blue)[#localized("cvut", lang)]
                ])
            ]
            #b(78mm)[
                #grid(columns: (3.5fr,5fr,7fr), [
                #text(size: 32pt, weight: "medium", fill: blue)[F3]

                ],
                [
                #text(size: 10.5pt, weight: "medium")[#faculty\ #department]
                ])
            ]

        #b(140.7mm, size: 18pt, weight: "regular")[
            #text(fill: blue)[#title]
        ]
  
        #b(164.25mm, [
            #text(size: 14.5pt, weight: "medium")[#author.name] \
        ])
        #b(248mm)[
            #text(size: 10.5pt, weight: "medium")[#localized("supervisor", lang): #supervisor \
            #localized("study-programme", lang): #study-programme \
                    #localized("specialization", lang): #study-spec \
            #submission-date.display("[year]")]
        ]
]
])
}


#let abstract-page(
  submission-date,
  lang,
  abstract-en: [],
  abstract-cz: [],
  acknowledgement: [],
) = {
  // render as a separate page; add room at the bottom for TODOs and notes
  set page(numbering: "i")
  counter(page).update(3)
  
  set heading(
    outlined: false,
    bookmarked: false,
  )
  show heading: it => [
    #set text(font: "Technika" ,fill: blue)
    #it.body
  ]

  // pretty hacky way to disable the implicit linebreak in my heading style
  show heading: it => {
    show pagebreak: it => {linebreak()}
    block(it, above: 2pt)
  }

  align(bottom)[
     #align(right)[
        = #localized("declaration", lang)
     ]
      #localized("declaration-text", lang) 

      #localized("ai-declaration-text", lang)
        #v(10pt)
      
      #localized("prague", lang), #submission-date.display("[day]. [month]. [year]")
    ]

    pagebreak(weak: false)
  
  set par(justify: true, spacing: 0.6em, first-line-indent:(amount: 1em, all: true))
  [
    = #localized("abstract", "cs")
    #abstract-cz
    #pagebreak()
    = #localized("abstract", "en")
    #abstract-en
    #pagebreak()
  ]

  v(6.6pt)
  //v(-6pt)
    align(horizon)[
      = #localized("acknowledgement", lang)
      #set text(style: "italic")
      #acknowledgement
    ]

  


  context {
    set text(size: 15pt, weight: "bold")
    set align(center)

    v(1em)
    grid(columns: (47%, 47%), gutter: 6%,
      {
        let todo-count = counter("todo").final().at(0);
        if (todo-count > 0) {
          set text(fill: red)
          block(width: 100%, inset: 4pt)[#todo-count TODOs remaining]
        }
      },
      {
        let note-count = counter("note").final().at(0);
        if (note-count > 0) {
          block(fill: yellow, width: 100%, inset: 4pt)[#note-count notes]
        }
      }
    )
  }
}

#let list_abbr(print, lang, abbrs) = {
  set heading(
    outlined: false,
    bookmarked: false,
  )
  [= #localized("abbrs", lang)]

  table(
    columns: 2,
    gutter: 2pt,
    stroke:none,
    align: (right, left),
    ..for (k, v) in abbrs {
      ([#k], v)
    }
  )
}


#let introduction(print, submission-date, lang, abbrs, ..args) = {
  // hide empty pages from web version
  if print {
    // assignment must be on a single sheet from both sides
    pagebreak(to: "odd")
  } else {
    // Typst cannot embed PDFs, add the assignment separately
    page[assignment page 1]
    page[assignment page 2]
  }

  if print {
    pagebreak(to: "odd", weak: true)
  }
  abstract-page(submission-date, lang, ..args)

  if print {
    // outline should be on the right, but the outline title has a pagebreak
    pagebreak(to: "even")
  }

  show heading: it => [
    #set text(font: "Technika" ,fill: blue)
    #it.body
  ]
  [
    #show outline.entry.where(
        level: 1
        ): it => {
          v(12pt, weak: true)
          strong(text(fill: blue, it))
      } 
    #outline(depth: 3)
  ]
  pagebreak(weak: true)
  outline(title: localized("images", lang), target: figure.where(kind: image))
  pagebreak(weak: true)
  outline(title: localized("tables", lang), target: figure.where(kind: table))
  outline(title: localized("code", lang), target: figure.where(kind: raw))

  pagebreak(weak: true)
  list_abbr(print, lang, abbrs)

}
