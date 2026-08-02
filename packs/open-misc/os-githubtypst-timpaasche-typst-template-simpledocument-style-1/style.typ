
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

#let setPage(
  headerLine1: [],
  headerLine2: [],
  authors: (),
  doc,
) = {
  set page(
    header: setHeader(
      title: headerLine1,
      subtitle: headerLine2,
      authors: authors
    ),
    footer: setFooterRoman(
      title: headerLine1,
      subtitle: headerLine2,
      authors: authors
    )
  )
  loadStyle(doc, headerLine1, headerLine2, authors)
}
