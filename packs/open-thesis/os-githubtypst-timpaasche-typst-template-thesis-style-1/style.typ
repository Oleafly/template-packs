
// +-------------------------------------------+
// |         STYLE OF THE HEADER               |
// +-------------------------------------------+

#let setHeader(title: [], subtitle: [], authors: ()) = {
  set text(font: "Cascadia Mono", size: 10pt, weight: "bold", fill: rgb("#288733"))
  locate(loc => 
    if calc.odd(loc.page()) {
      grid( columns: (25%,50%,25%), gutter: 0%,
        [
          #set align(left);
        ],
        [
          #set align(center);
          #title;
          #linebreak();
          #subtitle
        ],
        [
          #set align(right);
          #image("./../images/logos/HKA_EIT_Logo.jpg", height: 1cm)
        ])
    } else {
      grid( columns: (25%,50%,25%), gutter: 0%,
        [
          #set align(left);
          #image("./../images/logos/HKA_EIT_Logo.jpg", height: 1cm)
        ],
        [
          #set align(center);
          #title;
          #linebreak();
          #subtitle
        ],
        [
          #set align(right);
        ])
    }
  )
}

// +-------------------------------------------+
// |         STYLE OF THE FOOTER               |
// +-------------------------------------------+

#let setFooterRoman(title: [], subtitle: [], authors: ()) = {
  set text(font: "Cascadia Mono", size: 10pt)
  locate(loc => 
    if calc.odd(loc.page()) {
      grid( columns: (20%,60%,20%), gutter: 0%,
        [
          #set align(left);
        ],
        [
          #set align(center);
          #for author in authors {
            author.name
            if(authors.last() != author){
              " - "
            }
          }
        ],
        [
          #set align(right);
          #counter(page).display("I")
        ])
    } else {
      grid( columns: (20%,60%,20%), gutter: 0%,
        [
          #set align(left);
          #counter(page).display("I")
        ],
        [
          #set align(center);
          #for author in authors {
            author.name
            if(authors.last() != author){
              " - "
            }
          }
        ],
        [
          #set align(right);
        ])
    }
  )
}

#let setFooter(title: [], subtitle: [], authors: ()) = {
  set text(font: "Cascadia Mono", size: 10pt)
  locate(loc => 
    if calc.odd(loc.page()) {
      grid( columns: (20%,60%,20%), gutter: 0%,
        [
          #set align(left);
        ],
        [
          #set align(center);
          #for author in authors {
            author.name
            if(authors.last() != author){
              " - "
            }
          }
        ],
        [
          #set align(right);
          #counter(page).display("1")
        ])
    } else {
      grid( columns: (20%,60%,20%), gutter: 0%,
        [
          #set align(left);
          #counter(page).display("1")
        ],
        [
          #set align(center);
          #for author in authors {
            author.name
            if(authors.last() != author){
              " - "
            }
          }
        ],
        [
          #set align(right);
        ])
    }
  )
}

#let getSupplement(it) = {
     // see in "View Example": https://typst.app/docs/reference/meta/ref/#parameters-supplement
     if it.func() == figure and it.kind == raw {
         [Sourcecode]
     } else { // keep original
         it.supplement
     }
 }

// +-------------------------------------------+
// |        SETTINGS OF THE DOCUMENT           |
// +-------------------------------------------+

#let loadStyle(doc, title, subtitle, authors) = {
    set text(
      font: "Roboto",
      size: 12pt,
      lang: "de",
    )
    
    set heading(numbering: "1.1.1.")
    
    show heading.where(level: 1): it => block(width: 100%)[
      #set text(18pt, weight: 1200, font: "Cascadia Mono")
      #smallcaps(it)
      #v(4mm)
    ]
    
    show heading.where(level: 2): it => block(width: 100%)[
      #set text(16pt, weight: 1000, font: "Cascadia Mono")
      #smallcaps(it)
      #v(2mm)
    ]
    
    show heading.where(level: 3): it => block(width: 100%)[
      #set text(14pt, weight: 800, font: "Cascadia Mono")
      #smallcaps(it)
      #v(2mm)
    ]
    
    set page(
      paper: "a4",
      margin: (
        top: 3cm,
        bottom: 2cm,
        //left: 1.5cm,
        //right: 1.5cm
      )
    )
    set par(
      justify: true,
      leading: 0.52em,
    )
    outline(
      indent: auto,
    )

    // show figure : it => block(width: 100%)[
    //   #align(center)[
    //     #it.body
    //     #v(1mm)
    //     #getSupplement(it)
    //     #it.counter.display(it.numbering):
    //     #it.caption.content
    //   ]
    // ]

    show figure : set figure(gap: 5mm)

    show figure.where(
      kind: raw
    ): set figure(supplement: "Sourcecode")

    show figure.where(
      kind: table
    ): set figure.caption(position: top)


    set page(
      header: setHeader(title: title, subtitle: subtitle, authors: authors),
      footer: setFooter(title: title, subtitle: subtitle, authors: authors)
    )
    counter(page).update(1) 
  
    doc
}

// +-------------------------------------------+
// |       STYLE OF THE TITLEPAGE              |
// +-------------------------------------------+

#let titlePage(
  title: [],
  subtitle: [],
  authors: (),
  scientificSupervisor: [],
  technicalSupervisor: [],
  abstractUS: [],
  abstractDE: [],
  oath: false,
  doc,
) = {
  set align(center)
  set text(font: "Cascadia Mono", size: 12pt, lang: "de")

  v(4mm)
  
  image(alt: "HKA-Logo", width: 12cm, "./../images/logos/HKA_EIT_Logo.jpg")
  
  v(2mm)
  
  text(weight: "bold", size: 40pt, [#title])
  v(0mm)
  text(weight: "bold", size: 28pt, [#subtitle])

  v(8mm)
  
  for author in authors {
    table(columns: (50%, 50%), stroke: 0mm, align: (right, left),
      "Name:", author.name,
      "Matrikelnummer:", str(author.mnr)
    )
  }
  
  v(1cm)
      
  
  if(scientificSupervisor != []){
    table(columns: (50%, 50%), stroke: 0mm, align: (right, left), 
      "Wissenschaftlicher Betreuer:", [#scientificSupervisor]
    )
  }
  if(technicalSupervisor != []){
    table(columns: (50%, 50%), stroke: 0mm, align: (right, left), 
      "Fachlicher Betreuer:", [#technicalSupervisor]
    )
  }
  table(columns: (50%, 50%), stroke: 0mm, align: (right, left), 
      "Datum:", [#datetime.today().display("[day].[month].[year]")]
    )
  
  pagebreak()
  
  set text(font: "Roboto")
  set align(left)
  set page(
    header: setHeader(title: title, subtitle: subtitle, authors: authors),
    footer: setFooterRoman(title: title, subtitle: subtitle, authors: authors)
  )
  
  if(abstractUS != []){
    par(justify: false)[
      #heading(outlined: false, [
        #set text(18pt, weight: 1200, font: "Cascadia Mono")
        Abstract
        #v(4mm)
      ])
      #abstractUS
    ]
    pagebreak()
  }
  
  if(abstractDE != []){
    par(justify: false)[
      #heading(outlined: false, [
        #set text(18pt, weight: 1200, font: "Cascadia Mono")
        Zusammenfassung
        #v(4mm)
      ])
      #abstractDE
    ]
    pagebreak()
  }

  if(oath){
    par(justify: false)[
      #heading(outlined: false, [
        #set text(18pt, weight: 1200, font: "Cascadia Mono")
        Eidenstattliche Erklärung
        #v(4mm)
      ])
      <eidesstattliche-erklärung>
      Ich versichere, die von mir vorgelegte Arbeit selbstständig verfasst zu haben. Alle Stellen, die wörtlich oder sinngemäß aus veröffentlichten oder nicht veröffentlichten Arbeiten anderer entnommen sind, habe ich als entnommen kenntlich gemacht. Sämtliche Quellen und Hilfsmittel, die ich für die Arbeit benutzt habe, sind angegeben. Die Arbeit hat mit gleichem Inhalt bzw. in wesentlichen Teilen noch keiner anderen Prüfungsbehörde vorgelegen.
      #v(6mm)
      I declare that I have written this thesis independently. I have labelled all passages taken verbatim or in spirit from published or unpublished works by others as having been taken from them. All sources and aids that I have used for the work are indicated. The thesis has not been submitted to any other examination authority with the same content or in substantial parts.
      
      #v(3cm)

      #for author in authors {
        [
          Karlsruhe, #datetime.today().display("[day].[month].[year]") 
          #h(42mm)
          (#author.name)
          
          #line(
            start: ( 80mm, -3mm),
            length: 80mm,
            stroke: 1pt,
          )
          #v(8mm)
        ]
      }
    ]
    pagebreak()
  }

  loadStyle(doc, title, subtitle, authors)
}
